Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3067D8F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbjJ0HFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjJ0HFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:05:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806691B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21F7C433C8;
        Fri, 27 Oct 2023 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698390345;
        bh=MzPrDunkEPsaGBTgiGu7Bm+iAFgE5W6/xpGxbuuL6/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydh0IlYxdR3khNV9W5B9wnf9rG+2rXnMiVu473r4HAejrZqzf/xifjx25kJt3XHCg
         otkmYjoy55cVSSgDXXb9E8okiTOqo8OEzfIkOt/J65nCf687LQ2f6qyAtJX2JJ9Ll6
         lTy6151B3PN7wc8V5dMf4+g7qAA1H4E9Gc7NDoLU=
Date:   Fri, 27 Oct 2023 09:05:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Cc:     linux-kernel@vger.kernel.org, lee@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1 3/3] drivers: misc: Add support for TPS65224 pfsm
 driver
Message-ID: <2023102749-submerge-aptitude-f05b@gregkh>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
 <20231026133226.290040-4-sirisha.gairuboina@Ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026133226.290040-4-sirisha.gairuboina@Ltts.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:02:26PM +0530, Gairuboina Sirisha wrote:
> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> 
> Added support for pmic nvm set FSM_I2C_TRIGGER functions driver,
> state control driver, Makefile and Kconfig
> 
> Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> ---
>  drivers/misc/Kconfig               |  12 ++
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/tps65224-pfsm.c       | 290 +++++++++++++++++++++++++++++
>  include/uapi/linux/tps65224_pfsm.h |  36 ++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 drivers/misc/tps65224-pfsm.c
>  create mode 100644 include/uapi/linux/tps65224_pfsm.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index cadd4a820c03..6d12404b0fa6 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -562,6 +562,18 @@ config TPS6594_PFSM
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-pfsm.
>  
> +config TPS65224_PFSM
> +		tristate "TI TPS65224 Pre-configurable Finite State Machine support"
> +		depends on MFD_TPS65224
> +		default MFD_TPS65224
> +		help
> +		  Support PFSM (Pre-configurable Finite State Machine) on TPS65224 PMIC devices.
> +		  These devices integrate a finite state machine engine, which manages the state
> +		  of the device during operating state transition.

Please wrap your lines a bit better, like the rest of the file has.

> --- /dev/null
> +++ b/drivers/misc/tps65224-pfsm.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224 PMIC
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/

Again, 2015?

> +static long tps65224_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +	struct tps65224_pfsm *pfsm = TPS65224_FILE_TO_PFSM(f);
> +	struct pmic_state_opt state_opt;
> +	void __user *argp = (void __user *)arg;
> +	int ret = -ENOIOCTLCMD;
> +
> +	switch (cmd) {
> +	case PMIC_GOTO_STANDBY:
> +		/* Force trigger */
> +		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
> +					TPS65224_BIT_TRIGGER_I2C(0), TPS65224_BIT_TRIGGER_I2C(0));
> +		break;
> +	case PMIC_UPDATE_PGM:
> +		/* Force trigger */
> +		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
> +					TPS65224_BIT_TRIGGER_I2C(3), TPS65224_BIT_TRIGGER_I2C(3));
> +		break;
> +	case PMIC_SET_ACTIVE_STATE:
> +		/* Modify NSLEEP1-2 bits */
> +		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> +					  TPS65224_BIT_NSLEEP1B | TPS65224_BIT_NSLEEP2B);
> +		break;
> +	case PMIC_SET_MCU_ONLY_STATE:
> +		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
> +			return -EFAULT;
> +
> +		/* Configure retention triggers */
> +		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
> +							  state_opt.ddr_retention);

No error checking of userspace values at all?  That's brave.

> +		if (ret)
> +			return ret;
> +
> +		/* Modify NSLEEP1-2 bits */
> +		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> +					TPS65224_BIT_NSLEEP1B);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> +					  TPS65224_BIT_NSLEEP2B);
> +		break;
> +	case PMIC_SET_RETENTION_STATE:
> +		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
> +			return -EFAULT;

Again, no checking of valid values?

> +
> +		/* Configure wake-up destination */
> +		if (state_opt.mcu_only_startup_dest)
> +			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
> +						TPS65224_BIT_STARTUP_INT,
> +						TPS65224_STARTUP_DEST_MCU_ONLY);
> +		else
> +			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
> +						TPS65224_BIT_STARTUP_INT,
> +						TPS65224_STARTUP_DEST_ACTIVE);
> +		if (ret)
> +			return ret;
> +
> +		/* Configure retention triggers */
> +		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
> +							  state_opt.ddr_retention);
> +		if (ret)
> +			return ret;
> +
> +		/* Modify NSLEEP1-2 bits */
> +		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> +					TPS65224_BIT_NSLEEP2B);
> +		break;
> +	}
> +
> +	return ret;
> +}

Where is the example userspace code that uses these custom ioctls?
Where are they documented?  How do we know what they should be doing?

thanks,

greg k-h
