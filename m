Return-Path: <linux-kernel+bounces-18912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F482650D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CD1C20BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0B13AEC;
	Sun,  7 Jan 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqFx6g7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7F13AD5;
	Sun,  7 Jan 2024 16:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A02C433C8;
	Sun,  7 Jan 2024 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704644397;
	bh=uIAD5Kp2kfFIl9FoggQDWcZuqpMzhfaqIRSk/vA2DQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqFx6g7ImUgF+nkjBx9CrvDhk+3HY7beJOk1JAw5Kb9KYcl5sIoIiil23pNiWFIzE
	 H5ZYXTaENWD3s4Uw170hu52T+13Zeeanp2+wBT7DQR25FhAzFzovEQ4EdBuiKcJ0Xa
	 /RhA7Jel5bjtL+7TszdlfUvkHaW+uWLH28EjLNloNXAcAa+4NFNE5XosVe754Yyx+C
	 piZIiaGdfBRsXukEtf9LZmdDM4p2OyudONueEz/4iPfAxtFsRJC893biNgAP/hlpjb
	 yJdCutBCKdCv5it4noOCIsPjQxlvh/giq3Pq00HVigTVlLp4GRBEW61dRyz0FvSl/8
	 ZmJNeztyA8pIQ==
Date: Sun, 7 Jan 2024 16:19:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <cy_huang@richtek.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: rtq6056: Add support for the whole
 RTQ6056 family
Message-ID: <20240107161949.04ec0011@jic23-huawei>
In-Reply-To: <2980b67de00bae1fc25004188e8aabf53073d940.1704357933.git.cy_huang@richtek.com>
References: <cover.1704357933.git.cy_huang@richtek.com>
	<2980b67de00bae1fc25004188e8aabf53073d940.1704357933.git.cy_huang@richtek.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 17:03:31 +0800
<cy_huang@richtek.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> RTQ6053 and RTQ6059 are the same series of RTQ6056.
> 
> The respective differences with RTQ6056 are listed below
> RTQ6053
> - chip package type
> 
> RTQ6059
> - Reduce the pinout for vbus sensing pin
> - Some internal ADC scaling change
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Hi. 

One last follow on comment based on v4 changes to the enum naming.
I think you missed one place they should be updated - the reg_field
definitions.

Thanks,

Jonathan


>  
> +/*
> + * The enum is to present the 0x00 CONFIG RG bitfield for the 16bit RG value
> + * field value order from LSB to MSB
> + * RTQ6053/6 is OPMODE->VSHUNTCT->VBUSCT->AVG->RESET
> + * RTQ6059 is OPMODE->SADC->BADC->PGA->RESET
> + */
>  enum {
>  	F_OPMODE = 0,
>  	F_VSHUNTCT,
> +	F_RTQ6059_SADC = F_VSHUNTCT,
>  	F_VBUSCT,
> +	F_RTQ6059_BADC = F_VBUSCT,
>  	F_AVG,
> +	F_RTQ6059_PGA = F_AVG,
>  	F_RESET,
>  	F_MAX_FIELDS
>  };

>  
> +static const struct reg_field rtq6059_reg_fields[F_MAX_FIELDS] = {
> +	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
> +	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 6),
> +	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 7, 10),
> +	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 11, 12),
> +	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15),

Given these are the rtq6059 regfield definitions should they not be
using the new enum names?

> +};
> +


