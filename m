Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E47805D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbjLESHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLESHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:07:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AAD1CB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:07:42 -0800 (PST)
Received: (qmail 425300 invoked by uid 1000); 5 Dec 2023 13:07:41 -0500
Date:   Tue, 5 Dec 2023 13:07:41 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     oneukum@suse.com, davem@davemloft.net, edumazet@google.com,
        greg@kroah.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
References: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
 <20231205135154.516342-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205135154.516342-1-jtornosm@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:51:54PM +0100, Jose Ignacio Tornos Martinez wrote:
> When the device is disconnected we get the following messages showing
> failed operations:
> Nov 28 20:22:11 localhost kernel: usb 2-3: USB disconnect, device number 2
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: unregister 'ax88179_178a' usb-0000:02:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to read reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0001: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> 
> The reason is that although the device is detached, normal stop and
> unbind operations are commanded from the driver. These operations are
> not necessary in this situation, so avoid these logs when the device is
> detached if the result of the operation is -ENODEV and if the new flag
> informing about the disconnecting status is enabled.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Follow the suggestions from Alan Stern and Oliver Neukum to check the
> result of the operations (-ENODEV) and not the internal state of the USB 
> layer (USB_STATE_NOTATTACHED).
> V2 -> V3
> - Add cc: stable line in the signed-off-by area.
> V3 -> V4
> - Follow the suggestions from Oliver Neukum to use only one flag when
> disconnecting and include barriers to avoid memory ordering issues.

The __ax88179_read_cmd() and __ax88179_write_cmd() routines are 
asynchronous with respect to ax88179_disconnect(), right?  Or at least, 
they are if they run as a result of the user closing the network 
interface.  Otherwise there wouldn't be any memory ordering issues.

But the memory barriers you added are not the proper solution.  What you 
need here is _synchronization_, not _ordering_.  As it is, the memory 
barriers you have added don't do anything; they shouldn't be in the 
patch.

If you would like a more in-depth explanation, let me know.

Alan Stern

>  drivers/net/usb/ax88179_178a.c | 38 +++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 4ea0e155bb0d..1c671f2a43ee 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -173,6 +173,7 @@ struct ax88179_data {
>  	u8 in_pm;
>  	u32 wol_supported;
>  	u32 wolopts;
> +	u8 disconnecting;
>  };
>  
>  struct ax88179_int_data {
> @@ -208,6 +209,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  {
>  	int ret;
>  	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
> +	struct ax88179_data *ax179_data = dev->driver_priv;
>  
>  	BUG_ON(!dev);
>  
> @@ -219,9 +221,12 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  		 value, index, data, size);
>  
> -	if (unlikely(ret < 0))
> -		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
> -			    index, ret);
> +	if (unlikely(ret < 0)) {
> +		smp_rmb();
> +		if (!(ret == -ENODEV && ax179_data->disconnecting))
> +			netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
> +				    index, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -231,6 +236,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  {
>  	int ret;
>  	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
> +	struct ax88179_data *ax179_data = dev->driver_priv;
>  
>  	BUG_ON(!dev);
>  
> @@ -242,9 +248,12 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  		 value, index, data, size);
>  
> -	if (unlikely(ret < 0))
> -		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
> -			    index, ret);
> +	if (unlikely(ret < 0)) {
> +		smp_rmb();
> +		if (!(ret == -ENODEV && ax179_data->disconnecting))
> +			netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
> +				    index, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -492,6 +501,21 @@ static int ax88179_resume(struct usb_interface *intf)
>  	return usbnet_resume(intf);
>  }
>  
> +static void ax88179_disconnect(struct usb_interface *intf)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *ax179_data;
> +
> +	if (!dev)
> +		return;
> +
> +	ax179_data = dev->driver_priv;
> +	ax179_data->disconnecting = 1;
> +	smp_wmb();
> +
> +	usbnet_disconnect(intf);
> +}
> +
>  static void
>  ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
>  {
> @@ -1906,7 +1930,7 @@ static struct usb_driver ax88179_178a_driver = {
>  	.suspend =	ax88179_suspend,
>  	.resume =	ax88179_resume,
>  	.reset_resume =	ax88179_resume,
> -	.disconnect =	usbnet_disconnect,
> +	.disconnect =	ax88179_disconnect,
>  	.supports_autosuspend = 1,
>  	.disable_hub_initiated_lpm = 1,
>  };
> -- 
> 2.43.0
> 
