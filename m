Return-Path: <linux-kernel+bounces-77199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17798601F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E344A1C26589
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56871744;
	Thu, 22 Feb 2024 18:47:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F006E5E1;
	Thu, 22 Feb 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627667; cv=none; b=FlcVVQYpcoQ9vxxDfHhNtzCGKQjwcd4sez0MDHbBWjTTmADyWkoFqcYDOGz9jcdEHVFLTcHB9CQag4e74JfxsxUhwkOTgcyF1rBR4JviX91ctPPvutDKmYpXl43ht5vpn/YlpWVPtZ/3Ug1D5fbrzx4odWoA80jjFgst1qZfWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627667; c=relaxed/simple;
	bh=GDp40XzKQ0cQgRksU/oyFZVrTyRlcWTheyhy8HJaaAo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF4jdWiEift7gy17B6LKvRXreDHnRZ0EuJR+Xkjb0yZR12bJwYRFT6nh0XRIYlTk/FCHLNs4WZnOyYwb2ljmNgrdOHMnMBfDjtTHLcZQ0F5bDqMGG4bAD1/cz7f83sFrXUOCZBg7FbZtNhgX6H8MquO/HFwHKsQInL6Vbfx0vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TghqC0q26z6J9St;
	Fri, 23 Feb 2024 02:43:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66F81140119;
	Fri, 23 Feb 2024 02:47:42 +0800 (CST)
Received: from localhost (10.195.247.94) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 18:47:41 +0000
Date: Thu, 22 Feb 2024 18:47:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 4/4] ACPI: scan: Make acpi_processor_add() check the
 device enabled bit
Message-ID: <20240222184738.00000bf7@Huawei.com>
In-Reply-To: <3298279.44csPzL39Z@kreacher>
References: <4562925.LvFx2qVVIh@kreacher>
	<3298279.44csPzL39Z@kreacher>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 21:03:17 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify acpi_processor_add() return an error if _STA returns the enabled
> bit clear for the given processor device, so as to avoid using processors
> that don't decode their resources, as per the ACPI specification. [1]
> 
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This does the job for us so if you are happier with this approach
that works for me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/acpi_processor.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/acpi/acpi_processor.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_processor.c
> +++ linux-pm/drivers/acpi/acpi_processor.c
> @@ -381,6 +381,9 @@ static int acpi_processor_add(struct acp
>  	struct device *dev;
>  	int result = 0;
>  
> +	if (!acpi_device_is_enabled(device))
> +		return -ENODEV;
> +
>  	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
>  	if (!pr)
>  		return -ENOMEM;
> 
> 
> 


