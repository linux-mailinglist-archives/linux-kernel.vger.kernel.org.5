Return-Path: <linux-kernel+bounces-54703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17484B29A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382C81C23694
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BAA1EA80;
	Tue,  6 Feb 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRch0bcX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1A18EB2;
	Tue,  6 Feb 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215879; cv=none; b=YbVTw23tsmZHh5C5c0CJiF1rxAuFoZ3DcboQxcETu+plXwhj71X4xmeBFNlQTDPmZbybt0lBaAc+jOl6r44Zq4X0V2XwaXNhuZDsCR07UOzor7mo3HIhOdEy7D0J3aHFcCrW8/nrEWjnFlWdXsYVZt843krvaIqfmMZRnuDIuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215879; c=relaxed/simple;
	bh=aHkUF5YCR/boc9eFPrsYpkQzvcIHp6Qno9oWGGB7Ka8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GH13yXxPlQs/0MKco/3QZIG3UpsD9S0MtZdT00gs/q7ABejJgwVz0WbpHEBtwzc/nx2uxnghyqiC/tpwm6TSYqchs2wZC7oO4eQ/42z5BFS7QA5sjDe6n3XiKDz2fYOG3TCobCQ1NFsVAmF8sIXteauHDrLVGKVl4h+Zew4W7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRch0bcX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707215877; x=1738751877;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aHkUF5YCR/boc9eFPrsYpkQzvcIHp6Qno9oWGGB7Ka8=;
  b=KRch0bcXQHVsknwxFNrET2Jjl2yIeeJCIcemTuCXKdfHyWyyQikMtY4M
   1Ter8IT64qvBC+WnQBtcYLs3N2icLBQijtbxaTVZo1+4VFVbrnwHGxyia
   V3Tw1wOrvalEqCpFhVMhfy8+86OCq7ZSSx3rnETL5miB7vWNRaXG7djhX
   C/lHRrgOUxi6kZnpBlwXXa7PiUMGfazumNXObWoO765vzJAzP0qedpSKc
   QBU9ig4/QuXapmjvdlSFQBOTwG80UjOADNFtkH8nj1p7hlnEuJcagfb4m
   nszDvH6gZvvklNtpafByeKtC1XmKQrawSWhQ3/9zrBAlbau0Dde/ZiA50
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="601604"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="601604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933422448"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="933422448"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:37:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 12:37:50 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: dennisn@dennisn.mooo.com, lkml@vorpal.se, 
    Hans de Goede <hdegoede@redhat.com>, coproscefalo@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: Add ACPI quickstart button (PNP0C32)
 driver
In-Reply-To: <20240131111641.4418-2-W_Armin@gmx.de>
Message-ID: <93abd9ac-f76d-2bbc-dfef-a0483921e701@linux.intel.com>
References: <20240131111641.4418-1-W_Armin@gmx.de> <20240131111641.4418-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, Armin Wolf wrote:

> This drivers supports the ACPI quickstart button device, which
> is used to send manufacturer-specific events to userspace.
> Since the meaning of those events is not standardized, userspace
> has to use for example hwdb to decode them.
> 
> The driver itself is based on an earlier proposal, but contains
> some improvements and uses the device wakeup API instead of a
> custom sysfs file.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> new file mode 100644
> index 000000000000..ba3a7a25dda7
> --- /dev/null
> +++ b/drivers/platform/x86/quickstart.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * quickstart.c - ACPI Direct App Launch driver

ACPI Quickstart ?

> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + * Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
> + * Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
> + *
> + * Information gathered from disassembled dsdt and from here:
> + * <https://archive.org/details/microsoft-acpi-dirapplaunch>
> + */

> +static void quickstart_notify(acpi_handle handle, u32 event, void *context)
> +{
> +	struct quickstart_data *data = context;
> +
> +	switch (event) {
> +	case QUICKSTART_EVENT_RUNTIME:
> +		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
> +		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
> +		break;
> +	default:
> +		dev_err(data->dev, FW_INFO "Unexpected ACPI notify event (%u)\n", event);

Could this end up spamming the logs so perhaps use _ratelimited variant?

> +static int quickstart_probe(struct platform_device *pdev)
> +{
> +	struct quickstart_data *data;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = &pdev->dev;
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	/* We have to initialize the device wakeup before evaluating GHID because
> +	 * doing so will notify the device if the button was used to wake the machine
> +	 * from S5.
> +	 */
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = quickstart_get_ghid(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->input_device = devm_input_allocate_device(&pdev->dev);
> +	if (!data->input_device)
> +		return -ENOMEM;
> +
> +	ret = sparse_keymap_setup(data->input_device, quickstart_keymap, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	snprintf(data->input_name, sizeof(data->input_name), "Quickstart Button %u", data->id);
> +	snprintf(data->phys, sizeof(data->phys), DRIVER_NAME "/input%u", data->id);
> +
> +	data->input_device->name = data->input_name;
> +	data->input_device->phys = data->phys;

Why not devm_kasprintf() these directly into data->input_device->xx + 
NULL check instead of storing into struct quickstart_data ?

> +static struct platform_driver quickstart_platform_driver = {
> +	.driver	= {
> +		.name = DRIVER_NAME,
> +		.dev_groups = quickstart_groups,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.acpi_match_table = quickstart_device_ids,
> +	},
> +	.probe = quickstart_probe,
> +};
> +module_platform_driver(quickstart_platform_driver);
> +
> +MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
> +MODULE_AUTHOR("Angelo Arrifano");
> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");

ACPI Quickstart Button ?

> +MODULE_LICENSE("GPL");
> --
> 2.39.2
> 

-- 
 i.


