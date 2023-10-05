Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C337BA3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjJEP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjJEP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3916158FB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:57:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC6DC4160E;
        Thu,  5 Oct 2023 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696496915;
        bh=DKlHct01eZZdgFFxoFSnHEvWjamH4HVMNYorMvqVhcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hl0nRPjTCgvdFsoN+K40ZjBXi7s0IGP49FjOYJUblKJzn2o2mixa+kCOtZsGQUnmh
         9LCPyBFwDazPYxVpByMCpGSndjCRgc2eks0Ssi/G/hL+/pETpx3iNIofV+7U4GfhvO
         TKvIS8e0xn6oPJzFpOWsU+8tcb1iqg1IEdQDtGhc=
Date:   Thu, 5 Oct 2023 11:08:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
Subject: Re: [PATCH v7 2/3] greybus: Add BeaglePlay Linux Driver
Message-ID: <2023100501-siesta-dictate-132e@gregkh>
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
 <20231004184639.462510-3-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004184639.462510-3-ayushdevel1325@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:16:37AM +0530, Ayush Singh wrote:
> Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.
> 
> The current greybus setup involves running SVC in a user-space
> application (GBridge) and using netlink to communicate with kernel
> space. GBridge itself uses wpanusb kernel driver, so the greybus messages
> travel from kernel space (gb_netlink) to user-space (GBridge) and then
> back to kernel space (wpanusb) before reaching CC1352.
> 
> This driver directly communicates with CC1352 (running SVC Zephyr
> application). Thus, it simplifies the complete greybus setup eliminating
> user-space GBridge.
> 
> This driver is responsible for the following:
> - Start SVC (CC1352) on driver load.
> - Send/Receive Greybus messages to/from CC1352 using HDLC over UART.
> - Print Logs from CC1352.
> - Stop SVC (CC1352) on driver load.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/greybus/Kconfig         |  10 +
>  drivers/greybus/Makefile        |   2 +
>  drivers/greybus/gb-beagleplay.c | 501 ++++++++++++++++++++++++++++++++
>  4 files changed, 514 insertions(+)
>  create mode 100644 drivers/greybus/gb-beagleplay.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5467669d7963..d87e30626a6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8974,6 +8974,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
>  L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> +F:	drivers/greybus/gb-beagleplay.c
>  
>  GREYBUS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> index 78ba3c3083d5..fd4f26d09c53 100644
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -17,6 +17,16 @@ menuconfig GREYBUS
>  
>  if GREYBUS
>  
> +config GREYBUS_BEAGLEPLAY
> +	tristate "Greybus BeaglePlay driver"
> +	depends on TTY

What you want to depend on here is serdev, not tty, right?  Or am I
mis-reading the code requirements?

thanks,

greg k-h
