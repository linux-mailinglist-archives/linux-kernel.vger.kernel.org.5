Return-Path: <linux-kernel+bounces-36536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BD83A2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A912B28241
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592AF1642B;
	Wed, 24 Jan 2024 07:21:05 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80915AF9;
	Wed, 24 Jan 2024 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706080864; cv=none; b=MhfOBF6zgOWH5Wwa7eb1+1bmTXUg/bBCw5s5p1+IVMWLtpORMSEkPM+DIwTbTYLRkZvbW6rEGHMJYSU3Y5VcxJdiaRZ/gcfB+Y4gB9JVx7HN/azryjY+oNfrbQaDulXqaxmn+UmpwSTZUOu2hjsyOrpXDQ+ZHXqwyVPdKy9NDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706080864; c=relaxed/simple;
	bh=hqnn0O33ZGOANOF1UbdS2Zr5XzrRPb8ICqrmdQ7Xicg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=doBoAZPAjQtW7gfJeu3QYAG9ru9cJsEUJNM/d/nIaiAw5gSBTxjX0zdeB62mHQYcdD2zw6SeEgapQqQUFCNuMtjn+/9OztujFZd2haqiwPsZmECjJxAFDt663mrHKw/cGAIWe0veKxLAdC81HXNLbQkMuyodmoH5YOeqURMuQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TKb1H47m3z29khk;
	Wed, 24 Jan 2024 15:19:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B6EB61A0172;
	Wed, 24 Jan 2024 15:20:59 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 15:20:59 +0800
Subject: Re: [PATCH] ubi: Check for too small LEB size in VTBL code
To: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Chenyuan Yang <cy54@illinois.edu>,
	<stable@vger.kernel.org>
References: <20240124063702.5642-1-richard@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7875bf6f-faf4-5612-1d82-0f16a58f8455@huawei.com>
Date: Wed, 24 Jan 2024 15:20:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124063702.5642-1-richard@nod.at>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/1/24 14:37, Richard Weinberger Ð´µÀ:
> If the LEB size is smaller than a volume table record we cannot
> have volumes.
> In this case abort attaching.
> 
> Cc: Chenyuan Yang <cy54@illinois.edu>
> Cc: stable@vger.kernel.org
> Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
> Reported-by: Chenyuan Yang <cy54@illinois.edu>
> Closes: https://lore.kernel.org/linux-mtd/1433EB7A-FC89-47D6-8F47-23BE41B263B3@illinois.edu/
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   drivers/mtd/ubi/vtbl.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
> index f700f0e4f2ec..6e5489e233dd 100644
> --- a/drivers/mtd/ubi/vtbl.c
> +++ b/drivers/mtd/ubi/vtbl.c
> @@ -791,6 +791,12 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
>   	 * The number of supported volumes is limited by the eraseblock size
>   	 * and by the UBI_MAX_VOLUMES constant.
>   	 */
> +
> +	if (ubi->leb_size < UBI_VTBL_RECORD_SIZE) {
> +		ubi_err(ubi, "LEB size too small for a volume record");
> +		return -EINVAL;
> +	}
> +
>   	ubi->vtbl_slots = ubi->leb_size / UBI_VTBL_RECORD_SIZE;
>   	if (ubi->vtbl_slots > UBI_MAX_VOLUMES)
>   		ubi->vtbl_slots = UBI_MAX_VOLUMES;
> 


