Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7F7FDC22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbjK2QCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjK2QCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:02:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A91BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:02:42 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B72421F8D7;
        Wed, 29 Nov 2023 16:02:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A8F71388B;
        Wed, 29 Nov 2023 16:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Nzq8IqBgZ2UWewAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 16:02:40 +0000
Date:   Wed, 29 Nov 2023 17:02:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZWdgm2I3tF0zvHG9@tiehlicka>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <ZWW6bInvMA2x3mHC@tiehlicka>
 <20231128174853.vdpwullepoxg5blo@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128174853.vdpwullepoxg5blo@moria.home.lan>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: B72421F8D7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 12:48:53, Kent Overstreet wrote:
> On Tue, Nov 28, 2023 at 11:01:16AM +0100, Michal Hocko wrote:
> > On Wed 22-11-23 18:25:07, Kent Overstreet wrote:
> > [...]
> > > +void shrinkers_to_text(struct seq_buf *out)
> > > +{
> > > +	struct shrinker *shrinker;
> > > +	struct shrinker_by_mem {
> > > +		struct shrinker	*shrinker;
> > > +		unsigned long	mem;
> > > +	} shrinkers_by_mem[10];
> > > +	int i, nr = 0;
> > > +
> > > +	if (!mutex_trylock(&shrinker_mutex)) {
> > > +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> > > +		return;
> > > +	}
> > > +
> > > +	list_for_each_entry(shrinker, &shrinker_list, list) {
> > > +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> > 
> > This seems to be global reclaim specific. What about memcg reclaim?
> 
> I have no fsckin idea how memcg reclaim works - and, for that matter,
> the recent lockless shrinking work seems to have neglected to write even
> an iterator macro, leaving _that_ a nasty mess so I'm not touching that
> either.

OK, you could have made it more clearly that all of this is aiming at
the global OOM handling. With an outlook on what should be done if this
was ever required.

Another thing you want to look into is a NUMA constrained OOM (mbind,
cpuset) where this output could be actively misleading.

-- 
Michal Hocko
SUSE Labs
