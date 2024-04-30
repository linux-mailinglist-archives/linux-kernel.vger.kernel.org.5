Return-Path: <linux-kernel+bounces-163939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBD8B7656
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF21F221D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3617106E;
	Tue, 30 Apr 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff6AQhOQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB017107A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481637; cv=none; b=DfdzoFPTBnzGbhWjdrLm15eo82ToBznjepsatWBlFrlRycMRBagkyYdyREWtom6re3X/NDffnCB1R3twzwj3JsnND/ZVHH1wTZLUPUKNE4poGB6HvQUzRmsR9e3xirGChqYuqqqekdA8a3P0UDh83s7HZHsXRZh8bTZhi6vuNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481637; c=relaxed/simple;
	bh=h4O3ZkO/6Uci+AbMl7CR6TzeSBammz9dch1JOX09bms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KkV1vIe4b3RxFLSoyJ62HntNeZyp9xYg1lk0g11wA9lcIjQzT1RkzP5gzQUujlPDbZRysHYgw9RaDGvcD2L0VjNei9xzlTAJbiT2D+NwKsb3KESkOkkqy4Bahgjg1gswEzU/zsk5r3MGJaGJimsDc/ZLgzvH0DUB/QVG3QKW1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ff6AQhOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wTdBk861x2pP4lHOMRD8lFseOl4nVM4W1GX2dY9R83Y=;
	b=ff6AQhOQ6swxhLJnApXsMYvrUO/Or4T2YVVYI/1PMJGJKzWH5w0mMxcMYS1mj4NW3HFPSV
	6rGX374HNbrnkCyhRHeMrU6JmHhrMj4KtB9vbOdtMk47UbBmN4P0soTFKE3Bb3zeAaNRZB
	rF5+02iydm/casiwB/Mr1/J29mOXc88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-zLqD0ygCNRSAOphbnFvt8w-1; Tue, 30 Apr 2024 08:53:50 -0400
X-MC-Unique: zLqD0ygCNRSAOphbnFvt8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d9deebf38so230771f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481629; x=1715086429;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTdBk861x2pP4lHOMRD8lFseOl4nVM4W1GX2dY9R83Y=;
        b=c29uklRaop7ZG1AJahYbsfZNI79IgFlrc42KPbH2ydOBoQ6APhgUuFv8IIcBkGFlwc
         d84bWfl1Z17noUDv8IGdSduukALfANyMS9HYHDX823V/ke+psCcye0N7GVneDehXtOVX
         /8gQNFsnhylv3pgFSTwIXOJzzcvYDLqGMkY+h1IBI22N6DVX03AltEeXyR/irIj7v1rS
         7kluqhwafkj8d7A3Hj6fJq+C5Su76jUVcem8Kl7F1iFoQeFK221v0y3BRWR8G5f9h0e0
         xtWZPvvKKzIRPLtfNCl3mcxj6GO4w2m6W2sglZXmWWaxVYA+hVIsREwoc713wuEaL/L5
         TlIg==
X-Forwarded-Encrypted: i=1; AJvYcCXRDWho1hsIrN2JrdxNbMPemDP+sZaB9dinK1q5u249vcHNwxsr0gv/X6/CqEf+qZLFZPrwzk7nQp9t7hOYBQDYcivgps+b0IqKUlrM
X-Gm-Message-State: AOJu0Yyn7mcKS2xLof8MlJVDho/sdtN7sWVZk/F0Wufl4Xs37rrAiCNs
	es6CbOrkIZ8vv/0qQZ2Se6O8SCwjwiu/zFWOVthlA7kKSryjdVuzVLht8oQQN8Z1AN13WKgLLwQ
	KuEXZWQi4HxSAwPgCaxbWdlVKQBJuhTKWdiT1496clK49T7f0JIGtSpRaTPn7Hg==
X-Received: by 2002:a5d:4112:0:b0:34a:4445:22d1 with SMTP id l18-20020a5d4112000000b0034a444522d1mr10526815wrp.63.1714481629735;
        Tue, 30 Apr 2024 05:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEggDbukbiqDvAMKTOqhxZyrmHRM/JuOvl85t53ro1ZTAWFcsGBPlWbWDJtwS7I/1iw/hteZw==
X-Received: by 2002:a5d:4112:0:b0:34a:4445:22d1 with SMTP id l18-20020a5d4112000000b0034a444522d1mr10526806wrp.63.1714481629340;
        Tue, 30 Apr 2024 05:53:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d23-20020adfa357000000b0034cceee9051sm7222877wrb.105.2024.04.30.05.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:53:49 -0700 (PDT)
Message-ID: <24688466-6815-4aac-a8b9-4373a534727f@redhat.com>
Date: Tue, 30 Apr 2024 14:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/ksm: rename mm_slot members to ksm_slot for better
 readability.
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 izik.eidus@ravellosystems.com
References: <20240428100619.3332036-1-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240428100619.3332036-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.24 12:06, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> mm_slot is a struct of mm, and ksm_mm_slot is named the same again in
> ksm_scan struct. Furthermore, the ksm_mm_slot pointer is named as
> mm_slot again in functions, beside with 'struct mm_slot' variable.
> That makes code readability pretty worse.
> 
> struct ksm_mm_slot {
>          struct mm_slot slot;
> 	...
> };
> 
> struct ksm_scan {
>          struct ksm_mm_slot *mm_slot;
> 	...
> };
> 
> int __ksm_enter(struct mm_struct *mm)
> {
>          struct ksm_mm_slot *mm_slot;
>          struct mm_slot *slot;
> 	...
> 
> So let's rename the mm_slot member to ksm_slot in ksm_scan, and ksm_slot
> for ksm_mm_slot* type variables in functions to reduce this confusing.
> 
>   struct ksm_scan {
> -       struct ksm_mm_slot *mm_slot;
> +       struct ksm_mm_slot *ksm_slot;
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>

[...]

>   	}
>   	spin_unlock(&ksm_mmlist_lock);
>   
>   	if (easy_to_free) {
> -		mm_slot_free(mm_slot_cache, mm_slot);
> +		mm_slot_free(mm_slot_cache, ksm_slot);

And at this point I am not sure this is the right decision. You made 
that line more confusing.

Quite some churn for little (no?) benefit.


-- 
Cheers,

David / dhildenb


