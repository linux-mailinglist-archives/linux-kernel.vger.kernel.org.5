Return-Path: <linux-kernel+bounces-14699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A096D8220D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C81F1F23245
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C0156E7;
	Tue,  2 Jan 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBzVAXry"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF65156D6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704219499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqNcOVDP8DdJ819qPbE88DE6/hMQSOntgNZh+qc4qEc=;
	b=RBzVAXryavdEXf4ATb7s60KSn+zmd63naMKOhsyCto4zD8TcxAWNtxrq968KduR9ZzhQTj
	watAH7cjO0d5TwDCiWMTV7YK3gChVNhYJIIdDPVRa8jOpY9lKfOGMc6Fpwr74fHp5DPsNg
	6Ek7QVRWUiKXwT1PvWEbOpknDcn0OLg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-oFMZ16BTOse4w9EJg6vKFw-1; Tue, 02 Jan 2024 13:18:18 -0500
X-MC-Unique: oFMZ16BTOse4w9EJg6vKFw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-466ec6d33bcso1833054137.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704219498; x=1704824298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqNcOVDP8DdJ819qPbE88DE6/hMQSOntgNZh+qc4qEc=;
        b=UnBfZQB2SMWLefRCPRqaGCF3RFgYaFy9BUGLKjlZucK4JbAClI1RbJ7aNjvU7NbWQf
         XAnytlOMOr2R4DB6vUFDAR0NMBfRptPRI8mSW8oIqptmpEr0WEuvVE3Ezd7v27Upe84P
         e0gRbBGd29zOwPKNrhLt/MJRksY6P5D4uZ9E2LYmM0jXPBhKk2va3R+37PU04VY8zqve
         fLzYCNQ557uusw/QRxBnpO5mwkKYPQlqf3+YvGewoPsuis37c69HMPj9hdEcPOjYwZs5
         nLpTiMnykU0C7K8OUE3cBtEV1SbmrTJHMA8FpbRwjzEHNk/+TNSB6V7IPtHrWZVAlr1p
         aXtA==
X-Gm-Message-State: AOJu0YxRXIy7svNaW/ijVzgPs339aRU1qZZOvlSqbZiEfLekHA1z8CdK
	3Tj3VdttDuqIYmBWjhzQkGZelgeOEb49WucnLLudECGaKjFAQfQ2YC/QBpZjIEAwgZJC+nRI0B5
	oTnOrza3EMGZdUhXouTzf2+1r9hOYtc/SVAMzBFdn+hzLo4t0
X-Received: by 2002:a05:6102:32cb:b0:467:7df1:93d4 with SMTP id o11-20020a05610232cb00b004677df193d4mr1333694vss.56.1704219497988;
        Tue, 02 Jan 2024 10:18:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVztsrJFmMF0JJjeSQuEPrOTAsB2AewM3tqW1FHbMEMG3rKdHdoK3NErEji+Bu7ltEHjnjBgbxoSTivL4kKWw=
X-Received: by 2002:a05:6102:32cb:b0:467:7df1:93d4 with SMTP id
 o11-20020a05610232cb00b004677df193d4mr1333683vss.56.1704219497723; Tue, 02
 Jan 2024 10:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223120642.1067728-1-chenhuacai@loongson.cn>
In-Reply-To: <20231223120642.1067728-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jan 2024 19:18:05 +0100
Message-ID: <CABgObfZHRf7E_7Jk4uPRmSyxTy3EiuuYwHC35jQncNL9s-zTDA@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.8
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:12=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010b=
cb:
>
>   Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-6.8
>
> for you to fetch changes up to 118e10cd893d57df55b3302dfd188a981b6e6d1c:
>
>   LoongArch: KVM: Add LASX (256bit SIMD) support (2023-12-19 10:48:28 +08=
00)

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> LoongArch KVM changes for v6.8
>
> 1. Optimization for memslot hugepage checking.
> 2. Cleanup and fix some HW/SW timer issues.
> 3. Add LSX/LASX (128bit/256bit SIMD) support.
>
> ----------------------------------------------------------------
> Bibo Mao (5):
>       LoongArch: KVM: Optimization for memslot hugepage checking
>       LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
>       LoongArch: KVM: Allow to access HW timer CSR registers always
>       LoongArch: KVM: Remove kvm_acquire_timer() before entering guest
>       LoongArch: KVM: Fix timer emulation with oneshot mode
>
> Tianrui Zhao (2):
>       LoongArch: KVM: Add LSX (128bit SIMD) support
>       LoongArch: KVM: Add LASX (256bit SIMD) support
>
>  arch/loongarch/include/asm/kvm_host.h |  24 ++-
>  arch/loongarch/include/asm/kvm_vcpu.h |  21 ++-
>  arch/loongarch/include/uapi/asm/kvm.h |   1 +
>  arch/loongarch/kernel/fpu.S           |   2 +
>  arch/loongarch/kvm/exit.c             |  50 ++++--
>  arch/loongarch/kvm/main.c             |   1 -
>  arch/loongarch/kvm/mmu.c              | 124 +++++++++-----
>  arch/loongarch/kvm/switch.S           |  31 ++++
>  arch/loongarch/kvm/timer.c            | 129 ++++++++------
>  arch/loongarch/kvm/trace.h            |   6 +-
>  arch/loongarch/kvm/vcpu.c             | 307 ++++++++++++++++++++++++++++=
++----
>  11 files changed, 551 insertions(+), 145 deletions(-)
>


