Return-Path: <linux-kernel+bounces-78075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E1860E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BE2B280E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E15DF19;
	Fri, 23 Feb 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjOCExjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1735D735
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681741; cv=none; b=hnFS8+vRjrlJ3I3p94GL219mkvKrvKOkK054x8inpyC1xBf/+dhvuhnPlkmrR+UGrtwkbYqocrVTzLSczBc8LZVpMzVUDH8OOZyncS+CXczAJiQIMy5HZAonWoqNgNhkSonYogOmaHtTuTPFElZZpxXAhkgM9YRLD5x79BSn2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681741; c=relaxed/simple;
	bh=CHQ8ojToVVo2x2nBAVOg3oJvhiLAFfyJ4tNHaOYASYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2+4fTTT+N9fjQXYZn6MhRgs+UMZtGXbnWrf4EvssYLOghmSrAz9TsachxEqpKpMbh4CDdDIdzrqlgkledifMdlG1tN8d1xr8t13U6XDAoLlkDI+QLutndoNiFg1C27jkjfj1bgjnFsE09/26mwy05CDk+yXpyNCsFLAEDnCQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjOCExjr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708681737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny3rlNG4dj3vSMIabxV2MPIzBtaBKbqMGyTxyLeP7EI=;
	b=CjOCExjrs5kBG6PnRdL4p6PnpBIiTLHbEKFKuOTFaMptVApPWCVbtxY5jinNgpUPkS2qUX
	sW0vnScKCmd/jjzthqIk3qc9XHWi8G2Xg8d31d4BnCyd+qAMvbj4O7PvQjdguWocQjZCYh
	seAnndenbnzuRL7+o06+Ix9IC06NNmU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-9AcjSxaVP8anmyDfQkUlcw-1; Fri, 23 Feb 2024 04:48:55 -0500
X-MC-Unique: 9AcjSxaVP8anmyDfQkUlcw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512add274bfso533818e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681733; x=1709286533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny3rlNG4dj3vSMIabxV2MPIzBtaBKbqMGyTxyLeP7EI=;
        b=CjvcqqCX9h/YM3i38skI7rwoXQxFI4mCttT1BXShL82I9Aa58HQy4x0+TqOOuKqyr3
         tfNw36UmQHwZevaaaQJdi007DHH2oLOUDN7zhFZolNdtq+alQK/TriNn0UyWb1iWEu8F
         fO0BdGpMij2alRzQK2CS9SD8HYONBduhzDNysv2NMPH0izl1z2rTuH/15FihMmRzpxDK
         JqTiiXH7EEVK7AJg7uHNOLJJpxQdrzrANIk1a5xmL9DdlpTgTD9JUXG3osp7LL08IHHZ
         tOS8KTaWVurMa576Rt/36ytgEHcz0/DOztsdx4hyW9dUmHNRfhbpjlKGqr7lT9bDu3Jc
         8zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWacRpLjj5xa43qn/Q252JrJzHoEKZHPiEDE0qHpHJe900brtS3/WzuZXlR+VBLqk19b9dQt+QxQIbCRIVqSCDng1JaAGeBeSUHGXXl
X-Gm-Message-State: AOJu0Yx1fvhJsph7KzmQvCUMm6vvqcHKTnfdAk3MRiAtNT5aQvHqB5Kd
	91ZfeJAw6mWTQmvt51foIWe1ktDwOI4NuXGC6GRSrVXpn8ipW9yZ92ZXbmt3rjBjT4OMMlOMs+i
	PiFYG8p+LPD3Ehyulok3rkuvKxI21mlOuHrkKndv4R5H2w5jgMZmU8ENL+5KldHVDh81XZw==
X-Received: by 2002:ac2:4ec3:0:b0:512:bdd3:1539 with SMTP id p3-20020ac24ec3000000b00512bdd31539mr967265lfr.37.1708681733277;
        Fri, 23 Feb 2024 01:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzFi43eAzp8ls1n6lYPSL+WeUvLXTf3gmpGB+Q/29q/XRkCZHV6zgEp+R6GOxjP1qCo1xU5w==
X-Received: by 2002:ac2:4ec3:0:b0:512:bdd3:1539 with SMTP id p3-20020ac24ec3000000b00512bdd31539mr967253lfr.37.1708681732952;
        Fri, 23 Feb 2024 01:48:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id p11-20020a05600c468b00b004128812dcb6sm1740881wmo.28.2024.02.23.01.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 01:48:52 -0800 (PST)
Message-ID: <5580a562-b6ac-448d-a8fe-cedc32d33bab@redhat.com>
Date: Fri, 23 Feb 2024 10:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] KVM: mmu: Improve handling of non-refcounted pfns
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>,
 Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20240221072528.2702048-1-stevensd@google.com>
 <20240221072528.2702048-5-stevensd@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20240221072528.2702048-5-stevensd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 08:25, David Stevens wrote:
> +	/*
> +	 * TODO: Remove the first branch once all callers have been
> +	 * taught to play nice with non-refcounted struct pages.
> +	 */
> +	if (page && !kfp->refcounted_page &&
> +	    !kfp->allow_non_refcounted_struct_page) {
> +		r = -EFAULT;

Is the TODO practical, considering that 32-bit AMD as well as all 
non-TDP x86 do not support non-refcounted pages?

If the field is not going to go away, it's better to point out (in the 
definition of the struct) that some architectures may not have enough 
free space in the PTEs for the required tracking; and then drop the TODO.

> +	} else if (!kfp->refcounted_page &&
> +		   !kfp->guarded_by_mmu_notifier &&
> +		   !allow_unsafe_mappings) {
> +		r = -EFAULT;

Why is allow_unsafe_mappings desirable at all?

None of this is worth a respin, it can be fixed when applying.

Paolo


