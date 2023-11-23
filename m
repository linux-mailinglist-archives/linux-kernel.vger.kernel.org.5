Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C647F6B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKXEUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjKXEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:20:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F811F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:20:42 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6989321AD9;
        Thu, 23 Nov 2023 16:20:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E84413A82;
        Thu, 23 Nov 2023 16:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id sjq7EtJ7X2VVGQAAn2gu4w
        (envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:20:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9536EA07D9; Thu, 23 Nov 2023 17:20:25 +0100 (CET)
Date:   Thu, 23 Nov 2023 17:20:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io,
        neilb@suse.de, Michal Hocko <mhocko@suse.com>
Subject: Re: Question: memcg dirty throttle caused by low per-memcg dirty
 thresh
Message-ID: <20231123162025.4sibecbomc3apfkw@quack3>
References: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
 <20231122144932.m44oiw5lufwkc5pw@quack3>
 <7e3d3ff6-b453-404b-beaf-cdd23fb3e1a2@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3d3ff6-b453-404b-beaf-cdd23fb3e1a2@linux.dev>
X-Spamd-Bar: +++++
X-Spam-Score: 5.39
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 6989321AD9
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [5.39 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 23:32:50, Chengming Zhou wrote:
> On 2023/11/22 22:49, Jan Kara wrote:
> > Hello!
> > 
> > On Wed 22-11-23 17:38:25, Chengming Zhou wrote:
> >> Sorry to bother you, we encountered a problem related to the memcg dirty
> >> throttle after migrating from cgroup v1 to v2, so want to ask for some
> >> comments or suggestions.
> >>
> >> 1. Problem
> >>
> >> We have the "containerd" service running under system.slice, with
> >> its memory.max set to 5GB. It will be constantly throttled in the
> >> balance_dirty_pages() since the memcg has dirty memory more than
> >> the memcg dirty thresh.
> >>
> >> We haven't this problem on cgroup v1, because cgroup v1 doesn't have
> >> the per-memcg writeback and per-memcg dirty thresh. Only the global
> >> dirty thresh will be checked in balance_dirty_pages().
> > 
> > As Michal writes, if you allow too many memcg pages to become dirty, you
> > might be facing issues with page reclaim so there are actually good reasons
> > why you want amount of dirty pages in each memcg reasonably limited. Also
> 
> Yes, the memcg dirty limit (20%) is good for the memcg reclaim path.
> But for some workloads (like burst dirtier) which may only create many dirty
> pages in a short time, we want its memory.max 60% can be dirtied without
> being throttled. And this is not much harmful for its memcg reclaim path.

Well, I'd rather say that your memcg likely doesn't hit reclaim path too
much (the memory is reasonably sized for the task) and thus high fraction
of dirty pagecache pages does not really matter much.
 
> > generally increasing number of available dirty pages beyond say 1GB is not
> > going to bring any benefit in the overall writeback performance. It may
> > still be useful in case you generate a lot of (or large) temporary files
> > which get quickly deleted and thus with high enough dirty limit they don't
> > have to be written to the disk at all. Similarly if the generation of dirty
> > data is very bursty (i.e. you generate a lot of dirty data in a short while
> > and then don't dirty anything for a long time), having higher dirty limit
> > may be useful. What is your usecase that you think you'll benefit from
> > higher dirty limit?
> 
> I think it's the burst dirtier in our case, and we have good performance
> improvement if we change the global dirty_ratio to 60 just for testing.

OK.

> >> 3. Solution?
> >>
> >> But we could't think of a good solution to support this. The current
> >> memcg dirty thresh is calculated from a complex rule:
> >>
> >> 	memcg dirty thresh = memcg avail * dirty_ratio
> >>
> >> memcg avail is from combination of: memcg max/high, memcg files
> >> and capped by system-wide clean memory excluding the amount being used
> >> in the memcg.
> >>
> >> Although we may find a way to calculate the per-memcg dirty thresh,
> >> we can't use it directly, since we still need to calculate/distribute
> >> dirty thresh to the per-wb dirty thresh share.
> >>
> >> R - A - B
> >>     \-- C
> >>
> >> For example, if we know the dirty thresh of A, but wb is in C, we
> >> have no way to distribute the dirty thresh shares to the wb in C.
> >>
> >> But we have to get the dirty thresh of the wb in C, since we need it
> >> to control throttling process of the wb in balance_dirty_pages().
> >>
> >> I may have missed something above, but the problem seems clear IMHO.
> >> Looking forward to any comment or suggestion.
> > 
> > I'm not sure I follow what is the problem here. In balance_dirty_pages() we
> > have global dirty threshold (tracked in gdtc) and memcg dirty threshold
> > (tracked in mdtc). This can get further scaled down based on the device
> > throughput (that is the difference between 'thresh' and 'wb_thresh') but
> > that is independent of the way mdtc->thresh is calculated. So if we provide
> > a different way of calculating mdtc->thresh, technically everything should
> > keep working as is.
> > 
> 
> Sorry for the confusion. The problem is exactly how to calculate mdtc->thresh.
> 
> R - A - B
>     \-- C
> 
> Case 1:
> 
> Suppose the C has "memory.dirty_limit" set, should we just use it as mdtc->thresh?
> I see the current code also consider the system clean memory in mdtc_calc_avail(),
> should we also need to consider it when "memory.dirty_limit" set?
> 
> Case 2:
> 
> Suppose the C hasn't "memory.dirty_limit" set, but A has "memory.dirty_limit" set,
> how do we calculate the C mdtc->thresh ?
> 
> Obviously we can't directly use the A "memory.dirty_limit", since it should be
> distributed to B and C ?
> 
> So the problem is that I don't know how to reasonably calculate the mdtc->thresh,
> even given a memcg tree with some memcgs have "memory.dirty_limit" set. :\

I see, thanks for explanation. I guess we would need to redistribute
dirtiable memory in hierarchical manner like we do it for other resources.
The most natural would probably be to somehow follow the behavior of other
memcg memory limits - but I know close to nothing about how that works so
Michal would have to elaborate.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
