Return-Path: <linux-kernel+bounces-76202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDD85F421
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BD282026
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A9374F6;
	Thu, 22 Feb 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqizlL8m"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AB3715F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593596; cv=none; b=PQhVx7UigWE2MMmzkkbnA5dtebk5GICLnWfqjlopQdexK7mFOqmF1b2VcxCxOqwsrBdZ7SmUesOHKW/KKEucGLeBnv7y1unm2XVr/TEJNzsef1ggCs1VO8xM7lYuUS4lV5VY0gRTN7kPK0fWnaAjPNq8ZoEqDzH8NW3GkPw8vhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593596; c=relaxed/simple;
	bh=GeTk6TXrOBLprCtJy7fDOvTsG+cuRB3ZWlSbi+XrxUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUyF1AIKOs6YJEoLTljGBo/zMT44rjc8e/1uDUgLeY1CrXe++TsWO8QtZt6HQsvjEFnCc3AldfwqJqBfB5XqQPHiXQDLrZmsest6Yx0ugg5GGe8icCLu/kfI2fMgCf1fZSllgksVQlupmTPhyA8WJG9MnEdw7hte5Ue09WyZ/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KqizlL8m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so957749666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708593591; x=1709198391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmCv2CfcyvQ6sw1yTT6r/W//XC5XTP1YOZCBBSo1OxU=;
        b=KqizlL8m1G+awDnjbE1Thc5OQ02fg+qgbZsGG880drIK/gAvy8Y/Xb9mwGgUpsBWzI
         +8YG2W0+X8B6vkm3UEuGT+3nmbW127UxVi+1sm98oLxbaIoNKteVERYYWbLF9iXhWMdW
         KV/CjqmeJJP9pFHFrRWxcsMCIKAbtuvIN83Y9qb/RYIO/TqM90FpEk11THkZ3FfYDzIl
         +x+jz1vyu+Q+Jt1a9Pb9kgL4P+LfdbLBwKuSgE9oryjZCusOUDqC1aQLnMMUQcOuIlV2
         YtL8J8hl/iuX0zdaWrLPP9gasd+7OXhRfYyKQ02iipdJpCgMhbj5hMNZF8aK5fLbS+sc
         Bmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593591; x=1709198391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmCv2CfcyvQ6sw1yTT6r/W//XC5XTP1YOZCBBSo1OxU=;
        b=hlG5kE66clKP8Yq6vlLyz5fOJBrMLaihGfMDyGdFt9x14tTnFMd9dcRsVQrMKQ+c6G
         QS30Ln92+yIjvuyvq67mieeTBkQrPuDDp1tEh0bDTjau5t+64XtU0so7VbCSlUkth6NV
         eSO78RcC+oD+jiMWv8w22r43YHYkZKy77E0rxu19GscnfXhNg2reHojPde3X2SzUVYpl
         Nw/1cpYAq+EHN4Ol33hJcgYbUUrTxh6hRdLkXWRo0efbELjbiRlfBBc15OxFXg/9NdPU
         IplJ2Fm6VJgiDJ6OUsMjAL2QthCr7w6byPe4XX0kek6SgKohmx1I68ZY2xyTqZghOwhn
         6UlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP3owQu9hoDEPk/fc40pWjhuE+5hunbQIk7yi5u3KrvLsk3beWzutC8ohTs9YDfXEJIWmApHROwHa1SiZGKA9L/zIwu430fdRmDG5q
X-Gm-Message-State: AOJu0YwiiJZcLhu0Xqsnch6/oc/p5g5U/jNJ+E5QzZx2hAxxGswTSWqE
	IcVQ6bnCiAYgHpRe8SKjUbB2t+Q1nBNch8GzDqrcXDCv0WPAm6SYu2QyVQMr5+k=
X-Google-Smtp-Source: AGHT+IElQJs14kGBEH2/dau4pudlpNgnogD+EQS8guSJOGGw5Csg+0mpBBjRV5MfGLpTwt/CHIV6QQ==
X-Received: by 2002:a17:906:2b88:b0:a3e:34b2:a2fc with SMTP id m8-20020a1709062b8800b00a3e34b2a2fcmr8564380ejg.1.1708593590715;
        Thu, 22 Feb 2024 01:19:50 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090609aa00b00a3f6466ba85sm852819eje.35.2024.02.22.01.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:19:50 -0800 (PST)
Message-ID: <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
Date: Thu, 22 Feb 2024 09:19:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: David Bauer <mail@david-bauer.net>
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240220200325.19089-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/24 20:03, Christian Marangi wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> Add MTD support for the BoHong bh25q128as SPI NOR chip.
> The chip has 16MB of total capacity, divided into a total of 256
> sectors, each 64KB sized. The chip also supports 4KB sectors.
> Additionally, it supports dual and quad read modes.
> 
> Datasheet is public and can be found at the referenced link.
> 
> Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.
> 
> Link: https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf
> Signed-off-by: David Bauer <mail@david-bauer.net>
> [ reworked to new flash_info format ]
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Read/write/erase test are done by flashing and installing an OpenWrt
> image on the spi and by using overlayfs on it confirming correct
> read/write.
> 
> root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname 
> bh25q128as
> root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id 
> 684018
> root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer 
> bohong
> 
> root@OpenWrt:/# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 53464450000101ff00000109300000ff68000103600000ffffffffffffff
> ffffffffffffffffffffffffffffffffffffe520f1ffffffff0744eb086b
> 083b42bbeeffffffffff00ffffff44eb0c200f5210d800ffffffffffffff
> ffffffffffff003600279ef97764fcebffff
> 

Hey, Christian,

Seems that the flash defines the SFDP tables, thus it's likely you won't
need a flash entry at all, and instead rely on the generic SFDP driver
to parse the flash settings from SFDP and initialize the flash based on
that.

Have you tried testing the flash without adding a dedicated entry for
it? Just specifying the jedec,spi-nor compatible in dt will do the
trick. As you do now, but without this patch :).

Cheers,
ta

