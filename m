Return-Path: <linux-kernel+bounces-30112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B378883195D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7D282F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4824B53;
	Thu, 18 Jan 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sJB4mONY"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055E25116
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581896; cv=none; b=ihvLkhaQRIooUThaDBpT6/ljmuhAhrkHCNrLW8qxJwNqL0DNZqwXkJWhdE+4Rev9YJXMjMT/lm5rtL0HYBC/LjK1+HsykrOLmZthfOfdcwOPu8GRvLglkEgZq5wErRqz5e6iLlWeUnqh5PWG25VtTmBuKykMxCDtrVpuvekNOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581896; c=relaxed/simple;
	bh=37Nm1D6XQrs+VsUMHb4aux5DEe0RfLXArjfaU4qNE7E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jeh/N8l1GoGqqpMv3fkRFScKv+/dyeIsr5K0pdnJe9D8WjZAc6Lw3rum/AHieyzSrRb1HS0PJZvNVLLzxiTnzIrtzw6ud9Ke37MYn7BWSNn03biZa2K6YxsxRGKJ5Doj+2q8WX/d9zP8RzpRDO0BSn77uo0JiLHpjpAYZ2NO410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sJB4mONY; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3608cfa5ce6so56361385ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705581894; x=1706186694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CWJqfzPlIKbIm9XXUGeYPV3xbAqaiB/K2JIOon3tWs=;
        b=sJB4mONYac4ucb+zlyOttrKg+C2KJdOhwVGrwOOOqeAhzOkQgatCRZ/XS6iyDeRQ1J
         LxKZhW6YnLCyUDVymX2un0bqI6gqc+ClQr8OJKRfF089QLglA8DMMRNoP1Fiae/4cOaT
         tVKJBSMyPJUMOFEKv2+3d/St9EDiz4IkRbeG3JNmYLGeC0ZE0GDjA+GXyS+uL2NPWFW+
         eChxVp1f7KztacUVaud4fLTsX+wqk9t47ltJNTwCL/KCf/021hCZVD7rOku9fDkSjeWy
         9z8IToguiLrlmkU4jrVIXgf0HO0icZjunON4RNbgkUovKIXq9kg2Mn6sMp9bkYkbv9T0
         plyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581894; x=1706186694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CWJqfzPlIKbIm9XXUGeYPV3xbAqaiB/K2JIOon3tWs=;
        b=WI+RzJWYB5yoe5AerVYwu6FUkyFaL+Et1IEIcqNrzJDKusB+oH+UNf1oKRDYaGca3N
         XGxMnimDFWXe9seAOj0f61GDqROo4akHeD4mZbzxXUvhnkmuzq3qRuUpsKxI8VozPWk/
         H8iPPxQITG7CBkxq54uBd2aQCK9JmWrdvPw2KWXlaqGjv4q3cOw44N+2TamqqOOIZ4/5
         WoYEbW3VLLsWrjR2AlE4YfdpjZztrePrcb4fRdvMJobti24kL/3Twc+BPh0VaByGUvhG
         njRtaue63Ty0krYTN+B8DWj6wusNI1cKrcMNPqGSJNDCZQWus42jlKPEsQ6D4+sKUFCY
         1sxw==
X-Gm-Message-State: AOJu0YzOJwZgIeEjLnGvaa06yXpuWiDrARIB6F/ifkXtLeqAd0wS5dgx
	zVDDJcCg5aVLGwQNINjCrgiYU5nvdYd55B5t75JX70D3p7NtqA/iKNCadpOrrQIpkrfngxhg+X6
	Rmmp2VdcIElvJ5yFArfKS/YMIFhAs/synXMF9LQ==
X-Google-Smtp-Source: AGHT+IFJ1bu7mCR98lyWrW+kDP0nULQ1bDHopDCzu01vUiZEYsTfjPTku/pcO21lNxa+IQGYXi5gy2BL1dSF+jC1bNQ=
X-Received: by 2002:a05:6e02:96d:b0:361:a21d:d492 with SMTP id
 q13-20020a056e02096d00b00361a21dd492mr227444ilt.24.1705581893859; Thu, 18 Jan
 2024 04:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128145357.413321-1-apatel@ventanamicro.com>
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 18 Jan 2024 18:14:42 +0530
Message-ID: <CAAhSdy0Q8raGzH_mUsvAo++KmWu3yqBkjNTrn8CO-ZCiYEY9Cw@mail.gmail.com>
Subject: Re: [PATCH 00/15] KVM RISC-V report more ISA extensions through ONE_REG
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 8:24=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This extends the KVM RISC-V ONE_REG interface to report more ISA extensio=
ns
> namely: Zbz, scalar crypto, vector crypto, Zfh[min], Zihintntl, Zvfh[min]=
,
> and Zfa.
>
> This series depends upon the "riscv: report more ISA extensions through
> hwprobe" series.from Clement.
> (Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosi=
nc.com/)
>
> To test these patches, use KVMTOOL from the riscv_more_exts_v1 branch at:
> https://github.com/avpatel/kvmtool.git
>
> These patches can also be found in the riscv_kvm_more_exts_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (15):
>   KVM: riscv: selftests: Generate ISA extension reg_list using macros
>   RISC-V: KVM: Allow Zbc extension for Guest/VM
>   KVM: riscv: selftests: Add Zbc extension to get-reg-list test
>   RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
>   KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list
>     test
>   RISC-V: KVM: Allow vector crypto extensions for Guest/VM
>   KVM: riscv: selftests: Add vector crypto extensions to get-reg-list
>     test
>   RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
>   KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
>   RISC-V: KVM: Allow Zihintntl extension for Guest/VM
>   KVM: riscv: selftests: Add Zihintntl extension to get-reg-list test
>   RISC-V: KVM: Allow Zvfh[min] extensions for Guest/VM
>   KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
>   RISC-V: KVM: Allow Zfa extension for Guest/VM
>   KVM: riscv: selftests: Add Zfa extension to get-reg-list test

The first PATCH is already merged in upstream Linux.

I have rebased and queued the remaining patches for Linux-6.8.

Regards,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h             |  27 ++
>  arch/riscv/kvm/vcpu_onereg.c                  |  54 +++
>  .../selftests/kvm/riscv/get-reg-list.c        | 439 ++++++++----------
>  3 files changed, 265 insertions(+), 255 deletions(-)
>
> --
> 2.34.1
>

