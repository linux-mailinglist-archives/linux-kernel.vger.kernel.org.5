Return-Path: <linux-kernel+bounces-93449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7041873004
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616E228955F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85A5CDF5;
	Wed,  6 Mar 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RZMYyu/m"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1165C60F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711714; cv=none; b=lvmsZANjXIZGpybX5IYcAnof8bzchOY4ZEJrisuS+BDWfOA+gXOCEjYg+Udjwcq/KXYUJVGU6+FobbOEeuLeh/RtpNf5KtDEEOARrd17WU4SryKPZtWbx5r8V/sZoWJrl5zSnnCRImiM0JIzGKwp4MatRbUvv36T0jZoHgfY4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711714; c=relaxed/simple;
	bh=vw1Do1mdUeSYW8XeseizCXsoA/vB1CreAqCRX8tXwoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn7k81cAQFxKuEUJiZBRwXQkzptrKuI5Fz9pBa19xi5fKuV8K6khwQ1H3GeDHw/ayVTJYxLsUcVhEChtbo/Ly3AqUSpcJcT03JQJJF9QLa8nxyGz+3VlEOqMc2B2/85TZroULMx13TLgH4ivocsiRUo2zYd2ymgKcCSqqrxfE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RZMYyu/m; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709711708; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6m9vEWZGyUoYUNKNnaBD15J1Z0XArlRy+U6S81860p4=;
	b=RZMYyu/mWJUEasutgo7FvnE/M2gGaBnUL9CI3RfDG7x6IeEMCRW5DS6cnROxadx/f0t3M3Xk1O8L0m8kDFUJ1L7fTMzzPvBRUSb0NIAK7L+BCATm+VMQiSv6zjA2X5FlVFQAt7HJJSQvp/T+0Yt+vPak1fEwHU/CqJR3sudXRrM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1wff2R_1709711707;
Received: from 30.221.146.143(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1wff2R_1709711707)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 15:55:08 +0800
Message-ID: <3db6b039-a071-4736-aaa8-fe1a7934f981@linux.alibaba.com>
Date: Wed, 6 Mar 2024 15:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
 <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/24 2:51 PM, Gao Xiang wrote:
> 
> 
> On 2024/3/6 13:31, Gao Xiang wrote:
>> There are mainly two reasons that thp_get_unmapped_area() should be
>> used for EROFS as other filesystems:
>>
>>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>>     mappings");
>>
>>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>>     THPs for read-only mmapped files (e.g. shared libraries) even without
>>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>>     for non-DAX").
> 
> Refine this part as
> 
>  - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
>    which enable THPs for mmapped files (e.g. shared libraries) even without
>    ...
> 
>>
>> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular
>> file")
> 
> Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
> Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
> 
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/data.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index c98aeda8abb2..3d9721b3faa8 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
>>       .llseek        = generic_file_llseek,
>>       .read_iter    = erofs_file_read_iter,
>>       .mmap        = erofs_file_mmap,
>> +    .get_unmapped_area = thp_get_unmapped_area,
>>       .splice_read    = filemap_splice_read,
>>   };


LGTM.

Reviewed-by: Jingbo Xu \<jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

