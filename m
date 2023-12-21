Return-Path: <linux-kernel+bounces-8603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D046481BA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5E8B23941
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424AE4F884;
	Thu, 21 Dec 2023 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWJHVsUG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398B360AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e5fb1fa-33a3-470c-b479-24019f322ed3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703170738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5T5w8CgY/enZFfTVMOvm6QbdpwFB/KmSvNCGj7+SDI=;
	b=mWJHVsUGk2Krdds/QK0LWVTNIzd5fuP0Y8K9rrCg6vt9XbSEqkMluS03MvAR6R2XVe1hz5
	ZfhyAuzgncdrfVxmnvPmn/u2Pd9zCUj+t6b0stlWultOpdckiVIo74JT9/wd5S01Oyc9QT
	b0EsQIA/wHVlSpFYd9ol+DqAxomfWnE=
Date: Thu, 21 Dec 2023 14:58:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 1/1] ptp: ocp: Use DEFINE_RES_*() in place
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/12/2023 14:06, Andy Shevchenko wrote:
> There is no need to have an intermediate functions as DEFINE_RES_*()
> macros are represented by compound literals. Just use them in place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4021d3d325f9..306353a69231 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1716,20 +1716,6 @@ ptp_ocp_get_mem(struct ptp_ocp *bp, struct ocp_resource *r)
>   	return __ptp_ocp_get_mem(bp, start, r->size);
>   }
>   
> -static void
> -ptp_ocp_set_irq_resource(struct resource *res, int irq)
> -{
> -	struct resource r = DEFINE_RES_IRQ(irq);
> -	*res = r;
> -}
> -
> -static void
> -ptp_ocp_set_mem_resource(struct resource *res, resource_size_t start, int size)
> -{
> -	struct resource r = DEFINE_RES_MEM(start, size);
> -	*res = r;
> -}
> -
>   static int
>   ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
>   {
> @@ -1741,15 +1727,15 @@ ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
>   	int id;
>   
>   	start = pci_resource_start(pdev, 0) + r->offset;
> -	ptp_ocp_set_mem_resource(&res[0], start, r->size);
> -	ptp_ocp_set_irq_resource(&res[1], pci_irq_vector(pdev, r->irq_vec));
> +	res[0] = DEFINE_RES_MEM(start, r->size);
> +	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
>   
>   	info = r->extra;
>   	id = pci_dev_id(pdev) << 1;
>   	id += info->pci_offset;
>   
>   	p = platform_device_register_resndata(&pdev->dev, info->name, id,
> -					      res, 2, info->data,
> +					      res, ARRAY_SIZE(res), info->data,
>   					      info->data_size);
>   	if (IS_ERR(p))
>   		return PTR_ERR(p);
> @@ -1768,11 +1754,11 @@ ptp_ocp_i2c_bus(struct pci_dev *pdev, struct ocp_resource *r, int id)
>   
>   	info = r->extra;
>   	start = pci_resource_start(pdev, 0) + r->offset;
> -	ptp_ocp_set_mem_resource(&res[0], start, r->size);
> -	ptp_ocp_set_irq_resource(&res[1], pci_irq_vector(pdev, r->irq_vec));
> +	res[0] = DEFINE_RES_MEM(start, r->size);
> +	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
>   
>   	return platform_device_register_resndata(&pdev->dev, info->name,
> -						 id, res, 2,
> +						 id, res, ARRAY_SIZE(res),
>   						 info->data, info->data_size);
>   }
>   

Thanks, Andy!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

