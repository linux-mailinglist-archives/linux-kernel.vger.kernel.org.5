Return-Path: <linux-kernel+bounces-93392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86F872F04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED561F2495D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334455BADE;
	Wed,  6 Mar 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IJy+p5Ik"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542001BC46
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707927; cv=none; b=XqRXurLE5UQvWCCciUoqWvIP5DP8dVxloFLWk3Y9Jlm4cFXvI+ITIdBPG+ziXQLb6rUsy6QKjqg+sSuIfq5yrwUOX2bOOMGMf/q7B/3jDsOQj6FRPgIyQmwJvt9FxDHZeMKHS2W+KFHiNMdVu58cv1ifGec/6WrzyDc8/8rAcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707927; c=relaxed/simple;
	bh=3mJENGL3f4aRCBX1iaIm9ePtg/jQYq1jVfm8tlmjP+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dO7S6hisSjvKfOkMyvwU4zABvEPN4zJimzkTpQ2azwHux5WDuBfGAo5yzABHA+bMu/rL8EjDqNSDlqPqEWNqpmYHDEuzEMSReXIJtjYRSins41gJDTnikfnwmCpgdcWqKCOQhATa7RtoR51Ux68qAxpe8UJlDHyrOX2xqITMFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IJy+p5Ik; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709707916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c5yBu7adoqwvK7GV/nwnjKRKfn1zteyqa+I2+Qq4dDo=;
	b=IJy+p5IkbeJzOSQXCGSjiUMJby3YFD2b1Ap69o79E4ggN1tDMMFoyPRuoP1W42JJLK9SmJSvWh8OH5IGikXYohV80YM7euUfMhPgmlprpgJgzcFoJ6x6XEnVsHEyHEqZzQMSFx+8TZAkOBMgnIrb3ni/EaAKmMm7hAGSxo+3drA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1wOZdo_1709707914;
Received: from 30.97.48.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1wOZdo_1709707914)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 14:51:55 +0800
Message-ID: <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
Date: Wed, 6 Mar 2024 14:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/6 13:31, Gao Xiang wrote:
> There are mainly two reasons that thp_get_unmapped_area() should be
> used for EROFS as other filesystems:
> 
>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>     mappings");
> 
>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>     THPs for read-only mmapped files (e.g. shared libraries) even without
>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>     for non-DAX").

Refine this part as

  - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
    which enable THPs for mmapped files (e.g. shared libraries) even without
    ...

> 
> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")

Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index c98aeda8abb2..3d9721b3faa8 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
>   	.mmap		= erofs_file_mmap,
> +	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };

