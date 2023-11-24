Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6D7F7481
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKXNDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjKXNDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:03:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F2D60
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:03:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999F6C433C8;
        Fri, 24 Nov 2023 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700831008;
        bh=NUJpLAiq0V9wfKoWZ8yHbnyipzfbdiqAH8EwRQp2WVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0uut1qiG0cJzVA4Rnsu2L8he9uz2OvlpYtrwLjXPucjwC9YGWl1Q7Es+MqJjVqTZ
         Qn7S83pVEbefFQmEf+dKnjqvbhoAxfUhR3E3TB7hc37phnf/DqRoIEdJhVWAs6Y7gn
         mrQzVl9zgJPZM8Mg9yMWPQgStbIKTWzj77xwjLgA=
Date:   Fri, 24 Nov 2023 13:03:25 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Paul Geurts <paul_geurts@live.nl>, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: fix tx statemachine deadlock
Message-ID: <2023112434-winter-embezzle-1b46@gregkh>
References: <2023100450-charger-disregard-9683@gregkh>
 <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:58:19AM -0300, Fabio Estevam wrote:
> Hi Paul,
> 
> On Fri, Nov 24, 2023 at 9:55 AM Paul Geurts <paul_geurts@live.nl> wrote:
> >
> > When using the serial port as RS485 port, the tx statemachine is used to
> > control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> > TTY port is closed in the middle of a transmission (for instance during
> > userland application crash), imx_uart_shutdown disables the interface
> > and disables the Transmission Complete interrupt. afer that,
> > imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> > by the TC interrupt. This interrupt is disabled and therefore the tx
> > statemachine never transitions out of SEND. The statemachine is in
> > deadlock now, and the TX_EN remains low, making the interface useless.
> >
> > imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> > interrupts are enabled before bailing to be retriggered. This makes sure
> > the state machine handling is reached, and is properly set to
> > WAIT_AFTER_SEND.
> >
> > Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485
> 
> One nit: the correct format for the Fixes tag is:
> 
> Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
> 
> And no blank line is needed between the Fixes and Signed-off-by line.

It's not really a "nit", our tools will complain if this is in the wrong
format as so many things depend on this being correct.

Paul, can you make a v3 with this change?

And really, this should have been v3 anyway, as the difference being you
added a changelog from v2 :)

thanks,

greg k-h
