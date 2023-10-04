Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E697B7A19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbjJDIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbjJDIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:32:54 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF00D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:32:51 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5373F40E0176;
        Wed,  4 Oct 2023 08:32:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WggtAmaRNGsN; Wed,  4 Oct 2023 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696408366; bh=O4CwRbuRelGXMSOb280gHAYwKgs13o50KAGxFAAybuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1RZZ5lP3XBF5cmWzO9Q8Pnu5NxKX/moh36PdC7ZwpeaoHHoM6TAhonOKlm7uxqKs
         hVKUxqCZD8GWkOOQpJFT6EEBmuex305KUvK0+qqMf37/D6pBktLxIFX7doLi2vGyWT
         eF5ln6O9vyjVvMoxzHtqxs8KvkGpQRNFhqNQPVra2huZJWMPP9H+Uf/2FEbSKypjF6
         4NjlHWY7u889BU9ad5ixm0JfEAc37jXBHiRaBt59sst5cRUhKkX9TknYQ4xlXEEbyc
         7F7Vv96QQItlUPOuShcvV92tG3FtShBs8Cgx5bVo4iYEPyBI2VINBQVZ9ACrAMgKMK
         mKXyh6hFn6w84Q4A9uythGe8T+VOmgoVJ9+j+9Ocftbfzvjft8O/lgPNTGh4bLNI4P
         Tcr2FFXoNNRCaOXZ8iwb/8ivYxnKhs4nZhXpqWzhoN6E98LzxN9s41OME0wgOqkEBS
         PXT/HcjCBlzVpbX6UbERQMy0lgI4pqO6oU2AfQ1IsEsqLOculzCGOYwV4c3xq1bXdO
         HX1Sl25flo1eeOysBCUOet/OyvYilCxCYeaG6poE9y22nWrzMTqmxB4OELsMeDhdwU
         r2VDhNug4BV8JE24onb3D9CMnKWzAK0Jv+1zmS9QTt1XVblcHyUnuqrSw4gn4HWrP2
         kejO1h/QuL4ldpvrP6bSCIsg=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB6A840E0081;
        Wed,  4 Oct 2023 08:32:40 +0000 (UTC)
Date:   Wed, 4 Oct 2023 10:32:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V4 14/30] x86/microcode/amd: Read revision from hardware
 in collect_cpu_info_amd()
Message-ID: <20231004083235.GDZR0jI3TPtC96p0d0@fat_crate.local>
References: <20231002115506.217091296@linutronix.de>
 <20231002115902.854919221@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002115902.854919221@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:59:51PM +0200, Thomas Gleixner wrote:
> Prepare to decrapify the core initialization logic which invokes
> microcode_ops::apply_microcode() several times just to set
> cpu_data::microcode.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/cpu/microcode/amd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -634,12 +634,12 @@ void reload_ucode_amd(unsigned int cpu)
>  
>  static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
>  {
> -	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> +	u32 dummy __always_unused;
>  	struct ucode_patch *p;
>  
>  	csig->sig = cpuid_eax(0x00000001);
> -	csig->rev = c->microcode;
> +	rdmsr(MSR_AMD64_PATCH_LEVEL, csig->rev, dummy);
>  
>  	/*
> * a patch could have been loaded early, set uci->mc so that

Skipping that one as the rev needs to be read on the respective CPU for
mixed silicon steppings on AMD.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
