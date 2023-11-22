Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCA7F494F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjKVOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjKVOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:49:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B119D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:49:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36ADA1F385;
        Wed, 22 Nov 2023 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700664573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kq4fxvPRD3+OAsCP745uuOIslKd+n71GOa7alH4nMCE=;
        b=U6b9LWRbsjHW7H4M2bMLBt1dNaWPoEtqn+VEFumm3hzQC3pFxyTHbK1o8+jMJjLHu3ges3
        0f831xeKBhHtlUA3GWiiNiPYj1QbwH96b3uV35HeOH5AlEl+PBidEBk6rd2nnpx2taMOii
        a9wWv5jdlcS4ywUitEEXKTQPhGKQ/bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700664573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kq4fxvPRD3+OAsCP745uuOIslKd+n71GOa7alH4nMCE=;
        b=YXw5P8+TxQHa5tDxeU/lV5qni6HtBmE6hyYifqyfBvD0lsqaN4qC3eT2QbwdQD5z563RMQ
        MmM2AKJa/mw+RnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 305D513461;
        Wed, 22 Nov 2023 14:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OtDIC/0UXmWQEgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 14:49:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A911AA07DC; Wed, 22 Nov 2023 15:49:32 +0100 (CET)
Date:   Wed, 22 Nov 2023 15:49:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        jack@suse.cz, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io,
        neilb@suse.de, Michal Hocko <mhocko@suse.com>
Subject: Re: Question: memcg dirty throttle caused by low per-memcg dirty
 thresh
Message-ID: <20231122144932.m44oiw5lufwkc5pw@quack3>
References: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
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
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed 22-11-23 17:38:25, Chengming Zhou wrote:
> Sorry to bother you, we encountered a problem related to the memcg dirty
> throttle after migrating from cgroup v1 to v2, so want to ask for some
> comments or suggestions.
> 
> 1. Problem
> 
> We have the "containerd" service running under system.slice, with
> its memory.max set to 5GB. It will be constantly throttled in the
> balance_dirty_pages() since the memcg has dirty memory more than
> the memcg dirty thresh.
> 
> We haven't this problem on cgroup v1, because cgroup v1 doesn't have
> the per-memcg writeback and per-memcg dirty thresh. Only the global
> dirty thresh will be checked in balance_dirty_pages().

As Michal writes, if you allow too many memcg pages to become dirty, you
might be facing issues with page reclaim so there are actually good reasons
why you want amount of dirty pages in each memcg reasonably limited. Also
generally increasing number of available dirty pages beyond say 1GB is not
going to bring any benefit in the overall writeback performance. It may
still be useful in case you generate a lot of (or large) temporary files
which get quickly deleted and thus with high enough dirty limit they don't
have to be written to the disk at all. Similarly if the generation of dirty
data is very bursty (i.e. you generate a lot of dirty data in a short while
and then don't dirty anything for a long time), having higher dirty limit
may be useful. What is your usecase that you think you'll benefit from
higher dirty limit?

> 2. Thinking
> 
> So we wonder if we can support the per-memcg dirty thresh interface?
> Now the memcg dirty thresh is just calculated from memcg max * ratio,
> which can be set from /proc/sys/vm/dirty_ratio.
> 
> We have to set it to 60 instead of the default 20 to workaround now,
> but worry about the potential side effects.
> 
> If we can support the per-memcg dirty thresh interface, we can set
> some containers to a much higher dirty_ratio, especially for hungry
> dirtier workloads like "containerd".

As Michal wrote, if this ought to be configurable per memcg, then
configuring dirty amount directly in bytes may be more sensible.

> 3. Solution?
> 
> But we could't think of a good solution to support this. The current
> memcg dirty thresh is calculated from a complex rule:
> 
> 	memcg dirty thresh = memcg avail * dirty_ratio
> 
> memcg avail is from combination of: memcg max/high, memcg files
> and capped by system-wide clean memory excluding the amount being used
> in the memcg.
> 
> Although we may find a way to calculate the per-memcg dirty thresh,
> we can't use it directly, since we still need to calculate/distribute
> dirty thresh to the per-wb dirty thresh share.
> 
> R - A - B
>     \-- C
> 
> For example, if we know the dirty thresh of A, but wb is in C, we
> have no way to distribute the dirty thresh shares to the wb in C.
> 
> But we have to get the dirty thresh of the wb in C, since we need it
> to control throttling process of the wb in balance_dirty_pages().
> 
> I may have missed something above, but the problem seems clear IMHO.
> Looking forward to any comment or suggestion.

I'm not sure I follow what is the problem here. In balance_dirty_pages() we
have global dirty threshold (tracked in gdtc) and memcg dirty threshold
(tracked in mdtc). This can get further scaled down based on the device
throughput (that is the difference between 'thresh' and 'wb_thresh') but
that is independent of the way mdtc->thresh is calculated. So if we provide
a different way of calculating mdtc->thresh, technically everything should
keep working as is.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
