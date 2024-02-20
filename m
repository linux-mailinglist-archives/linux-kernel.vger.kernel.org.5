Return-Path: <linux-kernel+bounces-73124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E202F85BDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979B91F23B56
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81F71B55;
	Tue, 20 Feb 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PaoKjvW1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8D6A8BE;
	Tue, 20 Feb 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437343; cv=none; b=Tcvn29yFc58j33bsFoLitcz2SalcbtN6tvUlVyyHuzyDRZJV1GMOEN7qdjU1ATHOr3I7YQ6aabtDv0XWm/sZCBzMDdqQkaNksbHWdv5jPy6GUy++Bid0dvzp2hI7KvxSCoU3EtIQe8GVjeeaX3iJ5e5YXCXYXM6uFauc7bIwlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437343; c=relaxed/simple;
	bh=JDNYKCX7Gnczf5JaEMRjWQJZmqZ/a75WvEM0QMCpONE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g3T9+BUKg4j7lRd+ucPS5DJEs3DPu1MAEjNkQh/AFo43pahQVvsPKxZdukrdW30y5kLXRONMUSlEVG0rbJJNJw5wkOplBLUc1twlxSkZ1CvLok6uP5BZz6XmHR32hmSHTtHVg8lxNB+shqfsnixuA6LqYbFt/mqnRfEmQ8srgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PaoKjvW1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KDtar5080825;
	Tue, 20 Feb 2024 07:55:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708437336;
	bh=9L1rHmMmIbC6TlVE2ZEhGXvsFuBdWXewTcaJYFPLP8s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PaoKjvW1d65Ua54jd+7gp9MI+PwmvxH6+/LRrgLSp5CsHECnRbyQXJAKYubOIfjzu
	 vJ3pqT47ELcOj4NP2YM3FRc+ENFyfq+oK7QeEBAfP6iHxpo3QLWQaaSEnh0INkSfh4
	 QTEzZCLi9yUFfmrthq9YAgptOx8KfWtOvUle3vxw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KDtaAo008926
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 07:55:36 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 07:55:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 07:55:36 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KDtav0087390;
	Tue, 20 Feb 2024 07:55:36 -0600
Message-ID: <e69f523e-8d58-4a4f-af28-7238e818eac1@ti.com>
Date: Tue, 20 Feb 2024 07:55:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: xgene-reboot: Fix a NULL vs IS_ERR() test
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/20/24 3:02 AM, Dan Carpenter wrote:
> The devm_platform_ioremap_resource() function returns error points.  It
> never returns NULL.  Update the check accordingly.
> 
> Fixes: 7ddfd33c6ee5 ("power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/power/reset/xgene-reboot.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
> index 867162dfe7ea..b5eee19bac42 100644
> --- a/drivers/power/reset/xgene-reboot.c
> +++ b/drivers/power/reset/xgene-reboot.c
> @@ -51,9 +51,9 @@ static int xgene_reboot_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ctx->csr = devm_platform_ioremap_resource(pdev, 0);
> -	if (!ctx->csr) {
> +	if (IS_ERR(ctx->csr)) {
>   		dev_err(dev, "can not map resource\n");
> -		return -ENODEV;
> +		return PTR_ERR(ctx->csr);
>   	}
>   
>   	if (of_property_read_u32(dev->of_node, "mask", &ctx->mask))

