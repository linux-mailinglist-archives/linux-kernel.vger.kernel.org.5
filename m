Return-Path: <linux-kernel+bounces-56054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE184C56A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE96B2206A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194591CFBD;
	Wed,  7 Feb 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0ruSE6W"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E11F615
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289470; cv=none; b=m7XC5wdLhEs7CZ6lqOLmh2AY9cKFH1pIyGOB6pxwhkRRyBUvLCcAjD9ypRke5y4ZpaoJtWYypNhOy+hPkTAMemasecoOlKN8N5JEQmV0lSTVGY/9RmxGoCj5QsWar31VbA3vhGMrJEDWJeZgRviUb6xjDrfEuuoPGYQpkdq5AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289470; c=relaxed/simple;
	bh=ZvpmJ0RiKLlrFMkh0NikHJnBk2XqWFm5bNySknsd8SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrYN2rvLlUtbebFz5jpiWsTT7eGxdFrVau9Q79hP/i5nx/4Eyr5AHbU02d1t+s29LnRFdvBvdHxXXEd/q6q5LhB0iDWkde/LS9sv9iy87KR0NtvYa3HbXRsP759jW6+F/3DMDnVgMULt2v+D2ANEMkk/1KYESGnz6fL1xdz1mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0ruSE6W; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso2099585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707289466; x=1707894266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUGV0B/PmwgC6ZkuZAsZ9yoKwxsl/mjj13ekKdv5Iv8=;
        b=O0ruSE6WdcHw8iovgZB9tRLIikCWDWCY4maZaWfCPTtluAAnZbAEl8hTFTOTHBoEna
         D9i+ZehMUM+N/LHZ2L6eVc/CFjEC943R2QZ7HgIwkBEUekBjGZQp3Fk8wlCs0CSoioPh
         LLaGPo0vrKg6rWxE584gT7mHVult1BsrZatOtyCR6D8DNf8oufqKoKfqZvOO4dLrFfjM
         YgZuicUOdHW80FCt+8n+SFpmJzE9EqQIQPHrXm569pDxDRcUC8pupjLyRYQGj54uUD8R
         YAGPclzTTsTTdJe9WJozNgACRdegQ35ynkeGzo6hqgDNbpE8cI2QyunZPHjXTr2KPxp+
         ZFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289466; x=1707894266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGV0B/PmwgC6ZkuZAsZ9yoKwxsl/mjj13ekKdv5Iv8=;
        b=HAiRRIycAk1bGkurJI8/Gw2Upgy73Ucw5x/Oz9sR5VhybRjehnlNZfuKV+Nuoz8o9C
         JDqGX1P4wZmZUSFnPlVJe5ckqAt//3E3IgPWYCTjCvKL6RcPaV+sCNJSeq8ex3YOyahq
         pC4Xb1onY85GQErYLrFmkpH1Yoa3eu3D5KNKtOdsMrdZZeJgFr5oUvJl3CJfyMTGc8rb
         bpJ60PghLQjeIek2+q+PtPb+bF7ZzI6YHaNrtdq33GeC8SzbJzV20GGne1iS11rTcxOw
         Pywu3dCQ3GKxCZ27MGagzEE0sDqHK2dWuAyAy1Z5hZX7dgfuqxWvjR46q50MGAPsIPOL
         Bfig==
X-Gm-Message-State: AOJu0YwaEdXBq4RYyf8FziMZ2HFA2eNM33PfJOJamrha2R+ICKtrXj7J
	de4h0tubPWy4jGwrWHDD67fYzGdzxlLtdIqt8Iwo5kX/FsqTmLNUZvwP1HHw20I=
X-Google-Smtp-Source: AGHT+IED6dibeVsMjy1tpvPHsXYXNrwOKQw46Io+SXeW/Bqx/7ecKVNkVWABzwg06mql1JQI9f5NPQ==
X-Received: by 2002:a05:600c:3553:b0:40e:fc26:8719 with SMTP id i19-20020a05600c355300b0040efc268719mr3424034wmq.35.1707289466363;
        Tue, 06 Feb 2024 23:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsRvvJv+yQDiU75gECeewciWSwJ3KZBNRdLKD6g5/FTQfOQnZPgYb4gxFfzJ2cWiLC7KyxSRDuNq48ErLtT7Uc+PjHIqTP9odJmqOJerZu5KB3XSwmSj04jIVIkXkPnQBBB9Ja480KI22yQkN1umET3RGl+6IUDKUPJ3qZvU/RO9D7YSKo/fj1rE6BKt95nPqalxh28BYYHWGiyOs4917L5hWvKAx2DowquxHz3amKh3gvmAosytoVEQCJYkB+7VWW1hCG8INI4Oi7gyBM+a3Eb6mp7Y7Z/HisK9VTmuc8oTlvrl/5AqbeywjMesjD+zn3+EPouszZRij2oYktNLlX7X8/c0J1picZDSxW81NS/Rd/dNWS+VySON6BofCIGMtRA3bsc99mwbSGGSTnL9rQR4lINYDgCJIBgZhrfhlVpLNKp9qaF2jxARfR291/BNKF8jWr2kVkU/eWy323QoblmyriEWX4Y6z2E+FzEjo5YhoG2I/FovuI2Hs0gRN636wfi96h8Ae/XsjJWRlsZFp3mtRb/lxdHYOLsex3b+M6DRjw7vdIC3xNxiQY
Received: from [192.168.0.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0040f0219c371sm1031475wmo.19.2024.02.06.23.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:04:25 -0800 (PST)
Message-ID: <82358d4c-f100-472a-a4ed-88f28c460698@linaro.org>
Date: Wed, 7 Feb 2024 07:04:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep
 accessors
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-4-tudor.ambarus@linaro.org>
 <CAPLW+4k+FkuNwsyvWH54gcLz0YFmh8OmvOWt_LdQvELRXMvOTQ@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4k+FkuNwsyvWH54gcLz0YFmh8OmvOWt_LdQvELRXMvOTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/6/24 18:44, Sam Protsenko wrote:
> On Tue, Feb 6, 2024 at 2:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Allow SoCs that require 32 bits register accesses to write data in
>> chunks of 8 or 16 bits. One SoC that requires 32 bit register accesses
>> is the google gs101. The operation is rare, thus open code it in the
>> driver rather than making it generic (through asm-generic/io.h)
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 70 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 56 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index c15ca6a910dc..cb45ad615f3d 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -142,6 +142,7 @@ struct s3c64xx_spi_dma_data {
>>   *     prescaler unit.
>>   * @clk_ioclk: True if clock is present on this device
>>   * @has_loopback: True if loopback mode can be supported
>> + * @use_32bit_io: True if the SoC allows just 32-bit register accesses.
> 
> A matter of taste, but: just -> only.

ok, will change if I send a new version.
> 
>>   *
>>   * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
>>   * differ in some aspects such as the size of the fifo and spi bus clock
>> @@ -158,6 +159,7 @@ struct s3c64xx_spi_port_config {
>>         bool    clk_from_cmu;
>>         bool    clk_ioclk;
>>         bool    has_loopback;
>> +       bool    use_32bit_io;
>>  };
>>
>>  /**
>> @@ -412,6 +414,59 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
>>         return false;
>>  }
>>
>> +static void s3c64xx_iowrite8_32_rep(volatile void __iomem *addr,
>> +                                   const void *buffer, unsigned int count)
>> +{
>> +       if (count) {
>> +               const u8 *buf = buffer;
>> +
>> +               do {
>> +                       __raw_writel(*buf++, addr);
>> +               } while (--count);
>> +       }
> 
> How about:
> 
>     while (count--)
>         __raw_writel(*buf++, addr);
> 
> This way "if" condition is not needed. The same goes for the function below.

count will overflow, but shouldn't matter as it's not used afterwards.
But I would keep the style as it is, if you don't mind, it follows other
similar implementations from include/asm-generic/io.h. I'd like to be
consistent with the coding style of the generic implementations.

> 
>> +}
>> +
>> +static void s3c64xx_iowrite16_32_rep(volatile void __iomem *addr,
>> +                                    const void *buffer, unsigned int count)
>> +{
>> +       if (count) {
>> +               const u16 *buf = buffer;
>> +
>> +               do {
>> +                       __raw_writel(*buf++, addr);
>> +               } while (--count);
>> +       }
>> +}
>> +
>> +static void s3c64xx_iowrite_rep(const struct s3c64xx_spi_driver_data *sdd,
>> +                               struct spi_transfer *xfer)
>> +{
>> +       void __iomem *regs = sdd->regs;
> 
> Suggest declaring aliases here, like this:
> 
>     void __iomem *addr = sdd->regs + S3C64XX_SPI_TX_DATA;
>     const void *buf = xfer->tx_buf;
>     unsigned int len = xfer->len;
> 
> Using those in the code below makes it more compact and easier to read.

Ok, will add the local variables if I send again. I hope you're fine
with adding the local variables when introducing the method.
> 
>> +
>> +       switch (sdd->cur_bpw) {
>> +       case 32:
>> +               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                             xfer->tx_buf, xfer->len / 4);
>> +               break;
>> +       case 16:
>> +               if (sdd->port_conf->use_32bit_io)
>> +                       s3c64xx_iowrite16_32_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                                xfer->tx_buf, xfer->len / 2);
>> +               else
>> +                       iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                     xfer->tx_buf, xfer->len / 2);
>> +               break;
>> +       default:
>> +               if (sdd->port_conf->use_32bit_io)
>> +                       s3c64xx_iowrite8_32_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                               xfer->tx_buf, xfer->len);
>> +               else
>> +                       iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                    xfer->tx_buf, xfer->len);
>> +               break;
>> +       }
>> +}
>> +
>>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>>                                     struct spi_transfer *xfer, int dma_mode)
>>  {
>> @@ -445,20 +500,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>>                         modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
>>                         ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
>>                 } else {
>> -                       switch (sdd->cur_bpw) {
>> -                       case 32:
>> -                               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
>> -                                       xfer->tx_buf, xfer->len / 4);
>> -                               break;
>> -                       case 16:
>> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
>> -                                       xfer->tx_buf, xfer->len / 2);
>> -                               break;
>> -                       default:
>> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
>> -                                       xfer->tx_buf, xfer->len);
>> -                               break;
>> -                       }
>> +                       s3c64xx_iowrite_rep(sdd, xfer);
> 
> This extraction (with no functional change yet) could've been a
> preceding separate patch, preparing things for this rework.
> 

I'm not a fan of having preparation patches for small changes like this,
it hides the scope. As the patch is now one can see that the logic
extends and would have made the indentation horrible if not introducing
a dedicated method. No preparation patch, please.

