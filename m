Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28598801159
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjLAQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLAQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:43:54 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207ACF;
        Fri,  1 Dec 2023 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=7At9uuqHWGrA2m9Dhp2A4PrSwVUv/Y1UlsqVgIz15hI=; b=a6KD8D6juzVjavnBFuM3wf+B7M
        3uxRChtB/sCuHJekpKBLWWrufDPuWjmX3upNruc3a/hJo3nLGsr9rUjc2NI9fsvamnoXAEXtQJ6A3
        jWajIBl5kbfzUmctZIMy8g6a74aiMFGHkH8iIiPPI232ZtnjYmp+jf4Pm0F4FAXB1Gvw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49622 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r96cI-0004Xp-IO; Fri, 01 Dec 2023 11:43:51 -0500
Date:   Fri, 1 Dec 2023 11:43:48 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Message-Id: <20231201114348.fec7077998136877adb030f9@hugovil.com>
In-Reply-To: <f6e44cd7-4b25-48de-a57c-96497bf9da6a@cesnet.cz>
References: <20231122175957.3875102-1-hugo@hugovil.com>
        <f6e44cd7-4b25-48de-a57c-96497bf9da6a@cesnet.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] serial: max310x: change confusing comment about Tx FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 17:04:15 +0100
Jan Kundrát <jan.kundrat@cesnet.cz> wrote:

> On středa 22. listopadu 2023 18:59:56 CET, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > The comment wording can be confusing, as txlen will return the number of
> > bytes available in the FIFO, which can be less than the maximum theoretical
> > Tx FIFO size.
> 
> This (commit) message is confusing, too, IMHO, because `txlen` is the 
> number of bytes that are currently waiting in the TX FIFO. So that number 
> is "available" for the HW UART to pick up and send, but it's not a number 
> of bytes that's "available" in the FIFO for host to push more bytes to. I 
> guess you might want to tweak that description here.

Hi Jan,
you are right, the commit message is confusing. I copied it from the
commit message of a similar patch for the sc16is7xx driver, and I
should have modified it for the max310x:

SC16IS7XX TXLVL: spaces available in TX FIFO
MAX310X TXFIFOLVL: current fill level in TX FIFO

The patch has already been applied to Greg's tty-next tree (my
understanding is that it cannot be rebased?), but at least
the comment in the code is still valid.

Thank you for the precision.

Hugo V.


> >
> > Change the comment so that it is unambiguous.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/max310x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > index 97e4965b73d4..f3a99daebdaa 100644
> > --- a/drivers/tty/serial/max310x.c
> > +++ b/drivers/tty/serial/max310x.c
> > @@ -780,7 +780,7 @@ static void max310x_handle_tx(struct uart_port *port)
> >  	to_send = uart_circ_chars_pending(xmit);
> >  	until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> >  	if (likely(to_send)) {
> > -		/* Limit to size of TX FIFO */
> > +		/* Limit to space available in TX FIFO */
> >  		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
> >  		txlen = port->fifosize - txlen;
> >  		to_send = (to_send > txlen) ? txlen : to_send;
> >
> > base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> 
> 
