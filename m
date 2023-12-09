Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C980B47D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjLINAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjLIM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DAE1BC5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:59:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E554C433CB;
        Sat,  9 Dec 2023 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702126783;
        bh=GluywtkJ7Fw52cTbQzA8PDiEgSWS95tMk8Yrpah6YNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t51pg2IEgwrSLy/QGyoKbj/3Azggjn+GY2JQiMoejH/EGm/QXqlkfgFRnmklvKb/0
         lw0/zRUbhbA4NeVyGlu0vUXuSC03qKGUSOnj/V9Ahl83JUpJriQbCz7qr1Vthb+smx
         pgEItzSHimSObPzTIcHk4vRWj2oVqSu+3MLez/i3ZH9Xtp5CqBFrNSXCdXGjemES/B
         4abc6izJWT/LpNuAKON378aoh4vJkqOIpb6oEY6dQSUQKFzXVoQ4HpP6KTfmj8PKD1
         dnrSgQqPRlFed47SuNUV48F9eowHKO0yxwVQhpI9V+HXH4jRNbKQXbtsdxaLWs2HGt
         gbgkAFrmceH7A==
Date:   Sat, 9 Dec 2023 13:59:37 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     gregory.clement@bootlin.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, cyuval@marvell.com
Subject: Re: [PATCH v2 1/1] i2c: busses: i2c-mv64xxx: fix arb-loss i2c lock
Message-ID: <20231209125937.m3cfil5z4eheygcc@zenone.zhora.eu>
References: <20231207165027.2628302-1-enachman@marvell.com>
 <20231207165027.2628302-2-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207165027.2628302-2-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elad,

On Thu, Dec 07, 2023 at 06:50:27PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Some i2c slaves, mainly SFPs, might cause the bus to lose arbitration
> while slave is in the middle of responding.
> This means that the i2c slave has not finished the transmission, but
> the master has already finished toggling the clock, probably due to
> the slave missing some of the master's clocks.
> This was seen with Ubiquity SFP module.
> This is typically caused by slaves which do not adhere completely
> to the i2c standard.
> 
> The solution is to change the I2C mode from mpps to gpios, and toggle
> the i2c_scl gpio to emulate bus clock toggling, so slave will finish
> its transmission, driven by the manual clock toggling, and will release
> the i2c bus.

Thanks for the explanation.

[...]

> @@ -409,6 +424,56 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  			drv_data->reg_base + drv_data->reg_offsets.control);
>  		break;
>  
> +	case MV64XXX_I2C_ACTION_UNLOCK_BUS:
> +		if (!drv_data->soft_reset)
> +			break;
> +
> +		pc = devm_pinctrl_get(drv_data->adapter.dev.parent);

Why don't you get this in the probe? Besides where are you
"releasing" it?

> +		if (IS_ERR(pc)) {
> +			dev_err(&drv_data->adapter.dev,
> +				"failed to get pinctrl for bus unlock!\n");
> +			break;
> +		}
> +
> +		/* Change i2c MPPs state to act as GPIOs: */
> +		if (pinctrl_select_state(pc, drv_data->i2c_gpio_state) >= 0) {
> +			if (!ret) {

yeah... this was already already pointed out, I think you can
remove it.

> +				/*
> +				 * Toggle i2c scl (serial clock) 10 times.
> +				 * 10 clocks are enough to transfer a full
> +				 * byte plus extra as seen from tests with
> +				 * Ubiquity SFP module causing the issue.
> +				 * This allows the slave that occupies
> +				 * the bus to transmit its remaining data,
> +				 * so it can release the i2c bus:
> +				 */
> +				for (i = 0; i < 10; i++) {
> +					gpio_set_value(drv_data->scl_gpio, 1);
> +					udelay(100);

why do you want to use the atomic sleeps? Isn't uslee_range()
good for this case?

> +					gpio_set_value(drv_data->scl_gpio, 0);
> +				};
> +			}
> +
> +			/* restore i2c pin state to MPPs: */
> +			pinctrl_select_state(pc, drv_data->i2c_mpp_state);
> +		}
> +
> +		/*
> +		 * Trigger controller soft reset
> +		 * This register is write only, with none of the bits defined.
> +		 * So any value will do.
> +		 * 0x1 just seems more intuitive than 0x0 ...
> +		 */

Thanks!

> +		writel(0x1, drv_data->reg_base + drv_data->reg_offsets.soft_reset);
> +		/* wait for i2c controller to complete reset: */
> +		udelay(100);
> +		/*
> +		 * need to proceed to the data stop condition generation clause.
> +		 * This is needed after clock toggling to put the i2c slave
> +		 * in the correct state.
> +		 */

Thanks for the comment!

/need/Need/ for consistency.

Thanks,
Andi
