Return-Path: <linux-kernel+bounces-167580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2E8BAB8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A649D1F21DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB1152197;
	Fri,  3 May 2024 11:27:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911915217B;
	Fri,  3 May 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735649; cv=none; b=HNP/RZXcba8CLHy7LrVCB7VgGPeDulwzuo2V15s3LwUi+ZKMH973RtNcgYhiU9RZUUPxlR5TfD1D5lDfXHr6ZWEN1GAOB8W/pLVGEYUuhvkW0MfREcuGqZssxx1KCuaB+GMCbJszun29FEG9Zg0vkNyUkXj/IhRIRXnzJX95yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735649; c=relaxed/simple;
	bh=2QnvE9AM/nCj61570YvsJ3jyKgkDj7FmjGawI0Tyw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmRieipuUpwITKhywIbS6txCnvorNvEAiQkw75cBgNQUU/Pr9mpKFHCBFokIgF5EDzREIaey7KZ96jpvPE9s+oC5hNDe5TAF4Sp3FXHEj2s6zZVZ7hhc6bNPJZWiR2MIYcMdH9/j/Bq+4D2ZZ9fduIyPtyPPHJXAjY5SXIYZP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353CC339;
	Fri,  3 May 2024 04:27:52 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88ECE3F793;
	Fri,  3 May 2024 04:27:25 -0700 (PDT)
Date: Fri, 3 May 2024 12:27:23 +0100
From: Andre Przywara <andre.przywara@foss.arm.com>
To: "Ryan Walklin" <ryan@testtoast.com>
Cc: "Alois Fertl" <a.fertl@t-online.de>, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com, "Chen-Yu Tsai" <wens@csie.org>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Samuel Holland"
 <samuel@sholland.org>, linux-rtc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC
 Clock
Message-ID: <20240503122723.37b511e5@donnerap.manchester.arm.com>
In-Reply-To: <fde9c98a-e14d-4c03-91ab-0cdc209a1763@app.fastmail.com>
References: <20240502180736.7330-1-a.fertl@t-online.de>
	<fde9c98a-e14d-4c03-91ab-0cdc209a1763@app.fastmail.com>
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

On Fri, 03 May 2024 23:02:13 +1200
"Ryan Walklin" <ryan@testtoast.com> wrote:

Hi,

> On Fri, 3 May 2024, at 6:07 AM, Alois Fertl wrote:
> > I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618 SOC.
> > On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
> > operate correctly. Without this change the clock from the SOC is
> > ~29kHz and BT module does not start up. The patch enables the Internal
> > OSC Clock Auto Calibration of the H616/H618 which than provides the
> > necessary 32kHz and the BT module initializes successfully.
> > Add a flag and set it for H6 AND H616. The H618 is the same as H616
> > regarding rtc.
> >
> > Signed-off-by: Alois Fertl <a.fertl@t-online.de>
> > ---
> >
> > v1->v2
> > - add flag and activate for H6 AND H616
> >
> > v2->v3
> > - correct findings from review
> >
> > I was hoping to get some feedback regarding the situation on H6,
> > where an external 32k crystal can be present.
> > From what I understand from the H6 manual there should be no
> > conflict as one can select which souce will drive the output.
> > Should certainly be tested but I don`t have H6 hardware.
> >
> >  drivers/rtc/rtc-sun6i.c | 17 ++++++++++++++++-
> >
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> > index e0b85a0d5645..20e81ccdef29 100644
> > --- a/drivers/rtc/rtc-sun6i.c
> > +++ b/drivers/rtc/rtc-sun6i.c
> > @@ -42,6 +42,11 @@
> > 
> >  #define SUN6I_LOSC_CLK_PRESCAL			0x0008
> > 
> > +#define SUN6I_LOSC_CLK_AUTO_CAL			0x000c
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_16MS		BIT(2)
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_ENABLE		BIT(1)
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL		BIT(0)
> > +
> >  /* RTC */
> >  #define SUN6I_RTC_YMD				0x0010
> >  #define SUN6I_RTC_HMS				0x0014
> > @@ -126,7 +131,6 @@
> >   *     registers (R40, H6)
> >   *   - SYS power domain controls (R40)
> >   *   - DCXO controls (H6)
> > - *   - RC oscillator calibration (H6)
> >   *
> >   * These functions are not covered by this driver.
> >   */
> > @@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
> >  	unsigned int has_losc_en : 1;
> >  	unsigned int has_auto_swt : 1;
> >  	unsigned int no_ext_losc : 1;
> > +	unsigned int has_auto_cal : 1;
> >  };
> > 
> >  #define RTC_LINEAR_DAY	BIT(0)
> > @@ -268,6 +273,14 @@ static void __init sun6i_rtc_clk_init(struct 
> > device_node *node,
> >  	}
> >  	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
> > 
> > +	if (rtc->data->has_auto_cal) {
> > +		/* Enable internal OSC clock auto calibration */
> > +		reg = SUN6I_LOSC_CLK_AUTO_CAL_16MS |
> > +			SUN6I_LOSC_CLK_AUTO_CAL_ENABLE |
> > +			SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL;
> > +		writel(reg, rtc->base + SUN6I_LOSC_CLK_AUTO_CAL);
> > +	}
> > +
> >  	/* Yes, I know, this is ugly. */
> >  	sun6i_rtc = rtc;
> > 
> > @@ -380,6 +393,7 @@ static const struct sun6i_rtc_clk_data 
> > sun50i_h6_rtc_data = {
> >  	.has_out_clk = 1,
> >  	.has_losc_en = 1,
> >  	.has_auto_swt = 1,
> > +	.has_auto_cal = 1,
> >  };
> > 
> >  static void __init sun50i_h6_rtc_clk_init(struct device_node *node)  
> 
> I tried to test this with my H700 board but this struct is not actually in any mainline kernel and looks like it is from an earlier version of the H616 RTC changes which was never actually merged?

Yes, thanks for the heads up, Ryan. Is this some Armbian branch, by any
chance?

> Talked to Andre on IRC and he thinks the H6 and H616 RTC clocks *should*
> be equivalent.

Yeah, that was my first naive idea, but it's actually not true, and the
increasing complexity of the RTC *clocks* were the trigger for the new
driver. That doesn't mean that the IOSC calibration routine cannot be the
same between the H6 and H616, though, but as it stands that would need to
live in two drivers (see my other email).

Cheers,
Andre

> 
> > @@ -395,6 +409,7 @@ static const struct sun6i_rtc_clk_data 
> > sun50i_h616_rtc_data = {
> >  	.has_prescaler = 1,
> >  	.has_out_clk = 1,
> >  	.no_ext_losc = 1,
> > +	.has_auto_cal = 1,
> >  };
> > 
> >  static void __init sun50i_h616_rtc_clk_init(struct device_node *node)
> > -- 
> > 2.39.2  
> 
> Regards,
> 
> Ryan
> 


