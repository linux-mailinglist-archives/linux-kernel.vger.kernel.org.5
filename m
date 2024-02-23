Return-Path: <linux-kernel+bounces-78723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130E8617D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CF71F2379C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048C84FB2;
	Fri, 23 Feb 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/aotr/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3984FB3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705567; cv=none; b=ezJon0SLLgwDkgZqnI9VLrWcVSU1+p7ZsEMl5sbjrRsp2KYoYcVh6ItYbUHVKUhfy+d6aFg+QB0tR2gKfFeFf6uCrG1KfbL5pkjaPk0xAsa8YdioGOZW/g4o0G/bv7oll6qisDOVmQJEhkFmSebc0te5fM5nqnJHByjzE072/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705567; c=relaxed/simple;
	bh=87ijvGBUVdk2XeT/USaewCYk4ORdmGu/yjVUInEeHCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHmlX8zRGZ7lBHpSg4BTfvUG5q+TRpDJ3jBi4jqIK88nFS7+3x1D+KQ1Yxu8HpEJ0m/nuXjl+weSW1qT2NG6PFD9DS/w/KynE/kN8S31bBm/ABA/iZs2GLuJxI3i2pHCy+DbLPoMvfHbA6b1geeBKI3RdqGAz8C3pjtO9cDcZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/aotr/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708705564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=940/XEmJBSZDaRCjXuufne7H+L7fc/6jI5oiCpzkdYw=;
	b=X/aotr/I6Uzoc+ur/8Q9SbsSwhB4S9e8cXzI2hMkHqihEkrrVv2jKwxfuafP6LV9WAulwF
	N/wN50wX2vzSgMqlMY7GRlfrw9fC8MU7mHMockl3kiPAfa3RW2SmHljNkC9VR8xYx3t3iv
	JOmtIgGPOuaF/A1bCwWKUkqjr9HRIY4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-5Thxf5RlPUmMW9jsBz-5Tw-1; Fri, 23 Feb 2024 11:25:59 -0500
X-MC-Unique: 5Thxf5RlPUmMW9jsBz-5Tw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so46589966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705558; x=1709310358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=940/XEmJBSZDaRCjXuufne7H+L7fc/6jI5oiCpzkdYw=;
        b=p/2lMKKcebHO1LLf0C0Fp1MZrzyQe/pZ7Wqy/lfTI2l0hAkqC0G7kctrRSw1ooH/Y9
         7u9b0sQGU2hkrS+zRwEx9YQFBngga4D5jEduV3SRoaUIhrwEVG/HkBk3wg4mDseAbKTQ
         v/umOHSjs7VmodxtLzkaczuIroDSyRCUUz2Sv+EZOWNJFqu5Svnh6+iFxrwEJkva1eet
         GExZBxn9/7UBQOTcDVM5dch5lN9Oi9Ub4F7fSOT1Z4BbFUHInDR+rIqBtNjrXjD95yFV
         xrPbIQeYNcca0ni5L7DxASs3NRMg/iV8W48Yygsv2V/XiWEi94zF8OLutEIs1YEbpHWd
         vYLw==
X-Gm-Message-State: AOJu0YzBd77TTbM8Tf/O69TOiIse8CkJ5FaT+MgfjOZILwjk3FydrUpI
	2ap3g5M0/cw9x8tqCw1IZKpJMXrcihPACm4AxKfzVkBu7NUTACc3gTNS8NMiQb3Xf79GeGMRF3D
	tADLkCBUWwZZ8XQexF4DBCyndOn8/uSr3PlYZFbvOsLWDkxz2QDS/ODt6FzgGvw==
X-Received: by 2002:a17:906:d923:b0:a41:30be:4a82 with SMTP id rn3-20020a170906d92300b00a4130be4a82mr166472ejb.61.1708705558646;
        Fri, 23 Feb 2024 08:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4sbFmAlZnHaE/ojQ3u5/OWKq+fxOUwb1p/8RpYLJo/ppd2IOJQSq9yZuFbP5USJG0tPnnHg==
X-Received: by 2002:a17:906:d923:b0:a41:30be:4a82 with SMTP id rn3-20020a170906d92300b00a4130be4a82mr166460ejb.61.1708705558322;
        Fri, 23 Feb 2024 08:25:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ld1-20020a170906f94100b00a3e82ec0d76sm5331965ejb.113.2024.02.23.08.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:25:57 -0800 (PST)
Message-ID: <335d6086-2269-46b5-9e45-8707529213cd@redhat.com>
Date: Fri, 23 Feb 2024 17:25:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] KVM: SEV: publish supported VMSA features
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com,
 aik@amd.com
References: <20240223104009.632194-1-pbonzini@redhat.com>
 <20240223104009.632194-5-pbonzini@redhat.com> <ZdjCpX4LMCCyYev9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZdjCpX4LMCCyYev9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 17:07, Sean Christopherson wrote:
> And unless dead code elimination isn't as effective as I think it is,
> we don't even need any stubs since sev_guest() and sev_es_guest()
> are __always_inline specifically so that useless code can be elided.
> Or if we want to avoid use of IS_ENABLED(), we could add four stubs,
> which is still well worth it.

This particular #ifdef was needed to avoid a compilation failure, but 
I'll check your patches and include them.

Paolo


