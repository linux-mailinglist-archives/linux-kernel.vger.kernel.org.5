Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB27A63CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjISMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjISMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:52:25 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2B99
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:52:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A866340E01A3;
        Tue, 19 Sep 2023 12:52:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X0d7fvwakMJd; Tue, 19 Sep 2023 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695127935; bh=jy0UdsREx8z7iHUf+9XYtzwY6VCcMdrow/j2heB+Jzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zgjw3GcI4wqyPgM1nmZJBGktqclA7cLbPB5UtGm+c1mRbr1kFbM7PNONduM5eRlEt
         e81nkzzbf3BjVVeLLjrqUyEkj+cqUVyseRXSeerjoZHHLGF0YvHD+f3pPJ8CyU8AeK
         +hqizqgl4pK+2w6MvHZLf8vENUosIkyLPOo6ENdFd8TmR9dWNypxPUQztkPaJZCuhB
         JHMvB5+hebgKcSEeoLp1tahy99JfJePaLlPZ7c46ZebitHYMy8Dv4++cWYLXZLak/N
         jIbda9RGm9jqX2BfBKLTKYUD1RpLuKwCxvAfdVheWTXrF3ZpKwa5Iu68KbWgMOY4XQ
         sGpki6gbg+8pQln4gRGiS47tu/Fh7kjoC2wegHaI6i75i7nw9Sa1MFRrx5//pWqnGI
         leiSbMY2aBUp1wkOtXTQDFaVxsZJHwcFFxrwYHj3pe7zPXHR+k5gWkuc1/eL+++8P+
         DzzkCRqTwANLaL7GsUP222F5eeWHEmK9XcMJ84ljOcMoBhunwrz8Y7QUP+p2Ii2Qfp
         ZoyY7ZLE3I96qu43IMl3qQgBp16RRXGdiGOix+rDsGEUhRM3EgbJG5f75wjNC+S3zW
         j7tbOJE4QsxkQxJ2asmaheAk84OItv8fgOX4asE1zhd8bDZsTV2XLvyAg7Nj/Dyx7b
         44Sgbz1rVEfwq+NSU3dFBl1A=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDC6B40E00F4;
        Tue, 19 Sep 2023 12:52:08 +0000 (UTC)
Date:   Tue, 19 Sep 2023 14:52:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 04/30] x86/microcode/intel: Simplify scan_microcode()
Message-ID: <20230919125203.GBZQmZc5C9m24/vEop@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.009527288@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.009527288@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:49AM +0200, Thomas Gleixner wrote:
> Make it readable and comprehensible.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c |   30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -265,25 +265,19 @@ static void save_microcode_patch(void *d
>  		return;
>  
>  	/* Save for early loading */
> -	intel_ucode_patch = (struct microcode_intel *)p;
> +		intel_ucode_patch = (struct microcode_intel *)p;

This got committed by mistake.

> -/*
> - * Get microcode matching with BSP's model. Only CPUs with the same model as
> - * BSP can stay in the platform.
> - */
> -static struct microcode_intel *
> -scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
> +/* Scan CPIO for microcode matching the boot CPUs family, model, stepping */

"... the boot CPU's... " or simply the "BSP's".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
