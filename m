Return-Path: <linux-kernel+bounces-36318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC974839F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02911C24C74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C09469F;
	Wed, 24 Jan 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfoKY0XD"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097A3224;
	Wed, 24 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064029; cv=none; b=bKsIEWXq1Jz8vjjxeAkJ8r/2FKhJqjnVsv6ghenY0qFsnflsIVA3qRBO2NOxnSkBQeLLJMsamkiZMmUOiVVCdxPDycEdCchd+ak3qY2pImPUCON1OrdJlVK1Iqxwu3UbuxXxl1JFm92VDhjWZE5gqCsN/xfJasouinwDTh4t83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064029; c=relaxed/simple;
	bh=7vsPI7w1YMe/fesVR2Tr+nfZcMfZrfDYr/O4D8VfTLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shGj09JLme6fu8BVYtUivRbLnCWtInE1pfCiM7ehxwhYGKTqktZ9ugfJ6WQ98FROphCanXyOuRTvb3RreYfub9i1iUtYO/Qb3kJdlbMxPaFBTkh+Y8fFGG63Br02+QC3zKiWjFnO5nBhb7Qiq0LAgbR3N+I5y739eUddJR+nR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfoKY0XD; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1644AE0005;
	Wed, 24 Jan 2024 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706064024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGPV8qP/hkyaGbA0vNDa6zhWfSWvSFrWaGiwTw++pO4=;
	b=VfoKY0XDroy7i+8VLvvFsMTqiG5oYzqUwFZIxhn6aaCvEKMlU+D3iYfDhE6lA1l5yD87j/
	PN9iTmb7KXD1OPCbT6k5fE+JeTh5JFx5ZW9G2eQAT+DEuZXVgRNQociX/0kICH1Ty/DTD9
	5gd8OO1rnLSO9U1Cyva4DuuQN9rDnMxOWUsTQ7f42URiGuyY4UCtGvmbB8NcBf5Sj4rrUq
	aMGhgIdKWQSsbZz+KTxzvP7+QXNX+4MkKIm1xxRLgljwSYwa/PBSPLCPKf1up3ZzjNIvFG
	S+ddwbjo8mpZhlSaBg4X2VXiIaWTRkMYVYgl27oIyPSTlNRpFUbZcfqLb6Xelg==
Date: Wed, 24 Jan 2024 03:40:23 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: jianbinz <quic_jianbinz@quicinc.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH v2 1/1] rtc: rtc-pm8xxx: Retrigger RTC alarm if
 it's fired
Message-ID: <20240124024023df15ef6e@mail.local>
References: <20240124022443.21867-1-quic_jianbinz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124022443.21867-1-quic_jianbinz@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 24/01/2024 10:24:43+0800, jianbinz wrote:
> If the alarm is triggered before the driver gets probed, the alarm
> interrupt will be missed and it won't be detected, and the stale
> alarm settings will be still retained because of not being cleared.
> Check this condition during driver probe, retrigger the alarm and
> clear the settings manually if it's such case.
> 
> Changes in v2:
> *Adapt the V1 patch according to the newest rtc-pm8xxx
> 
> Changes in v1:
> *During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
> if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
> Link to v1:https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/
> 
> Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 57 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index f6b779c12ca7..eac4e7f23aaa 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -309,21 +309,33 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  	return 0;
>  }
>  
> +static int pm8xxx_rtc_read_alarm_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
> +{
> +	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> +	u8 value[NUM_8_BIT_RTC_REGS];
> +	int rc;
> +
> +	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
> +	if (rc)
> +		return rc;
> +
> +	*secs = get_unaligned_le32(value);
> +
> +	return 0;
> +}
> +
>  static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  {
>  	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> -	u8 value[NUM_8_BIT_RTC_REGS];
>  	unsigned int ctrl_reg;
>  	u32 secs;
>  	int rc;
>  
> -	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
> -			      sizeof(value));
> +	rc = pm8xxx_rtc_read_alarm_raw(rtc_dd, &secs);
>  	if (rc)
>  		return rc;
>  
> -	secs = get_unaligned_le32(value);
>  	secs += rtc_dd->offset;
>  	rtc_time64_to_tm(secs, &alarm->time);
>  
> @@ -398,6 +410,39 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Trigger the alarm event and clear the alarm settings
> + * if the alarm data has been behind the RTC data which
> + * means the alarm has been triggered before the driver
> + * is probed.
> + */
> +static int pm8xxx_rtc_init_alarm(struct pm8xxx_rtc *rtc_dd)
> +{
> +	int rc;
> +	u32 alarm_sec, rtc_sec;
> +	unsigned int ctrl_reg, alarm_en;
> +	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> +
> +	rc = pm8xxx_rtc_read_raw(rtc_dd, &rtc_sec);
> +	if (rc)
> +		return rc;
> +
> +	rc = pm8xxx_rtc_read_alarm_raw(rtc_dd, &alarm_sec);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
> +	if (rc)
> +		return rc;
> +
> +	alarm_en = !!(ctrl_reg & PM8xxx_RTC_ALARM_ENABLE);
> +
> +	if (alarm_en && rtc_sec >= alarm_sec)
> +		pm8xxx_alarm_trigger(0, rtc_dd);


I have not been replying because I had to go back to the original
description of the problem which you are not linking here.

Anyway, all of this doesn't do want you explain, you are looking at
whether the alarm is enabled but not whether it has actually
triggered...

> +
> +	return 0;
> +}
> +
>  static int pm8xxx_rtc_enable(struct pm8xxx_rtc *rtc_dd)
>  {
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> @@ -527,6 +572,10 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	rc = pm8xxx_rtc_init_alarm(rtc_dd);

..But isn't it useless? I guess that what you can do and what I was
referring to in my first reply is clear the interrupt in your probe
unconditionally, here:

rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2, PM8xxx_RTC_ALARM_CLEAR, 0);

That should do it just fine. There is no point in calling
pm8xxx_alarm_trigger because there is no chance that userspace is ready
to handle the rtc update.

> +	if (rc)
> +		return rc;
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

