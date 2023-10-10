Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5B7BFCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjJJNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJJNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:11:23 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682619E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:11:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE53540E014B;
        Tue, 10 Oct 2023 13:11:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WjwUpLhPDHOh; Tue, 10 Oct 2023 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696943476; bh=s6hwso6prMDxVtqqxwRgLVjr6kJJ/eMt+5h8SrEfaZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7HjwvgaEuwNjby0WAPT/Le2DYgCXACPXm21ti5Srgr9Ml+u0PjDZHRqbPkYvrItm
         xAd1Af4xlme+kQEvI2rPtAQW6RNQVeZRXyVpop5IH96Mo15BAKIgccKqCIdKXojtYI
         6hYIa5IsOwwJhim39J3YpLSjdCjk91B48N0udOEzmHVZIAcWrUqasV6CJcvc947KnG
         e2ZTyhKPwckfHPaLAeREr57FJrunRTGLTiLrfJkVpLCMqfTMvzAjYElR5iWt/DvHv8
         vsseuS0KqGQV9makU16QKEu+6NmumZc2rGT8D5T12pY/z6Pg2+vCRQo1PftJtMsyl+
         3Qd2BLfFN42UAj/7c/uOE2YNnfwfouZC3aKotFWlDBwlhRqDFfOtAAJj9jwirV7gt2
         mF+VRJkIyRS9ULEJvWYlF6R0MjCGcNb54g8hlpCxNh79y/mX2oWly5MLAYhrfRdMbd
         xR5S/MWhdQuFXTrift2BcgcAkc6w4bgKVIHIA1jJBNQgyJZS9Md9HAeVgM1OqJPuVp
         xOFFm81+ZEws8Os9u7aVu71cnZNERL0JjAe02qF+O45DnZlBwJHtXTj12PvO9QDn8a
         cBo9lD7sKEE184oNMFZUoj+mwH1RL0/yXCrNvxUiL/gqEkGnIo0+T7H3i4Q5T+J4ZP
         E/d1mmRBiy69wibl71K1BJEs=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1931340E01AE;
        Tue, 10 Oct 2023 13:11:00 +0000 (UTC)
Date:   Tue, 10 Oct 2023 15:10:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010131054.GHZSVNXhruJIx0iCzq@fat_crate.local>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010101056.GF377@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:56PM +0200, Peter Zijlstra wrote:
> Now, obviously you really don't want boot_cpu_has() in
> __VIRTUAL_MASK_SHIFT, that would be really bad (Linus recently
> complained about how horrible the code-gen is around this already, must
> not make it far worse).

You mean a MOV (%rip) and a TEST are so horrible there because it is
a mask?

I'd experiment with it when I get a chance...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
