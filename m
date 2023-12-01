Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A8800FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378485AbjLAQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjLAQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:04:16 -0500
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 08:04:22 PST
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625A10D0;
        Fri,  1 Dec 2023 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1701446660;
        bh=Uyp2Fb4Zn3ZB6NGD6IROczrgrgscb7OSUvgqaCDohCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Tqq3yAcIv4KzR4ypIqS9gU3N79tbQQZ0LiSegwdkq5E7JScw/hyoESbFiDZnHb3p9
         BZkHochj41Fw1ouwuhEiU/qm9PMYKXSd2oP9Aqod81FqG+GnwjBxjOUGZKl9pUcOkB
         ACA3XQDcXe2k1Iq0J2v4hwYPnL9wR83v0Ck3im7nU1A/vimvAC7VQeJLWC0lf6tXq3
         Yd86vqXvcCGaxKLlOJWnmF0WtWN545to+gOpbSzKbHro2TiQzaBPu9gjgB+r3sLrlc
         o3ZUy3LuGr3JAaWypPbI4Wi0EXGYO3lU4EMBCHdPiJKc+VYQHN8sHEAr8ccvdRoQ4C
         odc3Sduo4LvgA==
Received: from localhost (tlha232.cesnet.cz [IPv6:2001:718:1:6::134:232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 94023118007E;
        Fri,  1 Dec 2023 17:04:15 +0100 (CET)
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: change confusing comment about Tx FIFO
Date:   Fri, 01 Dec 2023 17:04:15 +0100
MIME-Version: 1.0
Message-ID: <f6e44cd7-4b25-48de-a57c-96497bf9da6a@cesnet.cz>
In-Reply-To: <20231122175957.3875102-1-hugo@hugovil.com>
References: <20231122175957.3875102-1-hugo@hugovil.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.10; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On st=C5=99eda 22. listopadu 2023 18:59:56 CET, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The comment wording can be confusing, as txlen will return the number of
> bytes available in the FIFO, which can be less than the maximum theoretical=

> Tx FIFO size.

This (commit) message is confusing, too, IMHO, because `txlen` is the=20
number of bytes that are currently waiting in the TX FIFO. So that number=20
is "available" for the HW UART to pick up and send, but it's not a number=20
of bytes that's "available" in the FIFO for host to push more bytes to. I=20
guess you might want to tweak that description here.

Cheers,
Jan

>
> Change the comment so that it is unambiguous.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/max310x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 97e4965b73d4..f3a99daebdaa 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -780,7 +780,7 @@ static void max310x_handle_tx(struct uart_port *port)
>  =09to_send =3D uart_circ_chars_pending(xmit);
>  =09until_end =3D CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  =09if (likely(to_send)) {
> -=09=09/* Limit to size of TX FIFO */
> +=09=09/* Limit to space available in TX FIFO */
>  =09=09txlen =3D max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
>  =09=09txlen =3D port->fifosize - txlen;
>  =09=09to_send =3D (to_send > txlen) ? txlen : to_send;
>
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263

