Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D71761D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGYPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjGYPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7353C1FFD;
        Tue, 25 Jul 2023 08:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E66DA617AC;
        Tue, 25 Jul 2023 15:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B9AC433C8;
        Tue, 25 Jul 2023 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690299246;
        bh=rpH154zrASptkkUj6Sk6ZcbARrBcY532COfB6r+zRUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqTJqQ1+tcHDfGRxPck404mYwMV+VwMly8u0XP5LXA6Ydfs3ZhCwWa3fxPNL96Kw9
         VyfvEx+sRsZmGKW+vtU8A/9FQ2p3ueTRUc+ALZHgk1aM6NUA7+4o3q9zfEAjm2qn0q
         z//Vj8/tWd1Fmy/X91HjdSUa3Q0ihyYdUsHhDlBc=
Date:   Tue, 25 Jul 2023 17:34:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: common: usb-conn-gpio: Prevent bailing out if initial role
 is none
Message-ID: <2023072517-revocable-squiggly-de1c@gregkh>
References: <1688638258-23806-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688638258-23806-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:40:58PM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, add a new flag initial_det in usb_conn_info,
> which is used to prevent bailing out during init detection.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/common/usb-conn-gpio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index 766005d..46290ff 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -42,6 +42,7 @@ struct usb_conn_info {
>  
>  	struct power_supply_desc desc;
>  	struct power_supply *charger;
> +	bool initial_det;

What does "initial_det" mean?  Please document this better.

>  };
>  
>  /*
> @@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
>  	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
>  		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
>  
> -	if (info->last_role == role) {
> +	if (!info->initial_det && info->last_role == role) {
>  		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
>  		return;
>  	}
>  
> +	info->initial_det = false;
> +
>  	if (info->last_role == USB_ROLE_HOST && info->vbus)
>  		regulator_disable(info->vbus);
>  
> @@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
>  	device_set_wakeup_capable(&pdev->dev, true);
>  
>  	/* Perform initial detection */
> +	info->initial_det = true;

What is protecting this from changing right after you test for it?

thanks,

greg k-h
