Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1954D7FECE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjK3Kd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Kd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:33:58 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB3D6C;
        Thu, 30 Nov 2023 02:34:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 211CF40E0239;
        Thu, 30 Nov 2023 10:33:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qDV6vmf5xhZb; Thu, 30 Nov 2023 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701340437; bh=ZShKLR6KTqCxQjQYunnv0hUCXzw06oeZAelERVmHTQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUacy/IhrUmBX+T4V8uG+XUxD6xFGliuzIbVZ3B+kYG4exrusgge1fZUdK67RfTT2
         VO7BA3K1PVpEv5J3ia+lAcqrqVNiYm+im2n8Bp4W6kWWPlxI0tpE7IclYzDF6+hak0
         uv3muctBuSAt0+9H9Ra99lDoMGHGj63T0fi2s2cKUd/xWU1bmJLn+2wryxveFdbdhe
         fASsgito5Rh6UIW43EPSLGkRWbgc77DB33ivrPINaBfdYpfb0CjR2NBwWeGSxzHJe0
         xipJhkHM5FQ3x6rwiRC60YTNc/cJ7nRnYnIklCUEr9SSZPzxeN+ebD0CFMvwn+MR6x
         YCFrduzg+1v3cSAEfMxs3OxwD5PlABBr+C4RATojzd6arNEGHsDRa/3TBhIGkneCvC
         hNJROiUmDrC5dvf/AnFKffyPs0hLAtMGfaqNjhtH2tZtpwX/qaZoXmlvxZSBZ2ymep
         HCyH7ByOMmY9StBJSFeaZhEI1tgNSFWI4PqE7k9+R3f1zLYI2l5aDLnnluvGiM0pzO
         0dY2ok4Mvvy8zANHMjKS9IDh9G9nhoYDwU9q86XtjngyD1tU23jbrUYkwrihBaMvqn
         AvsQGJ5EP9vTJwNtXoKmt36UxgG0v1qpc2r5hWMkcDQod9Z1GccV+yjkkdyxLqoMSq
         ZCO9zh7NCiJof8jofkTMqRCU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C733640E01AD;
        Thu, 30 Nov 2023 10:33:44 +0000 (UTC)
Date:   Thu, 30 Nov 2023 11:33:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jun'ichi Nomura <junichi.nomura@nec.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Message-ID: <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:59:44AM -0000, tip-bot2 for Jun'ichi Nomura wrote:
> +void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
> +{
> +	/* Empty handler to ignore NMI during early boot */

It might be good to issue something here to say that a spurious NMI got
ignored.

Something ala

	error_putstr("Spurious early NMI ignored.\n");

so that we at least say that we ignored an NMI and not have it disappear
unnoticed.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
