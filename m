Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1675EB07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGXFuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGXFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D57180;
        Sun, 23 Jul 2023 22:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12D760F24;
        Mon, 24 Jul 2023 05:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDF1C433C7;
        Mon, 24 Jul 2023 05:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690177812;
        bh=bFLNepPhPHCswQ9ft0pcj3E1XJXFCkjGVMeXp3+zrvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmwbpFPGParIZG7W1TUUE0yYYPD2FBLWu3ib2mFJqFva1McRElxdJv4LGNGcZf3/+
         YhS0qaQ3Fk7I10AJK0ox0MKRkUYab2sdAGsLZ4zyDj+YFl8VsUHszf1jnmGx1XBavt
         sL38/5lGbOXFVPHwuCIXa5zjFasgyrfUcpH4iNco=
Date:   Mon, 24 Jul 2023 07:50:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 1/5] usb: phy: add usb phy notify port status API
Message-ID: <2023072452-jasmine-palm-7b73@gregkh>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707064725.25291-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 02:47:00PM +0800, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of phy
> driver when usb port status change.
> 
> The Realtek phy driver is designed to dynamically adjust disconnection
> level and calibrate phy parameters. When the device connected bit changes
> and when the disconnected bit changes, do port status change notification:
> 
> Check if portstatus is USB_PORT_STAT_CONNECTION and portchange is
> USB_PORT_STAT_C_CONNECTION.
> 1. The device is connected, the driver lowers the disconnection level and
>    calibrates the phy parameters.
> 2. The device disconnects, the driver increases the disconnect level and
>    calibrates the phy parameters.
> 
> When controller to notify connect that device is already ready. If we
> adjust the disconnection level in notify_connect, the disconnect may have
> been triggered at this stage. So we need to change that as early as
> possible. Therefore, we add an api to notify phy the port status changes.

How do you know that the disconnect will not have already been triggered
at this point, when the status changes?


> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v6 to v7 change:
>     No change
> v5 to v6 change:
>     No change
> v4 to v5 change:
>     No change
> v3 to v4 change:
>     Fix the warning for checkpatch with strict.
> v2 to v3 change:
>     Add more comments about the reason for adding this api
> v1 to v2 change:
>     No change
> ---
>  drivers/usb/core/hub.c  | 13 +++++++++++++
>  include/linux/usb/phy.h | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a739403a9e45..8433ff89dea6 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -614,6 +614,19 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
>  		ret = 0;
>  	}
>  	mutex_unlock(&hub->status_mutex);
> +
> +	if (!ret) {
> +		struct usb_device *hdev = hub->hdev;
> +
> +		if (hdev && !hdev->parent) {

Why the check for no parent?  Please document that here in a comment.

> +			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
> +
> +			if (hcd->usb_phy)
> +				usb_phy_notify_port_status(hcd->usb_phy,
> +							   port1 - 1, *status, *change);
> +		}
> +	}
> +

This is safe to notify with the hub mutex unlocked?  Again, a comment
would be helpful to future people explaining why that is so.

thanks,

greg k-h
