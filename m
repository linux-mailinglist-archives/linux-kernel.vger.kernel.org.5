Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D47E0F8E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjKDNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjKDNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C3194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:05:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A68C433C8;
        Sat,  4 Nov 2023 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699103109;
        bh=NS3d8mZHUuCBEyhTLAwhKBb5EQ4I3qlp0HRGJG3BCMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LolMM84ex/eh6rDO21O8YysdjwP65FGQ3BR60t8tWwjy521i5pNkRI8++1UTfjTde
         pfSAh6RPHvXeVeKsVFBIiczIhto0BGvPdb32MI3MZ66eiDnf6f5C88KV60SiZA+Dq6
         H1EqAmjaIO9xYNGU8grrfLTCbzJdHw0qBnsduxKg=
Date:   Sat, 4 Nov 2023 14:05:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <2023110407-unselect-uptight-b96d@gregkh>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 12:29:30PM +0100, Thomas Weiﬂschuh wrote:
> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> The corresponding patch to qemu has also been submitted[0].
> General discussions about the feature should happen on the other thread.
> 
> [0] https://lore.kernel.org/qemu-devel/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de/
> ---
>  drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
>  include/uapi/misc/pvpanic.h    |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 305b367e0ce3..d7d807f5e47a 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/panic_notifier.h>
> +#include <linux/reboot.h>
>  #include <linux/types.h>
>  #include <linux/cdev.h>
>  #include <linux/list.h>
> @@ -74,6 +75,13 @@ static struct notifier_block pvpanic_panic_nb = {
>  	.priority = INT_MAX,
>  };
>  
> +static int pvpanic_sys_off(struct sys_off_data *data)
> +{
> +	pvpanic_send_event(PVPANIC_SHUTDOWN);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static void pvpanic_remove(void *param)
>  {
>  	struct pvpanic_instance *pi_cur, *pi_next;
> @@ -152,7 +160,7 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
>  		return -ENOMEM;
>  
>  	pi->base = base;
> -	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN;
>  
>  	/* initlize capability by RDPT */
>  	pi->capability &= ioread8(base);
> @@ -168,12 +176,18 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
>  }
>  EXPORT_SYMBOL_GPL(devm_pvpanic_probe);
>  
> +static struct sys_off_handler *sys_off_handler;
> +
>  static int pvpanic_init(void)
>  {
>  	INIT_LIST_HEAD(&pvpanic_list);
>  	spin_lock_init(&pvpanic_lock);
>  
>  	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
> +	sys_off_handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
> +						   pvpanic_sys_off, NULL);
> +	if (IS_ERR(sys_off_handler))
> +		sys_off_handler = NULL;

Why are you allowing this to succeed?  Shouldn't you be returning the
error instead?

>  	return 0;
>  }
> @@ -182,6 +196,7 @@ module_init(pvpanic_init);
>  static void pvpanic_exit(void)
>  {
>  	atomic_notifier_chain_unregister(&panic_notifier_list, &pvpanic_panic_nb);
> -
> +	if (sys_off_handler)
> +		unregister_sys_off_handler(sys_off_handler);
>  }
>  module_exit(pvpanic_exit);
> diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
> index 54b7485390d3..82fc618bfbcf 100644
> --- a/include/uapi/misc/pvpanic.h
> +++ b/include/uapi/misc/pvpanic.h
> @@ -5,5 +5,6 @@
>  
>  #define PVPANIC_PANICKED	(1 << 0)
>  #define PVPANIC_CRASH_LOADED	(1 << 1)
> +#define PVPANIC_SHUTDOWN	(1 << 2)

Why are these in a uapi file?

And if they need to be here, why not use the proper BIT() macro for it?

thanks,

greg k-h
