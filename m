Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D36770F27
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHEJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522E1B9;
        Sat,  5 Aug 2023 02:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9157A60C2D;
        Sat,  5 Aug 2023 09:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70219C433C7;
        Sat,  5 Aug 2023 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691229590;
        bh=8pq7Mvx+TRA12e4vFW91N0Mh0e3g8VjFd8UdpQ7QWYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgcdIwDBvGLn+mxO03OE/JR0v6I0If8yACOK6+4PIJRIYFcsNzrrQV7h8UcP0LN/t
         0fCKoOsW8l/Rib2JcR9XUSn4+sBlNYLBX992RGl0Po7lx/75irYdRnuD8MLdbDchln
         T6xDlSfTCdOSODNTRc8zU7DeXqbVbTLw2w1oEmFk=
Date:   Sat, 5 Aug 2023 11:59:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: select CONFIG_USB_COMMON
Message-ID: <2023080514-mothball-chaps-2b42@gregkh>
References: <20230805095157.3459892-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805095157.3459892-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 11:51:53AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is possible to configure the typec drivers to be built-in while the
> actual USB host and device support is in loadable modules, but that now
> causes a link failure because the usb debugfs support is then not
> available to built-in code.
> 
> x86_64-linux-ld: drivers/usb/typec/mux/intel_pmc_mux.o: in function `pmc_usb_init':
> intel_pmc_mux.c:(.init.text+0x3): undefined reference to `usb_debug_root'
> 
> Select CONFIG_USB_COMMON to get it to build again, as we do for
> other drivers that require the core usb functionality.
> 
> Fixes: 0a453dc9f2602 ("usb: typec: intel_pmc_mux: Expose IOM port status to debugfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/typec/mux/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 784b9d8107e9b..65da61150ba78 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -29,6 +29,7 @@ config TYPEC_MUX_INTEL_PMC
>  	tristate "Intel PMC mux control"
>  	depends on ACPI
>  	depends on INTEL_SCU_IPC
> +	select USB_COMMON
>  	select USB_ROLE_SWITCH
>  	help
>  	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
> -- 
> 2.39.2
> 

I think this is already fixed by commit ef7c4d8a90c6 ("usb: typec: mux:
intel: Add dependency on USB_COMMON") in my tree and will be in the next
linux-next release on Monday.

thanks,

greg k-h
