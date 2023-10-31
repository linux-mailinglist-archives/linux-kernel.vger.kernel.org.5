Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F677DC9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjJaJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjJaJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:48:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2557ED8;
        Tue, 31 Oct 2023 02:48:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E787C433C8;
        Tue, 31 Oct 2023 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698745696;
        bh=sM1Wv4trc5rYZHu5HPyjKmqhgM0mXr3pLbPOECiZojA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW0jS6/LBpKeo8eSNpHnM0lI92BdOehwUWDCNEqNAwtKgSgNv49mXuO0AYlgO8v3M
         H7b5YRXO1CESFmn6lcM8v9y1DLYWYPDuRhwMpfS0ZfmMm7gwqkv6ALrjoR+0w5nj72
         KS2x/XljH6UXfgQmWSQaUn1mHjNIHlimwKpCRYyM=
Date:   Tue, 31 Oct 2023 10:48:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guan-Yu Lin <guanyulin@google.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        stern@rowland.harvard.edu, heikki.krogerus@linux.intel.com,
        mkl@pengutronix.de, hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pumahsu@google.com, raychi@google.com, albertccwang@google.com
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
Message-ID: <2023103133-kelp-copartner-8e9c@gregkh>
References: <20231031093921.755204-1-guanyulin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031093921.755204-1-guanyulin@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:38:55PM +0800, Guan-Yu Lin wrote:
> Introducing PM_RPM_EXCEPTION config flag, which may alter the priority
> between system power management and runtime power management. In
> suspend-to-idle flow, PM core will suspend all devices to avoid device
> interact with the system. However, chances are devices might be used by
> other systems rather than a single system. In this case, PM core shouldn't
> suspend the devices. One may use PM_RPM_EXCEPTION config flag to mark
> such exception, and determine the power state of a device with runtime
> power management rather than system power management.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/core/generic.c |  6 ++++++
>  drivers/usb/core/usb.h     | 16 ++++++++++++++++
>  kernel/power/Kconfig       |  8 ++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index 740342a2812a..bb0dfcfc9764 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -266,6 +266,9 @@ int usb_generic_driver_suspend(struct usb_device *udev, pm_message_t msg)
>  {
>  	int rc;
>  
> +	if (usb_runtime_pm_exception(udev))
> +		return 0;
> +
>  	/* Normal USB devices suspend through their upstream port.
>  	 * Root hubs don't have upstream ports to suspend,
>  	 * so we have to shut down their downstream HC-to-USB
> @@ -294,6 +297,9 @@ int usb_generic_driver_resume(struct usb_device *udev, pm_message_t msg)
>  {
>  	int rc;
>  
> +	if (usb_runtime_pm_exception(udev))
> +		return 0;
> +
>  	/* Normal USB devices resume/reset through their upstream port.
>  	 * Root hubs don't have upstream ports to resume or reset,
>  	 * so we have to start up their downstream HC-to-USB
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 60363153fc3f..14a054f814a2 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -90,6 +90,22 @@ extern void usb_major_cleanup(void);
>  extern int usb_device_supports_lpm(struct usb_device *udev);
>  extern int usb_port_disable(struct usb_device *udev);
>  
> +#ifdef	CONFIG_PM_RPM_EXCEPTION
> +
> +static inline int usb_runtime_pm_exception(struct usb_device *udev)
> +{
> +	return atomic_read(&udev->dev.power.usage_count);
> +}
> +
> +#else
> +
> +static inline int usb_runtime_pm_exception(struct usb_device *udev)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  #ifdef	CONFIG_PM
>  
>  extern int usb_suspend(struct device *dev, pm_message_t msg);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4b31629c5be4..beba7a0f3947 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -193,6 +193,14 @@ config PM
>  	  responsible for the actual handling of device suspend requests and
>  	  wake-up events.
>  
> +config PM_RPM_EXCEPTION
> +	bool "Prioritize Runtime Power Management more than Power Management"
> +	default n

The default is always 'n' so no need to specify it.

> +	help
> +	Provides a way to prioritize Runtime Power Management more than Power
> +	Management. This way system can suspnd with maintaining specific
> +	components in operation.

This really doesn't give me a good description of why someone would ever
want to enable this at all.

And why does this have to be a build option?  That feels very heavy, why
not make it changable at runtime?

If this is a build option, how are you going to get all the distros and
all of the Android/ChromeOS systems in the world to enable it?

thanks,

greg k-h
