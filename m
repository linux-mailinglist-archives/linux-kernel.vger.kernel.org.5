Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05107BDE73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377068AbjJINTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377050AbjJINTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:19:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B694;
        Mon,  9 Oct 2023 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696857585; x=1728393585;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WrOxCluoJP6xWKpdaqb8cOgJDWAuRfTKax2I39sxdeg=;
  b=N1e+Nptqt0jfCIEo5jHkJY47h4Klq0ch4eGiSi0dXYTZm7S6aYlCno28
   jWqZmgfVGOzf8AjdlSnRcwC3/I6xCPlkqqnSJJUjnsgTKCiZgzU8M3N9g
   2A8IdTZBrhaWAKn3wzGdBovHlAJuUOiSM2BTtz/g5ehg1L1f/A/yqSCfK
   F/+Er6R2o89tsBE9hL3QrrNr6bV+vYXwAUgnHihVTJ+GUQnGkoAjp7zju
   zmSR9Lrw0E/ARaAzuCX2FaxGyOUL9esoLMOtVx9lQtLHkQ0VW2lXLwR23
   kBuOMB9JXlzVygm5J4j/xu0VQ4pl6Q9i4f+5VLeDfnSfRPLxTI6Mo6yun
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363491082"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363491082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869250011"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869250011"
Received: from lshebash-mobl3.ccr.corp.intel.com ([10.252.57.254])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:19:44 -0700
Date:   Mon, 9 Oct 2023 16:19:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] platform/x86: wmi: Decouple probe deferring from
 wmi_block_list
In-Reply-To: <20231007233933.72121-3-W_Armin@gmx.de>
Message-ID: <9e3c21ec-9b57-5ee-fc1d-8911b0a93cc@linux.intel.com>
References: <20231007233933.72121-1-W_Armin@gmx.de> <20231007233933.72121-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023, Armin Wolf wrote:

> Many aggregate WMI drivers do not use -EPROBE_DEFER when they
> cannot find a WMI device during probe, instead they require
> all WMI devices associated with an platform device to become
> available at once. This is currently achieved by adding those
> WMI devices to the wmi_block_list before they are registered,
> which is then used by the deprecated GUID-based functions to
> search for WMI devices.
> Replace this approach with a device link which defers probing

To make these more readable, you should break the paragraphs with an empty 
line, not just using a newline.

-- 
 i.

> of the WMI device until the associated platform device has finished
> probing (and has registered all WMI devices). New aggregate WMI
> drivers should not rely on this behaviour.



> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 39 +++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index a78ddd83cda0..1dbef16acdeb 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1221,6 +1221,26 @@ static int wmi_create_device(struct device *wmi_bus_dev,
>  	return 0;
>  }
> 
> +static int wmi_add_device(struct platform_device *pdev, struct wmi_device *wdev)
> +{
> +	struct device_link *link;
> +
> +	/*
> +	 * Many aggregate WMI drivers do not use -EPROBE_DEFER when they
> +	 * are unable to find a WMI device during probe, instead they require
> +	 * all WMI devices associated with an platform device to become available
> +	 * at once. This device link thus prevents WMI drivers from probing until
> +	 * the associated platform device has finished probing (and has registered
> +	 * all discovered WMI devices).
> +	 */
> +
> +	link = device_link_add(&wdev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
> +	if (!link)
> +		return -EINVAL;
> +
> +	return device_add(&wdev->dev);
> +}
> +
>  static void wmi_free_devices(struct acpi_device *device)
>  {
>  	struct wmi_block *wblock, *next;
> @@ -1263,11 +1283,12 @@ static bool guid_already_parsed_for_legacy(struct acpi_device *device, const gui
>  /*
>   * Parse the _WDG method for the GUID data blocks
>   */
> -static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
> +static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  {
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
>  	const struct guid_block *gblock;
> -	struct wmi_block *wblock, *next;
> +	struct wmi_block *wblock;
>  	union acpi_object *obj;
>  	acpi_status status;
>  	int retval = 0;
> @@ -1317,22 +1338,14 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
>  			wblock->handler = wmi_notify_debug;
>  			wmi_method_enable(wblock, true);
>  		}
> -	}
> 
> -	/*
> -	 * Now that all of the devices are created, add them to the
> -	 * device tree and probe subdrivers.
> -	 */
> -	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
> -		if (wblock->acpi_device != device)
> -			continue;
> -
> -		retval = device_add(&wblock->dev.dev);
> +		retval = wmi_add_device(pdev, &wblock->dev);
>  		if (retval) {
>  			dev_err(wmi_bus_dev, "failed to register %pUL\n",
>  				&wblock->gblock.guid);
>  			if (debug_event)
>  				wmi_method_enable(wblock, false);
> +
>  			list_del(&wblock->list);
>  			put_device(&wblock->dev.dev);
>  		}
> @@ -1487,7 +1500,7 @@ static int acpi_wmi_probe(struct platform_device *device)
>  	}
>  	dev_set_drvdata(&device->dev, wmi_bus_dev);
> 
> -	error = parse_wdg(wmi_bus_dev, acpi_device);
> +	error = parse_wdg(wmi_bus_dev, device);
>  	if (error) {
>  		pr_err("Failed to parse WDG method\n");
>  		goto err_remove_busdev;
> --
> 2.39.2
> 
