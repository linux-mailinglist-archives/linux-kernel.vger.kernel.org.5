Return-Path: <linux-kernel+bounces-167569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E38BAB6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5FB1F227E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52015217E;
	Fri,  3 May 2024 11:13:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18202F9EB;
	Fri,  3 May 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734797; cv=none; b=Zf0+zTrozjqR/3qT/Ws/Ie2uWHit2pbwrNCW5FSNiPEqFeEyiGhc6Tpr1BzWnM/z/K1dMAJQxOP0ErU3GAwDLvgYfE7/bEvrUdowXyObunY0KIFtTtx2XDxlZl7UVjW4kY3nvX2Y0tlQukWiNJGP7dpvs1bcEjGwJc8o4qjzW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734797; c=relaxed/simple;
	bh=ON9EuF/kfQrrlVsD3lIzJIMaCvPZdPofeSBKWj6O2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bASYgZFTX7vVsyTwKD6HW1uXhIFGdv8sAzGSVezCokW088zRHhLFsx4O9kNIwXu7oucaU9E5RGrCq74Wxx59SfPo/8YW1PrElx/BHKlEBPTT1kT7YNZcWyYZVqfdUc5U7qIusxic0jiSUpRjDiMsWdfx6EoBnsqxvCSu5SQSzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076C42F4;
	Fri,  3 May 2024 04:13:35 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597993F793;
	Fri,  3 May 2024 04:13:08 -0700 (PDT)
Date: Fri, 3 May 2024 12:13:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alois Fertl <a.fertl@t-online.de>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, linux-rtc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Ryan Walklin
 <ryan@testtoast.com>
Subject: Re: [PATCH v3 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC
 Clock
Message-ID: <20240503121304.5fc6add5@donnerap.manchester.arm.com>
In-Reply-To: <20240502180736.7330-1-a.fertl@t-online.de>
References: <20240502180736.7330-1-a.fertl@t-online.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 20:07:36 +0200
Alois Fertl <a.fertl@t-online.de> wrote:

Hi Alois,

many thanks for taking care and sending a patch! I think this problem is
plaguing some people.

> I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618 SOC.
> On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
> operate correctly. Without this change the clock from the SOC is
> ~29kHz and BT module does not start up. The patch enables the Internal
> OSC Clock Auto Calibration of the H616/H618 which than provides the
> necessary 32kHz and the BT module initializes successfully.
> Add a flag and set it for H6 AND H616. The H618 is the same as H616
> regarding rtc.

(many thanks to Ryan for the head up on this)

So what tree is this patch based on? It certainly is not mainline, is it?
Mainline never supported the H616 RTC clocks via the RTC driver, this was
only through the new driver in the clk
directory, in drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a93720329d4d2
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d91612d7f01aca

Please note that the H6 RTC clocks were intended to be handled via the new
driver as well, but this part was reverted:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60d9f050da63b

Please only send patches based on the mainline tree.

I doesn't look that hard to adjust the patch to mainline, though to cover
the H6 is well this would require this code in both drivers. So when we
want to address the H6 as well, it might make sense to solve the problem
that triggered the revert first, to only have that change only in one
file. 

> Signed-off-by: Alois Fertl <a.fertl@t-online.de>
> ---
> 
> v1->v2
> - add flag and activate for H6 AND H616
> 
> v2->v3
> - correct findings from review
> 
> I was hoping to get some feedback regarding the situation on H6,
> where an external 32k crystal can be present.
> From what I understand from the H6 manual there should be no
> conflict as one can select which souce will drive the output.
> Should certainly be tested but I don`t have H6 hardware.

I think I should have H6 boards both with and without an external crystal
oscillator, so can check the situation there, but only next week.

>  drivers/rtc/rtc-sun6i.c | 17 ++++++++++++++++-
> 
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index e0b85a0d5645..20e81ccdef29 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -42,6 +42,11 @@
>  
>  #define SUN6I_LOSC_CLK_PRESCAL			0x0008
>  
> +#define SUN6I_LOSC_CLK_AUTO_CAL			0x000c
> +#define SUN6I_LOSC_CLK_AUTO_CAL_16MS		BIT(2)
> +#define SUN6I_LOSC_CLK_AUTO_CAL_ENABLE		BIT(1)
> +#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL		BIT(0)
> +
>  /* RTC */
>  #define SUN6I_RTC_YMD				0x0010
>  #define SUN6I_RTC_HMS				0x0014
> @@ -126,7 +131,6 @@
>   *     registers (R40, H6)
>   *   - SYS power domain controls (R40)
>   *   - DCXO controls (H6)
> - *   - RC oscillator calibration (H6)
>   *
>   * These functions are not covered by this driver.
>   */
> @@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
>  	unsigned int has_losc_en : 1;
>  	unsigned int has_auto_swt : 1;
>  	unsigned int no_ext_losc : 1;
> +	unsigned int has_auto_cal : 1;
>  };
>  
>  #define RTC_LINEAR_DAY	BIT(0)
> @@ -268,6 +273,14 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>  	}
>  	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
>  
> +	if (rtc->data->has_auto_cal) {
> +		/* Enable internal OSC clock auto calibration */
> +		reg = SUN6I_LOSC_CLK_AUTO_CAL_16MS |
> +			SUN6I_LOSC_CLK_AUTO_CAL_ENABLE |
> +			SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL;
> +		writel(reg, rtc->base + SUN6I_LOSC_CLK_AUTO_CAL);
> +	}
> +
>  	/* Yes, I know, this is ugly. */
>  	sun6i_rtc = rtc;
>  
> @@ -380,6 +393,7 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
>  	.has_out_clk = 1,
>  	.has_losc_en = 1,
>  	.has_auto_swt = 1,
> +	.has_auto_cal = 1,
>  };
>  
>  static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
> @@ -395,6 +409,7 @@ static const struct sun6i_rtc_clk_data sun50i_h616_rtc_data = {

For the records: this whole struct does not exist in mainline.

Cheers,
Andre

>  	.has_prescaler = 1,
>  	.has_out_clk = 1,
>  	.no_ext_losc = 1,
> +	.has_auto_cal = 1,
>  };
>  
>  static void __init sun50i_h616_rtc_clk_init(struct device_node *node)


