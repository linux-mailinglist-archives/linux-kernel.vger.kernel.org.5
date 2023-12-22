Return-Path: <linux-kernel+bounces-9700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A424081C9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4383A1F25221
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B318026;
	Fri, 22 Dec 2023 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p+Cyvlqo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64ED527;
	Fri, 22 Dec 2023 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=6lNfPcJ9vgueCowbSfbMeQeA1QK5J3XCK2/SVo88cZw=;
	b=p+CyvlqoaM1DlLmGvPWaPaqex3Qn9UPhvDQBcZEsSlvxc2aHj9dS3nOa7Jd6aO
	G/XDCbFbe5gqTevFru8Vez0EPOe1wmiTzgPXqC1tDRuCC8fz6p+99yctdG2MCt+i
	ge0SHmU1EJ/XNSNdO+Rtw+cEMl6U3ly3GJTRbYox241ik=
Received: from [192.168.71.6] (unknown [114.92.108.205])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wDXH3RlgIVlc7QaCg--.29733S2;
	Fri, 22 Dec 2023 20:26:29 +0800 (CST)
Message-ID: <3c51ffb5-8198-459f-b4db-b9136a407c08@163.com>
Date: Fri, 22 Dec 2023 20:26:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Revert "usb: gadget: f_uvc: change endpoint
 allocation in uvc_function_bind()"
To: Frank Li <Frank.Li@nxp.com>, peter.chen@kernel.org
Cc: a-govindraju@ti.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, pawell@cadence.com,
 rogerq@kernel.org
References: <20231221165426.1590866-1-Frank.Li@nxp.com>
 <20231221165426.1590866-5-Frank.Li@nxp.com>
Content-Language: en-US
From: yuan linyu <cugyly@163.com>
In-Reply-To: <20231221165426.1590866-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXH3RlgIVlc7QaCg--.29733S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4UKw4kXw1xJr45Xr4Dtwb_yoW8ZF18pa
	1rJ3yrCr47tFZxtwn7Jwn5ZF47Xan2qrWqgF9rK343Zr43Xr93CFyUK348KFy5Cr97AF40
	qFZak3yS9r9YkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1mhrUUUUU=
X-CM-SenderInfo: pfxj5zr16rljoofrz/1tbiERdO417++Nl7bwAAs+


On 2023/12/22 00:54, Frank Li wrote:
> This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.
>
> gadget_is_{super|dual}speed() API check UDC controller capitblity. It
> should pass down highest speed endpoint descriptor to UDC controller. So
> UDC controller driver can reserve enough resource at check_config(),
> especially mult and maxburst. So UDC driver (such as cdns3) can know need
> at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
> this uvc functions.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index faa398109431f..cc4e08c8169b4 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -719,13 +719,21 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>  	}
>  	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
>  
> -	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);

how about all none-0 endpoint used for all uvc ?

please add some comment if currently this is only way to fix your issue.

need it for stable ?

> +	if (gadget_is_superspeed(c->cdev->gadget))
> +		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
> +					  &uvc_ss_streaming_comp);
> +	else if (gadget_is_dualspeed(cdev->gadget))
> +		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
> +	else
> +		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
> +
>  	if (!ep) {
>  		uvcg_info(f, "Unable to allocate streaming EP\n");
>  		goto error;
>  	}
>  	uvc->video.ep = ep;
>  
> +	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
>  	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
>  	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
>  


