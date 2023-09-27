Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16077B02EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjI0L2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjI0L2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:28:09 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F981B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:28:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4926540E014B;
        Wed, 27 Sep 2023 11:28:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LyA6T7BOW5AX; Wed, 27 Sep 2023 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695814083; bh=waqKRIaBA2IqOwcXyBMuzMAn22MXqhmh7ug3E5Ctzaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cled2b+OOqq3GTxypoZkDAw4aFQ2ghE11Db278QNa9O6EU3tz0z/+uAeD/83if8Kq
         0J0jbQbetKyGo7hbzXV8PH1ZTaoUlbPFmdUMU5+yyJl9m8BhU6fGtpjJ01+ysN04zb
         kTeytL8TKgHk4vdK8W8izx5erFmmrvNuOlqgD+Hk0UCf+JTRnN1STg9HKIAYJW38u6
         oSB6qgVQ0FkcoKUSiFtXcxaQzkF/mMoSvCLj51Ru51XmVvaFabLEhE669nPCKplTdK
         8SR0JdFirxS5Shb+yM28gP1kqYc9HGtUauJ4PThruYQ5i+DzGPr53hVZMhlDVNdE/Z
         vTH2Z3SI6iR2Bih4YOog+MJr3IX8qH648HY2+dp6dFY/AmJPw2vjxvckElE3wNosCb
         a99G/nHQicyr6LFLBHCcVz/YQvCzmaGqYj02MnXdng4ibKc9dMfyG2pI+CPyIs5lyO
         cDPEJFKgEZXqnwgyEb8hyranniDuk96IFVcZPr9r8OYcmmO/mycg5uN6M2F0vpF+12
         E+p75KP8rroKEfbwqlEI0a+T6unl++E8A54BLg5SEFOAp+pTP8zRNaf1DQtQPPBnlg
         KEN53XiVw1ypHEp0s5Z9HiwfxGYVDEVHffqvVpQFbcIqX/zht/4CDDn+Cehkzndl2P
         cfsrf0cYU/ThFaZ3ic363z2I=
Received: from nazgul.tnic (unknown [2.247.249.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1CCBA40E0198;
        Wed, 27 Sep 2023 11:27:57 +0000 (UTC)
Date:   Wed, 27 Sep 2023 13:28:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 21/30] x86/microcode: Add per CPU result state
Message-ID: <20230927112800.GBZRQRwFUWs0bKTP7Q@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.082789879@linutronix.de>
 <20230924062934.GLZQ/XThoM7jsrjmrt@fat_crate.local>
 <87sf71fgia.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf71fgia.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:09:01AM +0200, Thomas Gleixner wrote:
> That starts to get silly. The struct is used only in the microcode realm
> and nothing which is globally visible. ucode is a pretty obvious and
> established shortcut. But so what....

Ok, which prefix do you propose?

"microcode_", "ucode_"?

And I chose "microcode_" a while back and planned on converting stuff
gradually when touching the code and not do solely a renaming patch.

All I'm saying is, we should be consistent.

> > You could do
> >
> > static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
> >
> > so that the naming is different too.
> 
> And that solves what?

I find it somewhat confusing when the variable name is called the same
name as the struct and I try to have the struct names be more expressive
than the variables of the same type.

But not a big deal.

> > No need for "ucode_" prefixes to static functions.
> 
> What's the problem with that prefix? The function name clearly says what
> this is doing.

Giving proper prefixes only to the externally visible functions is,
I think, a nice way of showing what is what. The static, internally used
symbols, OTOH, don't need a prefix and when you look at the name, you know
immediately whether it is a static symbol or an externally visible and
potentially used by other things. We do that already for other code,
like global variables, for example.

> Nope, because stop_machine_cpuslocked() does not usefully accumulate
> results from all involved CPUs. But it can return errors related to the
> invocation itself, which is a completely different story.

Ah, I see what you mean:

" * RETURNS:
 * -ENOENT if @fn(@arg) was not executed at all because all cpus in
 * @cpumask were offline; otherwise, 0 if all executions of @fn
 * returned 0, any non zero return value if any returned non zero."

So we have to return 0 here. Oh well.

> That's why ucode_ctrl.result is per CPU and has to be evaluated
> separately.

Right.

> >> +	/* Analyze the results */
> >> +	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> >> +		switch (per_cpu(ucode_ctrl.result, cpu)) {
> >> +		case UCODE_UPDATED:	updated++; break;
> >> +		case UCODE_TIMEOUT:	timedout++; break;
> >> +		case UCODE_OK:		siblings++; break;
> >> +		default:		failed++; break;
> >> +		}
> >
> > Align vertically.
> 
> Align what?

		switch (per_cpu(ucode_ctrl.result, cpu)) {
		case UCODE_UPDATED:	updated++;	break;
		case UCODE_TIMEOUT:	timedout++;	break;
		case UCODE_OK:		siblings++;	break;
		default:		failed++;	break;

But meh, it's ok either way.

> and setup_cpus() then tells what?

See above. I think there's a merit in distinguishing the symbol scope
based on the naming only but I'm sure you have an opinion... :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
