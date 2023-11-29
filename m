Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8F7FD183
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjK2I70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2I7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:59:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C9AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:59:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7F541F88F;
        Wed, 29 Nov 2023 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701248368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1yHc5VrAmXwelDR9dNQ+LR2NWQ0Q1cDsi0EaonFx9k=;
        b=LMaHEQHDnalCvTB+9FmaMZs5JXGmYRIrO/sNXV8itLt3RsEkqJYg0HpLXsbI5WIivX1bIa
        x5F2oVg0V+wi1nQsT6slqzLv1UJ11tNgMu/JEsc/LH7Kgu1t4D1tATXIaVxp6Kw9Og/7IM
        8lx99iHkea59ukfhnuhbzNT3PsLUmMM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A9EA13637;
        Wed, 29 Nov 2023 08:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id aaraHnD9ZmV3bAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 08:59:28 +0000
Date:   Wed, 29 Nov 2023 09:59:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 4/7] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <ZWb9bwTQALvf5cMC@tiehlicka>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-5-kent.overstreet@linux.dev>
 <ZWW71lfACwiHw3zk@tiehlicka>
 <20231128175439.6jarreie7cay74fn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128175439.6jarreie7cay74fn@moria.home.lan>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[23.24%]
X-Spam-Score: -4.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 12:54:39, Kent Overstreet wrote:
> On Tue, Nov 28, 2023 at 11:07:18AM +0100, Michal Hocko wrote:
[...]
> > > @@ -423,4 +426,21 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > >  #ifdef CONFIG_MEMORY_FAILURE
> > >  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > >  #endif
> > > +
> > > +	buf = kmalloc(4096, GFP_ATOMIC);
> > 
> > I really do not think we want to allow allocations from the OOM context.
> > Is there any reason why this cannot be a statically allocated buffer?
> 
> You've made this claim before without ever giving any reasoning behind
> it.

We are actively out of memory at the stage you would like to allocate
memory. I am pretty sure I have mentioned this argument in the past.

> It's GFP_ATOMIC; it has to work from _interrupt_ context, OOM context is
> fine.

This is a completely _different_ contexts. GFP_ATOMIC works around IRQ
or any atomic context inability to wait for the reclaim by accessing the
memory reserves. At the _global_ oom situation those reserves are
extremely scarce resource. Debugging data is certainly not something we
would want to compete with e.g. oom victims or their dependencies that
might need to access those reserves in order to make a forward progress.
Especially in case where the said debugging data is not detrimental to
analyse the OOM situation. And to be completely honest, I haven't really
seen any strong arguments for shrinker internal state dumping other than
_in some very limited_ cases this _might_ be useful.

> And no, we don't want to burn 4k on a static buffer that is almost never
> used; people do care about making the kernel run on small systems.

WE DO NOT ALLOCATE FROM OOM context, not to mention for something as
disposable as debugging data which usefulness is not really clear. If
there are systems which cannot effort a 4kb for static buffer then just
disable this debugging data.
-- 
Michal Hocko
SUSE Labs
