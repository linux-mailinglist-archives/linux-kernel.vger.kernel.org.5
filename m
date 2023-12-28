Return-Path: <linux-kernel+bounces-12867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77681FB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A3A1F24514
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FD10A00;
	Thu, 28 Dec 2023 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="uJgMq1LK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850E1095F;
	Thu, 28 Dec 2023 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1703800801; bh=jRxI4sUcGXVzqRs0DmQVhY8OELVqC2WR+H20U6gi5PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uJgMq1LKFLUr5e7mCnCYPlG2CoGCPj6cY9l1P5tphocAHEn7ugK4NKErplKTJUX7w
	 1TFJ2pZhvwEcHnnRl2IfCujQ8OU22Dqf2NhZYBQZN7DLv5jamw42q2fxnAaWNpqcZ3
	 TjZGWQuYqVYXgX5SoOuuSF3ywIEXx6YODQcSCNjQ=
From: Luca Weiss <luca@z3ntu.xyz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>
Cc: Richard Acayan <mailingradian@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject:
 Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror detachment
Date: Thu, 28 Dec 2023 22:59:59 +0100
Message-ID: <4713072.LvFx2qVVIh@z3ntu.xyz>
In-Reply-To: <20231218164532.411125-2-mailingradian@gmail.com>
References: <20231218164532.411125-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 18. Dezember 2023 17:45:33 CET Richard Acayan wrote:
> In 6.7-rc1, there was a netif_device_detach call added to the
> gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> the netif device and suppresses pings (ICMP messages) and TCP connection
> requests from the connected host. If userspace temporarily disconnects
> the gadget, such as by temporarily removing configuration in the gadget
> configfs interface, network activity should continue to be processed
> when the gadget is re-connected. Mirror the netif_device_detach call
> with a netif_device_attach call in gether_connect to fix re-connecting
> gadgets.

(+Cc Thorsten Leemhuis)

This appears to fix the regression on a 6.7-rc5-based build for
qcom-msm8974pro-fairphone-fp2, that the NCM network gadget doesn't work.
I've also heard reports from qcom-sdm845 and a PXA1908-based phone (if
I see this correctly) about issues on 6.7.

In postmarketOS on the device side the usb0 interface doesn't get the IP
address assigned correctly it seems, but it seems to behave a bit
inconsistently - but always broken.

Anyways, with this patch everything looks good again. I hope this makes
it for 6.7 final still.

Tested-by: Luca Weiss <luca@z3ntu.xyz>


> 
> Link: https://gitlab.com/postmarketOS/pmaports/-/tree/6002e51b7090aeeb42947e0ca7ec22278d7227d0/main/postmarketos-base-ui/rootfs-usr-lib-NetworkManager-dispatcher.d-50-tethering.sh
> Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 9d1c40c152d8..3c5a6f6ac341 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -1163,6 +1163,8 @@ struct net_device *gether_connect(struct gether *link)
> if (netif_running(dev->net))
>  			eth_start(dev, GFP_ATOMIC);
> 
> +		netif_device_attach(dev->net);
> +
>  	/* on error, disable any endpoints  */
>  	} else {
>  		(void) usb_ep_disable(link->out_ep);





