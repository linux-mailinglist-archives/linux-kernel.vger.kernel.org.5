Return-Path: <linux-kernel+bounces-83476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2958699F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C915B1F21E47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5B14534E;
	Tue, 27 Feb 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G72C7Dhs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA213B79F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046500; cv=none; b=KS9IFRfGOpK89huL8BSI3sfzmN0My+iMWdW0UjEZaowHQ7brSKQdi+oEuI6tuknbEMk0hpW25M00sJj3ZJxo5t8ajB7tDtyR2ctT0U4zMRrjJ4V5nFpfDk6uebpLQXHJfnoccA9uoMUXzMo6fOUpknG3Pnbo2Cxqp/XcorcQOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046500; c=relaxed/simple;
	bh=/TS4Uk+uX2DJrtv5afK/9LkEjI7jA8CzPuwtOmUddl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSksdr40nAWEbx8vZIK77Uu8YKU1rI2tisaTOzsGbqOv4imzo7KG4gxZjvrjaSLLcf3sgHFbylJA5+vUfizzZpenEl6Yj/25qj7yGUh1LN8elBuDV6Ryya2iN0hSrqGH4EwEsBKZ+U+pTb0T9F4JCG89GeOnXKPJf7vlL/GxDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G72C7Dhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709046497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U1fwwS6mBtihIjVKbccmmIcWqcnqocCzmIYzFTTh/bU=;
	b=G72C7DhsKO5B4ePU6/hTc6l7XBwlhztXZi07PvO2VeHqU6ryOqzLFO62cNiXMHYmTqfX6u
	0Q1JizH5IAzvKA8P2hGEoGyz/OSOE9NkkTmV2mESCzkCTcIgn8Cy5vzkCz+UvLPEuji3k6
	T0MKjN2ebEwx3kU3e2zaKuRMS9dZugY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-mFwdVb5OM6e0jotOEpxxGg-1; Tue, 27 Feb 2024 10:08:11 -0500
X-MC-Unique: mFwdVb5OM6e0jotOEpxxGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d256ca4c8so2978451f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046489; x=1709651289;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1fwwS6mBtihIjVKbccmmIcWqcnqocCzmIYzFTTh/bU=;
        b=jTMIxH7Yqg9UQ5SYptv2MlpeiWJwUK3/OxbLc+hHd0AQtlgIH6QrAib6RiJxWOqSkD
         YoXD52IovxM9osUxnza5W+P4S64zRlX4F+OVIgEq5CNDZkEcPt4SMnIl5a4zacMCFf2y
         oMNmk/lxOr7fsTCvcexEoY652fpHFnrjUrI7QDJJiLaqc+kKvMacqJ+SFofT7t7RKJS0
         h5DiKcCfll5TMn9P9SHugzHOe+DvAN0nuNPsAeXh/oqIu/BB5RQMbbRYc2+IJfk21Zv5
         LMVhobFsEiCLILbwuS4+HLflqQxgmPLJz0n1Hffxi8490ryOOLFr8Aa42/J4Db4cR1D0
         UiSA==
X-Gm-Message-State: AOJu0YwM+Xno3hcekgjq9fFbAML6gyfgNUvECgihk1n9duS9B2dvx5po
	dBlgqvwXgcVYYCUZ5pF5AfKHdQ/esq4m78pE/qqG1goCKPgjoq/TtkmqySGHj/RS8m/PEyrczvV
	DxNWZrcZtuPWgVT9Dp9NkJGc/ZlgzGVRwDobVv0M5tqRWt2wXiclwf0E9yyPnkWB3QHOI2A==
X-Received: by 2002:a05:6000:118a:b0:33d:e2d9:8401 with SMTP id g10-20020a056000118a00b0033de2d98401mr3426317wrx.51.1709046489751;
        Tue, 27 Feb 2024 07:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9k/kAO4mxyqssVVCfdajmz2u4ELMcyTC1vyimJ7qvY0uVGBumn6dc21dApnMmaZV0HCFUHA==
X-Received: by 2002:a05:6000:118a:b0:33d:e2d9:8401 with SMTP id g10-20020a056000118a00b0033de2d98401mr3426295wrx.51.1709046489379;
        Tue, 27 Feb 2024 07:08:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b0033cf80ad6f5sm11555354wrs.60.2024.02.27.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:08:08 -0800 (PST)
Message-ID: <b8a36659-f1a5-4d28-9c0a-3426dd93c010@redhat.com>
Date: Tue, 27 Feb 2024 16:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: make folio_pte_batch available outside of
 mm/memory.c
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>
References: <20240227104201.337988-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240227104201.337988-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 11:42, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> madvise, mprotect and some others might need folio_pte_batch to check if
> a range of PTEs are completely mapped to a large folio with contiguous
> physical addresses. Let's make it available in mm/internal.h.
> 

Would have added

"
While at it, add proper kernel doc and sanity-check more input 
parameters using two additional VM_WARN_ON_FOLIO().
"

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


