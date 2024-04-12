Return-Path: <linux-kernel+bounces-143221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8728A35E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F211F22E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31814F119;
	Fri, 12 Apr 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRKtp1aR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64E148313
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947314; cv=none; b=etupz9SqvSV3+LKXnnB62AItAlZoxKGr5GOGg/pDgHkw4CcIXwV5YkiFOpBIj3zwirlUPb92jrL1aQbiLGCx4xZH7qmFQHA2cWVmHQHEwggAZwPdioVGkFteFNTxPCGL/husxE5DltIChelIh3dYPuC7TcbZ1T5Scodb9ChT5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947314; c=relaxed/simple;
	bh=RGNi9rzXqhjGiFDRNP+kvJNM7r5DsV922PEV+oBFzbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pb+/Y7aEoI4WiHxPmLbK6l1NVtZTbZAjPdYxW+iitcX2wIxVEYMBwoSWrTUimetTq7v3lAX6AHk9yiCUl7089P6nwr4mrOjwYw+Q3wmtiWwsxYZdAhUpbN4pOjZRSF7Hq7zkVScJALdJw+HNv2v/QZC5kp04Q+Lg3amlxqJn5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRKtp1aR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so2329961276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712947310; x=1713552110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwPJQIO9PCSTWhMKnDqZU+F6U0uKGIbW0CebiQxQU+E=;
        b=cRKtp1aR39ilgOndDfqFKd2I8mXlLBo/9rxu067W81nhUrTLVRX549n9CeUK4ydiJQ
         pOwmybrh5M0mmKW99QztCdQvlihbQPirulZsFmxm5crWY/LeXwHgUg9M5SCjZkgyUKO8
         h5f0z7NAW/YXZw+tdtlhQyxxxsBMw4HQGTslMVQhMt4aQk3UM24tFLq0ftnJbvycp5Xh
         RmKmZKX7ns+4aDvR4Ou5SqIFnaDTLCovnjabG6zjTbwvla+tEWAHpXzjENqT9fyeDDlK
         QCdTH+Yl0QMWltE8RsLZZ31sC80j/2cLVMziitspG9mMKMP44GwdZC0dMFjGxrz0jISl
         nSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947310; x=1713552110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwPJQIO9PCSTWhMKnDqZU+F6U0uKGIbW0CebiQxQU+E=;
        b=Elj4xaEObSavLJtfVAdDseeJbwm86jv+HdIUuAb/O3aS2KZEfFpQ+28poV0sUnKiaI
         Rz/oiBFqOmUlgaFXQJSKGW54fJQhOtdMptMWcJn7VQZVQmk4qo8Cd/FzfLPRmuRC2hQ3
         RN3AheMq7RDWfXKAJ+qq38+nZl2KmbE3op6xkWXyit570Vqc0tnRfbGOD/IOnabu4K5b
         QG/yIP517MDgvKLlCexetGtTfPMZ6RlrZ53c0NEJ8lx9BfubvRsgbrqXzt5UQ3Rlx3KK
         LI9kvgz/gd7GKn1ZN/s6qJVM4FInR97JkjQnQprza8ZxCkG3v1FP+6JtO4M18g3arpO8
         706g==
X-Forwarded-Encrypted: i=1; AJvYcCXKzh1wvy0rkOVs2c2hLOIIhT9/HlvQ4LvgCydxcLRYYA3UUfFvhfQRfPIY+KMRyzjgM4H5n8KPX/huvvJIpCyUX5Yy6yBeysGCvlF9
X-Gm-Message-State: AOJu0YxooMAk6erk9F7MMauUyOPKwdL01A9DbLcHkOKrX7rw6Ehw7UFm
	BamsvIGMBDNztvIvnRCMzPyr3gqNMpvVJ3VBTq3vHZU3NvixonlwPF6TVdAQLg/sFy5polhVADr
	4+A==
X-Google-Smtp-Source: AGHT+IHybk309r9yeTtvrGIJ+BHxaTibsx4Sw52ihb2S/NcXRw6GqWp6D/rTYKOn+I51ZDcn7hlg9iX2MrM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with SMTP id
 v1-20020a056902108100b00dc78e30e2e3mr936126ybu.2.1712947310492; Fri, 12 Apr
 2024 11:41:50 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:41:48 -0700
In-Reply-To: <20240412084703.1407412-1-wjduan@linx-info.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412084703.1407412-1-wjduan@linx-info.com>
Message-ID: <ZhmAbBGOvldKdkZu@google.com>
Subject: Re: [PATCH] KVM: loongarch: Add vcpu id check before create vcpu
From: Sean Christopherson <seanjc@google.com>
To: Wujie Duan <wjduan@linx-info.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org, 
	kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Wujie Duan wrote:
> Add a pre-allocation arch condition to checks that vcpu id should
> smaller than max_vcpus
> 
> Signed-off-by: Wujie Duan <wjduan@linx-info.com>
> ---
>  arch/loongarch/kvm/vcpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 3a8779065f73..d41cacf39583 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -884,6 +884,9 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  
>  int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  {
> +	if (id >= kvm->max_vcpus)
> +		return -EINVAL;

Do you have a testcase for this?  If I'm following the LoongArch code correctly,
I don't think this is actually necessary.

In arch/loongarch/include/asm/kvm_host.h:

  #define KVM_MAX_VCPUS			256

without a #define KVM_MAX_VCPU_IDS in loongarch/, AFAICT.  And so the common
code in include/linux/kvm_host.h will do:

  #ifndef KVM_MAX_VCPU_IDS
  #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
  #endif

LoongArch's kvm_vm_ioctl_check_extension() reports that to userspace:

	case KVM_CAP_MAX_VCPU_ID:
		r = KVM_MAX_VCPU_IDS;

and the common kvm_vm_ioctl_create_vcpu() does:

	if (id >= KVM_MAX_VCPU_IDS)
		return -EINVAL;

and the common kvm_create_vm() does:

	kvm->max_vcpus = KVM_MAX_VCPUS;

with again no override of max_vcpus in LoongArch or common KVM.  So unless I'm
missing something, manually checking max_vcpus in LoongArch's kvm_arch_vcpu_precreate()
is unnecessary.

