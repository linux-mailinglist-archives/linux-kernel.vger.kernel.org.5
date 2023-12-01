Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FF801394
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379528AbjLATah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLATaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:30:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 09494128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:30:41 -0800 (PST)
Received: (qmail 298611 invoked by uid 1000); 1 Dec 2023 14:30:41 -0500
Date:   Fri, 1 Dec 2023 14:30:41 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: core: Allow subclassed USB drivers to
 override usb_choose_configuration()
Message-ID: <0ca93d42-d650-405f-8acd-075132b8ac14@rowland.harvard.edu>
References: <20231201183113.343256-1-dianders@chromium.org>
 <20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:29:51AM -0800, Douglas Anderson wrote:
> For some USB devices we might want to do something different for
> usb_choose_configuration(). One example here is the r8152 driver where
> we want to end up using the vendor driver with the preferred
> interface.
> 
> The r8152 driver tried to make things work by implementing a USB
> generic_subclass driver and then overriding the normal config
> selection after it happened. This is less than ideal and also caused
> breakage if someone deauthorized and re-authorized the USB device
> because the USB core ended up going back to it's default logic for
> choosing the best config. I made an attempt to fix this [1] but it was
> a bit ugly.
> 
> Let's do this better and allow USB generic_subclass drivers to
> override usb_choose_configuration().
> 
> [1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> Changes in v2:
> - ("Allow subclassed USB drivers to override ...") new for v2.
> 
>  drivers/usb/core/generic.c | 7 +++++++
>  include/linux/usb.h        | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index 740342a2812a..dcb897158228 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -59,10 +59,17 @@ int usb_choose_configuration(struct usb_device *udev)
>  	int num_configs;
>  	int insufficient_power = 0;
>  	struct usb_host_config *c, *best;
> +	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
>  
>  	if (usb_device_is_owned(udev))
>  		return 0;
>  
> +	if (udriver->choose_configuration) {
> +		i = udriver->choose_configuration(udev);
> +		if (i >= 0)
> +			return i;
> +	}
> +
>  	best = NULL;
>  	c = udev->config;
>  	num_configs = udev->descriptor.bNumConfigurations;
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 8c61643acd49..618e5a0b1a22 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1264,6 +1264,9 @@ struct usb_driver {
>   *	module is being unloaded.
>   * @suspend: Called when the device is going to be suspended by the system.
>   * @resume: Called when the device is being resumed by the system.
> + * @choose_configuration: If non-NULL, called instead of the default
> + *	usb_choose_configuration(). If this returns an error then we'll go
> + *	on to call the normal usb_choose_configuration().
>   * @dev_groups: Attributes attached to the device that will be created once it
>   *	is bound to the driver.
>   * @drvwrap: Driver-model core structure wrapper.
> @@ -1287,6 +1290,9 @@ struct usb_device_driver {
>  
>  	int (*suspend) (struct usb_device *udev, pm_message_t message);
>  	int (*resume) (struct usb_device *udev, pm_message_t message);
> +
> +	int (*choose_configuration) (struct usb_device *udev);
> +
>  	const struct attribute_group **dev_groups;
>  	struct usbdrv_wrap drvwrap;
>  	const struct usb_device_id *id_table;
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
