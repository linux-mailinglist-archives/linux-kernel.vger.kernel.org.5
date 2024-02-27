Return-Path: <linux-kernel+bounces-82602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700E8686E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A5F290B57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B81EB22;
	Tue, 27 Feb 2024 02:23:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A681EA6E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000604; cv=none; b=AOros9TNJQxgkXbQwPThbDSNKGwtpYkBI0A5fjjIgEDbWp6dphsjk2pjGd2sVg6NUlyoqcBFZGnxoWYp52+DocE4XtO/B1pkHtv21qEjuiGYIGb3ILduaSJt2xEvN4HQWwi2YJDcMUOw7Nkc0KBycmBQTxE+mg1tj8Gf6JdqFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000604; c=relaxed/simple;
	bh=xwcfyNthPN1RaCRQZcjS0Np3XzkQ2lmusAvZoIpRo/Y=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e5WRRnEdUtcdWTWrM9x5B5uuTWY8geYM9+nOKO+EniwsDbGpfT4ybqThsvjKaju56dBJkrrkhX8X3yz7qjAOD3cERIH/KD5DQEEnCMIvNvArzAk8yfesC/rIjyisTz9Xq/uCVSOebznNY/fCo4Cct+6ehWKl4ugkHTtOA794z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TkLnY2Rb2z2Bdhq;
	Tue, 27 Feb 2024 10:21:05 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 294F4180060;
	Tue, 27 Feb 2024 10:23:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 10:23:18 +0800
Subject: Re: [PATCH] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
To: Daniel Golle <daniel@makrotopia.org>, Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <186fa96ae25f7033ff8b6f0f7fcfb1e602f556fc.1708971705.git.daniel@makrotopia.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ab2b4573-58ce-d895-0aae-69e3647e0a68@huawei.com>
Date: Tue, 27 Feb 2024 10:23:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <186fa96ae25f7033ff8b6f0f7fcfb1e602f556fc.1708971705.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/27 2:23, Daniel Golle Ð´µÀ:
> A compiler warning related to sizeof(int) != 8 when calling do_div()
> is triggered when building on 32-bit platforms.
> Address this by using integer types having a well-defined size where
> appropriate.
> 
> Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/mtd/ubi/nvmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> index b7a93c495d172..5820a170d2512 100644
> --- a/drivers/mtd/ubi/nvmem.c
> +++ b/drivers/mtd/ubi/nvmem.c
> @@ -23,14 +23,17 @@ struct ubi_nvmem {
>   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>   			      void *val, size_t bytes)
>   {
> -	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
> +	uint32_t bytes_left, offs, to_read;
>   	struct ubi_nvmem *unv = priv;
>   	struct ubi_volume_desc *desc;
> +	uint64_t lnum = from;
> +	int err = 0;
>   
>   	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
>   	if (IS_ERR(desc))
>   		return PTR_ERR(desc);
>   
> +	bytes_left = bytes;
The 'bytes' is a size_t type, which has 64 bits on 64-bit platforms. 
This assignment will lead a type truncation, so should we add a explicit 
type conversion here to avoid compiler warning?
>   	offs = do_div(lnum, unv->usable_leb_size);
>   	while (bytes_left) {
>   		to_read = unv->usable_leb_size - offs;
> 


