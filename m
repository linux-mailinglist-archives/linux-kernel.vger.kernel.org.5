Return-Path: <linux-kernel+bounces-148468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027918A82FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54162B230A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACA13D529;
	Wed, 17 Apr 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRK9Yy4C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061113BC21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356298; cv=none; b=a8+X29PSGxOTnAlYTJWqFXdCIbUWPPvEkpCTzYLLUHq9hkDsZteYzQQBqbnqyhwmD00vzg3NXdbdHTYC8iKNOU9j+UflGLnLn1jghic/g5ZWqhzDtBwW/NKRwprTIXeFI47U7znnNgOz6crbF8aKboh0dfeHZlQGWckOD5A/fBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356298; c=relaxed/simple;
	bh=5sPbX2601ThBLr4CINQAAZzaaohjANPkkqRezSuwCDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU3VEFKafW/dW3bVA5V/2Zq3FjkhxwZcrituyM5pB87uphD2XsHHns9Det2dr/4KPR5CQIgcOGVRuSl88SLOIx+/mvnCusUl9F1EF0mrOG5kWwSXwuul6u/wNjAEYGI6KL/y3WZsTDR8Q10LF8x6ihrmkH3R58i2+0RAEZLwEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRK9Yy4C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713356295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1xeyxCIrXbRqe02PXMvaFPCYUz5h2TFi+FFPVK4xZ0=;
	b=NRK9Yy4Ci8fwG4QRghd4vcJ3SJgY9ipY264hFZ45HqIkXkOnXnj9OaC6R9XXI/N+sY0pJ+
	lOAIG25LxbD4DK61vT9A3kTIh6GAEkSc8nKDpVr+RSj068603xJFZKwZqIT9+7srzMrH5t
	lMH6iegsmZvhTGZLJ70FOAmTa9YlnwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-6lHditKaPLSCPvcNYbTqVA-1; Wed, 17 Apr 2024 08:18:14 -0400
X-MC-Unique: 6lHditKaPLSCPvcNYbTqVA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3479b511725so2405527f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356293; x=1713961093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1xeyxCIrXbRqe02PXMvaFPCYUz5h2TFi+FFPVK4xZ0=;
        b=qxilSUkvoqooUAlufY5kcuPrv+Esf0arMAibwHA1/JIwazuDkn1ye1v8JDKzqrEQ/P
         k4AC1w34Wk+2C2c7Zb4Yl9rVxzqxtd/24BQQH4o2c5fv0tblARj7PkTYWKcg+xpeSW2B
         4lNAjRrdCnGkxkoG+GZZeg4Ojdlplk+wYXFCl7Fclclq6WJhbkzy14gJom4TYpttmkPw
         wHQP7huQ6Qr+dVxJBiZyj9LQRPPROt5F/rmPk7kR3TsVqDo+qm5nxtRw2qbeU4SzSjv+
         c5OYYIn/6upXszPJ+QqFMjX8ei1zityKKQuTvFjPkj2v7TOHMJMVaC1Ob7PviLcZL3Sn
         5gjg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8L/ptc9+A/OqMm02NPUFHfMxA1zJULw+Bl5+Tn9AjQbNa7p7i18iJh+ji7KR93aKHwKXnuwP4rxu7J9tT9knj/1GLLjXeAlxMx2j
X-Gm-Message-State: AOJu0YzjXb/HYLYsav6CoYUde4X1WRWDJj+RdHPmWULpv95RIpEUHCqp
	+Z6Ez/HXALgSJfsNtrPcFM21vsQMYq/UkEsuvZYk0wpJb65kdA9vYSpYdqb/hBdZL1/dt9s475M
	Q2gLj2VBbuXGaYLS3VyzMmzGVQmOI/kW81tWbOnOgkKwaWr7bLkDPA7j12fwakrFBzqqADoKWFO
	z0w3kYG4r2a/ubPRm74feYlWSi75H6j0caR5jW
X-Received: by 2002:adf:e691:0:b0:349:c5da:f234 with SMTP id r17-20020adfe691000000b00349c5daf234mr1166775wrm.24.1713356293316;
        Wed, 17 Apr 2024 05:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoOEsCTLjJTS1YCauqCVZzkKnhF2e22OnjEOVValYjW4muCtAADRbQj6C9XeKlg7eP6w5IWqmc1/zwRmMxqnQ=
X-Received: by 2002:adf:e691:0:b0:349:c5da:f234 with SMTP id
 r17-20020adfe691000000b00349c5daf234mr1166757wrm.24.1713356292989; Wed, 17
 Apr 2024 05:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712785629.git.isaku.yamahata@intel.com> <7138a3bc00ea8d3cbe0e59df15f8c22027005b59.1712785629.git.isaku.yamahata@intel.com>
In-Reply-To: <7138a3bc00ea8d3cbe0e59df15f8c22027005b59.1712785629.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 14:18:01 +0200
Message-ID: <CABgObfbrntjYobdHxfBGjMhSafW9BWKp-fWpcHW2-Cr3BuqOGQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] KVM: x86: Implement kvm_arch_vcpu_map_memory()
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Michael Roth <michael.roth@amd.com>, David Matlack <dmatlack@google.com>, 
	Federico Parola <federico.parola@polito.it>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:08=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Wire KVM_MAP_MEMORY ioctl to kvm_mmu_map_tdp_page() to populate guest
> memory.  When KVM_CREATE_VCPU creates vCPU, it initializes the x86
> KVM MMU part by kvm_mmu_create() and kvm_init_mmu().  vCPU is ready to
> invoke the KVM page fault handler.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> v2:
> - Catch up the change of struct kvm_memory_mapping. (Sean)
> - Removed mapping level check. Push it down into vendor code. (David, Sea=
n)
> - Rename goal_level to level. (Sean)
> - Drop kvm_arch_pre_vcpu_map_memory(), directly call kvm_mmu_reload().
>   (David, Sean)
> - Fixed the update of mapping.
> ---
>  arch/x86/kvm/x86.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2d2619d3eee4..2c765de3531e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4713,6 +4713,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>         case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
>         case KVM_CAP_IRQFD_RESAMPLE:
>         case KVM_CAP_MEMORY_FAULT_INFO:
> +       case KVM_CAP_MAP_MEMORY:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_EXIT_HYPERCALL:
> @@ -5867,6 +5868,35 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vc=
pu *vcpu,
>         }
>  }
>
> +int kvm_arch_vcpu_map_memory(struct kvm_vcpu *vcpu,
> +                            struct kvm_memory_mapping *mapping)
> +{
> +       u64 end, error_code =3D 0;
> +       u8 level =3D PG_LEVEL_4K;
> +       int r;
> +
> +       /*
> +        * Shadow paging uses GVA for kvm page fault.  The first implemen=
tation
> +        * supports GPA only to avoid confusion.
> +        */
> +       if (!tdp_enabled)
> +               return -EOPNOTSUPP;
> +
> +       /* reload is optimized for repeated call. */
> +       kvm_mmu_reload(vcpu);
> +
> +       r =3D kvm_tdp_map_page(vcpu, mapping->base_address, error_code, &=
level);
> +       if (r)
> +               return r;
> +
> +       /* mapping->base_address is not necessarily aligned to level-huge=
page. */

        /*
         * level can be more than the alignment of mapping->base_address if
         * the mapping can use a huge page.
         */

> +       end =3D (mapping->base_address & KVM_HPAGE_MASK(level)) +
> +               KVM_HPAGE_SIZE(level);
> +       mapping->size -=3D end - mapping->base_address;
> +       mapping->base_address =3D end;

Slightly safer in the case where level is more than the alignment of
mapping->base_address:

        mapped =3D min(mapping->size, end - mapping->base_address);
        mapping->size -=3D mapped;
        mapping->base_address +=3D mapped;

Paolo

> +       return r;
> +}
> +
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>                          unsigned int ioctl, unsigned long arg)
>  {
> --
> 2.43.2
>


