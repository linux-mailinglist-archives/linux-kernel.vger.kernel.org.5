Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094EF80CF77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjLKP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:27:06 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 82FFAD6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:27:11 -0800 (PST)
Received: (qmail 132862 invoked by uid 1000); 11 Dec 2023 10:27:10 -0500
Date:   Mon, 11 Dec 2023 10:27:10 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Brian Geffon <bgeffon@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: Fix crash w/ usb_choose_configuration() if
 no driver
Message-ID: <1ec52764-7fd9-484f-bcdc-bbf97194deef@rowland.harvard.edu>
References: <20231211070808.v2.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211070808.v2.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:08:14AM -0800, Douglas Anderson wrote:
> It's possible that usb_choose_configuration() can get called when a
> USB device has no driver. In this case the recent commit a87b8e3be926
> ("usb: core: Allow subclassed USB drivers to override
> usb_choose_configuration()") can cause a crash since it dereferenced
> the driver structure without checking for NULL. Let's add a check.
> 
> A USB device with no driver is an anomaly, so make
> usb_choose_configuration() return immediately if there is no driver.
> 
> This was seen in the real world when usbguard got ahold of a r8152
> device at the wrong time. It can also be simulated via this on a
> computer with one r8152-based USB Ethernet adapter:
>   cd /sys/bus/usb/drivers/r8152-cfgselector
>   to_unbind="$(ls -d *-*)"
>   real_dir="$(readlink -f "${to_unbind}")"
>   echo "${to_unbind}" > unbind
>   cd "${real_dir}"
>   echo 0 > authorized
>   echo 1 > authorized
> 
> Fixes: a87b8e3be926 ("usb: core: Allow subclassed USB drivers to override usb_choose_configuration()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Return immediately if no driver, as per Alan.
> 
>  drivers/usb/core/generic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index dcb897158228..2be1e8901e2f 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -59,7 +59,11 @@ int usb_choose_configuration(struct usb_device *udev)
>  	int num_configs;
>  	int insufficient_power = 0;
>  	struct usb_host_config *c, *best;
> -	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
> +	struct usb_device_driver *udriver;
> +
> +	if (!udev->dev.driver)
> +		return -1;

This is a rather unusual condition.  It would be good to put a comment 
just before the test, explaining that if a USB device (not an interface) 
doesn't have a driver then the kernel has no business trying to select 
or install a configuration for it.

Along with the comment, feel free to add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

> +	udriver = to_usb_device_driver(udev->dev.driver);
>  
>  	if (usb_device_is_owned(udev))
>  		return 0;
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
