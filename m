Return-Path: <linux-kernel+bounces-86111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BC86BFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E5D1F248E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B7376F4;
	Thu, 29 Feb 2024 04:05:36 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8F37165
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179536; cv=none; b=K523xTu7IJmihklnXN+sNCCPTnzRXWc5j+UWTRf7AEGrwjN+LhFlq4T+6/XnTBgBNH0QI12vXgduZ3RnMJpq5NbcUyZ9LGPW1blgbAkN65laTKK0pqz38Bg9r0yrO1k6jX/qU+qqqllp+0gYymlRCkEQqUEvYETcr1UpHtAlpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179536; c=relaxed/simple;
	bh=yjphq19O7syFPhhMeuEWeO2sgmYls4pYhpY5BptK2+U=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JsIgOmDJFcl/uYSWOSXJXeC7QZJDkEmWMhf/d9a8YFNhspRFqOQFNIxXfovfmgsb1YzbxnjlQ4j9/jbTR3q9ebSupshmGYSTLTenXRXJR92qGbvp1UZV3rll+Dy2txBpu/ErU9qs1UqyUjzxIRQSQaSh+a5pv5EXJd20tCPyBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tld0Q48mpz1FLNq;
	Thu, 29 Feb 2024 12:04:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E06C214011A;
	Thu, 29 Feb 2024 12:04:55 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 12:04:55 +0800
Subject: Re: [PATCH v3] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
To: Daniel Golle <daniel@makrotopia.org>, Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b64a4423-922b-de8e-3c43-fc5bf2df19be@huawei.com>
Date: Thu, 29 Feb 2024 12:04:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/29 11:47, Daniel Golle Ð´µÀ:
> A compiler warning related to sizeof(int) != 8 when calling do_div()
> is triggered when building on 32-bit platforms.
> Address this by using integer types having a well-defined size.
> 
> Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use size_t also for 'to_read' variable to avoid truncation
>      (no problem in practise beyond the compiler warning)
> v2: use size_t for 'bytes_left' variable to match parameter type
> 
>   drivers/mtd/ubi/nvmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> index b7a93c495d172..8aeb9c428e510 100644
> --- a/drivers/mtd/ubi/nvmem.c
> +++ b/drivers/mtd/ubi/nvmem.c
> @@ -23,9 +23,12 @@ struct ubi_nvmem {
>   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>   			      void *val, size_t bytes)
>   {
> -	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
> +	size_t to_read, bytes_left = bytes;
>   	struct ubi_nvmem *unv = priv;
>   	struct ubi_volume_desc *desc;
> +	uint32_t offs;
> +	uint64_t lnum = from;
> +	int err = 0;
>   
>   	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
>   	if (IS_ERR(desc))
> 


