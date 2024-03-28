Return-Path: <linux-kernel+bounces-122719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C088FC04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE17B1F2D915
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD5657BF;
	Thu, 28 Mar 2024 09:50:06 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0F41C62;
	Thu, 28 Mar 2024 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619405; cv=none; b=q5Vvmr0Onvq1+aNFkwSiDvKk2k1ha4JTK+seE3nHkWXecaE3ayu1uIwLc0ez1DM542xdVZd8WIHO65NAxHwpNaEQX2AjZx3a6W/pXmW2e6fl/+0a3GLs51PSbNGNl7AdbC4L2Q8GYf3vlfK+hRUjIFufBKxejW1juqHs91e4Cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619405; c=relaxed/simple;
	bh=XBHE/uu+Z4wWTdk0CrlvoxxR3xMTv2slwoV1UnlURD8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Cm4ZBQ1MBevaM8jvC5tlEvbYBelwt6k5nYPPlnWyhVCZh7RHsed1SvHyXac7vdD6ObvBuhA3T6+L4DG0yGdWE5eK11K5Rl/PrU9gnXmkhUkNeiD4jOwQUcRpNtFribCR8w9JBcqDuSUgCQBJlntu8ZbZDFfFyfvfbXxUdu6d0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V4zGs1896ztQrt;
	Thu, 28 Mar 2024 17:47:33 +0800 (CST)
Received: from canpemm100001.china.huawei.com (unknown [7.192.105.122])
	by mail.maildlp.com (Postfix) with ESMTPS id A87941404F6;
	Thu, 28 Mar 2024 17:49:59 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100001.china.huawei.com (7.192.105.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 17:49:59 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 17:49:58 +0800
Subject: Re: [PATCH v4] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Yihang Li <liyihang9@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <dlemoal@kernel.org>,
	<chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>
References: <20240328090626.621147-1-liyihang9@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <bd975860-8872-8bf9-0bd6-da69c2f2973d@huawei.com>
Date: Thu, 28 Mar 2024 17:49:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240328090626.621147-1-liyihang9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/28 17:06, Yihang Li wrote:
> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
> through kmalloc() allocation. However, for the hisi_sas hardware, all
> commands address must be 16-byte-aligned. Otherwise, the commands fail to
> be executed.
> 
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.
> 
> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> Changes since v3:
> - Still aligned to ARCH_DMA_MINALIGN for safe DMA operations.
> 
> Changes since v2:
> - Use 16B as alignment for SMP requests instead of ARCH_DMA_MINALIGN.
> 
> Changes since v1:
> - Directly modify alloc_smp_req() instead of using handler callback.
> ---
>   drivers/scsi/libsas/sas_expander.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..c989d182fc75 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>   
>   static inline void *alloc_smp_req(int size)
>   {
> -	u8 *p = kzalloc(size, GFP_KERNEL);
> +	u8 *p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
>   	if (p)
>   		p[0] = SMP_REQUEST;
>   	return p;
> 

Reviewed-by: Jason Yan <yanaijie@huawei.com>

Thanks,
Jason

