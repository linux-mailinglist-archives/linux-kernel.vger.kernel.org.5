Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124357FFD91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376918AbjK3Vdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3Vdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:33:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DA31B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:33:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE82EC433C7;
        Thu, 30 Nov 2023 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701380021;
        bh=zoLX8EMoe/pefdEhZ5q+qBiLo3+H4+isUNHHBqOWkyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rq46MTa6E0BZ7P6nDMGVHEIbqrT6a/+4vxnV3EWD+gk1kkiul2VBJcj2srNAhI2cM
         BW10h4l1E1kHdzFRlLa2Ltn3kO9sPFHN5kHpR5qkNCox7dCislZrvCIUfaSMwsErPm
         MpPwSzA5zgropOxblSm5gTHS6+dUOpzIZqDtgWXI=
Date:   Thu, 30 Nov 2023 13:33:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Message-Id: <20231130133340.36140526608289898acb3ac5@linux-foundation.org>
In-Reply-To: <20231130153658.527556-2-schatzberg.dan@gmail.com>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
        <20231130153658.527556-2-schatzberg.dan@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 07:36:54 -0800 Dan Schatzberg <schatzberg.dan@gmail.com> wrote:

> Allow proactive reclaimers to submit an additional swappiness=<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
> 
> For example:
> 
> echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  include/linux/swap.h |  3 ++-
>  mm/memcontrol.c      | 55 +++++++++++++++++++++++++++++++++++---------
>  mm/vmscan.c          | 13 +++++++++--

Documentation/admin-guide/cgroup-v2.rst is feeling unloved!

Please check whether this interface change can lead to
non-backward-compatible userspace.  If someone's script does the above
echo command, will it break on older kernels?  If so, does it matter?
