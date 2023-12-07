Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7D80861C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjLGKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:02:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF253A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:02:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7E0C433C8;
        Thu,  7 Dec 2023 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701943368;
        bh=SPYAWlnL7TYvvD5fILwvuEjH1F0EdpQ2gn+SMCdXalU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGbWkqWpE69/KJTLtC9uM/RqiNerYeh5JRHhvMQxGLKrVcgHs+Y1zw+vFVQ9PkZce
         11S9dN4QYOZ6GJPXmQz8QV21+ujNRkIa0TTugszsraf4/zenmpWN536nrfxuUpfUl2
         bSPBfKG/ulSlq2nXvBrk65Pw8961XtNzLOTLXlb0=
Date:   Thu, 7 Dec 2023 11:02:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 1/4] phy: core: add notify_connect and
 notify_disconnect callback
Message-ID: <2023120750-giggle-annotate-dc4f@gregkh>
References: <20231207074022.14116-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207074022.14116-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:38:04PM +0800, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of phy
> driver when usb connection/disconnection change.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> RESEND:
>     Because there is no extcon device provided in the USB framework to
>     notify connect and disconnect.
>     Therefore, I added the notification connection/disconnection based
>     on the generic phy. So I no use the EXTCON framework for notifying
>     connect/disconnect.
> v2 to v3:
>     No change
> v1 to v2:
>     No change
> ---
>  drivers/phy/phy-core.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h | 18 ++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 96a0b1e111f3..a84ad4896b7f 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -489,6 +489,53 @@ int phy_calibrate(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(phy_calibrate);
>  
> +/**
> + * phy_notify_connect() - phy connect notify
> + * @phy: the phy returned by phy_get()
> + * @port: the port index for connect
> + *
> + * If phy need the get connection status, the callback can be used.
> + * Returns: %0 if successful, a negative error code otherwise
> + */
> +int phy_notify_connect(struct phy *phy, int port)
> +{
> +	int ret;
> +
> +	if (!phy || !phy->ops->connect)
> +		return 0;

How can phy be null?

And it is not successful if connect is not valid, so why not return an
error there?

> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->connect(phy, port);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_notify_connect);
> +
> +/**
> + * phy_notify_disconnect() - phy disconnect notify
> + * @phy: the phy returned by phy_get()
> + * @port: the port index for disconnect
> + *
> + * If phy need the get disconnection status, the callback can be used.
> + *
> + * Returns: %0 if successful, a negative error code otherwise
> + */
> +int phy_notify_disconnect(struct phy *phy, int port)
> +{
> +	int ret;
> +
> +	if (!phy || !phy->ops->disconnect)
> +		return 0;

Same as above.

> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->disconnect(phy, port);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_notify_disconnect);
> +
>  /**
>   * phy_configure() - Changes the phy parameters
>   * @phy: the phy returned by phy_get()
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index f6d607ef0e80..cf98cb29ddaa 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -122,6 +122,8 @@ struct phy_ops {
>  			    union phy_configure_opts *opts);
>  	int	(*reset)(struct phy *phy);
>  	int	(*calibrate)(struct phy *phy);
> +	int	(*connect)(struct phy *phy, int port);
> +	int	(*disconnect)(struct phy *phy, int port);

You forgot to document these and would have a warning from the
documentation build if this was applied :(


>  	void	(*release)(struct phy *phy);
>  	struct module *owner;
>  };
> @@ -243,6 +245,8 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
>  }
>  int phy_reset(struct phy *phy);
>  int phy_calibrate(struct phy *phy);
> +int phy_notify_connect(struct phy *phy, int port);
> +int phy_notify_disconnect(struct phy *phy, int port);
>  static inline int phy_get_bus_width(struct phy *phy)
>  {
>  	return phy->attrs.bus_width;
> @@ -396,6 +400,20 @@ static inline int phy_calibrate(struct phy *phy)
>  	return -ENOSYS;
>  }
>  
> +static inline int phy_notify_connect(struct phy *phy, int index)
> +{
> +	if (!phy)
> +		return 0;

Why check this?

> +	return -ENOSYS;
> +}
> +
> +static inline int phy_notify_disconnect(struct phy *phy, int index)
> +{
> +	if (!phy)
> +		return 0;

Again, why check this?

thanks,

greg k-h
