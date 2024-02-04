Return-Path: <linux-kernel+bounces-51462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95D848B89
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF64B24524
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D67494;
	Sun,  4 Feb 2024 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEp/Y6bQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2667493;
	Sun,  4 Feb 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707028608; cv=none; b=qQv0vg3g1tN9evvbOvQcRBPHdLMAXfGNx31cujIjZ5YSInM+XMIqnnL9VOUlpLD+HmI9mpbM3t4ihVedORffgHx07fVVfJPMEMfv6TFEik31E96/5TzV+eq5ZAy0Ss5zzF2jYDIlgOEPvDSWGhZ9+kkl9KzGYcf3IW+fGqYWXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707028608; c=relaxed/simple;
	bh=FYK7AaDiYqbTlfS3pColRv7XRm0JZmbEe42rT2tlpYA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pXjkC5SDASiGLjnzu2loKtVoGzzrdGY8p3IKNF6GrfA96AuVkXI1i8jdAw9OQwfQGFtQyYJR25Eb1ozc4t77c1Xyy5qYfrYBct4WDnpsfn5qnoUK8vsA7j9i6XdGwLS9ybLN/iwMxeVO/H/FxC2q6aO3iE0ZySVgJfTY9bK6gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEp/Y6bQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d780a392fdso29016695ad.3;
        Sat, 03 Feb 2024 22:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707028606; x=1707633406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhrdsLXyharQtwk+YSZTkf4E5FkLiyUBnotfivIVHMw=;
        b=TEp/Y6bQI3Es9D/C5sAUlUn8XG/s313KEKLcpFYOdmKUYQYoWfxEe4wG1tjILZ4xaG
         zzSDVeEZH7RAAfzeYnRaGUrH8M1q+bccNkRlo+NH/tjcKmodkKsvcDbHqZ7vM9oKAah5
         G0R8HtSZlONKAcjF3UDuKPr+W5N28kCRmOH/7YdBwq6+ZbfFfQ98eofw8AODViL/zURA
         5rdcIEuyIvdZYLXBvLLbRKCmPn8TBeIyMwYGiyJ8bainhJEIPSUHcjHpuEDewxyttCGL
         KHE3vYvESh9tk7ZQdqSC6Ce/t0ETmpCBJi3yIo+d+O3TMMiiOV3jFrdMDRR4nsXRCiDo
         E/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707028606; x=1707633406;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AhrdsLXyharQtwk+YSZTkf4E5FkLiyUBnotfivIVHMw=;
        b=S2EbYlqrvcWPs2J46lhV+mcGXMvwD7PRZjG+oVcZuGXwkCXZUOeHHNNtD/N3EQDLQY
         jpcK2mG5H6dFDSTz4ra/dgxyovg5jtfXmlCeDTKEh3fbjJPbzrGOpEZb/om75kv5p1Xp
         6nYDavBUe8Nv7mTL9AXqkxN/XgjFpwx+MpRUEghyrTCWitxWBeGlObcmw20ZNnyypHVN
         i+uB9krUjjrA7rxC0CHOjCCwpAEU1GDtUj+IuCcaI4N/Ry5CmtujxZteBXyh4S8YOs6o
         6Y3iZggNVV2s6u8cGxdQVZ3H6DdG+JVdBljkxncBab5dMPWbkQs9YFKl7NlCZlIUVFuf
         2NdA==
X-Gm-Message-State: AOJu0Yw+ztXkqoNxA0CuXqqXbpZBf3ClDz1kerAD2qaSLlSxsDPqwqKm
	HXEohsyXzzmGlt5SQeKjxjQxbuMcOrFZUGoIxS+pZrYePdSEFMq7
X-Google-Smtp-Source: AGHT+IGnQ0gSe5sRpzcfC4U19xJj5IwPh91we/gcJADZ/cNtw5aEKY3XtZ+g5/rZ/QsrOXtmYBoN0w==
X-Received: by 2002:a17:902:c40c:b0:1d9:a6e8:1c8c with SMTP id k12-20020a170902c40c00b001d9a6e81c8cmr1073283plk.15.1707028606124;
        Sat, 03 Feb 2024 22:36:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDEKtZeceoHlPvaOg73HN92iSg8sP7+W8dEcfEgNCEvv/jgv75qW3RU97O4MqStQPwo5+uHpAyAd3wP0BXXZwElPYOSX8tdtd3ygWncV9LHZ3nvgXeny3ZrZNsMPKRYaLDZxOBDeXnQoA+cuP30OYEv6Xkcjd+vB1mfran7VE7jGSNzbKCLGm17D5ThM71drXZ2FCtrq1zODnNVqhkKCk3l9ZDAQRxFkqWChEJjFHZqbjTEOwCPqJ2Xj2pg53qLJUmJDQ85PjELaqkS9i355rhUJ9TYMbah6EKkbjbeBBi662c0lEdB/GtOJMKfbjNrWH+Cz0pU+AKgyWSdelHdm0ACHhCjU16X60HSsOcS7hE+xnni33HZBGe+zMFJjbcFH8whuXTg5JU8FzKU3UGumqc0AoDyE5+6mgqiDX7Lv2SDZWC0IaRG4O8Xcc7q3Gr4MCK0ncEskRkfsQ3uWf+Ufu4fqOzzoY3NcsNr1G1iy1Bep93KWGNhJuNZNAG+9F9lNXMEHSQWI6BiI+fXQG/O2Qp5GnlIOsW2EFeS2TvRuJrcnISdMs=
Received: from localhost.localdomain ([58.84.61.91])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902c75500b001d8b8bf8e45sm4102848plq.37.2024.02.03.22.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 22:36:45 -0800 (PST)
Message-ID: <65bf307d.170a0220.4d544.f32b@mx.google.com>
X-Google-Original-Message-ID: <9b5f9e1b-645a-4b44-a30c-fe93e7bf3532@gmx.net> (raw)
From: pratikmanvar09@gmail.com
To: wahrenst@gmx.net
Cc: festevam@gmail.com,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	pratik.manvar@ifm.com,
	pratikmanvar09@gmail.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v2] pwm: imx27: workaround of the pwm output bug
Date: Sun,  4 Feb 2024 12:06:26 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103063454.1795-1-pratikmanvar09@gmail.com>
References: <9b5f9e1b-645a-4b44-a30c-fe93e7bf3532@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Stefan,=0D
=0D
Thanks for your review.=0D
Please see my reply below inline.=0D
=0D
>> From: Clark Wang <xiaoning.wang@nxp.com>=0D
>>=0D
>> This fixes the pwm output bug when decrease the duty cycle.=0D
>> This is a limited workaround for the PWM IP issue TKT0577206.=0D
>this looks like a patch from the vendor tree.=0D
=0D
[Pratik]: Yes, this is the patch from NXP. Please see original link of the =
patch https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0e5a=
479990507816317=0D
=0D
>Could you please provide a link to the origin or at least to the=0D
>document which describes TKT0577206?=0D
[Pratik]: Please refer i.MX8MN errata #ERR051198 in https://www.nxp.com/doc=
s/en/errata/IMX8MN_0N14Y.pdf.=0D
=0D
>As a i.MX6ULL user i couldn't find this issue in the chip errata. So are=0D
>you sure that every PWM IP handled by this driver is affected?=0D
[Pratik]: Yes, looks like this issue is on all platforms which uses this PW=
M IP.=0D
=0D
>> Root cause:=0D
>> When the SAR FIFO is empty, the new write value will be directly applied=
=0D
>> to SAR even the current period is not over.=0D
>> If the new SAR value is less than the old one, and the counter is=0D
>> greater than the new SAR value, the current period will not filp the=0D
>s/filp/flip/ ?=0D
>> level. This will result in a pulse with a duty cycle of 100%.=0D
>>=0D
>> Workaround:=0D
>> Add an old value SAR write before updating the new duty cycle to SAR.=0D
>> This will keep the new value is always in a not empty fifo, and can be=0D
>> wait to update after a period finished.=0D
>>=0D
>> Limitation:=0D
>> This workaround can only solve this issue when the PWM period is longer=
=0D
>> than 2us(or <500KHz).=0D
>>=0D
>> Reviewed-by: Jun Li <jun.li@nxp.com>=0D
>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>=0D
>> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0=
e5a479990507816317=0D
>> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>=0D
>> ---=0D
>>   V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@inte=
l.com>=0D
>>             Closes: https://lore.kernel.org/oe-kbuild-all/202312300907.R=
GtYsKxb-lkp@intel.com/=0D
>>=0D
>>   drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---=
=0D
>>   1 file changed, 62 insertions(+), 5 deletions(-)=0D
>>=0D
>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c=0D
>> index 7d9bc43f12b0..1e500a5bf564 100644=0D
>> --- a/drivers/pwm/pwm-imx27.c=0D
>> +++ b/drivers/pwm/pwm-imx27.c=0D
>> @@ -21,11 +21,13 @@=0D
>>   #include <linux/platform_device.h>=0D
>>   #include <linux/pwm.h>=0D
>>   #include <linux/slab.h>=0D
>> +#include <linux/spinlock.h>=0D
>>=0D
>>   #define MX3_PWMCR			0x00    /* PWM Control Register */=0D
>>   #define MX3_PWMSR			0x04    /* PWM Status Register */=0D
>>   #define MX3_PWMSAR			0x0C    /* PWM Sample Register */=0D
>>   #define MX3_PWMPR			0x10    /* PWM Period Register */=0D
>> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */=0D
>>=0D
>>   #define MX3_PWMCR_FWM			GENMASK(27, 26)=0D
>>   #define MX3_PWMCR_STOPEN		BIT(25)=0D
>> @@ -91,6 +93,7 @@ struct pwm_imx27_chip {=0D
>>   	 * value to return in that case.=0D
>>   	 */=0D
>>   	unsigned int duty_cycle;=0D
>> +	spinlock_t lock;=0D
>>   };=0D
>>=0D
>>   #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_ch=
ip, chip)=0D
>> @@ -203,10 +206,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_ch=
ip *chip,=0D
>>=0D
>>   	sr =3D readl(imx->mmio_base + MX3_PWMSR);=0D
>>   	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);=0D
>> -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {=0D
>> +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {=0D
>>   		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),=0D
>>   					 NSEC_PER_MSEC);=0D
>> -		msleep(period_ms);=0D
>> +		msleep(period_ms * (fifoav - 2));=0D
>This touches a different workaround ("pwm: imx: Avoid sample FIFO=0D
>overflow for i.MX PWM version2") without any explanation.=0D
[Pratik]: Sure, I will look into this. Thanks!=0D
>>=0D
>>   		sr =3D readl(imx->mmio_base + MX3_PWMSR);=0D
>>   		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))=0D
>> @@ -217,13 +220,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_ch=
ip *chip,=0D
>>   static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,=0D
>>   			   const struct pwm_state *state)=0D
>>   {=0D
>> -	unsigned long period_cycles, duty_cycles, prescale;=0D
>> +	unsigned long period_cycles, duty_cycles, prescale, counter_check, fla=
gs;=0D
>>   	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);=0D
>> +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;=0D
>> +	__force u32 sar_last, sar_current;=0D
>>   	struct pwm_state cstate;=0D
>>   	unsigned long long c;=0D
>>   	unsigned long long clkrate;=0D
>>   	int ret;=0D
>> -	u32 cr;=0D
>> +	u32 cr, timeout =3D 1000;=0D
>>=0D
>>   	pwm_get_state(pwm, &cstate);=0D
>>=0D
>> @@ -264,7 +269,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,=0D
>>   		pwm_imx27_sw_reset(chip);=0D
>>   	}=0D
>>=0D
>> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);=0D
>> +	/*=0D
>> +	 * This is a limited workaround. When the SAR FIFO is empty, the new=0D
>> +	 * write value will be directly applied to SAR even the current period=
=0D
>> +	 * is not over.=0D
>> +	 * If the new SAR value is less than the old one, and the counter is=0D
>> +	 * greater than the new SAR value, the current period will not filp=0D
>The same typo as in the commit message.=0D
>> +	 * the level. This will result in a pulse with a duty cycle of 100%.=0D
>> +	 * So, writing the current value of the SAR to SAR here before updatin=
g=0D
>> +	 * the new SAR value can avoid this issue.=0D
>> +	 *=0D
>> +	 * Add a spin lock and turn off the interrupt to ensure that the=0D
>> +	 * real-time performance can be guaranteed as much as possible when=0D
>> +	 * operating the following operations.=0D
>> +	 *=0D
>> +	 * 1. Add a threshold of 1.5us. If the time T between the read current=
=0D
>> +	 * count value CNR and the end of the cycle is less than 1.5us, wait=0D
>> +	 * for T to be longer than 1.5us before updating the SAR register.=0D
>> +	 * This is to avoid the situation that when the first SAR is written,=
=0D
>> +	 * the current cycle just ends and the SAR FIFO that just be written=0D
>> +	 * is emptied again.=0D
>> +	 *=0D
>> +	 * 2. Use __raw_writel() to minimize the interval between two writes t=
o=0D
>> +	 * the SAR register to increase the fastest pwm frequency supported.=0D
>> +	 *=0D
>> +	 * When the PWM period is longer than 2us(or <500KHz), this workaround=
=0D
>> +	 * can solve this problem.=0D
>> +	 */=0D
>> +	if (duty_cycles < imx->duty_cycle) {=0D
>> +		c =3D clkrate * 1500;=0D
>> +		do_div(c, NSEC_PER_SEC);=0D
>> +		counter_check =3D c;=0D
>> +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);=0D
>> +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);=0D
>> +=0D
>> +		spin_lock_irqsave(&imx->lock, flags);=0D
>> +		if (state->period >=3D 2000) {=0D
>> +			while ((period_cycles -=0D
>> +				readl_relaxed(imx->mmio_base + MX3_PWMCNR))=0D
>> +				< counter_check) {=0D
>> +				if (!--timeout)=0D
>> +					break;=0D
>> +			};=0D
>> +		}=0D
>> +		if (!(MX3_PWMSR_FIFOAV &=0D
>> +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))=0D
>> +			__raw_writel(sar_last, reg_sar);=0D
>> +		__raw_writel(sar_current, reg_sar);=0D
>> +		spin_unlock_irqrestore(&imx->lock, flags);=0D
>> +	} else=0D
>> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);=0D
>> +=0D
>This is hard to believe that checkpatch.pl is fine with this patch.=0D
>Please use it before submission.=0D
[Pratik]: I used the checkpatch.pl in this patch and that runs without any =
warnings/errors!=0D
=0D
>>   	writel(period_cycles, imx->mmio_base + MX3_PWMPR);=0D
>>=0D
>>   	/*=0D
>> @@ -324,6 +379,8 @@ static int pwm_imx27_probe(struct platform_device *p=
dev)=0D
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),=0D
>>   				     "failed to get peripheral clock\n");=0D
>>=0D
>> +	spin_lock_init(&imx->lock);=0D
>> +	imx->duty_cycle =3D 0;=0D
>This line looks unrelated and unnecessary.=0D
[Pratik]: Right. I will remove this line in next patch version.=0D
=0D
>Best regards=0D
>>   	imx->chip.ops =3D &pwm_imx27_ops;=0D
>>   	imx->chip.dev =3D &pdev->dev;=0D
>>   	imx->chip.npwm =3D 1;=

