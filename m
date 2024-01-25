Return-Path: <linux-kernel+bounces-39143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CF83CB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781E31C23F01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2377135A5C;
	Thu, 25 Jan 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1olWlRk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E613667A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208255; cv=none; b=SrdLVl0fGNWfzk2OKbqA9KZHVGOil8ZvbDEOPaABrq8xohbpsj7vPRDaJrCkWEoorBkgcl61QkqAxF7PV43ibpaORvU/KMQ2kIvnhAqhofx+gJXoMCEjBz5ybPhEAcxtdDdy1m+zkXO4pbmzGq76o2tGJFzWoD95X3Jjztd72pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208255; c=relaxed/simple;
	bh=awSLOrEXP9rFT2y8LOhZ/9MdiMBuYZIY+MSqb9WthkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLL+3SUrSlNX6mnt5hhh78rG911QsLlt//Os49N+IdIM/xiq9NtV4cscBCmtFCy0186JmIUskJb6b+eqnqD31DK3PcixixaROUc1YXp+PBdb0YaEGDbi3LPb5/aOOLBwXkvhHHsBWy7q6lXr20m9b03UlI2f9wCqFVEDp2wDcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1olWlRk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e76626170so78400775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706208251; x=1706813051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrYJdLBwLw70S4ObciiJY9LJFq5pZvqC5Of2nJ/JVJM=;
        b=l1olWlRk4TjO8OAIsZZryqaOk/GF9PstHdjIOXjr+HkBDWxypi/BYkIypXPBcWxDiy
         cLhcvAunUVILJSecCliRaPKAzA/E7Vq82JX8UIHyHvHe4gZQ0+Y3NQOo4RBUMiFfVt0U
         oWzz5EGlZBN/QnuXdxEuz1HF0LHovGxS17EwYfPdAkydnDk7bCG8DSH6njZZbpbqMmwl
         AMGFsHRaWC8cOgJkzLguVKS9lpKS27X8RUHJKzbY7uNTPcAHo8d65dlcNEJm7Hfqoz1M
         iSPp3NSv6XEr8Ot9yLDs6rKSYfuuZoXJTD/voGPF81fhd626RaJjFeOx0y2VmyvcVCgE
         WK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208251; x=1706813051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrYJdLBwLw70S4ObciiJY9LJFq5pZvqC5Of2nJ/JVJM=;
        b=LnLvpryrvdXoI7RTPiBE/7KBYLBNsvro/ycLB07asGaUYjRnz9hr5j9WIkCEI/FWS+
         884BtDv4kUS8OtYCf/zuNWsxpOzKwXGmL5L+9vaf309tjAcUl7y5ZlBoS8BJ3oaity55
         wbpk/cen2TSdH2abmSwTKnVokX9OL3rObOuMUrRdLa5Ilej1bv4QRNH22BYQ6Dy3HvYh
         WwD9SON7bPmwaXzmTam03u+IgjsG4yvyCEFUqnC/mAx6PjRLVEjBNHoYwTp7f/OQpKFS
         29gKrSq3+I6Dg6fTwQGbVdt/2nfy4LmcY+ReKF/ovI3OOa5gToza8AJ8KEVJNvz49Crb
         e3eg==
X-Gm-Message-State: AOJu0YwAH9CSF8DRbPqEhyug7yO/kTICheV0uVfyEba3auGQP9w/euQL
	3PhlxRpvdAUtECPBnP8WFpdSghGwAOaVNGi1P90UE7uamcNbQYF5kPMynDMAKdg=
X-Google-Smtp-Source: AGHT+IE+cIhZxK3kunbbIhBn/MOUJGzmsMnmINwXcGYl+d9le2UEsWFf+v6SdKU9oWvk60jPYq4SJg==
X-Received: by 2002:a05:600c:365a:b0:40e:b174:8b0b with SMTP id y26-20020a05600c365a00b0040eb1748b0bmr120888wmq.40.1706208251067;
        Thu, 25 Jan 2024 10:44:11 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm3426678wms.33.2024.01.25.10.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 10:44:10 -0800 (PST)
Message-ID: <40ba9481-4aea-4a72-87bd-c2db319be069@linaro.org>
Date: Thu, 25 Jan 2024 18:44:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/28] spi: s3c64xx: infer fifosize from the compatible
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: andi.shyti@kernel.org, arnd@arndb.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, semen.protsenko@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-22-tudor.ambarus@linaro.org>
 <2086b88e-45fc-4224-b00f-0840d446d042@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2086b88e-45fc-4224-b00f-0840d446d042@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 17:18, Mark Brown wrote:
> On Thu, Jan 25, 2024 at 02:49:59PM +0000, Tudor Ambarus wrote:
> 
>> Infer the FIFO size from the compatible, where all the instances of the
>> SPI IP have the same FIFO size. This way we no longer depend on the SPI
>> alias from the device tree to select the FIFO size, thus we remove the
>> dependency of the driver on the SPI alias.
> 
>>  static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
>> -	.fifo_lvl_mask	= { 0x7f },
>> +	.fifosize	= 64,
>>  	.rx_lvl_offset	= 13,
>>  	.tx_st_done	= 21,
>>  	.clk_div	= 2,
> 
> I'm having real trouble associating the changelog with the change here.
> This appears to be changing from specifying the mask for the FIFO level
> register to specifying the size of the FIFO and unrelated to anything to
> do with looking things up from the compatible?

Let me try to explain everything.

In the driver there is a weird dependency between the SPI of_alias ID,
s3c64xx_spi_port_config.fifo_lvl_mask and the IP's FIFO depth.

s3c64xx_spi_port_config.fifo_lvl_mask is not a 1:1 match with the
SPI_STATUSn.{RX, TX}_FIFO_LVL register field. Those fields are defined
in the datasheet as:
+#define S3C64XX_SPI_ST_RX_FIFO_LVL		GENMASK(23, 15)
+#define S3C64XX_SPI_ST_TX_FIFO_LVL		GENMASK(14, 6)

Thus the register mask is on 9 bits, but the driver used either 0x1ff or
0x7f, which was not reflecting the real register mask. Patch 10/28
updates the driver to use the full register mask regardless of the FIFO
depth configuration.

Another problem with s3c64xx_spi_port_config.fifo_lvl_mask is that it
was used as a way to determine the FIFO depth. The SPI of_alias ID was
used as an index in this array to determine the FIFO depth with
something like
	fifo_depth = (fifo_lvl_mask[alias_id] >> 1) + 1
For example, if one wanted to specify a 64 FIFO length (0x40), it would
have configured the FIFO level to 127 (0x7f).

The patch set breaks this weird dependencies. Obviously the FIFO depth
must be tightly tied by the compatible and not by an alias. I tied the
FIFO depth to the compatible in 2 ways:
1/ For SoCs that have all the SPI nodes with the same FIFO depth, I
chose to deduce the FIFO depth from the compatible. Instead of
specifying "samsung,spi-fifosize" for all the gs101 SPI nodes in the
device tree, I chose to infer it from the compatible. I know for sure
that all the gs101 SPI nodes have 64 bytes FIFO depths, thus don't
pollute the device tree with superfluous info. (patches 20/28 and 21/28)
2/ For SoCs that have instances of the SPI IP with different FIFO
depths, specify the node's FIFO depth via the "samsung,spi-fifosize" dt
property. (patch 23/28)

Hope this helps. Please tell if you want me to elaborate on something.

