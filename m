Return-Path: <linux-kernel+bounces-100282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A158794F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D57B20E03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F879DD0;
	Tue, 12 Mar 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/Q7Ghko"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB056B92
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249585; cv=none; b=bTIwQkCixQNcZhF/r0///+0O3HVQK2EmB5+2JjACNzCiZasSyvy6euTPseZXOLtV6JbgXikOn+acu2Gm5V/+YUvI6QELm+an9rze8tvWoX8rRsGKKn8ixdH79QoQ4LZwZe9E6EsJM5e7DJZQI2dfFyruvxh3q/4Brrh+3JeeXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249585; c=relaxed/simple;
	bh=l4BI6HhWOeuS4d5tyqRjCd3roFHwxAbD4iigfKvGBIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvwNxL451cN3z0iSKm2KDH1kLAt80thjVB6twSgk+NCu3LjfiSwdGFNxMT8xHtizfOhWA+4nKw0qXfnpZ1heZ8N6SmSVRbsapz3PgarvgNKO0nc55fFaKJbHr5MYWMq9aWhjeKnT9o9hBaUUTnI0BrmAstxkfUVGw9l5xHR3fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/Q7Ghko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710249582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z2CW2lSbd7W/Mip0+an9Nn4llPQ0/xjPFm5UyZvJsu8=;
	b=E/Q7Ghko15EzCqEVN6nm0jzwIX4kAONUu/iM2dprG04NEe/NNClRC1jcC/V9t6sl00+Mgk
	hHB1eSVK/PGs/hUv67xAWonu0LJFWyMlqSOQYnHNESepNGi/Ybq/IkwOgkCEhO7xa940dO
	XhIyhMi1UrzDgjByJiXi7QZPjaLch6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-vMWPTTq8MJSjyZQYtgyOrA-1; Tue, 12 Mar 2024 09:19:40 -0400
X-MC-Unique: vMWPTTq8MJSjyZQYtgyOrA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e78c1b314so2262071f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249579; x=1710854379;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2CW2lSbd7W/Mip0+an9Nn4llPQ0/xjPFm5UyZvJsu8=;
        b=f19U7U2a4eoCsJ1Rl+mIsZBv2nklaplW4C8Hp7mZRQPsiDrYD3ZSqK15mgSrmN6oAr
         dfDRsdl73xyyyGwyElXrb1GCPSkubKOC22v19hi6PauZQ22jxFhFth8TN5WyJ9CcyakD
         zzOmkDTspb5r/6vKcy0pq9rhZc8hbD+LLGdlBWvOqsHQ2l5qPwB1BsNUkOlwVsJykzWJ
         koIJOjvCaL1bm2BK5PImTCz/78ZNOCmtHfMGHk9/8TRnh+gf/BRfFP5A7ELx/z5dKVIC
         250gWr6ed12oWPG4M9vAERZBInA2vxFXlOROW32MlSjHrdl+x5c49VCDRfglKsxzzKW2
         EuZg==
X-Forwarded-Encrypted: i=1; AJvYcCX2jL2eqS3qh4rsBcWPcO7tzYVpET3clwp17hZfqSCTch4yul3SFCGgHckh0Mhsg+W19Vhad58DfwPDx9M8xV3MaIIfNFITO6EPYLBs
X-Gm-Message-State: AOJu0YwJe9qYbjHbVNdbaDVILPuT8+bgOc0K92eflcJshpYgnEweoPKA
	ILqKG4Fd84+Emk9mbh7D64kO23SqLanzZdYK2LXC4z58yzehGKUwQjYoyPZWYlCPx8ZfOXWtvDv
	FXBdBv3aH0twJovOnT7bcBlW2meOggljgSzfX+uUTTW7PUOE+kpAOLz7JJaxnqg==
X-Received: by 2002:a5d:6191:0:b0:33e:a982:a206 with SMTP id j17-20020a5d6191000000b0033ea982a206mr1043083wru.11.1710249579273;
        Tue, 12 Mar 2024 06:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuEqfWlZNRI54jgIbMLFZlUcaUl1CSUX8iE5z7mmRhNcyt1eljcrCFPCojAbvp+TSiw0IUSw==
X-Received: by 2002:a5d:6191:0:b0:33e:a982:a206 with SMTP id j17-20020a5d6191000000b0033ea982a206mr1043061wru.11.1710249578833;
        Tue, 12 Mar 2024 06:19:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0033e456f6e7csm2505046wrb.1.2024.03.12.06.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 06:19:38 -0700 (PDT)
Message-ID: <75630ba6-79b6-4105-b614-29cfb0331084@redhat.com>
Date: Tue, 12 Mar 2024 14:19:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, songmuchun@bytedance.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240308074921.45752-1-ioworker0@gmail.com>
 <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
 <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.24 14:09, Lance Yang wrote:
> Hey David,
> 
> Thanks for taking time to review!
> 
> On Tue, Mar 12, 2024 at 12:19 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.03.24 08:49, Lance Yang wrote:
>>> The patch reduces the process visible downtime during hugepage
>>> collapse. This is achieved by pre-zeroing the hugepage before
>>> acquiring mmap_lock(write mode) if nr_pte_none >= 256, without
>>> affecting the efficiency of khugepaged.
>>>
>>> On an Intel Core i5 CPU, the process visible downtime during
>>> hugepage collapse is as follows:
>>>
>>> | nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
>>> --------------------------------------------------—----------
>>> |      511      |     233us      |      95us      |  -59.21%|
>>> |      384      |     376us      |     219us      |  -41.20%|
>>> |      256      |     421us      |     323us      |  -23.28%|
>>> |      128      |     523us      |     507us      |   -3.06%|
>>>
>>> Of course, alloc_charge_hpage() will take longer to run with
>>> the __GFP_ZERO flag.
>>>
>>> |       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
>>> |----------------------|----------------|---------------|
>>> | alloc_charge_hpage   |      198us     |      295us    |
>>>
>>> But it's not a big deal because it doesn't impact the total
>>> time spent by khugepaged in collapsing a hugepage. In fact,
>>> it would decrease.
>>
>> It does look sane to me and not overly complicated.
>>
>> But, it's an optimization really only when we have quite a bunch of
>> pte_none(), possibly repeatedly so that it really makes a difference.
>>
>> Usually, when we repeatedly collapse that many pte_none() we're just
>> wasting a lot of memory and should re-evaluate life choices :)
> 
> Agreed! It seems that the default value of max_pte_none may be set too
> high, which could result in the memory wastage issue we're discussing.

IIRC, some companies disable it completely (set to 0) because of that.

> 
>>
>> So my question is: do we really care about it that much that we care to
>> optimize?
> 
> IMO, although it may not be our main concern, reducing the impact of
> khugepaged on the process remains crucial. I think that users also prefer
> minimal interference from khugepaged.

The problem I am having with this is that for the *common* case where we 
have a small number of pte_none(), we cannot really optimize because we 
have to perform the copy.

So this feels like we're rather optimizing a corner case, and I am not 
so sure if that is really worth it.

Other thoughts?

-- 
Cheers,

David / dhildenb


