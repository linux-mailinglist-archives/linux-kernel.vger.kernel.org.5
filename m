Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352157BEFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379247AbjJJAmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379237AbjJJAmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:42:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9F9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:42:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6E0C433C7;
        Tue, 10 Oct 2023 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696898532;
        bh=Jh0sIBZh8nxYbq7VHsim1Kh7Mp+jQxSntzGqnBwKMdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o87WvQrd7I/dovg4pdMTbRabyl26XrcKQ0m+jND++sXRPeTn3nE4igwsAyn5wgNiX
         Yr/s6LBeJMB5FBRXOKggvWzX/+1pkIXQgQIJeXBIG6LxBVqf51T3yEvYVBmZsF4xiq
         oRbCdSydZNA7EQrMu7+Vt0QtSmlBj904i6oGEOCs=
Date:   Mon, 9 Oct 2023 17:41:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH -V2] mm: fix draining PCP of remote zone
Message-Id: <20231009174135.2357dcfcdc691a6ef61dbd9a@linux-foundation.org>
In-Reply-To: <20231007062356.187621-1-ying.huang@intel.com>
References: <20231007062356.187621-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Oct 2023 14:23:56 +0800 Huang Ying <ying.huang@intel.com> wrote:

> If there is no memory allocation/freeing in the PCP (Per-CPU Pageset)
> of a remote zone (zone in remote NUMA node) after some time (3 seconds
> for now), the pages of the PCP of the remote zone will be drained to
> avoid memory wastage.
> 
> This behavior was introduced in the commit 4ae7c03943fc ("[PATCH]
> Periodically drain non local pagesets") and the commit
> 4037d452202e ("Move remote node draining out of slab allocators")
> 
> But, after the commit 7cc36bbddde5 ("vmstat: on-demand vmstat workers
> V8"), the vmstat updater worker which is used to drain the PCP of
> remote zones may not be re-queued when we are waiting for the
> timeout (pcp->expire != 0) if there are no vmstat changes on this CPU,
> for example, when the CPU goes idle or runs user space only workloads.
> This may cause the pages of a remote zone be kept in PCP of this CPU
> for long time.  So that, the page reclaiming of the remote zone may be
> triggered prematurely.  This isn't a severe problem in practice,
> because the PCP of the remote zone will be drained if some memory are
> allocated/freed again on this CPU.  And, the PCP will eventually be
> drained during the direct reclaiming if necessary.
> 
> Anyway, the problem still deserves a fix via guaranteeing that the
> vmstat updater worker will always be re-queued when we are waiting for
> the timeout.  In effect, this restores the original behavior before
> the commit 7cc36bbddde5.
> 
> We can reproduce the bug via allocating/freeing pages from a remote
> zone then go idle as follows.  And the patch can fix it.
> 
> - Run some workloads, use `numactl` to bind CPU to node 0 and memory to
>   node 1.  So the PCP of the CPU on node 0 for zone on node 1 will be
>   filled.
> 
> - After workloads finish, idle for 60s
> 
> - Check /proc/zoneinfo
> 
> With the original kernel, the number of pages in the PCP of the CPU on
> node 0 for zone on node 1 is non-zero after idle.  With the patched
> kernel, it becomes 0 after idle.  That is, we avoid to keep pages in
> the remote PCP during idle.
> 

Thanks, I updated the changelog in place and queued this for mm-stable.
