Return-Path: <linux-kernel+bounces-96751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102CB8760FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9034D1F2425A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B5535A4;
	Fri,  8 Mar 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNnpmpch"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE887535A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890469; cv=none; b=LM29pX/Y3+gV+cjFKInPj7Z/A0OS9xtdkkHMgB+DPGj47NSREwT8WxQz3VNW+iXZYgiAQAgBHtoKWn5QeNnGw8PmaVgGSZSkOlTI1xHrlAxs4jU1kWFp2E448VT0kA6ULdw39zGDXznxAA4F+FVnTNv8N8lTOyJZv1edCTJWJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890469; c=relaxed/simple;
	bh=Olo/uAIKJMzOpkHppjGk3a3pyAR1GKfUi+0S4SqxRIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNwQ0j3Yk56wsysEeKJAEAFbGxT/APMCEarxVvoncmrsaPS7y3NqIriC71rfbTNKtTizJBgHNzF5C8OfEAcvFEkN/BFEf+G2ZCKJVPtWmd/UNw7b/8wV+hFq6Gj2SLylonOirx3wlzZFYRQ9D8iK0/vwqpuKEf1lg0SrLZ9Cq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNnpmpch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709890466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4PyYMujJIwSutTBcPEeTK5QOuGJr586IQzthYNJ4C2c=;
	b=hNnpmpchvPncKRkC3DxzAjPFWMGfCovjZhKvZIGcnXJ6F6bqXba/nLlZPwCUXa+Ih568yo
	3MBN0Ps4+3eZcxDZQ2karMFvGn+69lt4SVmFzv7YYT8Lv/oS1A10krZkanZ2jvkMOL5Z3F
	WFjdZvY96wdFxdnMTAQrnW/NB6kxs3o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-9C5xNm_CP7ynSOzNfA5z7w-1; Fri, 08 Mar 2024 04:34:24 -0500
X-MC-Unique: 9C5xNm_CP7ynSOzNfA5z7w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d8d208be9so350990f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890463; x=1710495263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PyYMujJIwSutTBcPEeTK5QOuGJr586IQzthYNJ4C2c=;
        b=M5XCLkuYyWjBG4oJLkUPz40EKIxIslIWWOCDcODjb80FN4/nwQIvoxlG8wh7Bt9Jb8
         AIPrz+/ZZJtNI0I5DExqffn5vs/Hp74b1ZCectWE1DDItteZEDTCM8IuSmAPWA610CNo
         YkMiaQy4gJDsTMokNCLgydLAayNheOpZ9rxdze5GD1WXEM2K/Gp/Ea4Y3cgEs7R3NmHo
         SjV7y0hbzptS8SgtluvztQi+PutTf92KEQUOeB3FEUTR5mlF8VmLpL3aXaXUuMtcqpq6
         JZNkYAYQub8lvsbdcDXXsh8ZxeyokLnniNKMDONPPUVuWRuxfeIFgHUYLhsr+sgoY+Fy
         augg==
X-Forwarded-Encrypted: i=1; AJvYcCX5xAzJestgoqX8V79uaBCIGGkG6p/MAz9rEpkYJrUdfrMaUoxxi84rwipyssx64qxZ80RnVNBpYfYdAObXHL4Tbai3kHi7CFxWmmuQ
X-Gm-Message-State: AOJu0YwN7RWG7MTwdw/8v4HQqr++q1+8ustkHJ+p6+19liZbiwRh1khT
	wZAwSbKOod3+ZPkLVFX4jly+qMtka9GUYMS2rYm/+TCWJ8urURXqtu7q1otb3Za5H/zq6lBoiBA
	qOE+fDzZ+XlkwlTRgT+beMcSacNRqvJOtcFShoobNPTG534t8KKJJG4mqevBiOA==
X-Received: by 2002:adf:f212:0:b0:33e:77b2:ff86 with SMTP id p18-20020adff212000000b0033e77b2ff86mr642369wro.69.1709890463574;
        Fri, 08 Mar 2024 01:34:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOEVeg2fTQaFV9r4rxDd46YTB5nKiqUPJYgjXilXVo4xWEkGlPStouwu3oB8WQBJ1QVmcXpA==
X-Received: by 2002:adf:f212:0:b0:33e:77b2:ff86 with SMTP id p18-20020adff212000000b0033e77b2ff86mr642342wro.69.1709890463070;
        Fri, 08 Mar 2024 01:34:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:3500:5cd0:78d9:ca49:21f3? (p200300cbc70735005cd078d9ca4921f3.dip0.t-ipconnect.de. [2003:cb:c707:3500:5cd0:78d9:ca49:21f3])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcb8d000000b0033ce06c303csm22260216wrh.40.2024.03.08.01.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:34:22 -0800 (PST)
Message-ID: <519fd6a7-072e-43a2-a9a8-2467ee783524@redhat.com>
Date: Fri, 8 Mar 2024 10:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: prohibit the last subpage from reusing the entire
 large folio
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: minchan@kernel.org, fengwei.yin@intel.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, peterx@redhat.com, ryan.roberts@arm.com,
 shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com,
 xiehuan09@gmail.com, zokeefe@google.com, chrisl@kernel.org,
 yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>
References: <20240308092721.144735-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240308092721.144735-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.03.24 10:27, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> In a Copy-on-Write (CoW) scenario, the last subpage will reuse the entire
> large folio, resulting in the waste of (nr_pages - 1) pages. This wasted
> memory remains allocated until it is either unmapped or memory
> reclamation occurs.
> 
> The following small program can serve as evidence of this behavior
> 
>   main()
>   {
>   #define SIZE 1024 * 1024 * 1024UL
>           void *p = malloc(SIZE);
>           memset(p, 0x11, SIZE);
>           if (fork() == 0)
>                   _exit(0);
>           memset(p, 0x12, SIZE);
>           printf("done\n");
>           while(1);
>   }
> 
> For example, using a 1024KiB mTHP by:
>   echo always > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
> 
> (1) w/o the patch, it takes 2GiB,
> 
> Before running the test program,
>   / # free -m
>                  total        used        free      shared  buff/cache   available
>   Mem:            5754          84        5692           0          17        5669
>   Swap:              0           0           0
> 
>   / # /a.out &
>   / # done
> 
> After running the test program,
>   / # free -m
>                   total        used        free      shared  buff/cache   available
>   Mem:            5754        2149        3627           0          19        3605
>   Swap:              0           0           0
> 
> (2) w/ the patch, it takes 1GiB only,
> 
> Before running the test program,
>   / # free -m
>                   total        used        free      shared  buff/cache   available
>   Mem:            5754          89        5687           0          17        5664
>   Swap:              0           0           0
> 
>   / # /a.out &
>   / # done
> 
> After running the test program,
>   / # free -m
>                  total        used        free      shared  buff/cache   available
>   Mem:            5754        1122        4655           0          17        4632
>   Swap:              0           0           0
> 
> This patch migrates the last subpage to a small folio and immediately
> returns the large folio to the system. It benefits both memory availability
> and anti-fragmentation.

It might be controversial optimization, and as Ryan said, there, are 
likely other cases where we'd want to migrate off-of a thp if possible 
earlier.

But I like that it just handles large folios now in a consistent way for 
the time being.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


