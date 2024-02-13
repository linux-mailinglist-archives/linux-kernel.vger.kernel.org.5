Return-Path: <linux-kernel+bounces-63606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FB853221
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD5E1F2312E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C8056763;
	Tue, 13 Feb 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="AR/DDjkn"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36E5646B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831752; cv=none; b=TGQ1nO3pfsLP2Kd82Qrh45zB0KaA7qmvQFa5bxHGObDqXSUBNtsBptvaRG5QceAklNeSn5HrYIp2CSA2iVEjeWFZwaL+7i/yF2fIt3gDOMWnEk6qQP+EADzhZUEiqJv0S+xVdvL58F4iUT7rUFFx5KLbDHlwRWW6Z5LYfPMuC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831752; c=relaxed/simple;
	bh=sqU8CWBYCpCtT0WVh42NGFNjFfhjI1FgaTgBLkB7j4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPhDDV53Itq0KK1/sf0S22v43JeeG2/FMjvxOesKprNcDA8eJfUazH2tUGrn7kXm1sVrqxnYzyUxsMRydcb7ETdSwLMRx0HkB0GbIktit8ncczHxljMNrX4kP7D6YsdioAp5ZriCGd1+Ai140e3y0EPoENmJXSVcRKZY9uketIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=AR/DDjkn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso3596331a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707831749; x=1708436549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqk9RnAdmzkTU6vK/TdAMH/5ZEvIKD4DovGTx4NMMSE=;
        b=AR/DDjknVajtlN8kWc4aBj9EnxnpFAeLFSN1eEoyd3R2CKFuPkiTdDTjwVb9plqok5
         GhoflYKN5j8sPXMLiQEDmErlych/fbN13FcODpcrDC052ZMxULIFC3JIPKaSPWss8YAY
         Xoij1bntO7QL61pXADBeKgg5peIyBEUae2YZhSPsyEF/lmiDdpAwAogxrHA3QPCCRMlf
         kzb05OftOJjlDf8pbdgYXG6Eg8hLnMix30K9TP92EEyUjL3DwQL93JJ3dzO3nZx0WBbq
         28+8g95100L4N38bJ0qrnDpykXuLiOeVIHcEyydWhlB97jEOPsPwi85HyNSQM1DLxc1Q
         btXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831749; x=1708436549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqk9RnAdmzkTU6vK/TdAMH/5ZEvIKD4DovGTx4NMMSE=;
        b=tZG+kZpHC9PrrITKeOBVPWzUJ3Jv5pFlrs1qTSVRxpe8hNWXNNHnR6J6IM7jmLC+ni
         Sd9HkV6W2fKl07U5GXKJ2c73p/xbCEmhKTE6FbLuWg7ASfjeahnWnHPJFVk/YVAA+Ble
         S7Ytfy33Oeo776yZ7Ltr6LpYHr2Kp7mnq2RFKZgWK7PTcN3f/q7zjGFA02265qKFDmPC
         LkpeQHCmz8IKofBgrrYtdSE7u9pEmoHNPVceIZNBzfOQ/FIOC46X+pKEBU2pzCXxPi6H
         fWpJ8Bmwbo6zt2NxqCmRau4OM1I5e6YWnXAXW0oLIRvrixtAlGsufZCqyhQTfxcKqfKc
         xadA==
X-Forwarded-Encrypted: i=1; AJvYcCUNw21w4IrBgqcJoaZUlJY/wKF9wnfQOkj9dbAgjo3OHH9XDkt9daH6p7hdVUOdUTFFQF60HwVS7xOAzx0ptJFAvAYJSIEW4WXdaSl/
X-Gm-Message-State: AOJu0YwDkHAByNO/w8zFCC9TD80+bZrM2n2cyseSJ8YverxiwaO6fekH
	PEUm/x+aw+pKd5zdiEYFaBYROANKn9DaCyxbvK0IuGft5Q6iuOy/4JuTcmHTvbvlvRQfkm1NPSR
	RQ5jUmKrfoSoNzNmhc7o7gCFkdLr9SNh68PmBkg==
X-Google-Smtp-Source: AGHT+IHfkgz90jq0P0pE2m4FPBNOBJy5rQ3Pwm/G10giSDI+WYnSqSkh78viB+HIrt0/DzkXiltUDZW4SKoQlUss6NM=
X-Received: by 2002:a17:90a:db93:b0:297:fb7:fe1 with SMTP id
 h19-20020a17090adb9300b002970fb70fe1mr5854891pjv.46.1707831749457; Tue, 13
 Feb 2024 05:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130175140.3834889-1-naresh.solanki@9elements.com> <cd84b051-1608-48c0-8335-b038cd236f61@roeck-us.net>
In-Reply-To: <cd84b051-1608-48c0-8335-b038cd236f61@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 13 Feb 2024 19:12:19 +0530
Message-ID: <CABqG17jbOgAHWUemV5=VFKwufuGX_xyheTDETfJtvoOO9UWjvg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix IRQ masking
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


On Wed, 31 Jan 2024 at 03:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jan 30, 2024 at 11:21:39PM +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MP2971/MP2973 use a custom 16bit register format for
> > SMBALERT_MASK which doesn't follow the PMBUS specification.
> >
> > Map the PMBUS defined bits used by the common code onto the custom
> > format used by MPS and since the SMBALERT_MASK is currently never read
> > by common code only implement the mapping for write transactions.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  drivers/hwmon/pmbus/mp2975.c | 57 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> >
> > base-commit: 909d8d33f8b4664c9b6c7fd585114921af77fc2b
> >
> > diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> > index b9bb469e2d8f..788ec2c5a45f 100644
> > --- a/drivers/hwmon/pmbus/mp2975.c
> > +++ b/drivers/hwmon/pmbus/mp2975.c
> > @@ -377,6 +377,62 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
> >       return ret;
> >  }
> >
> > +static int mp2973_write_word_data(struct i2c_client *client, int page,
> > +                               int reg, u16 word)
> > +{
> > +     u8 target, mask;
> > +     int ret;
> > +
> > +     if (reg != PMBUS_SMBALERT_MASK)
> > +             return -ENODATA;
> > +
> > +     /*
> > +      * Vendor-specific SMBALERT_MASK register with 16 maskable bits.
> > +      */
> > +     ret = pmbus_read_word_data(client, 0, 0, PMBUS_SMBALERT_MASK);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     target = word & 0xff;
> > +     mask = word >> 8;
> > +
> > +#define SWAP(cond, bit) (ret = (cond) ? (ret & ~BIT(bit)) : (ret | BIT(bit)))
>
> This isn't really a "SWAP", but setting or clearing of bits in "ret"
> depending on a bit set in "cond". I don't have a good idea for a
> better name, but either case I think a comment describing what it
> does would be useful.
Yes. will add below comment
/*
 * Set/Clear 'bit' in 'ret' based on condition
 */
>
> "ret" use is implied, but "mask" is always provided as parameter.
> Please either provide both as arguments, or make both implied.
Sure. Will update as:
#define SWAP(cond, bit) ret = (mask & cond) ? (ret & ~BIT(bit)) : (ret
| BIT(bit))

>
> Also, the first parameter is a bit mask, while the second parameter
> is a bit position. Please used defines for the second parameter
> and make it a mask as well.
Sure will be adding defines for second parameter as well.
#define MP2973_INVALID_DATA     8
#define MP2973_INVALID_COMMAND  9
#define MP2973_OTHER_COMM       5
#define MP2973_PACKET_ERROR     7
#define MP2973_VOLTAGE_UV       13
#define MP2973_VOLTAGE_OV       14
#define MP2973_IOUT_OC          11
#define MP2973_IOUT_OC_LV       10
#define MP2973_TEMP_OT          0

>
> > +     switch (target) {
> > +     case PMBUS_STATUS_CML:
> > +             SWAP(mask & PB_CML_FAULT_INVALID_DATA, 8);
> > +             SWAP(mask & PB_CML_FAULT_INVALID_COMMAND,  9);
> > +             SWAP(mask & PB_CML_FAULT_OTHER_COMM, 5);
> > +             SWAP(mask & PB_CML_FAULT_PACKET_ERROR, 7);
> > +             break;
> > +     case PMBUS_STATUS_VOUT:
> > +             SWAP(mask & PB_VOLTAGE_UV_FAULT, 13);
> > +             SWAP(mask & PB_VOLTAGE_OV_FAULT, 14);
> > +             break;
> > +     case PMBUS_STATUS_IOUT:
> > +             SWAP(mask & PB_IOUT_OC_FAULT, 11);
> > +             SWAP(mask & PB_IOUT_OC_LV_FAULT, 10);
> > +             break;
> > +     case PMBUS_STATUS_TEMPERATURE:
> > +             SWAP(mask & PB_TEMP_OT_FAULT, 0);
> > +             break;
> > +     /*
> > +      * Map remaining bits to MFR specific to let the PMBUS core mask
> > +      * those bits by default.
> > +      */
> > +     case PMBUS_STATUS_MFR_SPECIFIC:
> > +             SWAP(mask & BIT(1), 1);
> > +             SWAP(mask & BIT(3), 3);
> > +             SWAP(mask & BIT(4), 4);
> > +             SWAP(mask & BIT(6), 6);
> > +             break;
>
> Coming back to using defines for the second parameter: The
> above bit positions appear to be purely random. Having defines for
> those bits will at least explain what is being masked (and hopefully
> explain why bit 2, 12, and 15 are not covered at all).
> For example, at least one other chip from the same vendor defines
> bit 6 as CRC_ERROR, and the matching status register bit is bit
> 4 (memory fault detected) in STATUS_CML. Also, it is unclear why
> the chip would not issue any alerts when warning limits are exceeded.
> Without knowing what the bits in SMBALERT_MASK mean it is impossible
> to validate if the above is correct and/or complete.
Agree. Bit 2 & 15 are reserved & will add a comment to mention that.
For others, I will add #define as below..
#define MP2973_VIN_UVLO         1
#define MP2973_VIN_OVP          3
#define MP2973_MTP_FAULT        4
#define MP2973_MTP_BLK_TRIG     6
#define MP2973_VOUT_MAX_MIN_WARNING 12

Regards,
Naresh
>
> Thanks,
> Guenter

