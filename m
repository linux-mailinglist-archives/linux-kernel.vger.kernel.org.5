Return-Path: <linux-kernel+bounces-82982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C35868C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A8B265D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99013848A;
	Tue, 27 Feb 2024 09:41:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32F136665;
	Tue, 27 Feb 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026896; cv=none; b=I40hd/m6GYA37fYKgWF0eiX0HRxsOmwJQSjfT137yEqvcaXvkEsZs4IMEd4U7tP8ZrBaNmY4YVV0F0kqmGq0+Ms+fNpVNU5StMYRL7ZzsCbIlFWnVYAXGKlj9PBRcc+6Cy1ulE1EySJ01AFSv6F2sGBcJw4+UX6D0jr7jKuTbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026896; c=relaxed/simple;
	bh=GhoRHMmUUTvt+w0xFWRMfhOroiUsocjYqe7tLBaJ1vM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpxDTPahytyI6hECXP98qWXuC+KLpYukkHR1zlOODBN1LiQNxZVbFG2W/89h3UVHlqR/RoZ2/wy9zXomHFKHMlussSeJvVD0JUrZvgv/KxCEwbma5ipsU6bLWGwlV2VH2YWXKFBuUkgXNwGkGJ23s+D4BghyjjZR7ikr9kZERi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkXTR5Ys3z688KN;
	Tue, 27 Feb 2024 17:37:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33C471400CD;
	Tue, 27 Feb 2024 17:41:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 09:41:31 +0000
Date: Tue, 27 Feb 2024 09:41:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 5/5] ACPI: scan: Consolidate Device Check and Bus
 Check notification handling
Message-ID: <20240227094131.0000291c@Huawei.com>
In-Reply-To: <7632957.EvYhyI6sBW@kreacher>
References: <6021126.lOV4Wx5bFT@kreacher>
	<7632957.EvYhyI6sBW@kreacher>
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

On Mon, 26 Feb 2024 17:46:41 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is no particular reason why device object subtree rescans in
> acpi_scan_device_check() and acpi_scan_device_check() should be carried
> out differently, so move the rescan code into a new function called
> acpi_scan_rescan_bus() and make both the functions above invoke it.
> 
> While at it, in the Device Check case, start the device object subtree
> rescan mentioned above from the target device's parent, as per the
> specification. [1]
> 
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#device-object-notification-values # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

