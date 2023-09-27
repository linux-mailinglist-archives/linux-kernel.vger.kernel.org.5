Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AC7B00E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjI0Js6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjI0Jsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:48:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204CCC0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:48:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so12707811a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695808121; x=1696412921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeLDEtHk1VETK7POHub9wpgkckkjlOPVvFzZdvXKp5E=;
        b=TSi7VVh8HXG1zbtPEoVloqwrKAFAskcbCYUqIVc4tcvuzd2IHzVlojk9/0mifw7Xoy
         CPgohLIYoMxkzyHHPg//OBylwh0GvV9ehZ+mYuBAHW+GDd6c1KRFGwonfzjYSrNBQe4L
         wH33Is+DKFpDvS8PprJaAPaYCuEUJuAccJvU+XB6sXe+xHjkgEmaTMRyQUwjcswcbYDv
         9zDXuxw/cYXJjVh1Y4lRePCaLDB/soyktl/9OZLyhYB6pPEIPCvSnFvYGVJvWjkhAkkM
         mGndnFgaapDMNESsmWC39y1WKw1kaHVzfdv/2htjXKcxR9fkkLfU0k/xLGxJsq/7RZzx
         +fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808121; x=1696412921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeLDEtHk1VETK7POHub9wpgkckkjlOPVvFzZdvXKp5E=;
        b=J641t189myz5OXxf3VYfVR+ladfHcgqnryw76j2kcykQhhBdOG7oB92I/WYjWO2+6c
         bO5AWxK/FMk8T9fxRUw9v1LsOhbJ9WouKL7kmju7+OD9u8WZ9xeFiDL/xJMSEslNTDeP
         DxNxoZD+nZEE4Osd+YNQafB7UZBEHODng9Y4fqz+v7+nlqlF3+cWI55JKvCXljTltjiw
         mmj6ph8dpiIk5szV4oWkZvtMbkRmzKaBQgDomqWemdtx/+j/pGiOFpVB/a/yexoUVGOS
         GRH7MxptxhDDrSyunZ17rLSUtJC4Ywzn1UQA9WymM1RMRFMT8vTR0UUYtsSPKCAsCW0O
         KeuQ==
X-Gm-Message-State: AOJu0YwKGqO85MFk3dLCpfLJifc/Ef76U+9ZXdQ9cRr1GoYNrGtPBd4V
        PufVi407zqd7rId2PJKssQY=
X-Google-Smtp-Source: AGHT+IE6lnGPCQJOoXTaG1Nx32iClR7Y3h0foihyIyGm5y9uMhdR/9xyL0ptrsm22CwKfif3lIIPvA==
X-Received: by 2002:a05:6402:1a21:b0:530:9bea:ed5e with SMTP id be1-20020a0564021a2100b005309beaed5emr1580387edb.14.1695808120574;
        Wed, 27 Sep 2023 02:48:40 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id u7-20020a05640207c700b005311e934765sm7965157edy.27.2023.09.27.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:48:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 27 Sep 2023 11:48:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRP6cd6rEymUaiL+@gmail.com>
References: <20230926040526.957240-1-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926040526.957240-1-aik@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Kardashevskiy <aik@amd.com> wrote:

>  arch/x86/include/asm/svm.h   | 14 ++++++++++++++
>  arch/x86/kernel/sev-shared.c |  5 +++--

Doesn't build on x86-64 allmodconfig:

  arch/x86/kernel/sev-shared.c:442:75: error: ‘ghcb’ undeclared (first use in this function)
  arch/x86/kernel/sev-shared.c:442:81: error: ‘ctxt’ undeclared (first use in this function)

Not sure how this was supposed to work - there's no 'ghcb' passed in to
snp_cpuid_postprocess(). Does this patch have a dependency perhaps, that
I missed?

For the next version please also pick up the edited changelog I've done,
see below.

Thanks,

	Ingo

====================>
From: Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH] x86/sev: Reduce #VC nesting for intercepted CPUID for SEV-SNP guest, to fix nesting crash

For certain intercepts an SNP guest uses the GHCB protocol to talk to
the hypervisor from the #VC handler. The protocol requires a shared page so
there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
handler triggers a #VC, there is another "backup" GHCB page which stores
the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
The vc_raw_handle_exception() handler manages main and backup GHCB pages
via __sev_get_ghcb/__sev_put_ghcb.

This works fine for #VC and occasional NMIs. This does not work so fine if
the #VC handler causes intercept + another #VC, if NMI arrives during
the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
The problem place is the #VC CPUID handler. Running perf in the SNP guest
crashes with:

  Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use

  vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1

We lock the main GHCB and while it is locked we get to
snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
triggers:

  vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0

Here we lock the backup ghcb.

And then PMC NMI comes which cannot complete as there is no GHCB page left
to use:

  CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
  Call Trace:
   <NMI>
   dump_stack_lvl+0x44/0x60
   panic+0x222/0x310
   ____sev_get_ghcb+0x21e/0x220
   __sev_es_nmi_complete+0x28/0xf0
   exc_nmi+0x1ac/0x1c0
   end_repeat_nmi+0x16/0x67
  ...
   </NMI>
   <TASK>
   vc_raw_handle_exception+0x9e/0x2c0
   kernel_exc_vmm_communication+0x4d/0xa0
   asm_exc_vmm_communication+0x31/0x60
  RIP: 0010:snp_cpuid+0x2ad/0x420

Add a helper similar to rdmsr_safe() for making a direct hypercall in the SEV-ES
environment. Use the new helper instead of the raw "rdmsr" to avoid the extra #VC event.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230926040526.957240-1-aik@amd.com
