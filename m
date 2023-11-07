Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF867E3B46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKGLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjKGLpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:45:46 -0500
Received: from esa1.ltts.com (unknown [118.185.121.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F31B116
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:45:41 -0800 (PST)
IronPort-SDR: kbvIDjD1ZltXpxIQrYkXhIVp8lVht0qCYF9vX1sR74w+I89ipohTod+My6pQptGFzGguOGrskm
 jOp3y4Rb4M4w==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa1.ltts.com with ESMTP; 07 Nov 2023 17:15:39 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        sirisha.gairuboina@ltts.com
Subject: Re: [PATCH v1 3/3] drivers: misc: Add support for TPS65224 pfsm driver
Date:   Tue,  7 Nov 2023 17:14:10 +0530
Message-Id: <20231107114410.1056006-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102749-submerge-aptitude-f05b@gregkh>
References: <2023102749-submerge-aptitude-f05b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On Thu, Oct 26, 2023 at 07:02:26PM +0530, Gairuboina Sirisha wrote:
> > From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> >
> > Added support for pmic nvm set FSM_I2C_TRIGGER functions driver,
> > state control driver, Makefile and Kconfig
> >
> > Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> > ---
> >  drivers/misc/Kconfig               |  12 ++
> >  drivers/misc/Makefile              |   1 +
> >  drivers/misc/tps65224-pfsm.c       | 290 +++++++++++++++++++++++++++++
> >  include/uapi/linux/tps65224_pfsm.h |  36 ++++
> >  4 files changed, 339 insertions(+)
> >  create mode 100644 drivers/misc/tps65224-pfsm.c
> >  create mode 100644 include/uapi/linux/tps65224_pfsm.h
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index cadd4a820c03..6d12404b0fa6 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -562,6 +562,18 @@ config TPS6594_PFSM
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tps6594-pfsm.
> >
> > +config TPS65224_PFSM
> > +		tristate "TI TPS65224 Pre-configurable Finite State Machine support"
> > +		depends on MFD_TPS65224
> > +		default MFD_TPS65224
> > +		help
> > +		  Support PFSM (Pre-configurable Finite State Machine) on TPS65224 PMIC devices.
> > +		  These devices integrate a finite state machine engine, which manages the state
> > +		  of the device during operating state transition.
>
> Please wrap your lines a bit better, like the rest of the file has.
>
> > --- /dev/null
> > +++ b/drivers/misc/tps65224-pfsm.c
> > @@ -0,0 +1,290 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224 PMIC
> > + *
> > + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
>
> Again, 2015?

Will correct style and copyright issues in the next patch version V2.

> > +static long tps65224_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct tps65224_pfsm *pfsm = TPS65224_FILE_TO_PFSM(f);
> > +	struct pmic_state_opt state_opt;
> > +	void __user *argp = (void __user *)arg;
> > +	int ret = -ENOIOCTLCMD;
> > +
> > +	switch (cmd) {
> > +	case PMIC_GOTO_STANDBY:
> > +		/* Force trigger */
> > +		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
> > +					TPS65224_BIT_TRIGGER_I2C(0), TPS65224_BIT_TRIGGER_I2C(0));
> > +		break;
> > +	case PMIC_UPDATE_PGM:
> > +		/* Force trigger */
> > +		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
> > +					TPS65224_BIT_TRIGGER_I2C(3), TPS65224_BIT_TRIGGER_I2C(3));
> > +		break;
> > +	case PMIC_SET_ACTIVE_STATE:
> > +		/* Modify NSLEEP1-2 bits */
> > +		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> > +					  TPS65224_BIT_NSLEEP1B | TPS65224_BIT_NSLEEP2B);
> > +		break;
> > +	case PMIC_SET_MCU_ONLY_STATE:
> > +		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
> > +			return -EFAULT;
> > +
> > +		/* Configure retention triggers */
> > +		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
> > +							  state_opt.ddr_retention);
>
> No error checking of userspace values at all?  That's brave.
>
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Modify NSLEEP1-2 bits */
> > +		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> > +					TPS65224_BIT_NSLEEP1B);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> > +					  TPS65224_BIT_NSLEEP2B);
> > +		break;
> > +	case PMIC_SET_RETENTION_STATE:
> > +		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
> > +			return -EFAULT;
> >
> > Again, no checking of valid values?

Thanks for your feedback. Will validate the user space buffer and submit in V2.

> > +
> > +		/* Configure wake-up destination */
> > +		if (state_opt.mcu_only_startup_dest)
> > +			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
> > +						TPS65224_BIT_STARTUP_INT,
> > +						TPS65224_STARTUP_DEST_MCU_ONLY);
> > +		else
> > +			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
> > +						TPS65224_BIT_STARTUP_INT,
> > +						TPS65224_STARTUP_DEST_ACTIVE);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Configure retention triggers */
> > +		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
> > +							  state_opt.ddr_retention);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Modify NSLEEP1-2 bits */
> > +		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
> > +					TPS65224_BIT_NSLEEP2B);
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
>
> Where is the example userspace code that uses these custom ioctls?
> Where are they documented?  How do we know what they should be doing?

We have tested the PFSM driver using sample code available in sampes/pfsm/pfsm-wakeup.c with minimal change on Number of PMICs.

Thanks & Regards,
Sirisha G.
