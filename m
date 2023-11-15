Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415FD7EC82C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjKOQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKOQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:09:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170F83
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:09:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A73102290F;
        Wed, 15 Nov 2023 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700064562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaBHl1uTR+ZEXQNZ4k9WIKmP/Oe6q6fk6ypOJRyZ9ko=;
        b=1y6pz3zrR7HEvAzd6JFYqpb6sKNI6OyTwmfSjIApVxzi+9I/UoN+KpdNRqDL+fGlAbH2VD
        WHhr3P4lXGwe8/E5mbrIhRhqmeuhxuSFwN1E5HqCfbqVEbiqvLYnt/sgB0GEWonqNEMfnm
        MpZr3uXTS0FyZ1TSunhS5I1smOggGUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700064562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaBHl1uTR+ZEXQNZ4k9WIKmP/Oe6q6fk6ypOJRyZ9ko=;
        b=OraCKCPfbBMSUGOm/tSTU+A6mSIoresHTT7qXWcVh1R/dU7EIDPPluGUmZHsW1lyhPn6Lj
        VsLGVNBaZfYvBSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C74B13587;
        Wed, 15 Nov 2023 16:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 40ZnIDLtVGUOHwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 15 Nov 2023 16:09:22 +0000
Date:   Wed, 15 Nov 2023 17:09:22 +0100
From:   Andrea della Porta <aporta@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64/entry-common: Make Aarch32 exceptions'
 availability depend on aarch32_enabled()
Message-ID: <ZVTtMgtc0g9dgH8S@apocalypse>
Mail-Followup-To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1698069331.git.andrea.porta@suse.com>
 <d0484051d8ff23e0ed1f2933789cde3d390a2fa6.1698069331.git.andrea.porta@suse.com>
 <ZTj7mHTv-PDT4ba8@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTj7mHTv-PDT4ba8@FVFF77S0Q05N>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
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

On 12:27 Wed 25 Oct     , Mark Rutland wrote:
> On Mon, Oct 23, 2023 at 04:42:22PM +0200, Andrea della Porta wrote:
> > Another major aspect of supporting running of 32bit processes is the
> > ability to access 32bit syscalls and exceptions. Syscalls, in
> > particular, can be invoked by using the svc instruction.
> > 
> > If Aarch32 support is disabled ensure that calling svc (or any
> > exceptions) from 32bit context results in the same behavior as if
> > CONFIG_COMPAT has not been enabled (i.e. a kernel panic).
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> Just to be clear, as it stands, I don't think we should apply this patch.
> 
> * There's no justficiation so far for disabling the vectors given they should
>   be unreachable.
>

True, but let's see what it buys and what not:

- is it really necessary to check for 32 bit enablement when you cannot run 
32 bit excecutable (from binfmt loader) in teh first place? Obviously not at all,
unless you find a way (of which I'm not aware right now) to switch to 32 bit mode
maybe by expliting some execpotion return path. In that (admittedly unlikely, as
of now) case, you would expose all 32 bit syscall to be used by userspace.

- does 'redundantly' checking for 32 bit alignment in the vector handler pose
some performence bottleneck? Yes, but only in the dynamic enabled case (i.e.
you have enabled the 32 bit support via the proposed kernel parameter). 
All other cases are compiler optimized away or simply not reachable under normal
circumstances, so it's redundant only in very few (and probably irrelevant) 
cases. 
 
> * If we really want to do this, the behaviour should be driven by a cpucap, so
>   as to have truly negligible impact and to be consistent with how we handle
>   features elsewhere.
> 
>   That will require some preparatory rework to the way de handle detecing
>   support for AArch32 at EL0 (some of which I think we should do anyway as a
>   cleanup).
> 
> * We should not introduce new *_ni_handler() functions. If we really want to
>   do this, we should refactor the existing code such that we have a single
>   el0t_32_<vector>_handler() implementation for each vector regardless of
>   CONFIG_COMPAT, which can figure out what to do, e.g. something like:
> 
>   | asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
>   | {
>   |         if (!system_suports_compat_el0())
>   | 	            panic_unhandled_vector(el0t, 32, irq, regs);
>   |             
>   | 	    __el0_irq_handler_common(regs);
>   | }
> 
>   That way the feature check only needs to test IS_ENABLED(CONFIG_COMPAT) and
>   alternative_has_cap(whatever), and we can rely on the compiler to elide the
>   unreachable code. That way we use the exact same code for the case that
>   32-bit support is disabled statically or dynamically.
> 
>   I had a quick go at mocking that up:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry/unhandled-rework
> 
>   ... which doesn't look too hard.
>  

I agree with that, so assuming we still want to proceed and elaborate further,
I'd like to sort the various proposals since I'm a little bit confused about
them: from one side you propose to rework the vector handler definitions and
to insert the conditional logic inside them. On the other side there is the 
thread from you, Kees and others that eventually led to a seccomp assisted
solution as the preferred way. I'm not entirely sure how seccomp can be used here,
whether setting up a bpf filter from inside the kernel (that enable or disable
the 32 bit handler based on the kernel parameter) or from userspace (systemd,
others..), so I assume we're still interested to investigate on your proposed solution. 
Regarding that, I propose the following:

- rework the vector handler definitions as you've already mocked up, in
order to get rid of the UNHANDLED declarations.

- use the actual system_supports_32bit_el0() call as the conditional inside
the vector handler. That routine in turn is calling id_aa64pfr0_32bit_el0()
that should load the ID_AA64PFR0_EL1. We can override the EL0 nibble by 
leveraging the idreg-override machinery, as noted by robin.murphy. In this
way we don't even need to add a new kernel parameter, maybe just a user friendly
mnemonic alias to that register, such like 'arm64.no32bit-el0'.

- CONFIG_COMPAT can be checked in the vector handler as you proposed in your
mock up or maybe event inside system_supports_32bit_el0() - need to check
whether the compiler is able to optimize away the static case even in that
case.

Does it sounds reasonable?

Many thanks,
Andrea
