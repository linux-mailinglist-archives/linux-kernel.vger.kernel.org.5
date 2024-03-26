Return-Path: <linux-kernel+bounces-119475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9388C976
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4511F24B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DA3DAC0F;
	Tue, 26 Mar 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSOVoj2z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741074C65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470919; cv=none; b=U69xbkFh6NV9BAIugLIrFsZ34PdRTyQb6nSmqqnmlkK7HQVQW27V1QslnoBL0MpnCLjnGGMlORML1kuOREsCMnbau0SHa+Zvv1lOtTtHJb6UK0m82HW/A5mnVzHLrLIB581NVsWfy22eRhloLWSzcDx49lz3wGOPf3RXImvLUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470919; c=relaxed/simple;
	bh=OWEd4oCEkRpIaCT+Ek+4uet0mxBH1iDXwSUfgUT7RKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIGvMx0xldhGRzJAxFRrHwYhpTasigHi8bDAWo84npgjhOCiejVuIuAxQ5rAeL3tF0eVqZsE9VL4bSTOHPfhfGEKns/RUhp6pE0ov5cul/zt0P825D1+BFzggaPpl7IY8qtEZMnevvSOHfzmj1ZngRaoOVKPNb4qqn8zzBnWe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSOVoj2z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711470916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TTMBQBMJ2QKpmCzC47hqJsEt04RkZyfhpVeT9ptwCUc=;
	b=bSOVoj2zLKgtGs2Tkzfh824HKRn66U0t83ncJT71QHa1z6Rv3lXT7NZa4kebi8UVSXTUEN
	sit3Bs7snnoOEe7tfOdQGkNev8QFuh9eD9u7i98bv5ji4XH380LDO3a7ilXt8a8Ji+563j
	X7NIPyXznwFilHT6KG/KZ1Ac6ED6ZWw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-wDc8ipLJO7yJFhIva6dM0g-1; Tue, 26 Mar 2024 12:35:14 -0400
X-MC-Unique: wDc8ipLJO7yJFhIva6dM0g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56beb0ad4c0so1385925a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470913; x=1712075713;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTMBQBMJ2QKpmCzC47hqJsEt04RkZyfhpVeT9ptwCUc=;
        b=KkQncQCfWbvte/4U3/ER4InUvJN1bia1dgU8UdSTi3Mdnhs7pk33PEauFzzpj3fTfZ
         NkHDtb+gJa7kMilwDFUmmSRciDYRXToxDXUYj5vhsxjP15XdG+Ez14smgs/xyOEHn2yT
         TFcBhK1qBZ7KkkjB1M9EUSazaC7wKll8zC3HR83+4uFIKK/GRT2svW2y7AwSJqVoBh8V
         TYUCEIO3c+PWWbVu2iDqm0LkZZ36lZ1BjVCaMd9cMNMS3H1g+A3D4CT1VNWtTmxHhgRb
         VYolOyvFDyGpCZzNYoCILquqoammDzWydw7aNPrLJVCZSIXScYk6gN9uwO2dKLbxs0O7
         uqJw==
X-Forwarded-Encrypted: i=1; AJvYcCX65s4DNRqqy6iSBjDRLvuOgXp4SVfg6FsSygVdnddveEN3qD8CO0lW+1cncvOJHFJyMRqMfm7m2JrO0ocfhqs9RSM+3/8LFeEfpm0a
X-Gm-Message-State: AOJu0YxLuzbHFK34CsWUoQ3KjR0RT3zr7Pj0mIo17X4INp6PsKxfOEle
	altVswVEAs599XXk/mtrFenw8XS4qMfStFVurLyucBNnV3S8wvDyoFuPxpsfNgncgY1/QpuIByx
	M7GZE0164QrCOeHzr9TCxHGtVPGMrLg1eK/OY7lb4eKME4clTxBP1qSKMk5k+UQ==
X-Received: by 2002:a50:930c:0:b0:568:b4b7:3172 with SMTP id m12-20020a50930c000000b00568b4b73172mr275635eda.6.1711470913636;
        Tue, 26 Mar 2024 09:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOJkhTC610AORZT3t4COCBmAZHJoURxIDGr0DHl7vWvUYmtfZ65es4GlCav1qc2epyARBNgQ==
X-Received: by 2002:a50:930c:0:b0:568:b4b7:3172 with SMTP id m12-20020a50930c000000b00568b4b73172mr275614eda.6.1711470913008;
        Tue, 26 Mar 2024 09:35:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b0056be85c253fsm4470920edi.95.2024.03.26.09.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:35:12 -0700 (PDT)
Message-ID: <820c6ec7-8050-4518-a76a-ef707d76316f@redhat.com>
Date: Tue, 26 Mar 2024 17:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/4] arm64/mm: Override
 ptep_get_lockless_norecency()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-5-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215121756.2734131-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 13:17, Ryan Roberts wrote:
> Override ptep_get_lockless_norecency() when CONFIG_ARM64_CONTPTE is
> enabled. Because this API doesn't require the access and dirty bits to
> be accurate, for the contpte case, we can avoid reading all ptes in the
> contpte block to collect those bits, in contrast to ptep_get_lockless().
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 401087e8a43d..c0e4ccf74714 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1287,6 +1287,12 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
>   	return contpte_ptep_get_lockless(ptep);
>   }
> 
> +#define ptep_get_lockless_norecency ptep_get_lockless_norecency
> +static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
> +{
> +	return __ptep_get(ptep);
> +}
> +
>   static inline void set_pte(pte_t *ptep, pte_t pte)
>   {
>   	/*
> --
> 2.25.1
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


