Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1B808DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjLGQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjLGQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:41:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 712B710DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:41:09 -0800 (PST)
Received: (qmail 9300 invoked by uid 1000); 7 Dec 2023 11:41:08 -0500
Date:   Thu, 7 Dec 2023 11:41:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <0bd3204e-19f4-48de-b42e-a75640a1b1da@rowland.harvard.edu>
References: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
 <20231207114209.14595-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207114209.14595-1-jtornosm@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:42:09PM +0100, Jose Ignacio Tornos Martinez wrote:
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
> V4 -> V5
> - Fix my misundestanding and follow the suggestion from Alan Stern to 
> syncronize and not order the flag.

I did not suggest that you should synchronize anything.  What I said was 
that the problem you faced was one of synchronization, not of ordering.  

In fact, you should not try to synchronize -- ultimately it is 
impossible to do.  The only way to get true synchronization is to 
prevent the user from disconnecting the device and bringing the 
interface down at the same time, and obviously the kernel cannot do 
this.

>  drivers/net/usb/ax88179_178a.c | 47 +++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 4ea0e155bb0d..e07614799f75 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -173,6 +173,8 @@ struct ax88179_data {
>  	u8 in_pm;
>  	u32 wol_supported;
>  	u32 wolopts;
> +	u8 disconnecting;
> +	struct mutex lock;
>  };
>  
>  struct ax88179_int_data {
> @@ -208,6 +210,8 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  {
>  	int ret;
>  	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u8 disconnecting;
>  
>  	BUG_ON(!dev);
>  
> @@ -219,9 +223,14 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  		 value, index, data, size);
>  
> -	if (unlikely(ret < 0))
> -		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
> -			    index, ret);
> +	if (unlikely(ret < 0)) {
> +		mutex_lock(&ax179_data->lock);
> +		disconnecting = ax179_data->disconnecting;
> +		mutex_unlock(&ax179_data->lock);

Clearly you don't understand how mutexes work.  Using a mutex like this 
accomplishes nothing.

> +		if (!(ret == -ENODEV && disconnecting))
> +			netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
> +				    index, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -231,6 +240,8 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  {
>  	int ret;
>  	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u8 disconnecting;
>  
>  	BUG_ON(!dev);
>  
> @@ -242,9 +253,14 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  		 value, index, data, size);
>  
> -	if (unlikely(ret < 0))
> -		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
> -			    index, ret);
> +	if (unlikely(ret < 0)) {
> +		mutex_lock(&ax179_data->lock);
> +		disconnecting = ax179_data->disconnecting;
> +		mutex_unlock(&ax179_data->lock);

Same here.

> +		if (!(ret == -ENODEV && disconnecting))
> +			netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
> +				    index, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -492,6 +508,22 @@ static int ax88179_resume(struct usb_interface *intf)
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
> +	mutex_lock(&ax179_data->lock);
> +	ax179_data->disconnecting = 1;
> +	mutex_unlock(&ax179_data->lock);

And again, this does nothing.

Imagine a situation where the user brings the interface down on CPU 1, 
while at the same time CPU 2 handles a disconnection.  Then the 
following timeline of events can occur:

	CPU 1				CPU 2
	---------------------------	-----------------------------
	The stop operation calls
	__ax88179_read_cmd()

					The device is unplugged

	The routine tries to communicate
	with the device and gets a -ENODEV
	error because the device is gone

					The USB core calls ax88179_disconnect()

	The routine locks the mutex,
	reads ax179_data->disconnecting = 0,
	and unlocks the mutex

					ax88179_disconnect() locks the mutex,
					sets ax179_data->disconnecting = 1,
					and unlocks the mutex

	The routine prints an error message

As you can see, using the mutex does not prevent the problem from 
occurring.  You should not add the mutex at all; it serves no purpose.

Alan Stern
