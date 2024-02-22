Return-Path: <linux-kernel+bounces-77203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18008601F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25DA1C26B77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2420A12D204;
	Thu, 22 Feb 2024 18:51:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843512D1FB;
	Thu, 22 Feb 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627866; cv=none; b=RX0qEcM1XA4PD5iRTCrjKVVvzRYi3wJ2dCZ+JV7Dg7btBGVKwaZF4uoK68rSeC8qUQ4B8BI3yMkdWyB1jfokuPVxq/RKsVRzMImupNzvMerFnMZwIrNJlF87UpJVz2mudObXenCCN+nHy1Xle86QjYU4Xlt5xZyVhrto84Lny7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627866; c=relaxed/simple;
	bh=uF8n5frPiummjo0/NnhXvolUhAv0sKOfCyhG9BGm5qg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6eF6+kYRfrXZtdqwM/VZk86Jcc6TwFT7BvKFSW9snXyhdnjcUigcWUWvSGM0iL3X1Mu/oXLLFg2rTKeuPT+0lMQ6V1w9ulE88WuI3FuYqah4bbEuA7FPAfkJ35dl2aaGzw3vY+O9Pk6S80+E7WHsrCOaadKENODm5RHjYwt8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tghvv6sT0z6K8pZ;
	Fri, 23 Feb 2024 02:47:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CAE851412EB;
	Fri, 23 Feb 2024 02:51:01 +0800 (CST)
Received: from localhost (10.195.247.94) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 18:51:01 +0000
Date: Thu, 22 Feb 2024 18:50:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 1/4] ACPI: scan: Fix device check notification
 handling
Message-ID: <20240222185059.00005f40@Huawei.com>
In-Reply-To: <4886572.GXAFRqVoOG@kreacher>
References: <4562925.LvFx2qVVIh@kreacher>
	<4886572.GXAFRqVoOG@kreacher>
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

On Wed, 21 Feb 2024 21:01:02 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally invalid to fail a Device Check notification if the scan
> handler has not been attached to the given device after a bus rescan,
> because there may be valid reasons for the scan handler to refuse
> attaching to the device (for example, the device is not ready).
> 
> For this reason, modify acpi_scan_device_check() to return 0 in that
> case without printing a warning.
> 
> While at it, reduce the log level of the "already enumerated" message
> in the same function, because it is only interesting when debugging
> notification handling
> 
> Fixes: 443fc8202272 ("ACPI / hotplug: Rework generic code to handle suprise removals")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems reasonable to me.  Not sure it fixes any bugs anyone has seen
in the wild though. I'd not give it a fixes tag without such a
known case, but your subsystem so fair enough!

Thanks for resolving how to handle the processor case.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/scan.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -314,18 +314,14 @@ static int acpi_scan_device_check(struct
>  		 * again).
>  		 */
>  		if (adev->handler) {
> -			dev_warn(&adev->dev, "Already enumerated\n");
> -			return -EALREADY;
> +			dev_dbg(&adev->dev, "Already enumerated\n");
> +			return 0;
>  		}
>  		error = acpi_bus_scan(adev->handle);
>  		if (error) {
>  			dev_warn(&adev->dev, "Namespace scan failure\n");
>  			return error;
>  		}
> -		if (!adev->handler) {
> -			dev_warn(&adev->dev, "Enumeration failure\n");
> -			error = -ENODEV;
> -		}
>  	} else {
>  		error = acpi_scan_device_not_enumerated(adev);
>  	}
> 
> 
> 


