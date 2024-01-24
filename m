Return-Path: <linux-kernel+bounces-37230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BF83ACED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA191C24003
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D77E772;
	Wed, 24 Jan 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9NmOQVs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541357E562
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109166; cv=none; b=Q9VBUpz9HTG7I6DYT7UsvyVuNCIgDhA0UBkJuBV51YK2ePn9XTSmtytKwVtKPa4QzS2O2FNcpJSCUH129papjUF9PCvAQXoPunozKhqTy/SINs0WVdXSJe9EJpP0Oinlbd9+LhVCnOlxgDYtaLsR6HZdKr0lgrzniIxiOOeB6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109166; c=relaxed/simple;
	bh=wSUcVORR/B8/hFASvmkzEW/qWMh/vNxVvV+IJjMASVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCpNMjdDGR3GBw+8194W+T3F6WEZIJROi4j9kc6XQmIx1/JtHOErQGexrC0zjcTi6DCuk8TJ+KTMGyq/wBqTZkKklXCCRCYf5MkOsFYk7Zc7SuZJqqOwMzx7KHnzZX7/cfgwcL/4FRyV7M+P9pEIf/I1Ay4Ey30vHHcydfeoC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9NmOQVs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706109163;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9OCrAN+UT6ymJtmxhV/6yB5yqd39wFue7pD1+4bFjs=;
	b=i9NmOQVsgCcow2ZuysciM7Ven9C5pls4gikbXfeJvgoe/V78LCdPlTBd7jkcJTj3jrHRiL
	Pz0YMsAVA3iGy1pECpAC8V2sYRBaRnlhrhw0ANBtHqohDFG9x+oQBldfX9RfQ1gcc9xB7k
	Baxv1WstVecJE7mDRd8s4kaRvxarsv4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Gje49OwfORaEPgRdZx2Qcg-1; Wed, 24 Jan 2024 10:12:39 -0500
X-MC-Unique: Gje49OwfORaEPgRdZx2Qcg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7831ed4bb2aso1027987885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109159; x=1706713959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9OCrAN+UT6ymJtmxhV/6yB5yqd39wFue7pD1+4bFjs=;
        b=RY18pDAdyJKFspDR6dyDMrXcW1pJ+vRQQHR+52vp0rHcXSoFvm+UuOJCqSEJlSAhoO
         9p684Qa2djfyYPJpVeJFGoyIgyLljZDcgDR8/EbWbtdRbu7tLyL6DaMnp9qjMmyoYROA
         JRfNYCde+EJmBt6d9dVbuLh14pWMuU65rlM1qoc6wQ5aD6k6dtHDHAvreSlsaYaB1YHi
         GF0yrdXU01Lx07zju6UwyxCqnWuTX3N199+yjlP1EozX/NZKwYUX0veYoMdKEWARJ0YI
         M2IbHcwRVnkeLIN3JOSygEh8MLuBPHkchdSCTmQZwCearWN/S8naqrkSZBXDRwrUq77/
         5chg==
X-Gm-Message-State: AOJu0Yw3imLAEJlA6ifWix3laVU+Z5qF57N1kkvjoijmyPLb25D1JKe5
	HKS9TvHcr5eSMpFr01wK17k+I1/tnvae699B+QPZY8/u7BF20TChkV2shl14cjErbu1148V6nyD
	2oyFNDLtqJKgtZWDTgHzKvP5FHf6BwB1tocMaYYtKr2UOAkHUK4qx6QhUrgwAVg==
X-Received: by 2002:a0c:e18b:0:b0:680:b7fd:e3c0 with SMTP id p11-20020a0ce18b000000b00680b7fde3c0mr2602208qvl.130.1706109159390;
        Wed, 24 Jan 2024 07:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4YjMHgP4yQO1A1mLPxyYWjKYZXB3p75FsIdtm86FMAXD3LcuTiRkAWk2NCbxXvKHRbEkVxg==
X-Received: by 2002:a0c:e18b:0:b0:680:b7fd:e3c0 with SMTP id p11-20020a0ce18b000000b00680b7fde3c0mr2602197qvl.130.1706109159137;
        Wed, 24 Jan 2024 07:12:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cfc0f000000b0067f2559fd5esm4562012qvo.34.2024.01.24.07.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:12:38 -0800 (PST)
Message-ID: <6efb0e40-a1e8-45d8-8b59-c3e5a90daa4a@redhat.com>
Date: Wed, 24 Jan 2024 16:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 57/82] KVM: arm64: vgic-v3: Refactor intentional
 wrap-around test
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-57-keescook@chromium.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240123002814.1396804-57-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 01:27, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index c15ee1df036a..860b774c0c13 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -863,7 +863,7 @@ static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
>  	int ret;
>  
>  	/* cross the end of memory ? */
> -	if (base + size < base)
> +	if (add_would_overflow(base, size))
>  		return -EINVAL;
>  
>  	if (list_empty(rd_regions)) {


