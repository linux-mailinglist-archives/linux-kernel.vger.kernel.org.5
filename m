Return-Path: <linux-kernel+bounces-120203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99B88D463
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289E42E4BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660121A06;
	Wed, 27 Mar 2024 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kftvu67U"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F741219E4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505175; cv=none; b=Zh/a3uiJCjDwb5WLdOQ52TBpC7Map5XjD8t20en/YorkpOvbXja8JCVLSOP8yNmCDZlZUruNijq2qDQi2aVMUKBXBHGnb/1HBOVif8rykTpbVOkmWM179pA107k9jgErWvAgftNHLjm4vruRcfdt88HnNbCElHrK0y9lWD9uDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505175; c=relaxed/simple;
	bh=i9TQlwS4jHXsBaCog0XSG78A4Gp0vefPX1kFJMw18KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTsIc4Ln+ZLQOWXa3KqfYifd7ywDKzZ5rut+mT3QKBkOjVRYndW0y3oY4bHZlfJ49JbXpwP2ITjK0BJ51NpUSLuvOyZlWSNuB6sz4KaZEceFRzOH/9Oi+08GerMOvVcay6T9jsPZprCqR6fbuUC0FNkWvbuQJnr0gKv+TOFwpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kftvu67U; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d862e8b163so1316942a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711505173; x=1712109973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwUOUJFev6SeeJTav481VchkFk0enH4AA6PGxDjAHGs=;
        b=Kftvu67UI9npnD99ZX/Mh4LtelUsJoh9yClU5hJL+jy7ezcHGbDUeao7e6X3tn/jso
         ephFbNpvmEUjvxvg+5tsdqWR34SJwrLAgZQVTpihlWX8GG2N0Chkx/reggmBIS4jhWeo
         A7EBa0r2Bbl4kCmNOOF1/MSeHWuH+uUrGl48sKZjxCHorUy60I2qJj9KLBOHbFC7gdCY
         k08s3yq+Zt5et3dd8R6zHM0AhFwXtZlC9O+ctxx9xr4TuRw2OiNnodyJGc238dbxAJcx
         0YRqQyLPa5v8tr2ZBJusnRk36+0J5vYUPAYWvrZRB97tNP4Wm8C/dD4/+DR/lzGAZBbs
         9vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711505173; x=1712109973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwUOUJFev6SeeJTav481VchkFk0enH4AA6PGxDjAHGs=;
        b=C7yRCTuxwSpSRQj3XBpX0GEe0CnizmbhSsn2VnGK0aloZ3Wib4AosooZRfVKjBrdNW
         LBV1rIr0fkIf9DA7oJ0Pmpuc3H8PArOfblmlhhZdOBUF7RSncmVYaNpfp8S91Cuu6biC
         QUflmoK9Lj82GaN2LzHMQdFABOJ5+v5VCgHZUsfgHD4b5XqUHYaJxFYuI71OCjRkLWmV
         SG2ZTOVaqCGCfmZ/f9qaqFv3qHWCrbWA7L9PdeYHbcsNYNW5tjC7HcOmB0RD/QzNHhgd
         YunnlRsv4Uv2bkG8ZfdrfHMJCarIF6D4ED3B9dZK8H+rOTd3tD5/t7TT3Peqw27Jxgvs
         OxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6cNkElkSvrpIFx2kIGVL/7c4JajKkLncDU0uW958TtX3sZAtHYqGKLpWVLeFY9xjdIL0PG1dZx4T2rynYJ6o2NA+gwdQsycx1VEif
X-Gm-Message-State: AOJu0YzUktz+XGHRaQvsS13HQEgFi6nzAVAQRpY2zhKHz1lBIdE13Zd6
	Egbmeqg+GB8bNQC2kQ72nbN6zCaPOKAcs44tXVi0sY9L6C6+Hzd3eyAQALyzzCw=
X-Google-Smtp-Source: AGHT+IGfD8kxXoqXM9ss45RtxP+teLNaG0eXEfoVNsyy2oHStpBFx81guKfPstuUlABCC6y8qf6jrQ==
X-Received: by 2002:a05:6a20:7fa6:b0:1a3:b00a:7921 with SMTP id d38-20020a056a207fa600b001a3b00a7921mr15025519pzj.5.1711505173271;
        Tue, 26 Mar 2024 19:06:13 -0700 (PDT)
Received: from [10.254.105.249] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id ld8-20020a170902fac800b001e009717560sm7618786plb.232.2024.03.26.19.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 19:06:12 -0700 (PDT)
Message-ID: <d650b969-ebd7-4821-8d5a-7938ee1b7154@bytedance.com>
Date: Wed, 27 Mar 2024 10:06:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: pgtable: add missing pt_index to struct ptdesc
Content-Language: en-US
To: Vishal Moola <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 rppt@kernel.org, willy@infradead.org, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
 <283624c2af45fb2090b41a6b1b5481bb0a45bad7.1709541697.git.zhengqi.arch@bytedance.com>
 <ZgMhEp4R7de8oeAA@fedora>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZgMhEp4R7de8oeAA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/27 03:25, Vishal Moola wrote:
> On Mon, Mar 04, 2024 at 07:07:19PM +0800, Qi Zheng wrote:
>> In s390, the page->index field is used for gmap (see gmap_shadow_pgt()),
>> so add the corresponding pt_index to struct ptdesc and add a comment to
>> clarify this.
> 
> Yes s390 gmap 'uses' page->index, but not for the purpose page->index is
> supposed to hold. It's alright to have a variable here, but I'd rather
> see it named something more appropriate to the purporse it serves.

Make sense.

> 
> You can take look at this patch from v5 of my ptdesc conversion series
> for more info:
> https://lore.kernel.org/linux-mm/20230622205745.79707-3-vishal.moola@gmail.com/

Oh, but it seems that this patch has not been merged?

> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mm_types.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 5ea77969daae..5240bd7bca33 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -425,6 +425,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>>    * @_pt_pad_1:        Padding that aliases with page's compound head.
>>    * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
>>    * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
>> + * @pt_index:         Used for s390 gmap.
>>    * @pt_mm:            Used for x86 pgds.
>>    * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
>>    * @_pt_pad_2:        Padding to ensure proper alignment.
>> @@ -450,6 +451,7 @@ struct ptdesc {
>>   	unsigned long __page_mapping;
>>   
>>   	union {
>> +		pgoff_t pt_index;
>>   		struct mm_struct *pt_mm;
>>   		atomic_t pt_frag_refcount;
>>   	};
>> @@ -475,6 +477,7 @@ TABLE_MATCH(flags, __page_flags);
>>   TABLE_MATCH(compound_head, pt_list);
>>   TABLE_MATCH(compound_head, _pt_pad_1);
>>   TABLE_MATCH(mapping, __page_mapping);
>> +TABLE_MATCH(index, pt_index);
>>   TABLE_MATCH(rcu_head, pt_rcu_head);
>>   TABLE_MATCH(page_type, __page_type);
>>   TABLE_MATCH(_refcount, __page_refcount);
>> -- 
>> 2.30.2
>>

