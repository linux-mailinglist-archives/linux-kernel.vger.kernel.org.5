Return-Path: <linux-kernel+bounces-111052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D9886768
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA93B220C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EF12E51;
	Fri, 22 Mar 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkbRVOSP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75310A3E;
	Fri, 22 Mar 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091932; cv=none; b=F24H1dDifwmxBg/Md6R/rexFMScUold9oPFgxMGGUj45hQ+1eLrOCpKQFPN7pUYyM0SmWHvMGmgqU+NZ/2qsqV4xuyNsyka7PcTU5bjIPzti1VEo9ryOo5RqMe4lF3v7mPUHATQZumFNwrQqfMDf7+nj8C3gJGVbAZBlS0TahH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091932; c=relaxed/simple;
	bh=NPlRInHwRJ6iohau5+kZ/oUQSv6uulok/FeJjsPteg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b11GOBldnNMIr9k613nn49P9ZfqJy2CE6PyvdPADGB1a5Nxw3uj10wTBFUR/PgoFlMYbkxFst+1Tkeg1vFqBg3PZuHGySPC0Z/HUznPKYtiGRvUSnju3Z/H0Qy3KjfckSjMZqnKR/GmjEVGZjakCNfQabDvcbqSn+NfpSW94ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkbRVOSP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-414700cffd6so14093465e9.1;
        Fri, 22 Mar 2024 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711091929; x=1711696729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=St/cAfZevHpUSs708RoRbr6UCDF/rEtJSg31TN9Zl9c=;
        b=UkbRVOSPyD2k5lUtBa5X7cgIyuuSjp26Nxx5G24InWnK3NjghycVsOZTrxKD0vb+8N
         G2zNdNH9itU9EpPZl6i8iRUHjJ8e1dxlayTwieLEOWlrFqFCcs90ns16PlaKbTzJsuxk
         5PckDJsJQ3S6Ve+i91JNCoE06vUv9c3lkaMIT9i9WFe+k8pmmRh/GrRrgFG0fZfn21QJ
         e5isLSgVw5UHXphBxaW+OohGQe+T8xYo/QBSB5xQXaC2oFn1fqPZR+oGKk8R5kuBxmts
         Ou0Lwpdwmazz/BXcskNVMslF7TRwH75yIHB1hw3g0aVGCD3EB1ODSYCeM3tVqMgbyRzQ
         xZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091929; x=1711696729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St/cAfZevHpUSs708RoRbr6UCDF/rEtJSg31TN9Zl9c=;
        b=I/T7MjISA23n9iTGcxl8BpEHMSigwRtAvry12lU15aeSlSy7w/nUfVOcXU7g9KQiBl
         DCsuHSkNH4WJXyk8y2v+F+lu5MO1KOUtBf/9hZeKN6W+A5IiGEPQoQyxzUWDd4oM4LLV
         QF091G7lTToRIQEJhlsS8vV9a90x50oVsZrkoLPrquxZKR0rT68WSZtUEYu26DOWDRUf
         CCVJ9gOueWVVoKP+Q9XmlOOLFUOczxJllGiNfBPLzSHXks7OmiFfTpytEb25bl8ZT/h8
         ZncPPD7KcPMMG/5KzNj7UxhZgwk0qfrtQO7oZd0SM/LJyKyobjjccOH+bmEpMyOgEAuK
         rvyw==
X-Forwarded-Encrypted: i=1; AJvYcCUORnGSlKNN0jAT8dETru1TIxz21YHzHIJMokUHOZdzx9cDy0oj4C4OrhT7auGd5qofkGbABdwGZ5aYDtmXJAErPg09hIQ77ILErvzWWxqbbMFHVvVSEVXnI0LWRb2y7SCI8LdI+JYuow==
X-Gm-Message-State: AOJu0YyG1UFhawoHRUc4cUt2qjCbgT4AR8OpKFLWGuMghZy5+2KAOXkh
	zfrlxZVuH5jpi0eiTXeoC24pniTA/J12Ss9MyRFBjVhSyHH/YFSG
X-Google-Smtp-Source: AGHT+IHcp/K2WkruN9gpDQ2hrdMvHpSx8ArtcQIK2aNIjM1/GujN5ExwnsHE1sPbM4kmieRgrFYqfg==
X-Received: by 2002:a05:600c:5716:b0:414:fcc:ff4b with SMTP id jv22-20020a05600c571600b004140fccff4bmr798757wmb.20.1711091928465;
        Fri, 22 Mar 2024 00:18:48 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00414612a43a9sm7928823wmq.28.2024.03.22.00.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 00:18:48 -0700 (PDT)
Message-ID: <21b8933dc87ce76eb15abd3dbcb6f025f282eedf.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lothar Rubusch
	 <l.rubusch@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Date: Fri, 22 Mar 2024 08:18:47 +0100
In-Reply-To: <51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
	 <20240322003713.6918-2-l.rubusch@gmail.com>
	 <51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 06:53 +0100, Krzysztof Kozlowski wrote:
> On 22/03/2024 01:37, Lothar Rubusch wrote:
> > Move driver wide constants and fields into the header.
>=20
> Why?
>=20
> > Let probe call a separate setup function. Provide
>=20
> Why?
>=20
> > possibility for an SPI/I2C specific setup to be passed
> > as function pointer to core.
>=20
> Why?
>=20
> Your commit message *MUST* explain why you are doing things.
>=20
> >=20
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> > =C2=A0drivers/iio/accel/adxl345.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 44 +++++++++++-
> > =C2=A0drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++---------=
-----
> > =C2=A0drivers/iio/accel/adxl345_i2c.c=C2=A0 |=C2=A0 30 ++++----
> > =C2=A0drivers/iio/accel/adxl345_spi.c=C2=A0 |=C2=A0 28 ++++----
> > =C2=A04 files changed, 134 insertions(+), 85 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 284bd387c..01493c999 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -8,6 +8,39 @@
> > =C2=A0#ifndef _ADXL345_H_
> > =C2=A0#define _ADXL345_H_
> > =C2=A0
> > +#include <linux/iio/iio.h>
> > +
> > +/* ADXL345 register definitions */
> > +#define ADXL345_REG_DEVID		0x00
> > +#define ADXL345_REG_OFSX		0x1E
> > +#define ADXL345_REG_OFSY		0x1F
> > +#define ADXL345_REG_OFSZ		0x20
> > +#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> > +#define ADXL345_REG_BW_RATE		0x2C
> > +#define ADXL345_REG_POWER_CTL		0x2D
> > +#define ADXL345_REG_DATA_FORMAT		0x31
> > +#define ADXL345_REG_DATAX0		0x32
> > +#define ADXL345_REG_DATAY0		0x34
> > +#define ADXL345_REG_DATAZ0		0x36
> > +#define ADXL345_REG_DATA_AXIS(index)	\
> > +	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> > +
> > +#define ADXL345_BW_RATE			GENMASK(3, 0)
> > +#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
> > +
> > +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> > +#define ADXL345_POWER_CTL_STANDBY	0x00
> > +
> > +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolutio=
n */
> > +#define ADXL345_DATA_FORMAT_SPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BIT(6) /* spi-3wire */
> > +#define ADXL345_DATA_FORMAT_2G		0
> > +#define ADXL345_DATA_FORMAT_4G		1
> > +#define ADXL345_DATA_FORMAT_8G		2
> > +#define ADXL345_DATA_FORMAT_16G		3
> > +#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-
> > 3wire */
> > +
> > +#define ADXL345_DEVID			0xE5
> > +
> > =C2=A0/*
> > =C2=A0 * In full-resolution mode, scale factor is maintained at ~4 mg/L=
SB
> > =C2=A0 * in all g ranges.
> > @@ -23,11 +56,20 @@
> > =C2=A0 */
> > =C2=A0#define ADXL375_USCALE	480000
> > =C2=A0
> > +enum adxl345_device_type {
> > +	ADXL345,
> > +	ADXL375,
> > +};
> > +
> > =C2=A0struct adxl345_chip_info {
> > =C2=A0	const char *name;
> > =C2=A0	int uscale;
> > =C2=A0};
> > =C2=A0
> > -int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> > +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> > +
> > +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct adxl345_chip_info =
*chip_info,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*setup)(struct device*, st=
ruct regmap*));
>=20
> Last setup argument is entirely unused. Drop this change, it's not
> related to this patchset. Neither explained.
>=20

Yeah, you need to make it explicit in the message that this change is in pr=
eparation
for a future change (adding the 3-wire spi mode). Otherwise it's natural fo=
r
reviewers to make questions about it... Maybe another one that could live i=
n it#s own
patch.

- Nuno S=C3=A1=20
>=20


