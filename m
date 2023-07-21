Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118DF75BF54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGUHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGUHHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F7273E;
        Fri, 21 Jul 2023 00:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF59B61335;
        Fri, 21 Jul 2023 07:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2ACC433C7;
        Fri, 21 Jul 2023 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689923234;
        bh=eCotvYZ2SM3G2SSTM9Brh//9hAvs6Vg3USkUmu4uk8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPpm7X7z5vkJU2m7cWaN7JniQK1QDrOhAp5FgYgx0h6NxJ7NJtKYUqkNw3t1VHH0e
         UXDPEwwX1fYaGMMdddiF0PQ8Zpp17Os5Ay7wORN3yuWNZhiyWtvh36GutcZ4/tEhJ4
         3E7edBHQx7fStUbY5hruttkGTDrzYFdGJzkEthbg=
Date:   Fri, 21 Jul 2023 09:06:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <2023072109-fidelity-modular-4074@gregkh>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
 <2023072144-splurge-debate-e681@gregkh>
 <20230721061523.GP5194@atomide.com>
 <20230721065701.GQ5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721065701.GQ5194@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:57:01AM +0300, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [230721 06:19]:
> > Looks like linux-serial not getting added is caused by MAINTAINERS
> > not listing serial_base_bus.c, serial_ctrl.c and serial_port.c. This
> > causes get_maintainer.pl to not show linux-serial for a patch touching
> > serial_base_bus.c.. And this will causes git send-email to not pick up
> > linux-serial.. I'll send a patch for MAINTAINERS file too.
> 
> And the TTY LAYER is missing the list entries.. Does something like below
> make sense to you guys to include lkml and linux-serial for TTY LAYER?
> 
> Regards,
> 
> Tony
> 
> 8< ---------------------
> diff --git a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21628,11 +21628,17 @@ F:	Documentation/translations/zh_TW/
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-serial@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>  F:	Documentation/driver-api/serial/
>  F:	drivers/tty/
> +F:	drivers/tty/serial/serial_base.h
> +F:	drivers/tty/serial/serial_base_bus.c
>  F:	drivers/tty/serial/serial_core.c
> +F:	drivers/tty/serial/serial_ctrl.c
> +F:	drivers/tty/serial/serial_port.c
>  F:	include/linux/selection.h
>  F:	include/linux/serial.h
>  F:	include/linux/serial_core.h
> -- 
> 2.41.0

Seems sane to me, I've always wondered why some serial patches didn't
end up on the linux-serial list.

thanks,

greg k-h
