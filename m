Return-Path: <linux-kernel+bounces-19247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D23826A49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B210AB21E81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8411C80;
	Mon,  8 Jan 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hZMIDHT2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623611709;
	Mon,  8 Jan 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704704963;
	bh=N4STaPWl6V/kzg3Bq/Q6+nrlEzgQfF4x9E66Po7nkRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZMIDHT2SC6URiMOoZ/b5ZUhzDsxnjEsYp109u65CUaCvBDf3nFkgr8g4n7OVeFC8
	 E2NQ8fpTUllihhBulsD3L010AhXM2UyGc2GMcPGGtRIAFpNjxCp8JlG+fjTBTBNvWU
	 6anB9WFLbg5FLX9o2rIxmguvVc14294GBSOLN4qHZzyKhdrS4ELEQrVoKXi+IGrgNe
	 3oDBaPLx1bFaHF/eySKaIVcWRBtyJDzJG5BrhtkJSYH+HZOXHcpwxXLaQMy1dCMbJ0
	 Kwfi/kQE+gP46XEVxlPaG1FbmmV5ojaAC1FhfKM/wdFQPTiD5uVh7NrVUYTfoneQlK
	 CWdeDnTvUbPiw==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DAB8737804B2;
	Mon,  8 Jan 2024 09:09:22 +0000 (UTC)
Message-ID: <83fe7beb-de1a-4c71-a584-f3d205249d9d@collabora.com>
Date: Mon, 8 Jan 2024 10:09:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] media: cadence: csi2rx: Add enum_mbus_code pad ops
Content-Language: en-US
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Maxime Ripard <mripard@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231211094329.9090-1-changhuang.liang@starfivetech.com>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20231211094329.9090-1-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/11/23 10:43, Changhuang Liang wrote:
> Add enum_mbus_code ioctl so that user space can know what
> formats are supported to csi2rx.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Reviewed-by: Julien Massot <julien.massot@collabora.com>
Tested-by: Julien Massot <julien.massot@collabora.com>

> ---
>   drivers/media/platform/cadence/cdns-csi2rx.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 889f4fbbafb3..7788ce0e3171 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -389,6 +389,18 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>   	return ret;
>   }
>   
> +static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
> +				 struct v4l2_subdev_state *state,
> +				 struct v4l2_subdev_mbus_code_enum *code_enum)
> +{
> +	if (code_enum->index >= ARRAY_SIZE(formats))
> +		return -EINVAL;
> +
> +	code_enum->code = formats[code_enum->index].code;
> +
> +	return 0;
> +}
> +
>   static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
>   			  struct v4l2_subdev_state *state,
>   			  struct v4l2_subdev_format *format)
> @@ -439,6 +451,7 @@ static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
>   }
>   
>   static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
> +	.enum_mbus_code	= csi2rx_enum_mbus_code,
>   	.get_fmt	= v4l2_subdev_get_fmt,
>   	.set_fmt	= csi2rx_set_fmt,
>   	.init_cfg	= csi2rx_init_cfg,

Regards,
--
Julien Massot


