Return-Path: <linux-kernel+bounces-15948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4940B823618
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E8E28755F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C381CFB2;
	Wed,  3 Jan 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xYks43pB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538331D521;
	Wed,  3 Jan 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5dyrGtJzFd/nI+6RCdTpAzac1uifkIlq6gjdAP+yoZw=; b=xYks43pBdg0PRPfV3sN8AogwYq
	QBdSQshZw0qh4pNmSImWYahazDV6+yjxE0/7uGpf4wTxJRjzrOSHFK5L3M4esyXowrtX3at5XsEGa
	JCyti2kkoEqczDhNF9uiEs+2Jx9u4w0P4rjzQBQrJSUryiNeOC5osbVdG7LFqx+dx388C7q46SLUC
	v3YMSvT7u2FKJUSHs/IZBwVp66/ZDqtRTptFYgIRmfN58f+hwakY1xSWkJUweCGdRi+ec6gGKal1G
	XKQtfuY+uxe4wMrcHVQ5wDCSll0rClLFcD/aiKJdCW3cLNAAAAcIFrb2CrlUp9YZ4IjOZtivzx1qt
	y/fuJFFw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rL7Va-00BzMz-1A;
	Wed, 03 Jan 2024 20:06:34 +0000
Message-ID: <775efa9b-0917-4e89-abc5-470c9f4506db@infradead.org>
Date: Wed, 3 Jan 2024 12:06:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: thp7312: select CONFIG_FW_LOADER
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Paul Elder <paul.elder@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Hans de Goede <hdegoede@redhat.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Mehdi Djait <mehdi.djait@bootlin.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103155811.4092035-1-arnd@kernel.org>
 <20240103174820.GA17142@pendragon.ideasonboard.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103174820.GA17142@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 09:48, Laurent Pinchart wrote:
> Hi Arnd,
> 
> Thank you for the patch.
> 
> On Wed, Jan 03, 2024 at 04:58:05PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The recently added driver uses the firmware loader mechanism but causes
>> a link failure when that is in a loadable module while thp7312 itself
>> is built-in:
>>
>> arm-linux-gnueabi-ld: drivers/media/i2c/thp7312.o: in function `thp7312_probe':
>> thp7312.c:(.text+0x4164): undefined reference to `firmware_upload_register'
>>
>> Select the required Kconfig symbol. Note that the driver specifically
>> needs the firmware upload interface that is controlled by CONFIG_FW_UPLOAD,
>> but there is no link failure when that is disabled because the interfaces
>> are stubbed out here.
>>
>> Fixes: 7a52ab415b43 ("media: i2c: Add driver for THine THP7312")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I've posted a similar fix yesterday, see
> https://lore.kernel.org/linux-media/20240102074518.24968-1-laurent.pinchart@ideasonboard.com
> 
> What approach do you think is best ?

By far the dominant use of FW_LOADER is to select it instead of depend on it,
so I prefer Arnd's patch.

> 
>> ---
>>  drivers/media/i2c/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index 78a87331686e..4c3435921f19 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -674,6 +674,7 @@ menu "Camera ISPs"
>>  config VIDEO_THP7312
>>  	tristate "THine THP7312 support"
>>  	depends on I2C
>> +	select FW_LOADER
>>  	select MEDIA_CONTROLLER
>>  	select V4L2_CCI_I2C
>>  	select V4L2_FWNODE
> 

-- 
#Randy

