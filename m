Return-Path: <linux-kernel+bounces-94845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5C8745DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14691F25705
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E05672;
	Thu,  7 Mar 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="buIw++UH"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD27484
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776947; cv=none; b=s2RAbVeD/PXAPXpYhM0msN9//ho1+1AIrYOlOkENgbB5pphJmPRVwhngyLOZvHgYAuSEyTpk9UVu8Y6xT+Z8VhkuZiNXSWal6r+eODBJvxRVyEPT4QgP7sslG50GZB8ehU+FjuN40DZyGZKy8GUfWv7P8n9uZNDPU1McUtpsPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776947; c=relaxed/simple;
	bh=3dofe8XBTF5qxX/nAQfcCvkyYnl+W4TNyFSd7kdrbEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvwavv85RArlSKJ1bpzbY39PIBEWSsYDKomWIMfXbGAQngtvBYKH39zh4nJrcWM8AglriBt8Kf8pOfq0oyieD6xOVj/LZ5ksSHHYYqPwievR65HlySzz4rNyYV2lO6mBeZxpevXnH1L+fwMFguQ3UTs06ZuEexBTjbH3xtO7sJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=buIw++UH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709776942; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JBfqtPn8k1lCO84oA6JKbGN+1vMEH2khXMOKAyW0fAs=;
	b=buIw++UHIkodJt1yavK/HLEd94q30mO3yZpIbt9yPbIu9XNwJ5PxL4lbOM2DO34aUwNPXGXorb4zG6KkdFRsS+JE1HKuunTYBljXZ1qKydcsyDtHk5W+1P/T/Jl5pPcc3utSbl+cl2C76mY+vc8RIXK4lXbSbZUPwKA6EljT1Ns=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1z3fTt_1709776940;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1z3fTt_1709776940)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 10:02:21 +0800
Message-ID: <1096418c-7657-4d38-8344-bf6cf3c1b8bb@linux.alibaba.com>
Date: Thu, 7 Mar 2024 10:02:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
 <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
 <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/7 09:07, Chao Yu wrote:
> On 2024/3/6 14:51, Gao Xiang wrote:
>>
>>
>> On 2024/3/6 13:31, Gao Xiang wrote:
>>> There are mainly two reasons that thp_get_unmapped_area() should be
>>> used for EROFS as other filesystems:
>>>
>>>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>>>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>>>     mappings");
>>>
>>>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>>>     THPs for read-only mmapped files (e.g. shared libraries) even without
>>>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>>>     for non-DAX").
>>
>> Refine this part as
>>
>>   - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
>>     which enable THPs for mmapped files (e.g. shared libraries) even without
>>     ...
>>
>>>
>>> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
>>
>> Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
>> Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks, added!

Thanks,
Gao Xiang

> 
> Thanks,

