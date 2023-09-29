Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1B7B2C15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjI2FvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2FvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:51:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED85CC2;
        Thu, 28 Sep 2023 22:51:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15FC433C8;
        Fri, 29 Sep 2023 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695966664;
        bh=DhKPPMUpCS//A0/t/Y9gRLs3GysurWRA+G0kaM1iwKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMdxx+UBN8fGfNf1VRuQsoJMa8VSpOwjSLLRLREtbA/xi7Fh7tnxjEGZ9TIiKXzx8
         T44sy/7Xpp+TpHBW7Ae2s4N/Gc/cDIPOJDhBXNkoj7EmY3sqp1PE349V27i+IbELQ8
         iXnhYdKvo6YoFzPNxNINl70y92W5o22kIaeLLV2Q=
Date:   Fri, 29 Sep 2023 07:51:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not
 supported
Message-ID: <2023092948-canteen-pushy-7f54@gregkh>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928221246.13689-7-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:12:46AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> If the imx driver cannot support RS485 it sets the UARTS rs485_supported
> structure to NULL. But it still calls uart_get_rs485_mode() which may set
> the RS485_ENABLED flag.
> The flag however is evaluated by the serial core in uart_configure_port()
> at port startup and thus may lead to an attempt to configure RS485 even if
> it is not supported.
> 
> Avoid this by calling uart_get_rs485_mode() only if RS485 is actually
> supported by the driver. Remove also a check for an error condition
> that is not possible any more now.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/imx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Why is this patch not marked for stable?

thanks,

greg k-h
