Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8280138F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379520AbjLAT2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:28:41 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0BBA810DA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:28:46 -0800 (PST)
Received: (qmail 298503 invoked by uid 1000); 1 Dec 2023 14:28:46 -0500
Date:   Fri, 1 Dec 2023 14:28:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: core: Don't force USB generic_subclass
 drivers to define probe()
Message-ID: <59c5c190-234c-42d4-9a44-eadba4b717f0@rowland.harvard.edu>
References: <20231201183113.343256-1-dianders@chromium.org>
 <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:29:50AM -0800, Douglas Anderson wrote:
> There's no real reason that subclassed USB drivers _need_ to define
> probe() since they might want to subclass for some other reason. Make
> it optional to define probe() if we're a generic_subclass.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> Changes in v2:
> - ("Don't force USB generic_subclass drivers to define ...") new for v2.
> 
>  drivers/usb/core/driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f58a0299fb3b..1dc0c0413043 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -290,7 +290,10 @@ static int usb_probe_device(struct device *dev)
>  	 * specialised device drivers prior to setting the
>  	 * use_generic_driver bit.
>  	 */
> -	error = udriver->probe(udev);
> +	if (udriver->probe)
> +		error = udriver->probe(udev);
> +	else if (!udriver->generic_subclass)
> +		error = -EINVAL;
>  	if (error == -ENODEV && udriver != &usb_generic_driver &&
>  	    (udriver->id_table || udriver->match)) {
>  		udev->use_generic_driver = 1;
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
