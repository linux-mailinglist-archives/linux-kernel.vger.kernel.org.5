Return-Path: <linux-kernel+bounces-149358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE08A900E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CC41F21900
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEC5684;
	Thu, 18 Apr 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7btexJp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F645231
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400330; cv=none; b=iLcdvze2wMw2dKnalfVALRsSI77sh+M5ZbehANFFJXTcTWE3sNfBEFf8JeznrbZzU6G1+eb20g7NhkGOzabOhjoeFBZ66o7cblGQlS5gxuuvWVp8/MB3jeW3e+kp6uXkqtGdS+oRRkRj2sBKBdwG1jk2ZwvuRJXgnqVSHB3oiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400330; c=relaxed/simple;
	bh=f+jD+epNtwhtMfCuuI3QOEZOmFv228ffTSWKY8h6LwI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VsnDuUoZo9uFvMlkWNThXCeU8/cJqq4J1ZJKA0v6QXwolV8hguDIrPiwthU0iBLLkpWCxEgY5c1WpApK1RKzsnQrCBBj7BQN6evhPvFBpBGwkkAXBUVkTrstw5ibJTIvbKLyF+Y6oKAaGezZjTk649NVhMhqroXa9wNGu3QQNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7btexJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713400327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftopLKdLaUkjZZc9zSGZOxukCL07Uh+MIUdVJv2mP3o=;
	b=V7btexJp86bGS6YCSTruQM7BNG1HVbJSVMpmbjBXH4doMpJB9RwGSxbfaTSqB4mg34QBtA
	5sXB1kxcKxTPgtf8Q+1yyhS4tIE67x76qKpfk7FUyx54ADv6LGO8CByCFB1Tspty9MWs0K
	6f6Dz+lDIZ4n37AV7gWUs1F8VW8rgyI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-JAac4Hs2Nt6-IFN8pNv3OA-1; Wed, 17 Apr 2024 20:32:06 -0400
X-MC-Unique: JAac4Hs2Nt6-IFN8pNv3OA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5238ca77adso144412266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713400321; x=1714005121;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftopLKdLaUkjZZc9zSGZOxukCL07Uh+MIUdVJv2mP3o=;
        b=Lw9wm41P8fle2o5aXV5hab/PnrZ+0gQdcE2wajsTpaqKX0MZmLcDJ5Fa9zkfVHx3wB
         DLoNasRL5BrxKLS1ACMXSEW2IQVtUb43BQyiuZWvYv4SdDG2TEbd5cOrqT3Rw+u4noIy
         sg9EDj5hUTQPmF/H4Y0grwVyZ5UpHeHFIJQKvJ+2307yPtMlfxRsnbaGzNJWl3UxQU/P
         uERDCACqe2kuqN/f913zR0kV9Xgzf0CvezCW4T2b6SuFWf/x6yB6/PoWaXSiiq+ZVa4r
         oaAs4tRudkNtIBeCygnYCyj8wmgm1W4C29a1YEBb50VtHRzYgjjDJbuOvHMM90dEAoDW
         vG4g==
X-Forwarded-Encrypted: i=1; AJvYcCVnXcX7HCMr8+B2wQq4CBsyTWEeb1A46cGrYJv0HdTCddQ9AZpYPM88upyiLzXk1Lbp3ntw9WPFyIMki5hly9lnrG3HD8M4kIOOeRGT
X-Gm-Message-State: AOJu0YzkNOvhRj/G+GzPA/YDDhnrKZLBwKI7zJxlaPkur+VvsfVj98E2
	MNdVCTT6PYd1rjZBZRYfmpdIVUbE41YN+ld+d/m3ssSl7N8ARneK9YyaRwl7PMKhMTsk543VUe5
	eXuDijV4A3hfd0rCDnrA5MPleRncx3wEul5gJSMi5jPnBSxsJlj4UdMjrU7jXYw==
X-Received: by 2002:a17:906:3b13:b0:a55:6c07:1569 with SMTP id g19-20020a1709063b1300b00a556c071569mr438368ejf.0.1713400321399;
        Wed, 17 Apr 2024 17:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBqfbDFDBWFJ6N1bRlG2XjxigTMRmDUvyE9ut6OhjAP8LRg6YwgQo0tTxbzkwWZ8uQ7VLH8A==
X-Received: by 2002:a17:906:3b13:b0:a55:6c07:1569 with SMTP id g19-20020a1709063b1300b00a556c071569mr438355ejf.0.1713400321075;
        Wed, 17 Apr 2024 17:32:01 -0700 (PDT)
Received: from [127.0.0.1] ([176.206.84.58])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b00a525609ae30sm179635ejb.169.2024.04.17.17.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 17:32:00 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:31:58 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v3 0/7] KVM: Guest Memory Pre-Population API
User-Agent: K-9 Mail for Android
In-Reply-To: <65cdc0edae65ae78856fbeef90e77f21e729cf06.camel@intel.com>
References: <20240417153450.3608097-1-pbonzini@redhat.com> <65cdc0edae65ae78856fbeef90e77f21e729cf06.camel@intel.com>
Message-ID: <8245609C-0086-4DF6-8D17-509165F4D87A@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 18 aprile 2024 02:01:03 CEST, "Edgecombe, Rick P" <rick=2Ep=2Eedgecombe=
@intel=2Ecom> ha scritto:
>On Wed, 2024-04-17 at 11:34 -0400, Paolo Bonzini wrote:
>>=20
>> Compared to Isaku's v2, I have reduced the scope as much as possible:
>>=20
>> - no vendor-specific hooks
>
>The TDX patches build on this, with the vendor callback looking like:
>
>"
>int tdx_pre_mmu_map_page(struct kvm_vcpu *vcpu,
>			 struct kvm_map_memory *mapping,
>			 u64 *error_code)
>{
>	struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(vcpu->kvm);
>	struct kvm *kvm =3D vcpu->kvm;
>
>	if (!to_tdx(vcpu)->initialized)
>		return -EINVAL;
>
>	/* Shared-EPT case */
>	if (!(kvm_is_private_gpa(kvm, mapping->base_address)))
>		return 0;
>
>	/* Once TD is finalized, the initial guest memory is fixed=2E */
>	if (is_td_finalized(kvm_tdx))
>		return -EINVAL;

This is wrong, KVM_MAP_MEMORY should be idempotent=2E But anyway, you can =
post what you have on to of kvm-coco-queue (i=2Ee=2E, adding the hook in yo=
ur patches) and we will sort it out a piece at a time=2E

Paolo

>
>	*error_code =3D TDX_SEPT_PFERR;
>	return 0;
>}
>"
>
>kvm_is_private_gpa() check is already handled in this series=2E
>
>The initialized and finalized checks are nice guard rails for userspace, =
but
>shouldn't be strictly required=2E
>
>The TDX_SEPT_PFERR is (PFERR_WRITE_MASK | PFERR_PRIVATE_ACCESS)=2E The
>PFERR_WRITE_MASK doesn't seem to be required=2E Isaku, what was the inten=
tion?
>
>But, I think maybe we should add a hook back in the TDX series for the gu=
ard
>rails=2E

Paolo


