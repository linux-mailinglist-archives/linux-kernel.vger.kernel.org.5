Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D07B3ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjI3HSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjI3HSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:18:20 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C861B7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:18:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 21E5D40E01A1;
        Sat, 30 Sep 2023 07:18:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mFrFMCy--mhG; Sat, 30 Sep 2023 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696058291; bh=Naxm9oTFatb2xIDG9q2KAGbarRhctcJ38PpFJyBdl0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3bO5BWFPwdSRzEToXHMumY7lG2UPvdjPBoOO88JoZvd8HnELq8XHlWZupn9FpVNt
         Osva2o7uDK0+5P/OhyKtsMdRr1OepMNIMFfiJmDDbm7yvoFmMtusF/v8fwj3LWj3kg
         lrUTQfgil0MmTISHvVIsIji6f5oRetSY8gGk64+U5a4ED4XnLx/doLUF3epoXAqdML
         xtjrj3ougkIQLg0iNB8IgZiUow++rdn3nF2LL7Wqvfld3+pk4cpqzn+5VckPvuy60O
         +Nd8Oh5bJkhDZ3tyonLX4ewfK7ZXJRWnQ0NdP3ep/vYbWYF9UHgsb78kwUXakVN/Sh
         YS6RzCSpN1mbGhCvCPe3Ho+kvmJ6bDNlU+IzPhkjBTo2pfDGKqEatfb1ozPk3rFCed
         0KPH0MnJFyIcN5537HrTchZbxim2gIl68AoJKzTFIegEveSOon1FftQXdOp8PdVL6H
         3uaQ9A1l6PnN8yJinzBxXtbuN2OadiETDNXSzbMHdxacsOW4Pk+1+uAiscvxU0Gfbu
         YOWLPu2FuHx/pJNRnktsbMe8FOSYIMkl8twi2dKqBXVYLT0Ozty2BhNAPqwWCesTrn
         C40ctBysmugy7g7yvAN4F5EvMd7cbPFWArwyixzkYBjNy6eCeX5d1345WSjhAVm8mE
         /eIaCMBl1ICA7lXx1ushS/ls=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 718D140E014B;
        Sat, 30 Sep 2023 07:18:06 +0000 (UTC)
Date:   Sat, 30 Sep 2023 09:17:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
References: <20230926040526.957240-1-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926040526.957240-1-aik@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:05:26PM +1000, Alexey Kardashevskiy wrote:
> vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
> We lock the main GHCB and while it is locked we get to

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
> triggers:
> 
> vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
> Here we lock the backup ghcb.
> 
> And then PMC NMI comes which cannot complete as there is no GHCB page left
> to use:
> 
> CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
> Call Trace:
>  <NMI>
>  dump_stack_lvl+0x44/0x60
>  panic+0x222/0x310
>  ____sev_get_ghcb+0x21e/0x220
>  __sev_es_nmi_complete+0x28/0xf0
>  exc_nmi+0x1ac/0x1c0
>  end_repeat_nmi+0x16/0x67
> ...
>  </NMI>
>  <TASK>
>  vc_raw_handle_exception+0x9e/0x2c0
>  kernel_exc_vmm_communication+0x4d/0xa0
>  asm_exc_vmm_communication+0x31/0x60
> RIP: 0010:snp_cpuid+0x2ad/0x420

Drop that splat like we talked.

> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
> +#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) ({				\
> +	int __ret;								\
> +										\
> +	ghcb_set_rcx((ghcb), (msr));						\
> +	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
> +	if (__ret == ES_OK) {							\
> +		low  = (ghcb)->save.rax;					\
> +		high = (ghcb)->save.rdx;					\
> +		/* Invalidate qwords for likely another following GHCB call */	\
> +		vc_ghcb_invalidate(ghcb);					\
> +	}									\
> +	__ret; })
> +

First of all, this should be a function, not a macro.

Then, it should be defined only in sev-shared.c for now.

Furthermore, it should not be called "rdmsr" or so but something like

ghcb_prot_read_msr()

or so to denote that it is using the GHCB protocol to read the MSR. I'm
sure it'll gain more users with time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
