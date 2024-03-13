Return-Path: <linux-kernel+bounces-101550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7687A899
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5751E1F239F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1341208;
	Wed, 13 Mar 2024 13:41:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEA4085A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337276; cv=none; b=kPowaVdz9OPA+0srjjyR6GmF2CJhH59Sy5UzUbZ6dpeGp+WSrRd41md8aPGe7ob1YCXLC0kEjUBJg2tQFpDfHTtwJUeyAx9qgGL9qswbsgjlmwSHUGZ00OsZN4PyIeMIOwckuwOeaAtbSVpc5fWg05vIeUlzJPzbV2FoK3xhmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337276; c=relaxed/simple;
	bh=/zJsUCRHpKKyi8IF815/03gYTr19Z650y7wr1pJFN+k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pISAh8347mLXXOt6JEH4CNFevcbQGKwJ1BUGahPOeZCSrVaETQWlJrhbneYTrSrS4VoFuHu0ZKkn5je4byodR9QghiLnQigSExq0bCZfLq00ZTu22ao8T7bLeGBdCfCXOAWyr2frqM9s9RGWrPdts3QeCULgLk1UotF6dH/9BsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tvs7967dKz1xqk0;
	Wed, 13 Mar 2024 21:39:17 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 451821A0172;
	Wed, 13 Mar 2024 21:41:03 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 21:41:02 +0800
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
To: Arnd Bergmann <arnd@kernel.org>, Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240313084707.3292300-1-arnd@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c7c8644b-3dcb-d949-f596-bb8d100f0fe5@huawei.com>
Date: Wed, 13 Mar 2024 21:41:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240313084707.3292300-1-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/13 16:46, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The use of do_div() in ubi_nvmem_reg_read() makes calling it on
> 32-bit machines rather expensive. Since the 'from' variable is
> known to be a 32-bit quantity, it is clearly never needed and
> can be optimized into a regular division operation.
> 
> Fixes: b8a77b9a5f9c ("mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems")
> Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/mtd/ubi/nvmem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> index 8aeb9c428e51..a94a1a9aaec1 100644
> --- a/drivers/mtd/ubi/nvmem.c
> +++ b/drivers/mtd/ubi/nvmem.c
> @@ -6,7 +6,6 @@
>   /* UBI NVMEM provider */
>   #include "ubi.h"
>   #include <linux/nvmem-provider.h>
> -#include <asm/div64.h>
>   
>   /* List of all NVMEM devices */
>   static LIST_HEAD(nvmem_devices);
> @@ -27,14 +26,15 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>   	struct ubi_nvmem *unv = priv;
>   	struct ubi_volume_desc *desc;
>   	uint32_t offs;
> -	uint64_t lnum = from;
> +	uint32_t lnum;
>   	int err = 0;
>   
>   	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
>   	if (IS_ERR(desc))
>   		return PTR_ERR(desc);
>   
> -	offs = do_div(lnum, unv->usable_leb_size);
> +	offs = from % unv->usable_leb_size;
> +	lnum = from / unv->usable_leb_size;
>   	while (bytes_left) {
>   		to_read = unv->usable_leb_size - offs;
>   
> 


