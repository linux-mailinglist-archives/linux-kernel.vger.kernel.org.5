Return-Path: <linux-kernel+bounces-82971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BD868C67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B4228DB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F79136999;
	Tue, 27 Feb 2024 09:39:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857C7BAE7;
	Tue, 27 Feb 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026795; cv=none; b=ZHktK43MpTh1/GdNFJeyu4VyHRp0aVHGqU3t8aC8s7M/GlDO+HCQOaxcZbxuN+Pj132KRVytpFHOzLriotQC+PbRUBJ77g7RrdhVaPTH0k+OX1NGC/g3XlSCO4LLm4YLlMtklZIINAOLMNTWdmLjHRyvRtQ8oCXzu1cVt2rlt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026795; c=relaxed/simple;
	bh=0qPbRd+6tnaV2H2MEITsFHJAWN/QQ+mGHBMovXvJtdQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsjGf0JPRKP1XKDxEn3P3q5i1zbPfCSkuDMkoHvcgoIFEuesSOSQUC6aGfXHcxRomK7+bBJH3fBpUqhIMFG8DzV2PhewVvf0+yF4X+cLaBarlzNSRNu3w6P7LowJ4B2z0MqPvJ/hWzAVVhUq+ADdBg0DaHHSvAJRm854U6RjHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkXRT4Vxcz6H7Wb;
	Tue, 27 Feb 2024 17:36:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 236B11400C9;
	Tue, 27 Feb 2024 17:39:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 09:39:49 +0000
Date: Tue, 27 Feb 2024 09:39:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 4/5] ACPI: scan: Rework Device Check and Bus Check
 notification handling
Message-ID: <20240227093948.000050c9@Huawei.com>
In-Reply-To: <1958983.PYKUYFuaPT@kreacher>
References: <6021126.lOV4Wx5bFT@kreacher>
	<1958983.PYKUYFuaPT@kreacher>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 17:45:11 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The underlying problem is the handling of the enabled bit in device
> status (bit 1 of _STA return value) which is required by the ACPI
> specification to be observed in addition to the present bit (bit 0
> of _STA return value) [1], but Linux does not observe it.
> 
> Since Linux has not looked at that bit for a long time, it is generally
> risky to start obseving it in all device enumeration cases, especially
> at the system initialization time, but it can be observed when the
> kernel receives a Bus Check or Device Check notification indicating a
> change in device configuration.  In those cases, seeing the enabled bit
> clear may be regarded as an indication that the device at hand should
> not be used any more.
> 
> For this reason, rework the handling of Device Check and Bus Check
> notifications in the ACPI core device enumeration code in the
> following way:
> 
>  1. Rename acpi_bus_trim_one() to acpi_scan_check_and_detach() and make
>     it check device status if its second argument is not NULL, in which
>     case it will detach scan handlers or ACPI drivers from devices whose
>     _STA returns the enabled bit clear.

New name is much better - thanks!

> 
>  2. Make acpi_scan_device_check() and acpi_scan_bus_check() invoke
>     acpi_scan_check_and_detach() with a non-NULL second argument
>     unconditionally, so scan handlers and ACPI drivers are detached
>     from the target device and its ancestors if their _STA returns the
>     enabled bit clear.
> 
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Looks good.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


