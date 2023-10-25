Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9040C7D71B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJYQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjJYQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A921E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:28:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4FC433C7;
        Wed, 25 Oct 2023 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698251311;
        bh=Cq+VIWjTxwk9AIHSxO+EKxI0YiYlA7eqMW6ugBM7bbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dA6mwZfv1lv8yN0h/VACi3UUkqoITwAQlD88QYHkYhcLJagVy2How3uwju0lVBOtd
         s2c04ZEbd9PiuiyH51EtdlY/ibvi/oLPcABr8kUfYV//I4tQ92I/Su/bkz+VrpWQi4
         pe4BlmFUm57IoHWFdl64cGzZZQEiRbHGuYSJ+erTGvbSKFkgeVCjrMIXTbeFOPulAo
         ToyNag7vWJoQ3efNSJeXqbUrxNMpczuvDg7iotd159zo3ISF3b4VE3VCXHEhTPvFdK
         5rwAylcIXfGddIf5pgaDr0deSYkyb2gZtWQ6KDcBpGUrWHpI/NWjCTvWa/wZwPcCsD
         KHOkmoK8JPVaw==
Date:   Wed, 25 Oct 2023 17:28:24 +0100
From:   Simon Horman <horms@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 8/8] r8152: Block future register access if register
 access fails
Message-ID: <20231025162824.GK57304@kernel.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:06:59PM -0700, Douglas Anderson wrote:

...

> @@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
>  	return 0;
>  }
>  
> -static int rtl8152_probe(struct usb_interface *intf,
> -			 const struct usb_device_id *id)
> +static int rtl8152_probe_once(struct usb_interface *intf,
> +			      const struct usb_device_id *id, u8 version)
>  {
>  	struct usb_device *udev = interface_to_usbdev(intf);
>  	struct r8152 *tp;
>  	struct net_device *netdev;
> -	u8 version;
>  	int ret;
>  
> -	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> -		return -ENODEV;
> -
> -	if (!rtl_check_vendor_ok(intf))
> -		return -ENODEV;
> -
> -	version = rtl8152_get_version(intf);
> -	if (version == RTL_VER_UNKNOWN)
> -		return -ENODEV;
> -
>  	usb_reset_device(udev);
>  	netdev = alloc_etherdev(sizeof(struct r8152));
>  	if (!netdev) {
> @@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *intf,
>  	else
>  		device_set_wakeup_enable(&udev->dev, false);
>  
> +	/* If we saw a control transfer error while probing then we may
> +	 * want to try probe() again. Consider this an error.
> +	 */
> +	if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> +		goto out2;

Sorry for being a bit slow here, but if this is an error condition,
sould ret be set to an error value?

As flagged by Smatch.

> +
> +	set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
>  	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
>  
>  	return 0;
>  
> +out2:
> +	unregister_netdev(netdev);
> +
>  out1:
>  	tasklet_kill(&tp->tx_tl);
>  	cancel_delayed_work_sync(&tp->hw_phy_work);

...
