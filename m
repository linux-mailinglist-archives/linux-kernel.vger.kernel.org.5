Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E347CF953
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjJSMsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjJSMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:48:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69543115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:48:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1180A212AE;
        Thu, 19 Oct 2023 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697719710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZZS7PFDVx3AKmCIBUXkAjn7J/+CmX+2HHETluAokOo=;
        b=E30hlYqFmEwX03zGyFnlzrtSfB5ixodN9YhVTeQBT6p3Vz92nGdrXwM8qDFeyFiPtANDaR
        4arTSVgVeIsPQ4y4qKNdGzrbRs2X9F17Re2M8Dz1wXm2FiDipl7UfCTLfDaMbt3AvolcA7
        vwSHZbjWw13nR++1SQMFgh6qyrwiUDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697719710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZZS7PFDVx3AKmCIBUXkAjn7J/+CmX+2HHETluAokOo=;
        b=fdmzPcV42rurEEbMjfguhx7zIiE2J20j4knWOmaAgaCPogMHg2vxri6KOy18xJ9pw3pX7Z
        vu7FrI61X8yqVJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEF191357F;
        Thu, 19 Oct 2023 12:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ckROZ0lMWXbSQAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 12:48:29 +0000
Date:   Thu, 19 Oct 2023 14:48:29 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 3/4] arm64/entry-common: Make Aarch32 syscalls'
 availability depend on aarch32_enabled()
Message-ID: <ZTElnWpvwcxPsfls@apocalypse>
Mail-Followup-To: Mark Rutland <mark.rutland@arm.com>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com
References: <cover.1697614386.git.andrea.porta@suse.com>
 <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
 <ZS_WHHnWzfkKtJWs@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS_WHHnWzfkKtJWs@FVFF77S0Q05N.cambridge.arm.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:57 Wed 18 Oct     , Mark Rutland wrote:
> On Wed, Oct 18, 2023 at 01:13:21PM +0200, Andrea della Porta wrote:
> > Another major aspect of supporting running of 32bit processes is the
> > ability to access 32bit syscalls. Such syscalls can be invoked by
> > using the svc instruction.
> > 
> > If Aarch32 emulation is disabled ensure that calling svc results
> > in the same behavior as if CONFIG_COMPAT has not been enabled (i.e.
> > a kernel panic).
> 
> It's not "emulation" it's directly supported by the hardware.

You're right. I also struggled to use this label but I just reused the same
name from Nikolai's patchset for x86, in the hope that the option would be
more recognizable (something like 'ARCH_emulation' that could be used maybe
for other platforms as well), but I agree with you that this is highly
misleading. I will change it to something more straightforward.

> 
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  arch/arm64/kernel/entry-common.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index 69ff9b8c0bde..32761760d9dd 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -802,6 +802,11 @@ asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
> >  }
> >  
> >  #ifdef CONFIG_COMPAT
> > +UNHANDLED(el0t, 32, sync_ni)
> > +UNHANDLED(el0t, 32, irq_ni)
> > +UNHANDLED(el0t, 32, fiq_ni)
> > +UNHANDLED(el0t, 32, error_ni)
> 
> IRQ, FIQ, and SError are not syscalls, so the commit title is bad.

Agreed. I'll call them exceptions.

> 
> > +
> >  static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
> >  {
> >  	enter_from_user_mode(regs);
> > @@ -821,6 +826,11 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
> >  
> >  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
> >  {
> > +	if (!aarch32_enabled()) {
> > +		el0t_32_sync_ni_handler(regs);
> > +		return;
> > +	}
> 
> Why do we have to do this at all?
> 
> If we don't have AArch32 tasks, these paths are unreachable. Why do we need to
> check that they aren't called?
> 
> Mark.

Agreed. Please see also my previous comments here:
https://lore.kernel.org/lkml/ZTEKabxNdegsbxyv@apocalypse/
https://lore.kernel.org/lkml/ZTD0DAes-J-YQ2eu@apocalypse/

but again, that's only speculative as of now, so we can ignore that part.

Andrea
