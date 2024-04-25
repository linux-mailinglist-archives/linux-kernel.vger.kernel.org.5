Return-Path: <linux-kernel+bounces-159092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DC8B2932
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50472B21812
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271515252E;
	Thu, 25 Apr 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLvFUpqd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608F15252B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074970; cv=none; b=L+QYYxMFKTdzkeMpYa1aWLjNGTwOGSBRwwTFR3XQM/uXdhVfLnrsRsugPDyM1i5rDr2wHta1ltqVM4F2V78ec7vH/83SkbYu2L1gcQ8yMgPsbtUVX/zZLM4LHIU5a/NZyl4t48vcFyy9csRByINoF162edeOOMlkITM4nrXqouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074970; c=relaxed/simple;
	bh=mlCtUyjlYwpG8XC2M8PhO0swx9DedcqDZRTkR7ZAUSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTyhb6UruwSm2GIFZ7YxScdz7pbzl3Qi4OCSt79zzsnvJm+m9UcATlesT9AuJEAqXToCtzS/7DklcIKjcIBJXrGvBRz1ejSfEpr0LvmaKc/quWtuv1d60AJTn/P1En7uBKtm8YN2+KKuoqqQoDPKjywU0K2pBakiUUAmu0klvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLvFUpqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714074967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZvSvuTa9yGOG0wcjFccGcQ0zAW5oxbiOm14qIn43U44=;
	b=OLvFUpqdojnvZax8x3IT6Qrh47u5v2Vz0Qs/no7w8TaLeW+IXra1ZlWFly3Df5hLjadIza
	4wTPyYVYvvDlfy3BfEOCNBHm7z9jalgfGadfsybO4Obh3PunxM4qmPKTtJkDPT5cFHRj5C
	jmnjYmHuvvpTy6Rh7cE0eoz5QRK0jdo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-I_923DvqPwuknUKg1RVaMA-1; Thu, 25 Apr 2024 15:56:06 -0400
X-MC-Unique: I_923DvqPwuknUKg1RVaMA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so848459f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714074964; x=1714679764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvSvuTa9yGOG0wcjFccGcQ0zAW5oxbiOm14qIn43U44=;
        b=iECSi5Y+CIl4tk8cZK6p4E2mTMXXCfq1sy4qeyCqKkQ5+JyTMhM7OwWi26YU1FQA1A
         FpZvZzRucDy+r9ILHNLmIcmUjw1hon7WRCfIgI4Lttx4hFR5WMFN0o4IGRd1aY0Ceswr
         pI8MzNIiKJjeMsHNXm18v0b7HgNI1vpWH6zM44e6EpDSFku7jQR8MieVke5L18fOqFDK
         wuXZZJ6xO5cWxo2qjc08776S4Jn4zmkHhmbT//wGpVHWLt56VX/AX7EgYPeVon0Kd9QH
         RQyToFM9li/GNC5zp+bTNTRV/cxMSNCageZSmZ49ebCqGbBE80F++qQWDOlMBObyBIjm
         TB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7y3Q5XdZrEN+o4acUZN+7UoUL+iGMh7yPvdI5zG2ArrTHMBBmquKq2NuB531GVgB+k8QE+QxZzRMf1emP09V5vLgwuMz19B2bWFA1
X-Gm-Message-State: AOJu0YzDwzBlgfRUl7pDCNaQ+IkZWl85ycZUBz3BApG3XgsR34zJPAx5
	Y5+mzOO8Ku/TkBW6QzuqdfXgH7cOEu8/3elkjXErZPjV5egbzHkjOnr+65dRGb6noB24nXNgWNT
	h74AmncpNewqpU6ybIP9J+lnjLiicSd0OCd3IBD/1yxJYfEYJQuJMitYC7jTlkQ==
X-Received: by 2002:a5d:4acd:0:b0:345:edfd:9529 with SMTP id y13-20020a5d4acd000000b00345edfd9529mr324844wrs.29.1714074964120;
        Thu, 25 Apr 2024 12:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYgkFWz3TXjmB86O/65fQH0zQ4HG8R+cNsPwBs/sONCBKrv9FwbEKHPLsZW9SmepLzO1jxwQ==
X-Received: by 2002:a5d:4acd:0:b0:345:edfd:9529 with SMTP id y13-20020a5d4acd000000b00345edfd9529mr324832wrs.29.1714074963663;
        Thu, 25 Apr 2024 12:56:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id cs7-20020a056000088700b00346cdf48262sm20812230wrb.2.2024.04.25.12.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:56:03 -0700 (PDT)
Message-ID: <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
Date: Thu, 25 Apr 2024 21:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zip0fEliGeL0qmID@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 17:19, Guillaume Morin wrote:
> On 24 Apr 23:00, David Hildenbrand wrote:
>>> One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
>>> hugetlb mappings. However this was also on my TODO and I have a draft
>>> patch that implements it.
>>
>> Yes, I documented it back then and added sanity checks in GUP code to fence
>> it off. Shouldn't be too hard to implement (famous last words) and would be
>> the cleaner thing to use here once I manage to switch over to
>> FOLL_WRITE|FOLL_FORCE to break COW.
> 
> Yes, my patch seems to be working. The hugetlb code is pretty simple.
> And it allows ptrace and the proc pid mem file to work on the executable
> private hugetlb mappings.
> 
> There is one thing I am unclear about though. hugetlb enforces that
> huge_pte_write() is true on FOLL_WRITE in both the fault and
> follow_page_mask paths. I am not sure if we can simply assume in the
> hugetlb code that if the pte is not writable and this is a write fault
> then we're in the FOLL_FORCE|FOLL_WRITE case.  Or do we want to keep the
> checks simply not enforce it for FOLL_FORCE|FOLL_WRITE?
> 
> The latter is more complicated in the fault path because there is no
> FAULT_FLAG_FORCE flag.
> 

I just pushed something to
	https://github.com/davidhildenbrand/linux/tree/uprobes_cow

Only very lightly tested so far. Expect the worst :)

I still detest having the zapping logic there, but to get it all right I 
don't see a clean way around that.


For hugetlb, we'd primarily have to implement the 
mm_walk_ops->hugetlb_entry() callback (well, and FOLL_FORCE).

Likely vaddr and PAGE_SIZE in uprobe_write_opcode() would have to be 
expanded to cover the full hugetlb page.

-- 
Cheers,

David / dhildenb


