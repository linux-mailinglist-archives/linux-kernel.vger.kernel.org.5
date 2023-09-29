Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79727B2C11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjI2Fuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2Fui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:50:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F172199;
        Thu, 28 Sep 2023 22:50:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A46C433C9;
        Fri, 29 Sep 2023 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695966636;
        bh=xkilN8k3NzbzqCiUgNbnaC7gB4bdBzFwDX8FoLrYssI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLveylxkRyMBmMOE4nSW0CWvAqcpVwt2iCZLV216Q8Bt+d/osFvWKiDptZ9yrAlRq
         y/NdimLXgp/rPeUYElLldxpw4kieILWUEw6OWwjKLcKHZzpEbVlzqBUoOHUBb6boD5
         +Da0JdeT691gQbZLeLn2yoksD4uToaSqfMKfzokQ=
Date:   Fri, 29 Sep 2023 07:50:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
Message-ID: <2023092906-untainted-entangled-4d17@gregkh>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928221246.13689-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:12:41AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Both the imx and stm32 driver set the rx-during-tx GPIO in the
> rs485_config() function by means of gpiod_set_value(). Since rs485_config()
> is called with the port lock held, this can be an problem in case that
> setting the GPIO line can sleep (e.g. if a GPIO expander is used which is
> connected via SPI or I2C).
> 
> Avoid this issue by setting the GPIO outside of the port lock in the serial
> core and by using gpiod_set_value_cansleep() instead of gpiod_set_value().
> 
> Since now both the term and the rx-during-tx GPIO are set within the serial
> core use a common function uart_set_rs485_gpios() to set both.
> 
> With moving it into the serial core setting the rx-during-tx GPIO is now
> automatically done for all drivers that support such a GPIO.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

You cc: stable on many of these, but do not provide a "Fixes:" tag
showing just how far back they should go.  Can you do that so that we
have a hint as to what to do here?

thanks,

greg k-h
