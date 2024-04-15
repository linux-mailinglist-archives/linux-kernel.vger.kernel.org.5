Return-Path: <linux-kernel+bounces-145765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B838A5A82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C0D1C227BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3579155A37;
	Mon, 15 Apr 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE3fv2ZP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE5154BFB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208774; cv=none; b=Nj7/BqPTGziKrZpBRrbF1I2GP95cyiVfWm71eilxbjcnr9w+xCXK26cPmxNdzD19JCzt1/lc6uIsNwUT+dyvoJhbuqaddUcfKB0btVnq9TeoDyexM7QY+b9QNdaz5GeDUKhyoggIiyPJ6eC9R/kpXKp5MfpbGjaU0tLkobkjivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208774; c=relaxed/simple;
	bh=gEZ9HZG577UThAOdDmnc3kFUJUnkQWkeGM3aCJH0NiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRaAjVM7+ixIlC3owPSNURtrkBv+9prWa1O9pkHnAbi3foJrFIhxx3l6SJcqk/RNakNTb45Dk1Zre1uWgSS3quLiwskrkV9jKx0wfhWMRQeHqGTiOnAFvoD3cSv43H3ajKChy6qCgFCFxeR7mFiyJryyatr8UQ6zchVCc1SxvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE3fv2ZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713208770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lBTRJ/gmObsqxEPnSfTI3LGhxy29zWoDAyEXSuW9/VA=;
	b=LE3fv2ZPfPfCgGnvTFX+hbIjX5zM3dZeK6z8bDeluc0ExYKYR1Ilj/zHVCQlWn0YHJy4pm
	L0vjPOqvlTtIJFBHsZ8SsHYtaO/bP9KLR4ytGV7MBprN0a335IGH1Tm0aMB4yLj1+TPmNd
	khFtGznu/JFChPkxLzrLYCH4pFm/xNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ykt384V7N4mv_l51REoELA-1; Mon, 15 Apr 2024 15:19:28 -0400
X-MC-Unique: Ykt384V7N4mv_l51REoELA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4186cdaeb76so6306115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713208767; x=1713813567;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBTRJ/gmObsqxEPnSfTI3LGhxy29zWoDAyEXSuW9/VA=;
        b=QNlrQcqhF71p1EPq4R6qb6SwiGE2pnWlTkMY+CJc8LkQkGbE81MuOi/KhUOBoVNI8o
         QDZFzGfsYqUMIOCPpLpdevomGERmK43lOiTrMtTemRd6l8ovAFx7aHngcubsv2sUJuEE
         Hgo38++sLzb1NJGpG6Ih1UGos5yYfMU5k/RX3Zjrbe7eWjgGL1SaTFioICTyCZsAGLgE
         AxDKkmNBFoGKLO/ZXwtxLJ5UzS0tHPpqYNGe3HdOnybdR5nGyi77GrE73piIsYfcqD52
         BbmF8xGU+EHwJPMl3yDdsFYw3iPJ0yLyaC69n0qazpU0jTaI3moD6LgK+9eR4mRLrsTx
         AYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSjjPhq/hep1JK/RE/v2XxmL7uNoqlPBkzR8bNCiMumElLYvysySSDQjw7eHGQBJOCjDdEMHuzwFlZ0QVIBIjyE8VQmrFnAvExyIo
X-Gm-Message-State: AOJu0Yyf2mNFYjy7ozw1R0Z6YPKc0HX4JICbkCRTyNmNXM171+djCYHG
	j9Nk2XPJ4bGABMS0O1rCj7mB4d31dDMbjrdTzj4fyX2is1KKCNULBElHW2NNIGndflOpEog3HpV
	BKaXd5N6IzEWf9eOp6hq08ZvAlFSbdNEPJB8hWHVv7Fv+merAUCFhjDjhc1TfdY6CdmjgQw==
X-Received: by 2002:a05:600c:1552:b0:418:37e1:3f73 with SMTP id f18-20020a05600c155200b0041837e13f73mr5240678wmg.2.1713208767691;
        Mon, 15 Apr 2024 12:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDf/YXXOPdqtUer+Qv1m4XJ2VU3wrJIGA1vps59c7iWf3vPZHQ8b0wpdpBOBYZrN406lV75A==
X-Received: by 2002:a05:600c:1552:b0:418:37e1:3f73 with SMTP id f18-20020a05600c155200b0041837e13f73mr5240661wmg.2.1713208767282;
        Mon, 15 Apr 2024 12:19:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id jh2-20020a05600ca08200b00417f700eaeasm14191791wmb.22.2024.04.15.12.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:19:26 -0700 (PDT)
Message-ID: <c76c78ab-7146-4963-97aa-980b767e84a5@redhat.com>
Date: Mon, 15 Apr 2024 21:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
 <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
 <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
 <60049ec1-df14-4c3f-b3dd-5d771c2ceac4@redhat.com>
 <CAHbLzkpMjSUpB2gsYH+4kkEtPuyS4bP7ord+nSgR9xcp3fyVFQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkpMjSUpB2gsYH+4kkEtPuyS4bP7ord+nSgR9xcp3fyVFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> We could have
>> * THP_DEFERRED_SPLIT_PAGE
>> * THP_UNDO_DEFERRED_SPLIT_PAGE
>> * THP_PERFORM_DEFERRED_SPLIT_PAGE
>>
>> Maybe that would catch more cases (not sure if all, though). Then, you
>> could tell how many are still on that list. THP_DEFERRED_SPLIT_PAGE -
>> THP_UNDO_DEFERRED_SPLIT_PAGE - THP_PERFORM_DEFERRED_SPLIT_PAGE.
>>
>> That could give one a clearer picture how deferred split interacts with
>> actual splitting (possibly under memory pressure), the whole reason why
>> deferred splitting was added after all.
> 
> I'm not quite sure whether there is a solid usecase or not. If we
> have, we could consider this. But a simpler counter may be more
> preferred.

Yes.

> 
>>
>>> It may be useful. However the counter is typically used to estimate
>>> how many THP are partially unmapped during a period of time.
>>
>> I'd say it's a bit of an abuse of that counter; well, or interpreting
>> something into the counter that that counter never reliably represented.
> 
> It was way more reliable than now.

Correct me if I am wrong: now that we only adjust the counter for 
PMD-sized THP, it is as (un)reliable as it always was.

Or was there another unintended change by some of my cleanups or 
previous patches?

> 
>>
>> I can easily write a program that keeps sending your counter to infinity
>> simply by triggering that behavior in a loop, so it's all a bit shaky.
> 
> I don't doubt that. But let's get back to reality. The counter used to
> stay reasonable and reliable with most real life workloads before
> mTHP. There may be over-counting, for example, when unmapping a
> PTE-mapped THP which was not on a deferred split queue before. But
> such a case is not common for real life workloads because the huge PMD
> has to be split by partial unmap for most cases. And the partial unmap
> will add the THP to deferred split queue.
> 
> But now a common workload, for example, just process exit, may
> probably send the counter to infinity.

Agreed, that's stupid.

> 
>>
>> Something like Ryans script makes more sense, where you get a clearer
>> picture of what's mapped where and how. Because that information can be
>> much more valuable than just knowing if it's mapped fully or partially
>> (again, relevant for handling with memory waste).
> 
> Ryan's script is very helpful. But the counter has been existing and
> used for years, and it is a quick indicator and much easier to monitor
> in a large-scale fleet.
> 
> If we think the reliability of the counter is not worth fixing, why
> don't we just remove it. No counter is better than a broken counter.

Again, is only counting the PMD-sized THPs "fixing" the old use cases? 
Then it should just stick around. And we can even optimize it for some 
more cases as proposed in this patch. But there is no easy way to "get 
it completely right" I'm afraid.

-- 
Cheers,

David / dhildenb


