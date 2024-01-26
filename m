Return-Path: <linux-kernel+bounces-40014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074183D8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900391F29C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937814265;
	Fri, 26 Jan 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfhbPwDC"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C13AEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266840; cv=none; b=XZMS/STnbfihDiHZKSSsdIyV+MZlNFLjRjPS9E7h0mbpkmYEvW19Cds8DxxZiOVwe46ytoER5dffk+BSD5GQ3azjrXs0obDEDeXadAqUD2GlpE0oM8bGK+GpwLh/vfCAb93nCqwW08OBmDA+9PxFRLb0d8URsdbop+ss/JASWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266840; c=relaxed/simple;
	bh=iwaEjyQISX8oRt+7rdSg7FwouBhL5OwhhJgvvuCvF/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKy/pihWPYLLrBdXTeqMQwqv1bAEdF0balTrl2RcaQrjQc3j92tJFU3QIaXMI8x4vYlB+DVKOIp6IMVAE7DHhZX5BtpYVdA4ItokTbTmPMGsCl2rtrAFNWhKfhmOBH04x9nZF3VsgDwD2EraUyD+p5TNZwFy+jSt2PdUKDyrXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfhbPwDC; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8da0a157-6a09-4d82-ad36-7428fdb27f9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706266822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms/Iujyw2CJDI4xIWrn3lHPH9AmsLQ9BJPRb9vIIWTw=;
	b=UfhbPwDCLTBEi7XVrl2nUrql9KByyo8mpcqL6+h35BLeHk6xdOffcL/IHjyUi4ebkdVfYC
	4QeS81/itoTEbQ2DgHCElCV3SNOYgn+1p3aF3bzvQGc65ARhLZeL3p5/vEcj807UJ2z2ZZ
	RwblP3Rn1nAx3Pk0KNjO289hASALJgs=
Date: Fri, 26 Jan 2024 11:00:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: micrel: Fix set/get PHC time for lan8814
Content-Language: en-US
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Divya Koppera <divya.koppera@microchip.com>
References: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/01/2024 07:30, Horatiu Vultur wrote:
> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future like
> year 2150, it was failing to set this.
> 
> The issue can be reproduced like this:
> 
>   # phc_ctl /dev/ptp1 set 10000000000
>   phc_ctl[12.290]: set clock time to 10000000000.000000000 or Sat Nov 20 17:46:40 2286
> 
>   # phc_ctl /dev/ptp1 get
>   phc_ctl[15.309]: clock time is 1410065411.018055420 or Sun Sep  7 04:50:11 2014
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Divya Koppera <divya.koppera@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> ---
> Based on discussion here [1], this patch from the series was changed
> to target net-next instead of net.
> 
> [1] https://lore.kernel.org/netdev/20240119082103.edy647tbf2akokjy@DEN-DL-M31836.microchip.com/T/#m88b55103ee8c05599f2fa02c1588e195d95d6a49
> ---
>   drivers/net/phy/micrel.c | 61 +++++++++++++++++++---------------------
>   1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index dad720138baaf..40bea9293ddd7 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -154,11 +154,13 @@
>   #define PTP_CMD_CTL_PTP_LTC_STEP_SEC_		BIT(5)
>   #define PTP_CMD_CTL_PTP_LTC_STEP_NSEC_		BIT(6)
>   
> +#define PTP_CLOCK_SET_SEC_HI			0x0205
>   #define PTP_CLOCK_SET_SEC_MID			0x0206
>   #define PTP_CLOCK_SET_SEC_LO			0x0207
>   #define PTP_CLOCK_SET_NS_HI			0x0208
>   #define PTP_CLOCK_SET_NS_LO			0x0209
>   
> +#define PTP_CLOCK_READ_SEC_HI			0x0229
>   #define PTP_CLOCK_READ_SEC_MID			0x022A
>   #define PTP_CLOCK_READ_SEC_LO			0x022B
>   #define PTP_CLOCK_READ_NS_HI			0x022C
> @@ -2592,35 +2594,31 @@ static bool lan8814_rxtstamp(struct mii_timestamper *mii_ts, struct sk_buff *skb
>   }
>   
>   static void lan8814_ptp_clock_set(struct phy_device *phydev,
> -				  u32 seconds, u32 nano_seconds)
> +				  time64_t sec, u32 nsec)
>   {
> -	u32 sec_low, sec_high, nsec_low, nsec_high;
> -
> -	sec_low = seconds & 0xffff;
> -	sec_high = (seconds >> 16) & 0xffff;
> -	nsec_low = nano_seconds & 0xffff;
> -	nsec_high = (nano_seconds >> 16) & 0x3fff;
> -
> -	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, sec_low);
> -	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, sec_high);
> -	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, nsec_low);
> -	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, nsec_high);
> +	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_LO, lower_16_bits(sec));
> +	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_MID, upper_16_bits(sec));
> +	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_SEC_HI, upper_32_bits(sec));
> +	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_LO, lower_16_bits(nsec));
> +	lanphy_write_page_reg(phydev, 4, PTP_CLOCK_SET_NS_HI, upper_16_bits(nsec));
>   
>   	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_LOAD_);
>   }
>   
>   static void lan8814_ptp_clock_get(struct phy_device *phydev,
> -				  u32 *seconds, u32 *nano_seconds)
> +				  time64_t *sec, u32 *nsec)
>   {
>   	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_CLOCK_READ_);
>   
> -	*seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
> -	*seconds = (*seconds << 16) |
> -		   lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
> +	*sec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_HI);
> +	*sec <<= 16;
> +	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);

lanphy_read_page_reg returns int, but only 16 bits have meanings here.
Is it safe to assume that other 16 bits will be zeros always?
There are some more spots of this template in the function.

> +	*sec <<= 16;
> +	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_LO);
>   


> -	*nano_seconds = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
> -	*nano_seconds = ((*nano_seconds & 0x3fff) << 16) |
> -			lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
> +	*nsec = lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_HI);
> +	*nsec <<= 16;
> +	*nsec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_NS_LO);
>   }
>   
>   static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
> @@ -2630,7 +2628,7 @@ static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
>   							  ptp_clock_info);
>   	struct phy_device *phydev = shared->phydev;
>   	u32 nano_seconds;
> -	u32 seconds;
> +	time64_t seconds;
>   
>   	mutex_lock(&shared->shared_lock);
>   	lan8814_ptp_clock_get(phydev, &seconds, &nano_seconds);
> @@ -2660,38 +2658,37 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
>   {
>   	u32 nano_seconds_step;
>   	u64 abs_time_step_ns;
> -	u32 unsigned_seconds;
> +	time64_t set_seconds;
>   	u32 nano_seconds;
>   	u32 remainder;
>   	s32 seconds;
>   
>   	if (time_step_ns >  15000000000LL) {
>   		/* convert to clock set */
> -		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
> -		unsigned_seconds += div_u64_rem(time_step_ns, 1000000000LL,
> -						&remainder);
> +		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
> +		set_seconds += div_u64_rem(time_step_ns, 1000000000LL,
> +					   &remainder);
>   		nano_seconds += remainder;
>   		if (nano_seconds >= 1000000000) {
> -			unsigned_seconds++;
> +			set_seconds++;
>   			nano_seconds -= 1000000000;
>   		}
> -		lan8814_ptp_clock_set(phydev, unsigned_seconds, nano_seconds);
> +		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
>   		return;
>   	} else if (time_step_ns < -15000000000LL) {
>   		/* convert to clock set */
>   		time_step_ns = -time_step_ns;
>   
> -		lan8814_ptp_clock_get(phydev, &unsigned_seconds, &nano_seconds);
> -		unsigned_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
> -						&remainder);
> +		lan8814_ptp_clock_get(phydev, &set_seconds, &nano_seconds);
> +		set_seconds -= div_u64_rem(time_step_ns, 1000000000LL,
> +					   &remainder);
>   		nano_seconds_step = remainder;
>   		if (nano_seconds < nano_seconds_step) {
> -			unsigned_seconds--;
> +			set_seconds--;
>   			nano_seconds += 1000000000;
>   		}
>   		nano_seconds -= nano_seconds_step;
> -		lan8814_ptp_clock_set(phydev, unsigned_seconds,
> -				      nano_seconds);
> +		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
>   		return;
>   	}
>   


