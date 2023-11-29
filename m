Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4400D7FD409
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjK2KWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjK2KWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:22:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774CAF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:22:28 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB6A1219A5;
        Wed, 29 Nov 2023 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701253344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z08E1oEubgUv18/fMFXjEfb/IXlpOAqyFntT1non7IA=;
        b=fw7zhBX7eOmcGkrdZ86sQUuiVE99SemfBFiF3BNh/pHjmN1El1YTV7KOpRVDZ/O6hGvy56
        tWlVmQekrdcoCuX4E1Mjg81jXrLZRFNmREm+kG6PZf85QShj7lGahvImsyYp2ONYQ2s2EO
        AF95U0zEhedpTXObsPo2kFOey3TqbYs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 947431388B;
        Wed, 29 Nov 2023 10:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 8CgWIOAQZ2V+BwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 10:22:24 +0000
Date:   Wed, 29 Nov 2023 11:22:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Li <chriscli@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWcQ315wxPJW9GXX@tiehlicka>
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com>
 <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
 <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.77 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.17)[-0.864];
         RCPT_COUNT_TWELVE(0.00)[12];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.77
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 11:19:20, Huang, Ying wrote:
> Yosry Ahmed <yosryahmed@google.com> writes:
> 
> > On Mon, Nov 27, 2023 at 1:32 PM Minchan Kim <minchan@kernel.org> wrote:
> >>
> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> >> > On Mon, Nov 27, 2023 at 12:14 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> > > >  I agree with Ying that anonymous pages typically have different page
> >> > > > access patterns than file pages, so we might want to treat them
> >> > > > differently to reclaim them effectively.
> >> > > > One random idea:
> >> > > > How about we put the anonymous page in a swap cache in a different LRU
> >> > > > than the rest of the anonymous pages. Then shrinking against those
> >> > > > pages in the swap cache would be more effective.Instead of having
> >> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> >> > > > cache, file] LRU
> >> > >
> >> > > I don't think that it is necessary.  The patch is only for a special use
> >> > > case.  Where the swap device is used up while some pages are in swap
> >> > > cache.  The patch will kill performance, but it is used to avoid OOM
> >> > > only, not to improve performance.  Per my understanding, we will not use
> >> > > up swap device space in most cases.  This may be true for ZRAM, but will
> >> > > we keep pages in swap cache for long when we use ZRAM?
> >> >
> >> > I ask the question regarding how many pages can be freed by this patch
> >> > in this email thread as well, but haven't got the answer from the
> >> > author yet. That is one important aspect to evaluate how valuable is
> >> > that patch.
> >>
> >> Exactly. Since swap cache has different life time with page cache, they
> >> would be usually dropped when pages are unmapped(unless they are shared
> >> with others but anon is usually exclusive private) so I wonder how much
> >> memory we can save.
> >
> > I think the point of this patch is not saving memory, but rather
> > avoiding an OOM condition that will happen if we have no swap space
> > left, but some pages left in the swap cache. Of course, the OOM
> > avoidance will come at the cost of extra work in reclaim to swap those
> > pages out.
> >
> > The only case where I think this might be harmful is if there's plenty
> > of pages to reclaim on the file LRU, and instead we opt to chase down
> > the few swap cache pages. So perhaps we can add a check to only set
> > sc->swapcache_only if the number of pages in the swap cache is more
> > than the number of pages on the file LRU or similar? Just make sure we
> > don't chase the swapcache pages down if there's plenty to scan on the
> > file LRU?
> 
> The swap cache pages can be divided to 3 groups.
> 
> - group 1: pages have been written out, at the tail of inactive LRU, but
>   not reclaimed yet.
> 
> - group 2: pages have been written out, but were failed to be reclaimed
>   (e.g., were accessed before reclaiming)
> 
> - group 3: pages have been swapped in, but were kept in swap cache.  The
>   pages may be in active LRU.
> 
> The main target of the original patch should be group 1.  And the pages
> may be cheaper to reclaim than file pages.

Thanks this is really useful summary. And it begs question. How are we
telling those different types from each other? vmstat counter is
certainly not sufficient and that means we might be scanning a lot
without actually making any progress. And doing that repeatedly.
-- 
Michal Hocko
SUSE Labs
