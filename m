Return-Path: <linux-kernel+bounces-135702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC989C9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520B3286DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4C142652;
	Mon,  8 Apr 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Qu+v/lYh"
Received: from smtp68.iad3a.emailsrvr.com (smtp68.iad3a.emailsrvr.com [173.203.187.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1B1428F7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594515; cv=none; b=EMss4Lvod8yZdMFNLBN4R2nYayGFGZTrkZc4BYLqYdsPx9aQHtA4EHW/aFYUzHDkdJqPvbuuRQr5tV7vGWvGB60fS0h2+h5DFWQllc8qFjhoS29CbvEfqeE2YpMrRufdfkCzFFwy0dyxFwcVQSyiWyI1WkO9KWGx8pI0QlMKXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594515; c=relaxed/simple;
	bh=DGas92X4/ZpcXb5tSqkSEcJjOWyWwlBNT3zZo8zN0jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7MDeEArjHDcMZg/nRBiM1DkPQQ5Md9kRg/EHcHqpZDRIKTon+DBUyUUdw9CoIGmIjRNcYwsoEstdjKPnateYV2wB9DkZkG8q5cZizFhB2lhj/tLz7YgpQEV0SjrxaoJtC19WBq7iI/UM033VED6zSSvZOxw3oTaFDZ35bNMHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Qu+v/lYh; arc=none smtp.client-ip=173.203.187.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Received: from smtp78.iad3a.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
	by smtp9.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id 9919A59AB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1712589941;
	bh=DGas92X4/ZpcXb5tSqkSEcJjOWyWwlBNT3zZo8zN0jc=;
	h=Date:Subject:To:From:From;
	b=Qu+v/lYhEfKwZ1oLPqGSzmVtAnawgyHZu/zH8EAR0nsJMmheP2OBhwnRF+uVnSHpA
	 o28HZoUpSkmAux5R8yy/xSTfhF4mjXTDJ04hI17vNmRlH/Si+zLWeXBbmlvr2pdhBz
	 UxvUid3aa+8gFDhjAvQGAMbrLC+JY1NkQPdDE+x8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3A43E25415;
	Mon,  8 Apr 2024 11:25:40 -0400 (EDT)
Message-ID: <e9d04d29-b4a4-4ebc-b04f-9e9877f4eeee@mev.co.uk>
Date: Mon, 8 Apr 2024 16:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: vmk80xx: fix incomplete endpoint checking
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
References: <20240407162646.27486-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240407162646.27486-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 0f6ca594-37db-496d-b7aa-0d846ec83d1a-1-2

On 07/04/2024 17:26, Nikita Zhandarovich wrote:
> While vmk80xx does have endpoint checking implemented, some things
> can fall through the cracks. Depending on the hardware model,
> URBs can have either bulk or interrupt type, and current version
> of vmk80xx_find_usb_endpoints() function does not take that fully
> into account. While this warning does not seem to be too harmful,
> at the very least it will crash systems with 'panic_on_warn' set on
> them.
> 
> Fix the issue found by Syzkaller [1] by somewhat simplifying the
> endpoint checking process with usb_find_common_endpoints() and
> ensuring that only expected endpoint types are present.
> 
> This patch has not been tested on real hardware.
> 
> [1] Syzkaller report:
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 0 PID: 781 at drivers/usb/core/urb.c:504 usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
> ...
> Call Trace:
>   <TASK>
>   usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
>   vmk80xx_reset_device drivers/comedi/drivers/vmk80xx.c:227 [inline]
>   vmk80xx_auto_attach+0xa1c/0x1a40 drivers/comedi/drivers/vmk80xx.c:818
>   comedi_auto_config+0x238/0x380 drivers/comedi/drivers.c:1067
>   usb_probe_interface+0x5cd/0xb00 drivers/usb/core/driver.c:399
> ...
> 
> Similar issue also found by Syzkaller:
> Link: https://syzkaller.appspot.com/bug?extid=5205eb2f17de3e01946e
> 
> Reported-and-tested-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
> Fixes: 49253d542cc0 ("staging: comedi: vmk80xx: factor out usb endpoint detection")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>   drivers/comedi/drivers/vmk80xx.c | 35 ++++++++++++-----------------------
>   1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
> index 4536ed43f65b..476885403c61 100644
> --- a/drivers/comedi/drivers/vmk80xx.c
> +++ b/drivers/comedi/drivers/vmk80xx.c
> @@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
>   	struct vmk80xx_private *devpriv = dev->private;
>   	struct usb_interface *intf = comedi_to_usb_interface(dev);
>   	struct usb_host_interface *iface_desc = intf->cur_altsetting;
> -	struct usb_endpoint_descriptor *ep_desc;
> -	int i;
> +	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
> +	int i, ret;

I get a "warning: unused variable 'i' [-Wunused-variable]" warning here.

>   
> -	if (iface_desc->desc.bNumEndpoints != 2)
> -		return -ENODEV;
> -
> -	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> -		ep_desc = &iface_desc->endpoint[i].desc;
> -
> -		if (usb_endpoint_is_int_in(ep_desc) ||
> -		    usb_endpoint_is_bulk_in(ep_desc)) {
> -			if (!devpriv->ep_rx)
> -				devpriv->ep_rx = ep_desc;
> -			continue;
> -		}
> -
> -		if (usb_endpoint_is_int_out(ep_desc) ||
> -		    usb_endpoint_is_bulk_out(ep_desc)) {
> -			if (!devpriv->ep_tx)
> -				devpriv->ep_tx = ep_desc;
> -			continue;
> -		}
> -	}
> +	if (devpriv->model == VMK8061_MODEL)
> +		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
> +						&ep_tx_desc, NULL, NULL);
> +	else
> +		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
> +						&ep_rx_desc, &ep_tx_desc);
>   
> -	if (!devpriv->ep_rx || !devpriv->ep_tx)
> +	if (ret)
>   		return -ENODEV;
>   
> +	devpriv->ep_rx = ep_rx_desc;
> +	devpriv->ep_tx = ep_tx_desc;
> +
>   	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
>   		return -EINVAL;
>   

I've tested it on a K8055/VM110 board and it still works OK. I don't 
have a K8061/VM140 to test it with, but it should be OK.

Feel free to add "Reviewed-by: Ian Abbott <abbotti@mev.co.uk>" after 
fixing the compiler warning.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


