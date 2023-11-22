Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF017F4799
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKVNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344122AbjKVNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:19:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61213D78
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:19:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFF781F8D6;
        Wed, 22 Nov 2023 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700659177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hlfUJNemNX5RvK9UupKma9tgfKErCXKSSlnJ4F/bgU=;
        b=NyKE0AGTH1t6Z4wzPD7zkiu22YrCmVkXRvvb/EVx4vexKfzEhjEfbUlqSroJg9FPWLHSXm
        07W70Hv4+OieqEyiabRGheVfYMyvawAvVe+dVRO7hgLo6HzcGYsNVRV4zATjQH5ErOrOZe
        9oCZ3sOsowkvZHrd8PVG9bc+1esvhAI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B22D113467;
        Wed, 22 Nov 2023 13:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jVR0KOn/XWXYZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Nov 2023 13:19:37 +0000
Date:   Wed, 22 Nov 2023 14:19:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZV3_6UH28KMt0ZDb@tiehlicka>
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka>
 <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka>
 <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.994];
         RCPT_COUNT_SEVEN(0.00)[10];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 02:39:15, Yosry Ahmed wrote:
> On Wed, Nov 22, 2023 at 2:09 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 22-11-23 09:52:42, Michal Hocko wrote:
> > > On Tue 21-11-23 22:44:32, Yosry Ahmed wrote:
> > > > On Tue, Nov 21, 2023 at 10:41 PM Liu Shixin <liushixin2@huawei.com> wrote:
> > > > >
> > > > >
> > > > > On 2023/11/21 21:00, Michal Hocko wrote:
> > > > > > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> > > > > >
> > > > > > However, in swapcache_only mode, the scan count still increased when scan
> > > > > > non-swapcache pages because there are large number of non-swapcache pages
> > > > > > and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> > > > > > is skipped and do not count, the scan of pages in isolate_lru_folios() can
> > > > > > eventually lead to hung task, just as Sachin reported [2].
> > > > > > I find this paragraph really confusing! I guess what you meant to say is
> > > > > > that a real swapcache_only is problematic because it can end up not
> > > > > > making any progress, correct?
> > > > > This paragraph is going to explain why checking swapcache_only after scan += nr_pages;
> > > > > >
> > > > > > AFAIU you have addressed that problem by making swapcache_only anon LRU
> > > > > > specific, right? That would be certainly more robust as you can still
> > > > > > reclaim from file LRUs. I cannot say I like that because swapcache_only
> > > > > > is a bit confusing and I do not think we want to grow more special
> > > > > > purpose reclaim types. Would it be possible/reasonable to instead put
> > > > > > swapcache pages on the file LRU instead?
> > > > > It looks like a good idea, but I'm not sure if it's possible. I can try it, is there anything to
> > > > > pay attention to?
> > > >
> > > > I think this might be more intrusive than we think. Every time a page
> > > > is added to or removed from the swap cache, we will need to move it
> > > > between LRUs. All pages on the anon LRU will need to go through the
> > > > file LRU before being reclaimed. I think this might be too big of a
> > > > change to achieve this patch's goal.
> > >
> > > TBH I am not really sure how complex that might turn out to be.
> > > Swapcache tends to be full of subtle issues. So you might be right but
> > > it would be better to know _why_ this is not possible before we end up
> > > phising for couple of swapcache pages on potentially huge anon LRU to
> > > isolate them. Think of TB sized machines in this context.
> >
> > Forgot to mention that it is not really far fetched from comparing this
> > to MADV_FREE pages. Those are anonymous but we do not want to keep them
> > on anon LRU because we want to age them indepdendent on the swap
> > availability as they are just dropped during reclaim. Not too much
> > different from swapcache pages. There are more constrains on those but
> > fundamentally this is the same problem, no?
> 
> I agree it's not a first, but swap cache pages are more complicated
> because they can go back and forth, unlike MADV_FREE pages which
> usually go on a one way ticket AFAICT.

Yes swapcache pages are indeed more complicated but most of the time
they just go away as well, no? MADV_FREE can be reinitiated if they are
written as well. So fundamentally they are not that different.

> Also pages going into the swap
> cache can be much more common that MADV_FREE pages for a lot of
> workloads. I am not sure how different reclaim heuristics will react
> to such mobility between the LRUs, and the fact that all pages will
> now only get evicted through the file LRU. The anon LRU will
> essentially become an LRU that feeds the file LRU. Also, the more
> pages we move between LRUs, the more ordering violations we introduce,
> as we may put colder pages in front of hotter pages or vice versa.

Well, traditionally the file LRU has been maintaining page cache or
easily disposable pages like MADV_FREE (which can be considered a cache
as well). Swapcache is a form of a page cache as well.

> All in all, I am not saying it's a bad idea or not possible, I am just
> saying it's probably more complicated than MADV_FREE, and adding more
> cases where pages move between LRUs could introduce problems (or make
> existing problems more visible).

Do we want to start adding filtered anon scan for a certain type of
pages? Because this is the question here AFAICS. This might seem an
easier solution but I would argue that it is less predictable one. 
It is not unusual that a huge anon LRU would contain only very few LRU
pages.

That being said, I might be missing some obvious or less obvious reasons
why this is completely bad idea. Swapcache is indeed subtle.
-- 
Michal Hocko
SUSE Labs
