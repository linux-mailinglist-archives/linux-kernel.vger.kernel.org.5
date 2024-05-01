Return-Path: <linux-kernel+bounces-165843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D38B9244
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B6E1C20F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062E17C6B;
	Wed,  1 May 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sEwO7ik"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E581168AE4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605812; cv=none; b=YSnhs5Zra+JkH/cXdH1AsYR1f62oVMuzwlqs48SCUYro2pT4c8xLpyHqWSFecsUvys3vz3J71J0ZLxtka3DwxBnyo5PvadY5/wuiEcB6Dx88sLpyDtfORt1UGegPe7vFFluZFO69SwwsxGsIWntTtkh3tCXxhyNWo9LbOPVwiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605812; c=relaxed/simple;
	bh=231v0OwQJF08ECYNjJXoWz8Y+SFz+mViZcTa+7nlTz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZc6TUQGdsIgDOIN2uesD/dx82SO8Es8VhURbEYEGf5ioS+oGWmv9+v9p6oeAytiUz2SB8FvtHYp3Yj7EOCfzA/T69ntIAT5hFCW1fdF13R59L3vKo5DEOP3sa9/bkbgnExHKi8eQMj/xH9CkQVAbVS3pqXmvAyU9MOeItoee/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sEwO7ik; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so4298027b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605810; x=1715210610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FNnnFZTcKPfEm7VblCNu4kPLJ7DsOg30+YeTbsn4M=;
        b=2sEwO7iksPX3CiGGwtiZ8xIlyuGST4sTUhG/kGStcMODip3P6O3mA87jsXReKDx0zp
         6hnRBSvdPgSyHgRSCj6l4QgXgzwUGrPCGLwg9P3xSsLVtKuUpJy33UIKfchHlMtcu1T9
         gfTD5uX8MIYPRA5dI1q6cefrsXaI7kmFvuQlzZIJJs5JcU5yscZYI7WN+EyP0q4QeFNs
         jvdAO8WiCtdo2BvnzjadQSegB8rP/JCM/TlYfZfMm0NJSVmASWQ3oCJIJkOxCsr3muzo
         h4nTBvs7poR2yxFXDbcOuGPDxZkzog1NreOSFr/8eIEu2Tp3GMfSr7WIwT4g/V5uUpCk
         8BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605810; x=1715210610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FNnnFZTcKPfEm7VblCNu4kPLJ7DsOg30+YeTbsn4M=;
        b=cNmZeUFUiQNRZSegfuH42g5xRhmqbe70IbSNY/nrO8ba5c4N2lqpp7uOVQ/+oixW6N
         uiq5xvNoL8dmB5sWjZf4yF8tneKBD9AU5ylox1nXhFR3zW/Ne+vNCxLspmK9VyuIgoA7
         6O3ThUDge5a2UYtwbob7yh9vFV2DWXiXaydDDkF0sczUbvgdX0xB8j77/Avymm4MRyNE
         Wb+M8rv28mUmr21ZPBJ/vNNP73aleE97mJWY67RAh9PMjVa3Zjj9w+6oK1aSGjnFqhiW
         ORCCtWb7tilcvz+SAjh6PxYxhbdIiS33naLJmxg44b6LyDSRgRLo4+JXBYE1sS0sGePu
         GKkA==
X-Forwarded-Encrypted: i=1; AJvYcCWOnJdpH/uoCAMq4JvrhCiNcL4XD2KTWOp2z5Ck/8Z7soXR/P7dzrknSzCyapQjaToHCY1gNXyhLS8K0Pw5w8xQDa8O6EkNs4cZj0R3
X-Gm-Message-State: AOJu0YyCDP0WFhNoszmEbzVcbZJW79bR16+oCsiiw6SlJIDuTRsG5Dr8
	Tzc0p34Vb73CiHmysfgPZgtEKBzstJtY4WDRd615c3AVRqqXNT+YL01Lmrj2/S4BqXGS/b+sEAC
	PQA==
X-Google-Smtp-Source: AGHT+IEOjeIyS0Vq7PCwvO7KUdaZE2d8RWnqhYBXhtHAcO9e78TZV/qDl2RIwSPsFQChQCrvTG3v5kji/6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c0a:b0:dd9:20c1:85b6 with SMTP id
 fs10-20020a0569020c0a00b00dd920c185b6mr278499ybb.2.1714605810351; Wed, 01 May
 2024 16:23:30 -0700 (PDT)
Date: Wed, 1 May 2024 16:23:28 -0700
In-Reply-To: <20240219074733.122080-27-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-27-weijiang.yang@intel.com>
Message-ID: <ZjLO8FsnJ7NgED0G@google.com>
Subject: Re: [PATCH v10 26/27] KVM: nVMX: Enable CET support for nested guest
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> @@ -2438,6 +2460,30 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
>  	}
>  }
>  
> +static inline void cet_vmcs_fields_get(struct kvm_vcpu *vcpu, u64 *ssp,
> +				       u64 *s_cet, u64 *ssp_tbl)
> +{
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK)) {
> +		*ssp = vmcs_readl(GUEST_SSP);
> +		*s_cet = vmcs_readl(GUEST_S_CET);
> +		*ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	} else if (guest_can_use(vcpu, X86_FEATURE_IBT)) {
> +		*s_cet = vmcs_readl(GUEST_S_CET);
> +	}

Same comments about accessing S_CET, please do so in a dedicated path.

> +}
> +
> +static inline void cet_vmcs_fields_put(struct kvm_vcpu *vcpu, u64 ssp,
> +				       u64 s_cet, u64 ssp_tbl)

This should probably use "set" instead of "put".  I can't think of a single case
where KVM uses "put" to describe writing state, e.g. "put" is always used when
putting a reference or unloading state.

> +{
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK)) {
> +		vmcs_writel(GUEST_SSP, ssp);
> +		vmcs_writel(GUEST_S_CET, s_cet);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, ssp_tbl);
> +	} else if (guest_can_use(vcpu, X86_FEATURE_IBT)) {
> +		vmcs_writel(GUEST_S_CET, s_cet);
> +	}

And here.

