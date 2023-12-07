Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C0808622
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379115AbjLGKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379076AbjLGKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:08:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70C133
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:08:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AEEC433C9;
        Thu,  7 Dec 2023 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701943687;
        bh=+TtWj3u6F3zGN0JIXvl73oCLKKxPXp04JKwR9ZXgj3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPPnoCwQQoWgHzBERudad0ncb3tnicMaEM1xQeqYyAMaMSeNXmNv5+N2ZGa6k2C/u
         fzwsvVRg4OcGLQw4HeVW/9YxXMauLsodfn2ww6y9Z8oNrgRVSfXZSBYyRhffOPKuUq
         WWWPpTNzmsmF60dK43Bme7ISlTk30HraApCZoLMs=
Date:   Thu, 7 Dec 2023 11:08:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 4/4] usb: core: add phy notify connect and
 disconnect
Message-ID: <2023120730-mouth-jolt-0170@gregkh>
References: <20231207074022.14116-1-stanley_chang@realtek.com>
 <20231207074022.14116-4-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207074022.14116-4-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:38:07PM +0800, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of generic
> phy driver when usb device connect and disconnect change.
> 
> The Realtek phy driver is designed to dynamically adjust disconnection
> level and calibrate phy parameters. When the device connected bit changes
> and when the disconnected bit changes, do connection change notification:
> 
> Check if portstatus is USB_PORT_STAT_CONNECTION and portchange is
> USB_PORT_STAT_C_CONNECTION.
> 1. The device is connected, the driver lowers the disconnection level and
>    calibrates the phy parameters.
> 2. The device disconnects, the driver increases the disconnect level and
>    calibrates the phy parameters.
> 
> Generic phy driver in usb core framework does not support device connect
> and disconnect notifications. Therefore, we add an api to notify phy
> the connection changes.
> 
> Additionally, the generic phy only specifies primary_hcd in the original
> design. Added specific "usb2-phy" on primary_hcd and "usb3-phy" on
> shared_hcd.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3:
>     No change
> v1 to v2 change:
>     rebase the driver to remove the part of usb phy notify API
> ---
>  drivers/usb/core/hcd.c | 14 +++++--
>  drivers/usb/core/hub.c | 29 +++++++++++++
>  drivers/usb/core/phy.c | 94 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/phy.h |  3 ++
>  4 files changed, 136 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 12b6dfeaf658..992284461ad8 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2794,10 +2794,16 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	struct usb_device *rhdev;
>  	struct usb_hcd *shared_hcd;
>  
> -	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
> -		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> -		if (IS_ERR(hcd->phy_roothub))
> -			return PTR_ERR(hcd->phy_roothub);
> +	if (!hcd->skip_phy_initialization) {
> +		if (usb_hcd_is_primary_hcd(hcd)) {
> +			hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> +			if (IS_ERR(hcd->phy_roothub))
> +				return PTR_ERR(hcd->phy_roothub);
> +		} else {
> +			hcd->phy_roothub = usb_phy_roothub_alloc_usb3_phy(hcd->self.sysdev);
> +			if (IS_ERR(hcd->phy_roothub))
> +				return PTR_ERR(hcd->phy_roothub);
> +		}
>  
>  		retval = usb_phy_roothub_init(hcd->phy_roothub);
>  		if (retval)
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 87480a6e6d93..65c0454ee70a 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -37,6 +37,7 @@
>  #include <asm/byteorder.h>
>  
>  #include "hub.h"
> +#include "phy.h"
>  #include "otg_productlist.h"
>  
>  #define USB_VENDOR_GENESYS_LOGIC		0x05e3
> @@ -622,6 +623,34 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
>  		ret = 0;
>  	}
>  	mutex_unlock(&hub->status_mutex);
> +
> +	/*
> +	 * There is no need to lock status_mutex here, because status_mutex
> +	 * protects hub->status, and the phy driver only checks the port
> +	 * status without changing the status.
> +	 */
> +	if (!ret) {
> +		struct usb_device *hdev = hub->hdev;
> +
> +		/*
> +		 * Only roothub will be notified of connection changes,
> +		 * since the USB PHY only cares about changes at the next
> +		 * level.
> +		 */
> +		if (is_root_hub(hdev)) {
> +			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
> +			bool connect;
> +			bool connect_change;
> +
> +			connect_change = *change & USB_PORT_STAT_C_CONNECTION;
> +			connect = *status & USB_PORT_STAT_CONNECTION;
> +			if (connect_change && connect)
> +				usb_phy_roothub_notify_connect(hcd->phy_roothub, port1 - 1);
> +			else if (connect_change)
> +				usb_phy_roothub_notify_disconnect(hcd->phy_roothub, port1 - 1);
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index fb1588e7c282..26585fc1ec32 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -19,6 +19,29 @@ struct usb_phy_roothub {
>  	struct list_head	list;
>  };
>  
> +static int usb_phy_roothub_add_phy_by_name(struct device *dev, const char *name,
> +					   struct list_head *list)
> +{
> +	struct usb_phy_roothub *roothub_entry;
> +	struct phy *phy;
> +
> +	phy = devm_of_phy_get(dev, dev->of_node, name);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
> +	if (!roothub_entry)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&roothub_entry->list);
> +
> +	roothub_entry->phy = phy;
> +
> +	list_add_tail(&roothub_entry->list, list);
> +
> +	return 0;
> +}
> +
>  static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  				   struct list_head *list)
>  {
> @@ -65,6 +88,9 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>  
>  	INIT_LIST_HEAD(&phy_roothub->list);
>  
> +	if (!usb_phy_roothub_add_phy_by_name(dev, "usb2-phy", &phy_roothub->list))
> +		return phy_roothub;
> +
>  	for (i = 0; i < num_phys; i++) {
>  		err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>  		if (err)
> @@ -75,6 +101,32 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_alloc);
>  
> +struct usb_phy_roothub *usb_phy_roothub_alloc_usb3_phy(struct device *dev)
> +{
> +	struct usb_phy_roothub *phy_roothub;
> +	int num_phys;
> +
> +	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
> +		return NULL;
> +
> +	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
> +					      "#phy-cells");
> +	if (num_phys <= 0)
> +		return NULL;
> +
> +	phy_roothub = devm_kzalloc(dev, sizeof(*phy_roothub), GFP_KERNEL);
> +	if (!phy_roothub)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&phy_roothub->list);
> +
> +	if (!usb_phy_roothub_add_phy_by_name(dev, "usb3-phy", &phy_roothub->list))
> +		return phy_roothub;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_phy_roothub_alloc_usb3_phy);
> +
>  int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub)
>  {
>  	struct usb_phy_roothub *roothub_entry;
> @@ -172,6 +224,48 @@ int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
>  
> +int usb_phy_roothub_notify_connect(struct usb_phy_roothub *phy_roothub, int port)
> +{
> +	struct usb_phy_roothub *roothub_entry;
> +	struct list_head *head;
> +	int err;
> +
> +	if (!phy_roothub)
> +		return 0;

How can phy_roothub ever be NULL?

> +
> +	head = &phy_roothub->list;
> +
> +	list_for_each_entry(roothub_entry, head, list) {
> +		err = phy_notify_connect(roothub_entry->phy, port);
> +		if (err)
> +			return err;
> +	}
>

You walk a list with no locking at all?  That does not seem right at
all.

Also, this is a new function that is exported with no documentation?
Please fix.

thanks,

greg k-h
