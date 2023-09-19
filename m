Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3E7A5DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjISJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjISJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:25:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2BDA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:25:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8683C433C8;
        Tue, 19 Sep 2023 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695115516;
        bh=wOd+SarwGP4T3vpwPLPNeCYjoyb6XTJraOKvPadONUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v81CP53hmUlxPIGQp7N0Zh09cVBZOoiEWJmNyv6UfoIwEyGMm0zAJfOPS4pXwFbrc
         qfzeh7VWTHmFJtwUcneD7Ghs7Fqp8zavFWUhX6gqEAY8hprxSVmDUCmaQh0KWTo5vZ
         lNv0ODY+wBcyW9SQAf2aC12y3g/PysmHOhsOft98=
Date:   Tue, 19 Sep 2023 11:25:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb:typec:tcpm:support double Rp to Vbus cable as sink
Message-ID: <2023091900-dilation-bully-c56b@gregkh>
References: <20230919090632.42517-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919090632.42517-1-michael@allwinnertech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:06:32PM +0800, Michael Wu wrote:
> The USB Type-C Cable and Connector Specification defines the wire
> connections for the USB Type-C to USB 2.0 Standard-A cable assembly
> (Release 2.2, Chapter 3.5.2).
> The Notes says that Pin A5 (CC) of the USB Type-C plug shall be connected
> to Vbus through a resister Rp.
> However, there is a large amount of such double Rp connected to Vbus
> non-standard cables which produced by UGREEN circulating on the market, and
> it can affects the normal operations of the state machine easily,
> especially to CC1 and CC2 be pulled up at the same time.
> In fact, we can regard those cables as sink to avoid abnormal state.
> 
> Message as follow:
> [   58.900212] VBUS on
> [   59.265433] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
> [   62.623308] CC1: 3 -> 0, CC2: 3 -> 0 [state TOGGLING, polarity 0, disconnected]
> [   62.625006] VBUS off
> [   62.625012] VBUS VSAFE0V
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d962f67c95ae6..6e843c511b856 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -517,9 +517,9 @@ static const char * const pd_rev[] = {
>  	((cc) == TYPEC_CC_RP_DEF || (cc) == TYPEC_CC_RP_1_5 || \
>  	 (cc) == TYPEC_CC_RP_3_0)
>  
> +/* As long as cc is pulled up, we can consider it as sink. */
>  #define tcpm_port_is_sink(port) \
> -	((tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) || \
> -	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
> +	(tcpm_cc_is_sink((port)->cc1) || tcpm_cc_is_sink((port)->cc2))
>  
>  #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
>  #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)
> -- 
> 2.29.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
