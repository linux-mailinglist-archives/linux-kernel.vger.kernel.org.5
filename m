Return-Path: <linux-kernel+bounces-35043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8091838AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90151284B89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347059B7A;
	Tue, 23 Jan 2024 09:52:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D758ACD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003574; cv=none; b=knG/p8c+7NnfD+Mr+TghD1DGjkJrR8R+HUhkJdmqHK6pbQ+sUVl1qCwN5VdKrRJklD10jCwkYevFfxvJPSja7zYFlu3fSEwZIBGygwoFNlo8JVlrwvJ3xbH+cAtoMcggrRHCiIxgGc5+uS0KqFQCppjOiu9auu+ShhlJVGOJgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003574; c=relaxed/simple;
	bh=/pwL8Yk8naFUcATh/l5HS01M5d9UaBR8TpR2YD6nyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJynkk3H7HluLcp4bzBrk6N6mMH4gdPbINtu+JllZUeOrBdyTo/9fUaT0+TOKYDUXqgtNTYo4Gu+0Yud5N6UY9qHvg/53qNS3BpG/vQriiLh5zAFStl1pCpOHWmk1nLt9wR/TupC01/+7do0gSRXdC/zt25D+UV0hzZM8oX27Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rSDST-0003WN-Po; Tue, 23 Jan 2024 10:52:41 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rSDST-001nXf-8B; Tue, 23 Jan 2024 10:52:41 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rSDST-001LYv-5H; Tue, 23 Jan 2024 10:52:41 +0100
Date: Tue, 23 Jan 2024 10:52:41 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	linux-imx@nxp.com, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clocksource: timer-imx-sysctr: support i.MX95
Message-ID: <20240123095241.66nrgkkrdth6g32w@pengutronix.de>
References: <20240122092225.2083191-1-peng.fan@oss.nxp.com>
 <20240122092225.2083191-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122092225.2083191-2-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 24-01-22, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> To i.MX95 System counter module, we use Read register space to get
> the counter, not the Control register space to get the counter, because
> System Manager firmware not allow Linux to read Control register space.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clocksource/timer-imx-sysctr.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
> index 5a7a951c4efc..3d3bc16388ed 100644
> --- a/drivers/clocksource/timer-imx-sysctr.c
> +++ b/drivers/clocksource/timer-imx-sysctr.c
> @@ -8,9 +8,12 @@
>  #include "timer-of.h"
>  
>  #define CMP_OFFSET	0x10000
> +#define RD_OFFSET	0x20000
>  
>  #define CNTCV_LO	0x8
>  #define CNTCV_HI	0xc
> +#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
> +#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
>  #define CMPCV_LO	(CMP_OFFSET + 0x20)
>  #define CMPCV_HI	(CMP_OFFSET + 0x24)
>  #define CMPCR		(CMP_OFFSET + 0x2c)
> @@ -22,6 +25,8 @@
>  
>  static void __iomem *sys_ctr_base __ro_after_init;
>  static u32 cmpcr __ro_after_init;
> +static u32 cntcv_hi = CNTCV_HI;
> +static u32 cntcv_lo = CNTCV_LO;
>  
>  static void sysctr_timer_enable(bool enable)
>  {
> @@ -43,9 +48,9 @@ static inline u64 sysctr_read_counter(void)
>  	u32 cnt_hi, tmp_hi, cnt_lo;
>  
>  	do {
> -		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
> -		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
> -		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
> +		cnt_hi = readl_relaxed(sys_ctr_base + cntcv_hi);
> +		cnt_lo = readl_relaxed(sys_ctr_base + cntcv_lo);
> +		tmp_hi = readl_relaxed(sys_ctr_base + cntcv_hi);
>  	} while (tmp_hi != cnt_hi);
>  
>  	return  ((u64) cnt_hi << 32) | cnt_lo;
> @@ -139,6 +144,11 @@ static int __init sysctr_timer_init(struct device_node *np)
>  		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
>  	}
>  
> +	if (of_device_is_compatible(np, "nxp,imx95-sysctr-timer")) {
> +		cntcv_hi = CNTCV_HI_IMX95;
> +		cntcv_lo = CNTCV_LO_IMX95;
> +	}

I'm not a fan of this, since TIMER_OF_DECLARE() can do the compat check.
So instead of using fallback bindings just use the correct binding
within the dts file. Also I'm not a fan of this clobal variable setting
albeit there is just one instance _yet_ we really should instead rework
this driver a bit and instead provide a i.MX95 specific
sysctr_read_counter() function. This is clearly a bit more work but IMO
a cleaner approach. Also afterwards once you add i.MX9x which is again a
bit different would gain from this work.

Regards,
  Marco

> +
>  	sys_ctr_base = timer_of_base(&to_sysctr);
>  	cmpcr = readl(sys_ctr_base + CMPCR);
>  	cmpcr &= ~SYS_CTR_EN;
> -- 
> 2.37.1
> 
> 
> 

