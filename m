Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F3783B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHVIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHVIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:09:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D5E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:09:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50CBD22C3E;
        Tue, 22 Aug 2023 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692691743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1f+eYC6yXyQc7wgBy27gYH2LaoZ+nOmBUa0CiiZDq5I=;
        b=uC2PPyvD29/c2OWKdR7DlOi+jU/UnafZkGqW6QlofPud1YQWzUHaiC8IJxLwGsHty5vioP
        ZwkDciAy8FLAk0HoKc73BOKIz7tJUgWnVxJnhWs51UeIWWl0RjgXDvl1fJ5qn50yCMllve
        QjUX4NRLk4eW9PkW4OHVN/22YVb04JQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33321132B9;
        Tue, 22 Aug 2023 08:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id koW9CR9t5GQmZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 22 Aug 2023 08:09:03 +0000
Date:   Tue, 22 Aug 2023 10:09:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
Message-ID: <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
References: <20230811090819.60845-1-ying.huang@intel.com>
 <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
 <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
 <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
 <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz>
 <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-08-23 06:31:42, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 21-08-23 16:30:18, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Wed 16-08-23 15:08:23, Huang, Ying wrote:
> >> >> Michal Hocko <mhocko@suse.com> writes:
> >> >> 
> >> >> > On Mon 14-08-23 09:59:51, Huang, Ying wrote:
> >> >> >> Hi, Michal,
> >> >> >> 
> >> >> >> Michal Hocko <mhocko@suse.com> writes:
> >> >> >> 
> >> >> >> > On Fri 11-08-23 17:08:19, Huang Ying wrote:
> >> >> >> >> If there is no memory allocation/freeing in the remote pageset after
> >> >> >> >> some time (3 seconds for now), the remote pageset will be drained to
> >> >> >> >> avoid memory wastage.
> >> >> >> >> 
> >> >> >> >> But in the current implementation, vmstat updater worker may not be
> >> >> >> >> re-queued when we are waiting for the timeout (pcp->expire != 0) if
> >> >> >> >> there are no vmstat changes, for example, when CPU goes idle.
> >> >> >> >
> >> >> >> > Why is that a problem?
> >> >> >> 
> >> >> >> The pages of the remote zone may be kept in the local per-CPU pageset
> >> >> >> for long time as long as there's no page allocation/freeing on the
> >> >> >> logical CPU.  In addition to the logical CPU goes idle, this is also
> >> >> >> possible if the logical CPU is busy in the user space.
> >> >> >
> >> >> > But why is this a problem? Is the scale of the problem sufficient to
> >> >> > trigger out of memory situations or be otherwise harmful?
> >> >> 
> >> >> This may trigger premature page reclaiming.  The pages in the PCP of the
> >> >> remote zone would have been freed to satisfy the page allocation for the
> >> >> remote zone to avoid page reclaiming.  It's highly possible that the
> >> >> local CPU just allocate/free from/to the remote zone temporarily.
> >> >
> >> > I am slightly confused here but I suspect by zone you mean remote pcp.
> >> > But more importantly is this a concern seen in real workload? Can you
> >> > quantify it in some manner? E.g. with this patch we have X more kswapd
> >> > scanning or even hit direct reclaim much less often.
> >> >> So,
> >> >> we should free PCP pages of the remote zone if there is no page
> >> >> allocation/freeing from/to the remote zone for 3 seconds.
> >> >
> >> > Well, I would argue this depends a lot. There are workloads which really
> >> > like to have CPUs idle and yet they would like to benefit from the
> >> > allocator fast path after that CPU goes out of idle because idling is
> >> > their power saving opportunity while workloads want to act quickly after
> >> > there is something to run.
> >> >
> >> > That being said, we really need some numbers (ideally from real world)
> >> > that proves this is not just a theoretical concern.
> >> 
> >> The behavior to drain the PCP of the remote zone (that is, remote PCP)
> >> was introduced in commit 4ae7c03943fc ("[PATCH] Periodically drain non
> >> local pagesets").  The goal of draining was well documented in the
> >> change log.  IIUC, some of your questions can be answered there?
> >> 
> >> This patch just restores the original behavior changed by commit
> >> 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8").
> >
> > Let me repeat. You need some numbers to show this is needed.
> 
> I have done some test for this patch as follows,
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
> kernel, that becomes 0 after idle.  We avoid to keep pages in the remote
> PCP during idle.
> 
> This is the number I have.  If you think it isn't enough to justify the
> patch, then I'm OK too (although I think it's enough).  Because the
> remote PCP will be drained later when some pages are allocated/freed on
> the CPU.

Yes, this doesn't really show any actual correctness problem so I do not
think this is sufficient to change the code. You would need to show that
the existing behavior is actively harmful.

-- 
Michal Hocko
SUSE Labs
