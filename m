Return-Path: <linux-kernel+bounces-117469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FE88ABC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB251C2406F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9613A3ED;
	Mon, 25 Mar 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA59lr5u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B445473D;
	Mon, 25 Mar 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384196; cv=none; b=TqkzfKWM4x3UvobAtA2/mt2pv4nu6S6u8UE99KfGU5kO2JC5yu2mrwYBDUBujbI87w8IBynfZ+EheBQMkzlSYK25g3wbcSetA7VvRbhDFLJp6Ic9xxdSEzjACAqktCV3ffq7bF4MQM6qds11gD/sGtT20coq66kv+uoSe/lPVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384196; c=relaxed/simple;
	bh=qOr94dkjdQAFRjI3x/SoL7AT1gteENtLlwbLMaL3eiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLRXzwDPu6PTc8r+fHiMJePQ8Z7zirwYClyDRIXqa2aqOtgKwGEmzJlit0qCKdVvftIXnRMagWCOTHpuQLVIk+YA7yiGb3L/6iOIe+T8F4Ecmz/Pk/TsHSwHrhRsVvf//CN1TejkmkDkhQqeIuafz3gcNizIBQYoad3nZ9ChveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA59lr5u; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711384194; x=1742920194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOr94dkjdQAFRjI3x/SoL7AT1gteENtLlwbLMaL3eiI=;
  b=IA59lr5u+dQxyDkiVIfrU6ZcAyzm/0wuTd556BNCdo25ToPCQw9maAMD
   Ii/ggt0xHG+Hs/o+zdZILb1y7+rH68KhF3At9tZgPlZ85u5JweCzRJYjU
   mNICMUUQeEouAbB1xhB5ksdsTU5t/V11VssylLTZBEtHzC3PlH6dHbgph
   VsBrbDsUel30geBa48borLV0iKFKhY6GFs4m8c5c6DHjNzgtuOaLl5lto
   7NRF2EpkotQNIqMi7pYBg9TdtQL/vmrIidUuUCOpD/OgeTwu5zsduN1LG
   iT2cTJFq7k2NBtT04wCQru65vYlU5Kv23WXXXQGUJCWyyA08wAa6UvcNI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6994791"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6994791"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914848465"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914848465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:29:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ronCn-0000000G2uH-367U;
	Mon, 25 Mar 2024 18:29:49 +0200
Date: Mon, 25 Mar 2024 18:29:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ai Chao <aichao@kylinos.cn>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Message-ID: <ZgGmfV9ciPdtbGO1@smile.fi.intel.com>
References: <20240322064750.267422-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322064750.267422-1-aichao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 22, 2024 at 02:47:50PM +0800, Ai Chao wrote:
> Add lenovo generic wmi driver to support camera button.

WMI

> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.

> +config LENOVO_WMI_CAMERA
> +	tristate "Lenovo WMI Camera Button driver"
> +	depends on ACPI_WMI
> +	depends on INPUT

No COMPILE_TEST?

> +	help
> +	  This driver provides support for Lenovo camera button. The Camera
> +	  button is a GPIO device. This driver receives ACPI notify when the
> +	  camera button is switched on/off.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called lenovo-wmi-camera.

..

> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

+ types.h

> +#include <linux/wmi.h>

..

> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */

WMI

> +};

..

> +	/* obj->buffer.pointer[0] is camera mode:
> +	 *      0 camera close
> +	 *      1 camera open
> +	 */

/*
 * The correct multi-line comment style
 * is depicted here.
 */

..

> +	keycode = (camera_mode == SW_CAMERA_ON ?
> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);

Useless parentheses.

..

> +	ret = input_register_device(priv->idev);
> +	if (ret)
> +		return ret;

> +	mutex_init(&priv->notify_lock);

Your mutex should be initialized before use. Have you tested that?

..

> +static struct wmi_driver lenovo_wmi_driver = {
> +	.driver = {
> +		.name = "lenovo-wmi-camera",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lenovo_wmi_id_table,
> +	.no_singleton = true,
> +	.probe = lenovo_wmi_probe,
> +	.notify = lenovo_wmi_notify,
> +	.remove = lenovo_wmi_remove,
> +};
> +

Unneeded blank line.

> +module_wmi_driver(lenovo_wmi_driver);

..

> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);

Please, move it closer to the respective table.

-- 
With Best Regards,
Andy Shevchenko



