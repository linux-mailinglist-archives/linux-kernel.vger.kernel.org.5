Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29467C730C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379525AbjJLQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbjJLQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:32:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ECBC0;
        Thu, 12 Oct 2023 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697128344; x=1728664344;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jKhmhLoZMtAQbPlIEKKqj8u2OJYSYB1CSvXNiZknyjQ=;
  b=XnZp7KbuRX3HcZms7vqNvYsdzRyXLBsp7cqpqjFevLPQq3K7Rdyd9eUz
   OcWWN0+8olbW/qkPcdEuhNLA2s7J9OJgmHeV8SsY2fRjKkiwrd0bIr5qB
   sdivQTUB5B15pxSbuOP8JTIGtW5WQjgzcDlRTI7iqzdwXNNgLkWSU9/2h
   3zXw73Us7iswxA63eAvKBWFRb0g0e3bbGgEUz8NjYkqXb93/HFIvTmHSZ
   u3xn9RiQ05etkWHsjk/HOQ5S0q+lhLbXUBYJaeZa70ogcz8fc1BK1FdRW
   WqX/NCk2Q8Qf1tyUK2FZSLZnFSvWI6g0zA3GwwsUyr5+dwtvxCbY+hilE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375324576"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="375324576"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898181366"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898181366"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:30:34 -0700
Date:   Thu, 12 Oct 2023 19:32:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>
cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] platform/x86: wmi: Fix probe failure when failing
 to register WMI devices
In-Reply-To: <20231007233933.72121-5-W_Armin@gmx.de>
Message-ID: <6fc5eacc-15e7-8de4-a031-d57ae27568bd@linux.intel.com>
References: <20231007233933.72121-1-W_Armin@gmx.de> <20231007233933.72121-5-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023, Armin Wolf wrote:

> When a WMI device besides the first one somehow fails to register, retval
> is returned while still containing a negative error code. This causes the
> ACPI device failing to probe, leaving behind zombie WMI devices leading
> to various errors later.
> Fix this by handling the single error path separately and return 0 after
> trying to register all WMI devices. Also continue to register WMI devices
> even if some fail to allocate.

I think the usual approach would be to unroll all registerations done so 
far when an error occurs while registering n devices.

Do you Hans have something to add what would be the best course of action 
here?

-- 
 i.

> Fixes: 6ee50aaa9a20 ("platform/x86: wmi: Instantiate all devices before adding them")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index e3984801883a..ab24ea9ffc9a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1338,8 +1338,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	struct wmi_block *wblock;
>  	union acpi_object *obj;
>  	acpi_status status;
> -	int retval = 0;
>  	u32 i, total;
> +	int retval;
> 
>  	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
>  	if (ACPI_FAILURE(status))
> @@ -1350,8 +1350,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  		return -ENXIO;
> 
>  	if (obj->type != ACPI_TYPE_BUFFER) {
> -		retval = -ENXIO;
> -		goto out_free_pointer;
> +		kfree(obj);
> +		return -ENXIO;
>  	}
> 
>  	gblock = (const struct guid_block *)obj->buffer.pointer;
> @@ -1366,8 +1366,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
> 
>  		wblock = kzalloc(sizeof(*wblock), GFP_KERNEL);
>  		if (!wblock) {
> -			retval = -ENOMEM;
> -			break;
> +			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
> +			continue;
>  		}
> 
>  		wblock->acpi_device = device;
> @@ -1398,9 +1398,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  		}
>  	}
> 
> -out_free_pointer:
> -	kfree(out.pointer);
> -	return retval;
> +	kfree(obj);
> +
> +	return 0;
>  }
> 
>  /*
> --
> 2.39.2
> 

