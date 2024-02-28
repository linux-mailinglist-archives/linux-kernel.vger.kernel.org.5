Return-Path: <linux-kernel+bounces-84575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5286A88C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C7C1C243DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD924B24;
	Wed, 28 Feb 2024 06:48:46 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479922F00;
	Wed, 28 Feb 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102926; cv=none; b=A3ILUZuLluTCFKUhkP/BqLyV98yPg75Laxs6toFqu42tvST6+B+FmuK/3KTt9GOPI23kMzMwygRqwKrUWcZn2z9n8n63HSroeKKe9Xm5xkzsvGx9NmTCXlaw1lGM5dpnw4nm3hJZvq01nU72TbHpkP4N5Sbw7Pvq0LabuxdY97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102926; c=relaxed/simple;
	bh=J0F7oEgNQ9OifyFp0og5GKcg7g1hKuax/CW1CKt2xnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uvlx+dbZ3fCb1VuBgwh1F8rxDDTS2X6At+93Vy8Z6k3IXHR/FNxMXX0gAI2UY5PrWYmru2jdpHmBPk2vyydtM6qL6MuwY4RRFn39YsQgg7ZvafnKvBW4VEIWGyyNzp0ETVQrtKF0mpAXzfe28LC9y1zhlPJtBSSoGHf3+hgM648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tl4g156swzqjhm;
	Wed, 28 Feb 2024 14:47:57 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D2CDE1A016B;
	Wed, 28 Feb 2024 14:48:34 +0800 (CST)
Received: from [10.67.121.249] (10.67.121.249) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 14:48:34 +0800
Message-ID: <7163b400-1e35-49ea-9a12-9dae27428431@huawei.com>
Date: Wed, 28 Feb 2024 14:48:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: hisilicon/zip - fix the missing
 CRYPTO_ALG_ASYNC in cra_flags
To: Barry Song <21cnbao@gmail.com>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Barry Song <v-songbaohua@oppo.com>, Zhou
 Wang <wangzhou1@hisilicon.com>
References: <20240220044222.197614-1-v-songbaohua@oppo.com>
From: Yang Shen <shenyang39@huawei.com>
In-Reply-To: <20240220044222.197614-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)



在 2024/2/20 12:42, Barry Song 写道:
> Add the missing CRYPTO_ALG_ASYNC flag since hisilizon zip driver
> works asynchronously.
>
> Cc: Yang Shen <shenyang39@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   drivers/crypto/hisilicon/zip/zip_crypto.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
> index c650c741a18d..94e2d66b04b6 100644
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
>   	.base			= {
>   		.cra_name		= "deflate",
>   		.cra_driver_name	= "hisi-deflate-acomp",
> +		.cra_flags		= CRYPTO_ALG_ASYNC,
>   		.cra_module		= THIS_MODULE,
>   		.cra_priority		= HZIP_ALG_PRIORITY,
>   		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
Thx！

Acked-by: Yang Shen <shenyang39@huawei.com>

