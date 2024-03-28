Return-Path: <linux-kernel+bounces-122361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40088F5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0111F28CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFEB2555B;
	Thu, 28 Mar 2024 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDkhlqJV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182E101D0;
	Thu, 28 Mar 2024 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594737; cv=none; b=VfaoG2y5A5vQe3+mfE/FrMf1/IwpWhAwPreKzFctP73OOtYBmyKYDPcgFY6nOyK70U/H9OvBaVQYLkms9RIralDU7AahuLeOFerCNcHYBc+FGstSrmfJX6RO12cUln3nVKrg5Z8o6a/AkZLDq6ahRbH7f4kUx8MdKywMCJDkUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594737; c=relaxed/simple;
	bh=tzaJbkaugwkpAb7GyR2Hz30nnIxHhPx+V/EoDzp0WZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTZwIly202/3SCvQkLDTsyTsQwiJfs9O2u2c+GdHFHsMe0jieuomZYtL5DkwDo8x5Wuq0yUGGJSjWXzmHkFoxb+lvfcVkz7s67Xc3kZQtoLRiG5qx5eXJTbwScJXwDiyQVGfC84Nr7BDHjeR80IerE5Tokh5russCdb4lFnF81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDkhlqJV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711594736; x=1743130736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tzaJbkaugwkpAb7GyR2Hz30nnIxHhPx+V/EoDzp0WZs=;
  b=mDkhlqJVd0IK5E0Efv4/NFufErucZA2GYhqSwSfODmEFqgrPsfCYAlum
   9cjxscpX4k6paeD9tM6kwZd3p4niiVFkR0bLa3a/hLK267krK0nN+ycU9
   msq5Ck32f+c+FB0w6UR4URgVM3iK+Q70SbAffNayECzBWrUV544tduBpI
   L3CQTzJxfVIcNAMb1Fpvwn592rmzoa9eFrhZb1r+Mb6jW0On1VMRMSILF
   +adNy2bQaJYar6joezNRT4PRAw0fZXvA5tbd0sbvSo4il9/v6LHjUphD4
   ZoU3CVEjmjCatSypkNZXI+EvH9eAOmpdCpJdrfWIED/dbGIqrTG+0fcaQ
   A==;
X-CSE-ConnectionGUID: 9flhov2+TsmbH4C+WPeV/A==
X-CSE-MsgGUID: nCxEwLelSKy+svxJDBo0fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29209429"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="29209429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="47705056"
Received: from soralee-mobl1.amr.corp.intel.com (HELO [10.255.228.178]) ([10.255.228.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:58:54 -0700
Message-ID: <b82ded95-d599-4ef7-b984-ac4d8a5c2370@linux.intel.com>
Date: Wed, 27 Mar 2024 19:58:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
 <20240328012336.145612-2-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240328012336.145612-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/27/24 6:23 PM, Armin Wolf wrote:
> Multiple WMI events can be received concurrently, so multiple instances
> of xiaomi_wmi_notify() can be active at the same time. Since the input
> device is shared between those handlers, the key input sequence can be
> disturbed.

Since locking is needed for all notify related calls in all WMI drivers,
is there a generic way to add this support in WMI core driver? Like
defining some common function which will hold the lock and call
driver specific notify handler? I am just thinking aloud.. If it is not
feasible, then it is fine.

> Fix this by protecting the key input sequence with a mutex.
>
> Compile-tested only.
>
> Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 1f5f108d87c0..7efbdc111803 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -2,8 +2,10 @@
>  /* WMI driver for Xiaomi Laptops */
>
>  #include <linux/acpi.h>
> +#include <linux/device.h>
>  #include <linux/input.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/wmi.h>
>
>  #include <uapi/linux/input-event-codes.h>
> @@ -20,12 +22,21 @@
>
>  struct xiaomi_wmi {
>  	struct input_dev *input_dev;
> +	struct mutex key_lock;	/* Protects the key event sequence */
>  	unsigned int key_code;
>  };
>
> +static void xiaomi_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
>  static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	struct xiaomi_wmi *data;
> +	int ret;
>
>  	if (wdev == NULL || context == NULL)
>  		return -EINVAL;
> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  		return -ENOMEM;
>  	dev_set_drvdata(&wdev->dev, data);
>
> +	mutex_init(&data->key_lock);
> +	ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
> +	if (ret < 0)
> +		return ret;
> +
>  	data->input_dev = devm_input_allocate_device(&wdev->dev);
>  	if (data->input_dev == NULL)
>  		return -ENOMEM;
> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>  	if (data == NULL)
>  		return;
>
> +	mutex_lock(&data->key_lock);
>  	input_report_key(data->input_dev, data->key_code, 1);
>  	input_sync(data->input_dev);
>  	input_report_key(data->input_dev, data->key_code, 0);
>  	input_sync(data->input_dev);
> +	mutex_unlock(&data->key_lock);
>  }
>
>  static const struct wmi_device_id xiaomi_wmi_id_table[] = {
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


