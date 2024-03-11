Return-Path: <linux-kernel+bounces-99161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8F878452
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA3282F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE347794;
	Mon, 11 Mar 2024 15:58:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB74A99C;
	Mon, 11 Mar 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172722; cv=none; b=Wm/lFkQ3QJeibzRKBXlnH5IkETG1vUYS8oVmlJJ15ltUsjRYENOYyxkUpRZIIkyqYAOk1joby0eWKEErWoHQ8NZZtjwbVMsC1CJOmYi1ZGEm/1rEo123oyZtdaUP4JYhK3Zstxt6XlfgUVZUPU+o+k6Uevf8InkfKq5WAdoh20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172722; c=relaxed/simple;
	bh=uPk/YFMv5dSeHslgbuWypcz5oo6ifz8zjx4p7Cws0jM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rp44qfITSNPkwiBZJXCVWTq1MICG3chUJClXRPXpGF6gp5C9CDlgbEg1B1qvK/0YgeklsUgR8CAfrZqFfmY/v4knJWCFBtihQi3k5serg5nPhlG8PVAJM7AhYhsX4j9vfvSr1Mw0Agyw6iyoRjS0L/qnO4G8MShXk5QTx6ZQvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TthD25rLCz6K9LZ;
	Mon, 11 Mar 2024 23:54:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F0ECA1404F4;
	Mon, 11 Mar 2024 23:58:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Mar
 2024 15:58:30 +0000
Date: Mon, 11 Mar 2024 15:58:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Vasileios Amoiridis <vassilisamir@gmail.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <ang.iglesiasg@gmail.com>, <phil@raspberrypi.com>,
	<579lpy@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: pressure: Fixes SPI support for BMP3xx devices
Message-ID: <20240311155829.00004478@Huawei.com>
In-Reply-To: <Ze7XU5JS8FF5FZdg@smile.fi.intel.com>
References: <20240311005432.1752853-1-vassilisamir@gmail.com>
	<Ze7XU5JS8FF5FZdg@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 11 Mar 2024 12:05:07 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 11, 2024 at 01:54:32AM +0100, Vasileios Amoiridis wrote:
> > Bosch does not use unique BMPxxx_CHIP_ID for the different versions of
> > the device which leads to misidentification of devices if their ID is
> > used. Use a new value in the chip_info structure instead of the
> > BMPxxx_CHIP_ID, in order to choose the regmap_bus to be used.  
> 
> ...
> 
> >  	const struct regmap_config *regmap_config;
> > +	int spi_read_extra_byte;  
> 
> Why is it int and not boolean?
> Also, please run `pahole` to see the best place for a new member.

Whilst that's good in general, there aren't many of these structs (4ish)
so if the 'cheapest' positioning isn't natural or hurts readability
ignore what you get from pahole.

Jonathan

> 


