Return-Path: <linux-kernel+bounces-162656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F78B5E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E1F1F25AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77483CB0;
	Mon, 29 Apr 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEURjgpz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226D182D7F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406941; cv=none; b=R95wYgJSZuDEi0prquGDvApjseQTSAMaHaqZ/ECSM9toBNyQWwpAFcawQUtAQyx0QS6KqqO+uuUILcfMd9oCaZs06NHW5SQMRArpcIIeBpeiVo/VG2NyN9lpcNH+vNU/IDhs4Df/UwFGQ1pUXA27y3e+W9v+yoo+pR30hwtDzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406941; c=relaxed/simple;
	bh=geuz4mI1o3nOSadVoVQwlqmI5p/vbFpdtOfXBQyDk5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukZJMlytLiNQETaX4se0O8Atr+XqRYxrjPKowZNtlEF0XJV4u1W+ns8IMnyQOtxVQk/uY5RtWlPaTZTF9dPffFhtUxnYnuAizM4mNwUsnpiljRTmjQmFo5n1M4ianKiUK6WzvRqviBt4GE2GIEAsMBUvjc2n16jBj9AIdzClq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEURjgpz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714406939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sTKK5gj5KL3hvuuu0vZd3eljlGRuw56Y/qEfIGH3Xv4=;
	b=YEURjgpzJNo4LVjCksOYWmBTxM30JQteJvpo85imA5ciQ1ParYKyVzMfM8IOz2sH4f0yvf
	c/MtoebeFTG+pg2QjlkKgL4bAZYLWV74bGw0sYNhUjD8dCAm++cPdIHpGAlk1uXk7n1C/w
	+NcTZe2YQKnapC4ZFskqH6aWmHePkZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Z_no5VLDNlCTAet577n3RA-1; Mon, 29 Apr 2024 12:08:57 -0400
X-MC-Unique: Z_no5VLDNlCTAet577n3RA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34ccedec528so1240488f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406935; x=1715011735;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTKK5gj5KL3hvuuu0vZd3eljlGRuw56Y/qEfIGH3Xv4=;
        b=fGt+pkXCfmxfJb2dagvrGt+w62L+oLvVFybpOoF3XgTgZP0JFIBwS/4QLKIT8MHbge
         pA7CZ30pn9fu1k1D+UfF2oOlCqVGNV40fjuwGq+b+Op+ZgQAo6DvJZniXNyamxeI3TX7
         iYH52+13whCP6k5R1E8/bP+GOdZqTCTLrVRnA7MOfIno6tbe1+uDQWiFkaSzOK8uv2DC
         qW22sN2/UhyY7/moSHy3GEZn9sHri7tTOPggJiAWM4wZ0I41hF+DLqX2j60E2zeRxYnU
         wn435wYXcYBOSOZ61II2nZJ7JCQk1c1xEBg7LLZ2emgGkvzyK9azeww9MsLSFLjLFjOn
         EoLg==
X-Forwarded-Encrypted: i=1; AJvYcCUL4VViv500ex2roCIwbbxlmwvoIwX2b4zc+WHb+2I8RIO+Oa9RHmdblXYQfuvth1uRj2Kol8IrcGsADtazhZTWIvg8gw0bshhMaStw
X-Gm-Message-State: AOJu0YzM0uxUpU3Rxffo8KWNOFapnoKIX84nnF7RARbpAybvOMzxM2Cb
	kU3X99NHjoS+/Te6LauT3ELD9qZqqtNIogEcWvKLmVcq6pGXG5j5/TFpXG1TnI0CVO0Kv5twDW/
	dwvHF60DwdltUTBwb6gpSo9+tDxGd2UWx6BaYGHuZNH8czlCmRvQXOcS2NR5wWw==
X-Received: by 2002:a05:6000:459d:b0:347:6a1d:d19d with SMTP id gb29-20020a056000459d00b003476a1dd19dmr7876495wrb.27.1714406934655;
        Mon, 29 Apr 2024 09:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoimThG3j/m/tTgVG3NvEdOrsM5WRpxSGLICSWty6m7LRuw1nMVN3zDCUoRVWQC9m18ZupMw==
X-Received: by 2002:a05:6000:459d:b0:347:6a1d:d19d with SMTP id gb29-20020a056000459d00b003476a1dd19dmr7876476wrb.27.1714406934193;
        Mon, 29 Apr 2024 09:08:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id j1-20020adfb301000000b0034d29b87fcasm2273493wrd.87.2024.04.29.09.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 09:08:53 -0700 (PDT)
Message-ID: <9f0b3a67-a570-4e2d-8968-234d7cd641b8@redhat.com>
Date: Mon, 29 Apr 2024 18:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64/mm: Add uffd write-protect support
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-4-ryan.roberts@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429140208.238056-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 16:02, Ryan Roberts wrote:
> Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.
> 
> The standard handlers are implemented for set/test/clear for both pte
> and pmd. Additionally we must also track the uffd-wp state as a pte swp
> bit, so use a free swap pte bit (3).
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


