Return-Path: <linux-kernel+bounces-153618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D38AD071
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA291F21A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A48152E00;
	Mon, 22 Apr 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="Nv2QAuDs"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2071.outbound.protection.outlook.com [40.92.75.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C970152DEE;
	Mon, 22 Apr 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799074; cv=fail; b=PyhMF8dHM9WwMPEj2juYN6Vb0HJbXQRd/9WnlPejU1UW7YMsTIe1dzh5cRYI9+LSY0Q3qjPybVUnIpZlMfqCZYC4T0u3HHy4vCVTGlKuWUWfWGO//7bSc8LQUZ5STg8bh4JVzoNHBKCyOUaaELYm0qHphJxI7nJ6kif+d4KPnjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799074; c=relaxed/simple;
	bh=Q+zKGzRZlIqj9oLeXCZcwzXQZKB5E/KXRz2jzwx3jZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yc3za5hFxz4zqi8845R5UooINSfHDELlb8qqIAXYs5WGe258oVTfuruig0Vgta8oJvHnZl3ahByJ225PU36kuLVBh8pR5XFjzaCSWM6nFj7juNpDw2a3AFNFpS9UkhTJFT4lmgF+qRGlhDW1o8Sh8OynKqv3pRXT1KYTEm8ZDqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=Nv2QAuDs; arc=fail smtp.client-ip=40.92.75.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ailIPu6xuCFI5tU2OB13lNbMa1y39YsSyFhTcBI4y9TxsNXdZsPYMXyXeSuRFEA5ox9ynI+SL1z+SsU2lk77XfO/nCbOxArfjjudSHDKGLTTroJS+NDJH7J8EkV7Swu2aKjcHgH1NRlQB6/jVENH2sdnlQyIUIk/rRG+I0Tu8DdoNHleFP6uTUm3sXLDXpz/L0TXgqw71MWw+1s2Jk+SBRP6zqZ874t6ZmxwXOn5hWP4lRT6YlGS59TjFL7ydRaIMv2xBSEbhFnD8UDHahoSl/GiM+XET+hXziIhv0yqhAD/lAp8atQ7hd+6PycqxuXqqECIfzttiqc3YQ7jcQWyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg3jL89NylADvp3oPzS1lLc3WvWckxg0b6MaslorH8E=;
 b=HptGIOyVn7NDJNnIfqgBXyx0ptJaJpOicdxZdAlSMnARpqs/Qvywxr3kEUCoT+OIeDrNLhlpycYjl4TBReUBn1XYKvY58zQqyBgyCKqt5TyZtj16Ain3m1iAF+Uk3PxPmd6MuBaMOuFWifTUB+tCUzt3xHgxxn70WM+aFMjOatJsk1abgfHqlZH8mO22cPH+gp0FfXRt96OH/SLGI3wTfjvbT2lxVFCZLAlVO1tMgSFyqLM9zG7koyjjlkO+7bDmoFcbMQl4fFXY1pGwDnswxT5/IexxPG+Sh2yeu7NcPLCyboFo2G/K8AxpjevJEjExEAcI9uG6o5Un9aOabCuqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg3jL89NylADvp3oPzS1lLc3WvWckxg0b6MaslorH8E=;
 b=Nv2QAuDsY/bJC8+WbYMD5h4veSigAenEuN0OIUGliNqSSNZkwXATMFF0QjaqAB8vut52RxarJw9Rcay8/VLrjM1CD4kJ5V7bpjxOqVPr5EU9SnDCWEN3Q0yGzziFyBUmsNb/DcvDoLtbQxE9YXqlLY0QxSkWyY85IyWv2APOOQErOz+Nwuw5S7rFrV/qag6kxqFX4Qq+WfeVCwQXPSe92w/x01zWm4oz3YZqW1Gko4ZMX6toqX7GlmVsS/fKp9iMqIaxFG7Qr84KxntFiOm7GwXNpbyNEZODDDsb4hvzMPv8fC/ivziA7YsMFyTzbNRiNHOuITQAUkiDU90K1T8l8w==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DU0PR09MB5696.eurprd09.prod.outlook.com (2603:10a6:10:311::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:17:47 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:17:47 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl345: Added buffered read support
Thread-Topic: [PATCH] iio: accel: adxl345: Added buffered read support
Thread-Index: AQHakKFFDIAXzNl/rUunGi8gDVDdWrFxIosAgANtnIA=
Date: Mon, 22 Apr 2024 15:17:47 +0000
Message-ID: <a1d0f85d-2ea7-4966-b842-c6e0028b61b2@live.nl>
References:
 <AM0PR09MB26757E9F7575A2357E318C50950F2@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <20240420135438.03f17072@jic23-huawei>
In-Reply-To: <20240420135438.03f17072@jic23-huawei>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: AM9PR09MB4817.eurprd09.prod.outlook.com
 (15.20.7544.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [IzoW6kwgrONyWK6jTHRISnd18R2fleNv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR09MB2675:EE_|DU0PR09MB5696:EE_
x-ms-office365-filtering-correlation-id: 0cfa6200-cb58-44ee-8b47-08dc62df5e10
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 prP8MNSR9JT0AjYtYI/OtgybzQmD2TpnPOeTste+NHeeHkPQhugfpEXNPwOodxe+8V3p7vYxM63N0Xukm4FrBuoRmboLCIaUlcAc96d9dOXcSUACoIRLJDN+yS/vqPCmOJXGQIyMgpSeg3Iv3TmHP0zo5Xwd1S1t5dV2Yxo8i70Vl3buBSk32KbRnEQmrvCLGudilukgZs7kdZJ5ACzar2mH823ugZvWSOM5+HBF8bhAkOqHU2WhHFPYO/LFtCzzdX6IgdPXjv431ep8IPo6cIXv8TeUH2d0k7ZwfxkopwsuynwgcU2Es8HXwfZhthH1WKd3z15Fa0uc8xD4yU8zh2JTNCexMOGlKiMvROe0Sf1FqnxI9pXUUOpqeQ8llalhQginPMhYynYLlgX+98Bw13B7xsDrWTi+t4wTNoVXCmJfQMrL9n+TFdQ2DtZ/pBIHJmYSc6PhgiqPnOs2vOnbKknwIlzJseNyPQCJ14x7npwq6/jla9stPSklwBd57i0xqskBV7sM3ZOxg9CeVKEwooPaVSop2fwcA+f0gFtI0smpBn+sBgGYy0EZyN35CoMT
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ybrdEoUIC6qvKdjL2xwjFsRGgNA6LoL1kowaYdnkBWuKIvYl+u1WqrM86B?=
 =?iso-8859-1?Q?mV/sFOqEGmOAZkQPFsDWrLOF7iNwIchwyiiLbPfNIN3F8fBkGEGkYooC8d?=
 =?iso-8859-1?Q?kBB2NMU9ChXGQrT+cQdSfTfG8pcVEsW52HE13xShpt7NGn5KM6KCmMpGJc?=
 =?iso-8859-1?Q?WywLUvxYj6lfaHqzn/l2esVnHliBfi1JhCa6BbSsU+O913GkxVoM6Fi/or?=
 =?iso-8859-1?Q?ID3rniyHO60qrC4a88XsRL+h7ALl3CwIIpnmKhURUjJBgmcxfpLvI/5v8Z?=
 =?iso-8859-1?Q?lKiE0dCrmDhD5ZjmwBHXkzvINakKx64C/pBxptJ2Bs251U/ihWZzyTWHHQ?=
 =?iso-8859-1?Q?HH+Qaeld6mBLGAVbM0eskaBMO0qJczPb9EoPQ0iNcIes+u9P9HxBkuaEsJ?=
 =?iso-8859-1?Q?yWj/UOfDxReF1qnWVEQskKDclLD0XkSkYOO5m8MkO4wy47CxsIVKYlPKf1?=
 =?iso-8859-1?Q?Nr5xRsvWlNugJ7+I2aIehuLDh5VkZ6rRcT4b/AwA4/ubTjUehCkuTPizoB?=
 =?iso-8859-1?Q?8cWmYyv3UFDVNquLvoMQDBoO7fQvcqf6HUZp19txFAjb5gDD2zs1Wdj+wM?=
 =?iso-8859-1?Q?5B3aTXv6znYdqBkOr4n7uyg5qu77sVgjZwqa81WjlXyPJrRE8qhkEPmwUu?=
 =?iso-8859-1?Q?Zcwxy1/d1t92REDfMCEWsIeUk9yemB3z5eKhIUXCM2cOn+pL2sZz5Zsprr?=
 =?iso-8859-1?Q?hxrHh02su+OCAdmgVYwW4Y2Ok5cxKsl9N8apffpZB+BB93A/UJPMdhzE0j?=
 =?iso-8859-1?Q?yIQsaHMqUjM6QNteNxXLSZmSfxWun2740kc3hpDcZX1y7ULDb7sad6QNCY?=
 =?iso-8859-1?Q?SdAX4pGOnRmlQmimK21ma+DIN0B/q4Aknd8A9H8B2JRA+JLb1fcptgxfrJ?=
 =?iso-8859-1?Q?WePc+2srghr9NN0xXNeZjBErUc7vV5o11XYC675kP7VHe7XNhaNGXVrwyF?=
 =?iso-8859-1?Q?KpufbCxCugti0izaW01R0NIuNHSOVFLa8rA4XJ1ucNvwSZrXhLOMOCgD+q?=
 =?iso-8859-1?Q?wkqy4I6WyU2E5rTED0ieNgksm2aGp6MVd2uyxfPLc2uV+4xRRe+Lcl7s/A?=
 =?iso-8859-1?Q?xcDSw+eIZ969na7PrKJq/Frl0k1i3ce9mnHb/SaLlaRe4HFETXA2rEUI0w?=
 =?iso-8859-1?Q?XZGU0DR/lW4SqwYrJYtYR/M7hl/QMAQSVWMVPO2lUElGWYJsQtirXKFKgU?=
 =?iso-8859-1?Q?PNo4RZVvFte/QGVoz7x8P7Khxf+b2qv1Lr5gSePE87YooOJo/PiGbxakr0?=
 =?iso-8859-1?Q?i5L0RtoUrBUgrDFcWEzQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID:
 <506D88B069646249B8BDAE32A7B7E060@sct-15-20-4755-11-msonline-outlook-64da6.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfa6200-cb58-44ee-8b47-08dc62df5e10
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:17:47.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5696

On 20-04-2024 14:54, Jonathan Cameron wrote:=0A=
> On Wed, 17 Apr 2024 10:28:34 +0200=0A=
> Paul Geurts <paul_geurts@live.nl> wrote:=0A=
>=0A=
> Hi Paul, various comments inline.=0A=
>=0A=
>=0A=
>> This implements buffered reads for the accelerometer data. A buffered=0A=
>> IIO device is created containing 3 channels. The device FIFO is used for=
=0A=
>> sample buffering to reduce the IRQ load on the host system.=0A=
>>=0A=
>> Reading of the device is triggered by a FIFO waterlevel interrupt. The=
=0A=
>> waterlevel settings are dependent on the sampling frequency to leverage=
=0A=
>> IRQ load against responsiveness.=0A=
> I'm unconvinced that trade off belongs in the driver. Until now we=0A=
> have exposed all the relevant controls to userspace via bufferX/watermark=
=0A=
> Set that to 0 or 1 if you don't want a fifo and appropriate level for wha=
tever=0A=
> responsiveness is needed for a particular application.=0A=
>=0A=
> The need to manually disable / enable interrupts is also normally somethi=
ng=0A=
> that needs a close look. Very very occasionally this is necessary but for=
 most=0A=
> devices IRQF_ONESHOT should provide suitable masking.=0A=
>=0A=
> It's also not clear that a trigger is appropriate here. For FIFO equipped=
 devices=0A=
> like this, the trigger abstraction often doesn't work as we don't have on=
e interrupt=0A=
> per 'scan' of data.  In these cases it is not necessary to use a trigger =
at all=0A=
> and that can simplify things considerably.=0A=
>=0A=
> Jonathan=0A=
=0A=
This was my first interaction with the IIO subsystem, So these changes were=
 somewhat of a=0A=
learning experience. Your review comments indicate major refactoring of my =
patch is in=0A=
order. I will see when I have time to get to it and resend it at some point=
=0A=
=0A=
>=0A=
>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>=0A=
>> ---=0A=
>>  drivers/iio/accel/adxl345.h      |   2 +-=0A=
>>  drivers/iio/accel/adxl345_core.c | 387 ++++++++++++++++++++++++++++---=
=0A=
>>  drivers/iio/accel/adxl345_i2c.c  |   2 +-=0A=
>>  drivers/iio/accel/adxl345_spi.c  |   2 +-=0A=
>>  4 files changed, 363 insertions(+), 30 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h=
=0A=
>> index 284bd387ce69..269ce69517ce 100644=0A=
>> --- a/drivers/iio/accel/adxl345.h=0A=
>> +++ b/drivers/iio/accel/adxl345.h=0A=
>> @@ -28,6 +28,6 @@ struct adxl345_chip_info {=0A=
>>  	int uscale;=0A=
>>  };=0A=
>>  =0A=
>> -int adxl345_core_probe(struct device *dev, struct regmap *regmap);=0A=
>> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int i=
rq);=0A=
>>  =0A=
>>  #endif /* _ADXL345_H_ */=0A=
>> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl34=
5_core.c=0A=
>> index 8bd30a23ed3b..1f38d2287783 100644=0A=
>> --- a/drivers/iio/accel/adxl345_core.c=0A=
>> +++ b/drivers/iio/accel/adxl345_core.c=0A=
>> @@ -11,28 +11,50 @@=0A=
>>  #include <linux/property.h>=0A=
>>  #include <linux/regmap.h>=0A=
>>  #include <linux/units.h>=0A=
>> +#include <linux/irq.h>=0A=
>>  =0A=
>>  #include <linux/iio/iio.h>=0A=
>>  #include <linux/iio/sysfs.h>=0A=
>> +#include <linux/iio/buffer.h>=0A=
>> +#include <linux/iio/trigger.h>=0A=
>> +#include <linux/iio/trigger_consumer.h>=0A=
>> +#include <linux/iio/triggered_buffer.h>=0A=
>>  =0A=
>>  #include "adxl345.h"=0A=
>>  =0A=
>>  #define ADXL345_REG_DEVID		0x00=0A=
>> +#define ADXL345_REG_THRESH_TAP 0x1D=0A=
>>  #define ADXL345_REG_OFSX		0x1e=0A=
>>  #define ADXL345_REG_OFSY		0x1f=0A=
>>  #define ADXL345_REG_OFSZ		0x20=0A=
>>  #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))=0A=
>>  #define ADXL345_REG_BW_RATE		0x2C=0A=
>>  #define ADXL345_REG_POWER_CTL		0x2D=0A=
>> +#define ADXL345_REG_INT_ENABLE   0x2E=0A=
>> +#define ADXL345_REG_INT_SOURCE   0x30=0A=
>>  #define ADXL345_REG_DATA_FORMAT		0x31=0A=
>>  #define ADXL345_REG_DATAX0		0x32=0A=
>>  #define ADXL345_REG_DATAY0		0x34=0A=
>>  #define ADXL345_REG_DATAZ0		0x36=0A=
>>  #define ADXL345_REG_DATA_AXIS(index)	\=0A=
>>  	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))=0A=
>> +#define ADXL345_REG_FIFO_CTL		0x38=0A=
>> +#define ADXL345_REG_FIFO_STATUS		0x39=0A=
>>  =0A=
>>  #define ADXL345_BW_RATE			GENMASK(3, 0)=0A=
>>  #define ADXL345_BASE_RATE_NANO_HZ	97656250LL=0A=
>> +#define ADXL345_MAX_RATE_NANO_HZ	(3200LL * NANOHZ_PER_HZ)=0A=
>> +#define ADXL345_MAX_BUFFERED_RATE	400L=0A=
>> +#define ADXL345_DEFAULT_RATE		(100LL * NANOHZ_PER_HZ)=0A=
>> +=0A=
>> +#define ADXL345_INT_DATA_READY	BIT(7)=0A=
>> +#define ADXL345_INT_SINGLE_TAP	BIT(6)=0A=
>> +#define ADXL345_INT_DOUBLE_TAP	BIT(5)=0A=
>> +#define ADXL345_INT_ACTIVITY	BIT(4)=0A=
>> +#define ADXL345_INT_INACTIVITY	BIT(3)=0A=
>> +#define ADXL345_INT_FREE_FALL	BIT(2)=0A=
>> +#define ADXL345_INT_WATERMARK	BIT(1)=0A=
>> +#define ADXL345_INT_OVERRUN	BIT(0)=0A=
>>  =0A=
>>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)=0A=
>>  #define ADXL345_POWER_CTL_STANDBY	0x00=0A=
>> @@ -43,12 +65,30 @@=0A=
>>  #define ADXL345_DATA_FORMAT_8G		2=0A=
>>  #define ADXL345_DATA_FORMAT_16G		3=0A=
>>  =0A=
>> -#define ADXL345_DEVID			0xE5=0A=
>> +#define ADXL345_FIFO_CTL_MODE_FIFO		BIT(6)=0A=
>> +#define ADXL345_FIFO_CTL_MODE_STREAM		BIT(7)=0A=
>> +#define ADXL345_FIFO_CTL_MODE_TRIGGER		(BIT(6) | BIT(7))=0A=
>> +#define ADXL345_FIFO_CTL_SAMPLES_MASK		GENMASK(4, 0)=0A=
>> +#define ADXL345_FIFO_CTL_SAMPLES(n)		((n) & ADXL345_FIFO_CTL_SAMPLES_MA=
SK)=0A=
>> +#define ADXL345_FIFO_MAX_FREQ_WATERLEVEL	20=0A=
>> +=0A=
>> +#define ADXL345_DEVID	0xE5=0A=
> No obvious reason to realign this so put it back as it was before.=0A=
>=0A=
>> +=0A=
>> +#define ADXL345_SCAN_SIZE	(sizeof(__le16) * 3)=0A=
>>  =0A=
>>  struct adxl345_data {=0A=
>>  	const struct adxl345_chip_info *info;=0A=
>>  	struct regmap *regmap;=0A=
>> -	u8 data_range;=0A=
>> +	int irq;=0A=
>> +=0A=
>> +	struct iio_trigger *drdy_trig;=0A=
>> +	/*=0A=
>> +	 * This lock is for protecting the consistency of series of i2c operat=
ions, that is, to=0A=
>> +	 * make sure a measurement process will not be interrupted by a set fr=
equency operation,=0A=
>> +	 * which should be taken where a series of i2c or SPI operations start=
, released where the=0A=
> Wrap at 80 chars.=0A=
>=0A=
> Also can probably just say "protects internal device state during a measu=
rement."=0A=
>=0A=
>> +	 * operation ends.=0A=
>> +	 */=0A=
>> +	struct mutex lock;=0A=
>>  };=0A=
>> +=0A=
>> +/* Trigger handling */=0A=
>> +static irqreturn_t adxl345_irq_handler(int irq, void *d)=0A=
>> +{=0A=
>> +	struct iio_dev *indio_dev =3D d;=0A=
>> +	struct adxl345_data *data =3D iio_priv(indio_dev);=0A=
>> +	int regval, ret;=0A=
>> +=0A=
>> +	ret =3D regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &regval);=0A=
>> +	if (ret < 0) {=0A=
>> +		dev_err(indio_dev->dev.parent, "Broken IRQ!\n");=0A=
> It's a comms error, nothing necessarily wrong with the IRQ.=0A=
> So perhaps just log that you couldn't read the int source regsiter.=0A=
=0A=
true=0A=
=0A=
>=0A=
>> +		return IRQ_HANDLED;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (regval & ADXL345_INT_OVERRUN)=0A=
>> +		dev_err(indio_dev->dev.parent, "FIFO overrun detected! Data lost\n");=
=0A=
> Probably best to use a rate limited print here. Otherwise far too easy to=
 fill=0A=
> the whole kernel log with these.=0A=
>=0A=
>> +=0A=
>> +	if (regval & ADXL345_INT_WATERMARK)=0A=
>> +		iio_trigger_poll_nested(data->drdy_trig);=0A=
> As below - if it isn't useful to present a trigger to userspace, don't ha=
ve one.=0A=
> It's fine to have fifo equiped devices with buffers register the buffer d=
irectly=0A=
> and fill it directly from the watermark interrupt.  Several other drivers=
 do this=0A=
> because the trigger model isn't a good fit for them.=0A=
=0A=
I wasn't aware of this way of working withing. I will take a look into this=
=0A=
=0A=
>=0A=
>> +	else=0A=
>> +		dev_err(indio_dev->dev.parent, "Unexpected IRQ! Source: 0x%02X\n", re=
gval);=0A=
>> +=0A=
>> +	return IRQ_HANDLED;=0A=
>> +}=0A=
>> +=0A=
>> +static int adxl345_get_sampling_freq(struct adxl345_data *data, s64 *fr=
eq_nhz)=0A=
>> +{=0A=
>> +	int ret;=0A=
>> +	unsigned int regval;=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	ret =3D regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);=0A=
> Add a comment on why the lock is needed for this register read. If the de=
vice is=0A=
> unable to cope with interleaving reads with other activity that is unusua=
l=0A=
> and we might need to think about how to enforce that more generally.=0A=
>=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +	if (ret < 0)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	*freq_nhz =3D ADXL345_BASE_RATE_NANO_HZ <<=0A=
>> +			(regval & ADXL345_BW_RATE);=0A=
>> +=0A=
>> +	return IIO_VAL_INT_PLUS_NANO;=0A=
> It doesn't. It returns a value that is then acted on to make this true.=
=0A=
> Return 0 from this function on success and only return this at the caller=
=0A=
> after doing more maths.=0A=
>=0A=
>> +}=0A=
>> +=0A=
>> +static int adxl345_set_sampling_freq(struct adxl345_data *data, s64 fre=
q_nhz)=0A=
>> +{=0A=
>> +	int ret, waterlevel;=0A=
>> +	s64 n;=0A=
>> +=0A=
>> +	/* Only allow valid sampling rates */=0A=
>> +	if (freq_nhz < ADXL345_BASE_RATE_NANO_HZ || freq_nhz > ADXL345_MAX_RAT=
E_NANO_HZ)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Trade-off the number of IRQs to the responsiveness on lower sample =
rates.=0A=
>> +	 * sample rates < 100Hz don't use the FIFO=0A=
> This feels like a userspace problem.=0A=
> If userspace sets the watermark to 0 or 1, don't use the fifo, otherwise =
do=0A=
> so. In driver handling is complex and the correct answers depend on the h=
ardware=0A=
> platform.=0A=
>=0A=
> There is ABI to let userspace control the watermark directly.=0A=
=0A=
Makes sense to use the ABI if it is there.=0A=
=0A=
>=0A=
>=0A=
>> +	 * 100<>1600Hz issue 100 IRQs per second=0A=
>> +	 * 3200Hz issues 160 IRQs per second=0A=
>> +	 */=0A=
>> +	if (freq_nhz < ADXL345_DEFAULT_RATE)=0A=
>> +		waterlevel =3D 0;=0A=
>> +	else if (freq_nhz < ADXL345_MAX_RATE_NANO_HZ)=0A=
>> +		waterlevel =3D (freq_nhz / ADXL345_DEFAULT_RATE);=0A=
>> +	else=0A=
>> +		waterlevel =3D ADXL345_FIFO_MAX_FREQ_WATERLEVEL;=0A=
>> +=0A=
>> +	n =3D div_s64(freq_nhz, ADXL345_BASE_RATE_NANO_HZ);=0A=
>> +=0A=
>> +	/* Disable the IRQ before claiming the mutex to prevent deadlocks */=
=0A=
> What is the deadlock? I can see some races with values, but not an obviou=
s=0A=
> deadlock.=0A=
>=0A=
> Also can we do what most drivers do which is just prevent updating the sa=
mpling=0A=
> frequency (and similar parameter) whilst in buffered mode?=0A=
> iio_device_claim_direct_mode() is there to provide a race free way to do =
this=0A=
> sort of thing.=0A=
>=0A=
> It's fine to make userspace stop a buffer, update settings and restart it=
=0A=
>=0A=
>> +	if (data->irq)=0A=
>> +		disable_irq(data->irq);=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	ret =3D regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,=0A=
>> +				 ADXL345_BW_RATE, clamp_val(ilog2(n), 0, ADXL345_BW_RATE));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	ret =3D regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,=0A=
>> +				 ADXL345_FIFO_CTL_SAMPLES_MASK,=0A=
>> +				 ADXL345_FIFO_CTL_SAMPLES(waterlevel));=0A=
>> +=0A=
>> +out:=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +	if (data->irq)=0A=
>> +		enable_irq(data->irq);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +/* Direct mode functions */=0A=
>>  static int adxl345_read_raw(struct iio_dev *indio_dev,=0A=
>>  			    struct iio_chan_spec const *chan,=0A=
>>  			    int *val, int *val2, long mask)=0A=
>> @@ -80,26 +219,35 @@ static int adxl345_read_raw(struct iio_dev *indio_d=
ev,=0A=
>>  =0A=
>>  	switch (mask) {=0A=
>>  	case IIO_CHAN_INFO_RAW:=0A=
>> +		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
>> +		if (ret < 0)=0A=
>> +			return ret;=0A=
>>  		/*=0A=
>>  		 * Data is stored in adjacent registers:=0A=
>>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte=0A=
>>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte=0A=
>>  		 */=0A=
>> +		mutex_lock(&data->lock);=0A=
>>  		ret =3D regmap_bulk_read(data->regmap,=0A=
>>  				       ADXL345_REG_DATA_AXIS(chan->address),=0A=
>>  				       &accel, sizeof(accel));=0A=
>> +		mutex_unlock(&data->lock);=0A=
>>  		if (ret < 0)=0A=
>>  			return ret;=0A=
>>  =0A=
>>  		*val =3D sign_extend32(le16_to_cpu(accel), 12);=0A=
>> +=0A=
>> +		iio_device_release_direct_mode(indio_dev);=0A=
>>  		return IIO_VAL_INT;=0A=
>>  	case IIO_CHAN_INFO_SCALE:=0A=
>>  		*val =3D 0;=0A=
>>  		*val2 =3D data->info->uscale;=0A=
>>  		return IIO_VAL_INT_PLUS_MICRO;=0A=
>>  	case IIO_CHAN_INFO_CALIBBIAS:=0A=
>> +		mutex_lock(&data->lock);=0A=
>>  		ret =3D regmap_read(data->regmap,=0A=
>>  				  ADXL345_REG_OFS_AXIS(chan->address), &regval);=0A=
>> +		mutex_unlock(&data->lock);=0A=
> If we always need to take the lock because reads can interrupt fifo read =
out (seems=0A=
> that might be the case from a quick look at the datasheet, then=0A=
> set regmap to not use it's internal locking and wrap these calls up local=
ly=0A=
> with the lock.=0A=
>=0A=
> Do that in a precursor patch with a comment to say why it is necessary la=
ter=0A=
> in the series.=0A=
>=0A=
>>  		if (ret < 0)=0A=
>>  			return ret;=0A=
>>  		/*=0A=
>> @@ -110,15 +258,10 @@ static int adxl345_read_raw(struct iio_dev *indio_=
dev,=0A=
>>  =0A=
>>  		return IIO_VAL_INT;=0A=
>>  	case IIO_CHAN_INFO_SAMP_FREQ:=0A=
>> -		ret =3D regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);=0A=
>> -		if (ret < 0)=0A=
>> -			return ret;=0A=
>> -=0A=
>> -		samp_freq_nhz =3D ADXL345_BASE_RATE_NANO_HZ <<=0A=
>> -				(regval & ADXL345_BW_RATE);=0A=
>> +		ret =3D  adxl345_get_sampling_freq(data, &samp_freq_nhz);=0A=
> Data may be invalid, so don't carry on to do maths if it is.=0A=
>=0A=
>>  		*val =3D div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);=0A=
> as above,the value is not IIO_VAL_INT_PLUS_NANO until after this maths=0A=
> so not appropriate to have the get_sampling_freq() function return=0A=
> a value that implies this maths is not needed.=0A=
>>  =0A=
>> -		return IIO_VAL_INT_PLUS_NANO;=0A=
>> +		return ret;=0A=
>  =0A=
>>  	}=0A=
>>  =0A=
>>  	return -EINVAL;=0A=
>> @@ -129,7 +272,7 @@ static int adxl345_write_raw(struct iio_dev *indio_d=
ev,=0A=
>>  			     int val, int val2, long mask)=0A=
>>  {=0A=
>>  	struct adxl345_data *data =3D iio_priv(indio_dev);=0A=
>> -	s64 n;=0A=
>> +	int ret =3D -EINVAL;=0A=
>>  =0A=
>>  	switch (mask) {=0A=
>>  	case IIO_CHAN_INFO_CALIBBIAS:=0A=
>> @@ -137,20 +280,17 @@ static int adxl345_write_raw(struct iio_dev *indio=
_dev,=0A=
>>  		 * 8-bit resolution at +/- 2g, that is 4x accel data scale=0A=
>>  		 * factor=0A=
>>  		 */=0A=
>> -		return regmap_write(data->regmap,=0A=
>> -				    ADXL345_REG_OFS_AXIS(chan->address),=0A=
>> -				    val / 4);=0A=
>> +		mutex_lock(&data->lock);=0A=
>> +		ret =3D regmap_write(data->regmap,=0A=
>> +				   ADXL345_REG_OFS_AXIS(chan->address), val / 4);=0A=
>> +		mutex_unlock(&data->lock);=0A=
>> +		break;=0A=
> 		return ret;=0A=
>>  	case IIO_CHAN_INFO_SAMP_FREQ:=0A=
>> -		n =3D div_s64(val * NANOHZ_PER_HZ + val2,=0A=
>> -			    ADXL345_BASE_RATE_NANO_HZ);=0A=
>> -=0A=
>> -		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,=0A=
>> -					  ADXL345_BW_RATE,=0A=
>> -					  clamp_val(ilog2(n), 0,=0A=
>> -						    ADXL345_BW_RATE));=0A=
>> +		ret =3D adxl345_set_sampling_freq(data, (s64)(val * NANOHZ_PER_HZ + v=
al2));=0A=
>> +		break;=0A=
> 		return adxl345...=0A=
>=0A=
> We do direct returns for a reason, don't change it without a strong=0A=
> argument (more on this below).=0A=
>=0A=
>>  	}=0A=
>>  =0A=
>> -	return -EINVAL;=0A=
>> +	return ret;=0A=
> You could push this into a default: statement in the switch, but definite=
ly=0A=
> don't make all paths now return down here. That makes the code harder=0A=
> to review.=0A=
>=0A=
>>  }=0A=
>>  =0A=
>>  static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,=0A=
>> @@ -197,7 +337,149 @@ static void adxl345_powerdown(void *regmap)=0A=
>>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY)=
;=0A=
>>  }=0A=
>>  =0A=
>> -int adxl345_core_probe(struct device *dev, struct regmap *regmap)=0A=
>> +static int adxl345_flush_fifo(struct regmap *map)=0A=
>> +{=0A=
>> +	__le16 axis_data[3];=0A=
>> +	int ret, regval;=0A=
>> +=0A=
>> +	/* Clear the sample FIFO */=0A=
>> +	ret =3D regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);=0A=
> Why not use the FIFO_STATUS register and read out whatever that tells us =
is=0A=
> in the FIFO? Can at least read that many before having to check if there =
are=0A=
> more. =0A=
=0A=
That could be a good idea indeed.=0A=
=0A=
>=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
> return ret;=0A=
>> +	while (regval & ADXL345_INT_DATA_READY) {=0A=
>> +		ret =3D regmap_bulk_read(map, ADXL345_REG_DATA_AXIS(0), &axis_data,=
=0A=
>> +				       sizeof(axis_data));=0A=
>> +		if (ret < 0)=0A=
>> +			goto out;=0A=
> The datasheet puts a timing requirement on repeat reads that you need to =
enforce..=0A=
> 5 usec.=0A=
>=0A=
> return ret;=0A=
=0A=
I didn't find this requirement in the datasheet. I did however write this f=
or ADXL343, which seems=0A=
to be compatible with ADXL345. But maybe I missed something here?=0A=
=0A=
>> +		ret =3D regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);=0A=
>> +		if (ret < 0)=0A=
>> +			goto out;=0A=
> return directly - going to a label that does nothing makes a reviewer=0A=
> following code paths have to go see that nothing happens.=0A=
>=0A=
> 			return ret;=0A=
>=0A=
>> +	}=0A=
>> +=0A=
>> +out:=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int adxl345_buffer_preenable(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	struct adxl345_data *data =3D iio_priv(indio_dev);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	/* Disable measurement mode to setup everything */=0A=
>> +	ret =3D regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345=
_POWER_CTL_MEASURE);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	ret =3D adxl345_flush_fifo(data->regmap);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out_enable;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Set the FIFO up in streaming mode so the chip keeps sampling.=0A=
>> +	 * Waterlevel is set by the sample frequency functions as it is dynami=
c=0A=
> This I don't follow.  Why is it dynamic?  It's fixed for a given run at a=
 given=0A=
> frequency. I can sort of see a true dynamic adjustment might make sense, =
but that=0A=
> would be complex and isn't obviously a problem for the kernel.=0A=
>=0A=
> I'd prefer to see this done like the majority of other fifo handling driv=
ers:=0A=
> Make setting the watermark vs frequency a userspace problem.=0A=
=0A=
So having an interrupt coming in for every sample on 3200Hz sampling rate c=
ompletely overloaded my=0A=
i.MX8M Mini CPU (1600MHz) I was testing this on. This was the main reason t=
o be using the internal=0A=
FIFO in the accelerometer. But when doing that, the device becomes somewhat=
 unresponsive on the=0A=
lower frequencies, as it first needs to fill the FIFO before actually firin=
g an interrupt towards=0A=
the CPU. Therefore I created this, which only uses the water level interrup=
t on highter frequencies=0A=
to try to have best of both worlds. But I agree that this should be a users=
pace choice.=0A=
=0A=
>=0A=
>> +	 */=0A=
>> +	ret =3D regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,=0A=
>> +				 (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK),=0A=
>> +				 ADXL345_FIFO_CTL_MODE_STREAM);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out_enable;=0A=
>> +=0A=
>> +	/* Enable the Watermark and Overrun interrupt */=0A=
>> +	ret =3D regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, (ADXL345_IN=
T_WATERMARK |=0A=
>> +			   ADXL345_INT_OVERRUN));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out_enable;=0A=
>> +=0A=
>> +	/* Re-enable measurement mode */=0A=
>> +	ret =3D regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_P=
OWER_CTL_MEASURE);=0A=
>> +	goto out;=0A=
> Don't do this as it makes for messy control flow to review=0A=
>=0A=
> 	if (ret)=0A=
> 		goto out_enabled;=0A=
>=0A=
> 	mutex_unlock(&data->lock)=0A=
> 	return 0;=0A=
>=0A=
> out_enable:=0A=
> ...=0A=
> Can use guard(mutex)(&data->lock) to avoid need to unlock manually and al=
low at least=0A=
> some paths to return directly.=0A=
=0A=
I am very pleased to find out scoped locking is finally possible in the Lin=
ux kernel :-). I didn't know this.=0A=
=0A=
>=0A=
>> +=0A=
>> +out_enable:=0A=
>> +	dev_err(indio_dev->dev.parent, "Error %d Setting up device\n", ret);=
=0A=
>> +	/* Re-enable measurement mode */=0A=
>> +	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL=
_MEASURE);=0A=
>> +out:=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int adxl345_buffer_postdisable(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	struct adxl345_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	/* Disable measurement mode and interrupts*/=0A=
>> +	regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_C=
TL_MEASURE);=0A=
> Check errors on all these accesses.=0A=
>=0A=
>> +	regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, 0x00);=0A=
>> +=0A=
>> +	/* Clear the FIFO and disable FIFO mode */=0A=
>> +	adxl345_flush_fifo(data->regmap);=0A=
>> +	regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,=0A=
>> +			   (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK), 0x00);=0A=
>> +=0A=
>> +	/* re-enable measurement mode for direct reads */=0A=
>> +	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL=
_MEASURE);=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct iio_buffer_setup_ops adxl345_buffer_ops =3D {=0A=
>> +	.preenable =3D adxl345_buffer_preenable,=0A=
>> +	.postdisable =3D adxl345_buffer_postdisable,=0A=
>> +};=0A=
>> +=0A=
>> +static irqreturn_t adxl345_trigger_handler(int irq, void *p)=0A=
>> +{=0A=
>> +	struct iio_poll_func *pf =3D p;=0A=
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
>> +	struct adxl345_data *data =3D iio_priv(indio_dev);=0A=
>> +	struct regmap *regmap =3D data->regmap;=0A=
>> +	u8 buffer[ADXL345_SCAN_SIZE] __aligned(8);=0A=
> Not necessary to align - that's only need if there is a timestmap.=0A=
> However, given this driver supports spi and regmap doesn't make any=0A=
> guarantees on whether dma safe buffers are needed, this should be=0A=
> DMA safe.   Easiest option is to put an __aligned(IIO_DMA_MINALIGN) =0A=
> buffer at the end of your iio_priv structure.=0A=
> I'll note that you probably won't ever see the result of not doing=0A=
> this as I believe regmap happens to always copy the buffers today=0A=
> but in earlier discussions we concluded that it was better to always=0A=
> use it as if it didn't make those copies (as there are optimizatons=0A=
> that would get rid of them.)  If you can find docs that say otherwise=0A=
> then let me know!=0A=
>=0A=
> I'll note there is already one bulk read in the driver that would suffer=
=0A=
> from the same problem and should be fixed.=0A=
>=0A=
>> +	int ret, data_available;=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +=0A=
>> +	/* Disable the IRQ before reading the FIFO */=0A=
> This needs a lot more explanation.  Disabling interrupts like=0A=
> this can be very expensive and can be hard to reason about=0A=
> + it's not necessary most of the time because of IRQF_ONESHOT.=0A=
=0A=
I did experience some issues with the interrupts, hence the disabling. But =
I might have just=0A=
implemented it badly. I will take a look into why things go bad and try to =
make it so that=0A=
disabling IRQs is not needed anymore.=0A=
=0A=
>=0A=
> I'm not 100% sure there is a good reason for this driver to expose=0A=
> at trigger - normally we only do that if it will support non fifo=0A=
> buffered modes - even then if it's a fifo interrupt we often=0A=
> switch to that mode explicitly by enabling the buffer _without_=0A=
> a trigger set (to indicate that one doesn't make sense).=0A=
>=0A=
> In that case this would be directly called from an interrupt thread=0A=
> so it oneshot should protect it against additional IRQs until done=0A=
> without the need for explicit handling.=0A=
=0A=
Fair enough. Maybe removing the trigger exposure will solve my problems any=
way.=0A=
=0A=
>=0A=
>=0A=
>> +	if (data->irq)=0A=
>> +		disable_irq_nosync(data->irq);=0A=
>> +=0A=
>> +	ret =3D regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);=
=0A=
> I'd rename this to reflect it contains a lot of other things int_source=
=0A=
> seems sensible.=0A=
>=0A=
>> +	if (ret < 0) {=0A=
>> +		dev_err(indio_dev->dev.parent, "Could not read available data (%d)\n"=
, ret);=0A=
>> +		goto done;=0A=
>> +	}=0A=
>> +=0A=
>> +	while (data_available & ADXL345_INT_DATA_READY) {=0A=
> As for the flush above, read the FIFO_STATUS register to get an initial n=
umber of samples,=0A=
> and read those without rechecking INT_SOURCE.  =0A=
>=0A=
>=0A=
>> +		/* Read all axis data to make sure the IRQ flag is cleared. */=0A=
>> +		ret =3D regmap_bulk_read(regmap, ADXL345_REG_DATA_AXIS(0),=0A=
>> +				       &buffer, (sizeof(buffer)));=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(indio_dev->dev.parent, "Could not read device FIFO (%d)\n", =
ret);=0A=
>> +			goto done;=0A=
>> +		}=0A=
>> +		iio_push_to_buffers(indio_dev, buffer);=0A=
>> +		ret =3D regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);=
=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(indio_dev->dev.parent, "Could not push data to buffers (%d)\=
n",=0A=
>> +				ret);=0A=
>> +			goto done;=0A=
>> +		}=0A=
>> +	}=0A=
>> +done:=0A=
>> +	iio_trigger_notify_done(indio_dev->trig);=0A=
>> +=0A=
>> +	/* Re-enable the IRQ */=0A=
>> +	if (data->irq)=0A=
>> +		enable_irq(data->irq);=0A=
>> +=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +=0A=
>> +	return IRQ_HANDLED;=0A=
>> +}=0A=
>> +=0A=
>> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int i=
rq)=0A=
>>  {=0A=
>>  	struct adxl345_data *data;=0A=
>>  	struct iio_dev *indio_dev;=0A=
>> @@ -218,22 +500,29 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap)=0A=
>>  =0A=
>>  	data =3D iio_priv(indio_dev);=0A=
>>  	data->regmap =3D regmap;=0A=
>> -	/* Enable full-resolution mode */=0A=
>> -	data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;=0A=
>>  	data->info =3D device_get_match_data(dev);=0A=
>>  	if (!data->info)=0A=
>>  		return -ENODEV;=0A=
>>  =0A=
>> +	/* Enable full-resolution mode */=0A=
>>  	ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,=0A=
>> -			   data->data_range);=0A=
>> +			   ADXL345_DATA_FORMAT_FULL_RES);=0A=
>>  	if (ret < 0)=0A=
>>  		return dev_err_probe(dev, ret, "Failed to set data range\n");=0A=
>>  =0A=
>> +	/* Set the default sampling frequency */=0A=
>> +	ret =3D adxl345_set_sampling_freq(data, ADXL345_DEFAULT_RATE);=0A=
>> +	if (ret < 0)=0A=
>> +		dev_err(dev, "Failed to set sampling rate: %d\n", ret);=0A=
> return dev_err_probe() This should not happen, if it does, why does it=0A=
> make sense to continue>?=0A=
>=0A=
>> +=0A=
>> +	mutex_init(&data->lock);=0A=
>> +=0A=
>>  	indio_dev->name =3D data->info->name;=0A=
>>  	indio_dev->info =3D &adxl345_info;=0A=
>> -	indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;=0A=
> No need as INDIO_BUFFER_TRIGGERED is set when you register the buffer.=0A=
=0A=
Didn't know that!=0A=
=0A=
>=0A=
>>  	indio_dev->channels =3D adxl345_channels;=0A=
>>  	indio_dev->num_channels =3D ARRAY_SIZE(adxl345_channels);=0A=
>> +	indio_dev->available_scan_masks =3D adxl345_available_scan_masks;=0A=
>>  =0A=
>>  	/* Enable measurement mode */=0A=
>>  	ret =3D adxl345_powerup(data->regmap);=0A=
>> @@ -244,7 +533,51 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap)=0A=
>>  	if (ret < 0)=0A=
>>  		return ret;=0A=
>>  =0A=
>> -	return devm_iio_device_register(dev, indio_dev);=0A=
>> +	if (irq) {=0A=
>> +		/* Setup the data ready trigger */=0A=
>> +		ret =3D devm_request_threaded_irq(dev, irq, NULL, adxl345_irq_handler=
,=0A=
>> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,=0A=
> Given the possibility of inverters in the interrupt line that aren't repr=
esented=0A=
> explicitly in DT, we tend to leave interrupt polarity as something docume=
nted=0A=
> in the bindings and set from them not in the driver.=0A=
>=0A=
> We used to do this wrong so there is plenty of legacy we can't remove=0A=
> because boards may be relying on it.=0A=
>=0A=
>> +						indio_dev->name, indio_dev);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(dev, "request irq line failed.\n");=0A=
>> +			return ret;=0A=
>> +		}=0A=
>> +		data->irq =3D irq;=0A=
>> +=0A=
>> +		data->drdy_trig =3D devm_iio_trigger_alloc(dev, "%s-drdy%d",=0A=
>> +							 indio_dev->name, iio_device_id(indio_dev));=0A=
> Line getting long.  Wrap it after name,=0A=
> For IIO aim for sub 80 chars unless readability is much better with a 80-=
100 char line.=0A=
>=0A=
>=0A=
>> +		if (!data->drdy_trig) {=0A=
>> +			dev_err(dev, "Could not allocate drdy trigger\n");=0A=
> dev_err_probe() preferred for all errors in probe.=0A=
>=0A=
>=0A=
>> +			return -ENOMEM;=0A=
>> +		}=0A=
>> +		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);=0A=
>> +		ret =3D devm_iio_trigger_register(dev, data->drdy_trig);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(dev, "Could not register drdy trigger\n");=0A=
> return dev_err_probe(dev, ret, "Could not...")=0A=
>> +			return ret;=0A=
>> +		}=0A=
>> +		/* Set the new trigger as the current trigger for this device */=0A=
>> +		indio_dev->trig =3D iio_trigger_get(data->drdy_trig);=0A=
>> +	} else {=0A=
>> +		dev_info(dev, "Not registering IIO trigger as no IRQ has been specifi=
ed\n");=0A=
> dev_dbg() or not all.  The absence of a trigger will make this obvious.=
=0A=
>=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Setup the triggered buffer */=0A=
>> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,=0A=
>> +					      NULL,=0A=
>> +					      adxl345_trigger_handler,=0A=
>> +					      &adxl345_buffer_ops);=0A=
>> +	if (ret < 0) {=0A=
>> +		dev_err(dev, "Error setting up the triggered buffer\n");=0A=
> dev_err_probe()=0A=
>=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D devm_iio_device_register(dev, indio_dev);=0A=
>> +	if (ret)=0A=
>> +		dev_err(dev, "Error registering IIO device: %d\n", ret);=0A=
>> +	else=0A=
>> +		dev_info(dev, "Registered IIO device\n");=0A=
> dev_dbg at most.  There are many ways to find out if a device is register=
ed=0A=
> and the kernel boot log is far too noisy already!=0A=
>=0A=
>> +	return ret;=0A=
>>  }=0A=
>>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);=0A=
>>  =0A=
>> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345=
_i2c.c=0A=
>> index a3084b0a8f78..b90d58a7a73c 100644=0A=
>> --- a/drivers/iio/accel/adxl345_i2c.c=0A=
>> +++ b/drivers/iio/accel/adxl345_i2c.c=0A=
>> @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client=
)=0A=
>>  	if (IS_ERR(regmap))=0A=
>>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializi=
ng regmap\n");=0A=
>>  =0A=
>> -	return adxl345_core_probe(&client->dev, regmap);=0A=
>> +	return adxl345_core_probe(&client->dev, regmap, client->irq);=0A=
>>  }=0A=
>>  =0A=
>>  static const struct adxl345_chip_info adxl345_i2c_info =3D {=0A=
>> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345=
_spi.c=0A=
>> index 93ca349f1780..ea9a8438b540 100644=0A=
>> --- a/drivers/iio/accel/adxl345_spi.c=0A=
>> +++ b/drivers/iio/accel/adxl345_spi.c=0A=
>> @@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)=
=0A=
>>  	if (IS_ERR(regmap))=0A=
>>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing =
regmap\n");=0A=
>>  =0A=
>> -	return adxl345_core_probe(&spi->dev, regmap);=0A=
>> +	return adxl345_core_probe(&spi->dev, regmap, spi->irq);=0A=
> Device has two interrupt lines so you'll need to work out which one this =
is=0A=
> (normally via interrupt-names in DT.  Binding needs fixing as well to ref=
lect that.=0A=
> We can document in there that for backwards compatibility that the defaul=
t=0A=
> is that that if one interrupt is provided with no interrupt names then it=
 is=0A=
> INT1.=0A=
=0A=
Yes indeed.=0A=
=0A=
>  =0A=
> Jonathan=0A=
>=0A=
>=0A=
>>  }=0A=
>>  =0A=
>>  static const struct adxl345_chip_info adxl345_spi_info =3D {=0A=
=0A=
Thank you for the thorough review.=0A=
=0A=
Best regards,=0A=
=0A=
Paul=0A=
=0A=

