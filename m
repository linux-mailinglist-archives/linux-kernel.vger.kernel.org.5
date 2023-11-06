Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410A7E2B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFRrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:47:37 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA40D4C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:47:34 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f066fc2a28so2338441fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699292853; x=1699897653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK4uYtCWASAh5nxvSUgk2a3NS0yQI0Q/PF/dmiOH8ms=;
        b=CVf3bS1oPIgRR9WwVZ5J8LnqOWTeY9j54x6syDdFN6J7Cru0+B7H9amudVbyYleG4k
         teHmCqSCTSPctdUlV7FP0yNGEfKUbDknSvX26GlO6Gx+EXvsNQlU1IlFjLCcyI0361i5
         W+QkDA9hUKl7YIGyJAP7VNTu6/4alkzSnWiFBWh8zYrfSfGrlY3GTqUgGQ5s1C0pf5ar
         FfIQlTGbUDLH5RHEtNQs3zfYugzPXGmhvLY1mDJ9Hze+J/YMw3higmwmJaGSRhGbwo2l
         Y0Wt8xoQt//zEWgeVsAeB7uTIBU1bCClq+FUI7K6pLGC8STcdvnxjKQui8IQFsKdggpW
         o8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292853; x=1699897653;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK4uYtCWASAh5nxvSUgk2a3NS0yQI0Q/PF/dmiOH8ms=;
        b=TbUBWSDb5P8Qau0ASXiLdP3Jv3aiOEl9A3n9OTMrEu1Zc1cvGswJY2L9xhjdm2Eh7q
         nUc4gXhuwHkpa15FR0xy9WiVKLaTxavpfvUhkL4W3167KsvR8NvbRfu0AtwaoJ78fF6a
         Iw/wJGlqZcA4ctgq3I89MeccO59+L4hW9rtTV0sgxvdGlc1xaOW2i3v9PSwgMfUC5jJk
         DOy8cXrwUfyNkkSEYZaopsrblJVy8JCXAYgbmN1b4f8ToFPlTvCqrpN6lHRZVClBGWiS
         fEmpVy38g9/aIoFfC4isY8fwnmw4YGgqT6wOlO+5vFGfS92ExwY55x9vnjpNxfwqm63R
         D8Pw==
X-Gm-Message-State: AOJu0YxrBwKKSPo/idOiX4f/kAhNG0GRQ3/PbWvcyP1dgGyWMnI323O6
        oYAJLYv+QWLVwCzIfxQ8El8VLA==
X-Google-Smtp-Source: AGHT+IFGSnSfFc6b5MBPxmnaVZPt275KPab3iutOmg8Iu0JyM8F+e9ss29YnSmuuK35tariXtn+E0g==
X-Received: by 2002:a05:6870:6b09:b0:1f0:cef:6a45 with SMTP id mt9-20020a0568706b0900b001f00cef6a45mr411591oab.56.1699292851972;
        Mon, 06 Nov 2023 09:47:31 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id ec29-20020a0568708c1d00b001e9ce1b5e8fsm1473031oab.15.2023.11.06.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:47:31 -0800 (PST)
Date:   Mon, 06 Nov 2023 09:47:31 -0800 (PST)
X-Google-Original-Date: Mon, 06 Nov 2023 09:40:42 PST (-0800)
Subject:     Re: [PATCH v2 5/5] riscv: kvm: use ".L" local labels in assembly when applicable
In-Reply-To: <20231024132655.730417-6-cleger@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, atishp@atishpatra.org,
        ajones@ventanamicro.com, cleger@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     cleger@rivosinc.com
Message-ID: <mhng-467ba655-d75b-4197-b3cb-4b3f97ff0d26@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 06:26:55 PDT (-0700), cleger@rivosinc.com wrote:
> For the sake of coherency, use local labels in assembly when
> applicable. This also avoid kprobes being confused when applying a
> kprobe since the size of function is computed by checking where the
> next visible symbol is located. This might end up in computing some
> function size to be way shorter than expected and thus failing to apply
> kprobes to the specified offset.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_switch.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
> index 8b18473780ac..0c26189aa01c 100644
> --- a/arch/riscv/kvm/vcpu_switch.S
> +++ b/arch/riscv/kvm/vcpu_switch.S
> @@ -45,7 +45,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
>  	REG_L	t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
>  	REG_L	t1, (KVM_ARCH_GUEST_HSTATUS)(a0)
>  	REG_L	t2, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
> -	la	t4, __kvm_switch_return
> +	la	t4, .Lkvm_switch_return
>  	REG_L	t5, (KVM_ARCH_GUEST_SEPC)(a0)
>
>  	/* Save Host and Restore Guest SSTATUS */
> @@ -113,7 +113,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
>
>  	/* Back to Host */
>  	.align 2
> -__kvm_switch_return:
> +.Lkvm_switch_return:
>  	/* Swap Guest A0 with SSCRATCH */
>  	csrrw	a0, CSR_SSCRATCH, a0

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
