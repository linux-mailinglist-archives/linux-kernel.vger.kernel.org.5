Return-Path: <linux-kernel+bounces-87768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7486D8B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7661F22BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE532BAE9;
	Fri,  1 Mar 2024 01:24:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5F2B9B9;
	Fri,  1 Mar 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256246; cv=none; b=cJfSjWAM+3nNu0tuVFikj6GJFQU5OTOy12BZT49h6rcomP42dxUJJmQaWnPdF2+o7tcgmauluE6h6MpH34upaLD7Tz/3i62sizzHruvhXB5zRPicuegJucu1z0l07RIw8OZ+zXKO9vZobIBX1PPq2PhrKQkbou5yhnvSH6ltwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256246; c=relaxed/simple;
	bh=XBpVTizpGtxnNmFfrxzIv8+FmfNwz48diAaegGnbCBY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jkqfTD4VzbxhKVI26luiq3g52pPetKJE5Aenn6ihVZ+shHtmvONsV07B/lkXmQchnJQlv5HoHglJbWgyDC/vvTGM3y2k4QkLwOHoxaNuL6CKT8HSoytyIZWsOcUjJooDMnR80sLEEZzz3vKHVsxeOaKoQ/MsPIbTfGLIqKlMVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tm9Km5P9GzvW3L;
	Fri,  1 Mar 2024 09:21:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D65F14037F;
	Fri,  1 Mar 2024 09:24:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 09:23:58 +0800
Subject: Re: [PATCH] ubi: eba: properly rollback inside self_check_eba
To: Fedor Pchelkin <pchelkin@ispras.ru>, Richard Weinberger <richard@nod.at>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
References: <20240229204237.30453-1-pchelkin@ispras.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1421503e-b1d2-87f2-e33e-1a0428100be2@huawei.com>
Date: Fri, 1 Mar 2024 09:23:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240229204237.30453-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/1 4:42, Fedor Pchelkin Ð´µÀ:
> In case of a memory allocation failure in the volumes loop we can only
> process the already allocated scan_eba and fm_eba array elements on the
> error path - others are still uninitialized.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 00abf3041590 ("UBI: Add self_check_eba()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   drivers/mtd/ubi/eba.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
> index 8d1f0e05892c..6f5eadb1598d 100644
> --- a/drivers/mtd/ubi/eba.c
> +++ b/drivers/mtd/ubi/eba.c
> @@ -1557,6 +1557,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
>   					  GFP_KERNEL);
>   		if (!fm_eba[i]) {
>   			ret = -ENOMEM;
> +			kfree(scan_eba[i]);
>   			goto out_free;
>   		}
>   
> @@ -1592,7 +1593,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
>   	}
>   
>   out_free:
> -	for (i = 0; i < num_volumes; i++) {
> +	while (--i >= 0) {
>   		if (!ubi->volumes[i])
>   			continue;
>   
> 


