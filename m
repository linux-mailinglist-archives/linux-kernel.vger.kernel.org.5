Return-Path: <linux-kernel+bounces-23358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED382AB92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F9B282472
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739B12E5B;
	Thu, 11 Jan 2024 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSH8f5B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EE12B76;
	Thu, 11 Jan 2024 10:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D68C43390;
	Thu, 11 Jan 2024 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704967597;
	bh=VYrd9TK5vSZv+DQia/igxBL3YVo83ir67Ef6elbaMrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSH8f5B6Cz0YR+iTIx3EPz7hnVD09H687f1+CsbVoZyclMuBnyTNTjsJlQKoAS7VF
	 +rSapP8GHDNP63b25oeHq0MkgHNwaesLSSNyFyi7RXsNHirr/5b5wD5s1KfFe0YYFf
	 Nldq23YFUNQvRb9CMzd359iP/X1jAIOXmoJgNYLpV+CB1B9pOvIz0DQ6LAIfnNTVLJ
	 a7mK7sA2GmsnS+D9xnGHrNw+xxhLeLsegoAs4RFNMDUtOYKz6VAAkERNxWdMF0Ii0H
	 4mm9t+eZvtbWSN0HxGkbHs0mUl6Hq8W1p8uoF7bK7AnKZWmYcfZGQU0pwgY/jxOtDA
	 Eju+eJdwEquOA==
Date: Thu, 11 Jan 2024 10:06:31 +0000
From: Lee Jones <lee@kernel.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: pavel@ucw.cz, thierry.reding@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
	quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Message-ID: <20240111100631.GL7948@google.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-5-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221185838.28440-5-quic_amelende@quicinc.com>

On Thu, 21 Dec 2023, Anjelique Melendez wrote:

> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
> configuration is stored in a single SDAM module instead of LUT
> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 268 ++++++++++++++++++++++++++++---
>  1 file changed, 244 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 68d82a682bf6..a76cb1d6b7b5 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -8,11 +8,13 @@
>  #include <linux/bitfield.h>
>  #include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/soc/qcom/qcom-pbs.h>

[...]

> +static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
> +{
> +	struct nvmem_device *lpg_chan_sdam = chan->lpg->lpg_chan_sdam;
> +	unsigned int lo_idx = chan->pattern_lo_idx;
> +	unsigned int hi_idx = chan->pattern_hi_idx;
> +	u8 val = 0, conf = 0;
> +
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)

Nit: you can use lo_idx and hi_idx here instead, right?

Please fix this up subsequently.

-- 
Lee Jones [李琼斯]

