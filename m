Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266E7ADD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjIYQbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:31:01 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF3BE;
        Mon, 25 Sep 2023 09:30:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D4A7C0007;
        Mon, 25 Sep 2023 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695659452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQ/JBsKhQfvBa0JgvkSbVZg5pomj/M1197UlLRWvkpc=;
        b=Cnp9yQ8kw8KZx+WPmqR9wTQzYRJBkOQd6iu+uB/RJtKhpcGYZZPJhJ9cywYNQYtoiX9Ztn
        UlKCdOMHC4jwgQNTKsqeWHDa+z53q9w//AvFJqvUZl9EWhruViK9FmDQ/hBDTlQ/0XEiaS
        s/vGHvCab+q0zIyW1ss0HhfaMunwrUnN5AXXyPFUmZ5rggImetWY1/W0rfkTb/6v2q0o4l
        f2rfCARRSMthwfAXNN4F8xJ8SFMmFICbhOE26lkgmmQw9mbZtX6tQ2wP4TOmoW++3TZZCZ
        7vbz1ecCTvAdF3jMJAiW8rMVElS+GGIz1sLNQOnMzu/8AkJ2bDQeciRnel7rwg==
Date:   Mon, 25 Sep 2023 18:30:49 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: tegra: Add support to display pin function
Message-ID: <20230925183049.10a40546@booty>
In-Reply-To: <20230714113547.15384-1-pshete@nvidia.com>
References: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
        <20230714113547.15384-1-pshete@nvidia.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prathamesh Shete,

On Fri, 14 Jul 2023 17:05:47 +0530
Prathamesh Shete <pshete@nvidia.com> wrote:

> The current function for a given pin is not displayed via the debugfs.
> Add support to display the current function that is set for each pin.
> 
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

While testing a Tegra20-based custom board I found a regression which
according to my bisecting appears starting with this patch (commit
d1cd5b51bc91 upstream).

The symptom is that i2c3 is not working anymore, the I2C lines being
always high. No other known issues at the moment.

The board is built around an Avionic Design Tamonten SOM:
arch/arm/boot/dts/nvidia/tegra20-tamonten.dtsi, which has in the
&state_default node:

    dtf {
        nvidia,pins = "dtf";
        nvidia,function = "i2c3";
    };

But on top of that the board dts has:
 
&state_default {
       dtf {
               nvidia,pins = "dtf";
               nvidia,function = "i2c3";
               nvidia,pull = <TEGRA_PIN_PULL_NONE>;
               nvidia,tristate = <TEGRA_PIN_DISABLE>;
       };
};

> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index 4547cf66d03b..cb1d67239cd0 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -96,6 +96,7 @@ static const struct cfg_param {
>  	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
>  	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
>  	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
> +	{"nvidia,function",		TEGRA_PINCONF_PARAM_FUNCTION},

FYI, I reduced your patch to only this line plus the one in the
pinctrl-tegra.h and the problem appears as well.

This is all the info I have at the moment. Can you provide more info on
what could be going on or how to investigate?

I am available to share more info as needed.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
