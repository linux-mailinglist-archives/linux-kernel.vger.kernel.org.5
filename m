Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC87DCC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbjJaLnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbjJaLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:43:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8FE91
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:43:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EBC433C8;
        Tue, 31 Oct 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752625;
        bh=p99OjcIysNRLbcUAAt0Zd2DW319yL12hpVvXPeYTCEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpCNNSautJ24/ecDIFfU2AfJeOWlA2quBKOz5W/upvwkmLrTB+46d8wUholuzea6d
         kvgi3Wecqp6N531leydrZcQqLM8X9hFMNqz2G9DgJafcsDp6Ie8nAaG7Rc6H0d1Acg
         SuVfd7E7biFzd9qG62zDLlIg4HWaEnMgKweNlUbmctP4PDdJn90gJIgrubI6nmHWwZ
         AXPZ8Vyb5NuQXqC+Ay9tEndOfH5+LUCjx1QmdOmCp9TuXLXi9ZI5F7DPapv4skzmXg
         wpygSA1ZbvLY4uNokkqP9aEw4I11kZU0H2z5j1VahO3Re1dtuJXTJz6+TEYYCVExGo
         e2R44cFP8Fkjw==
Date:   Tue, 31 Oct 2023 12:43:39 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     mike.isely@cobaltdigital.com
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine
 after a timeout
Message-ID: <20231031114339.nutx2q2vtwbaaw6h@zenone.zhora.eu>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
 <20231030162114.3603829-2-mike.isely@cobaltdigital.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030162114.3603829-2-mike.isely@cobaltdigital.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

> When the driver detects a timeout, there's no guarantee that the ISR
> would have fired.  Thus after a timeout, it's the foreground that
> becomes responsible to reset the hardware state machine.  The change
> here just duplicates what is already implemented in the ISR.

Is this a fix? What failing here?

Can we have a feedback from Florian, Ray or Scott here?

...

>  	if (!time_left) {
> +		/* Since we can't trust the ISR to have cleaned up, do the
> +		 * full cleanup here... */

Please use the

	/*
	 * comment
	 * comment
	 */

format

>  		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
>  				   BCM2835_I2C_C_CLEAR);
> +		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
> +				   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);

I'm not sure this is really making any difference though. How
have you tested this?

Have you tried reading those registers before and understand what
went wrong?

Andi

