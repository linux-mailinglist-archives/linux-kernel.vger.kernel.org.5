Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866B7DBFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJ3SkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3SkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:40:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DDB7;
        Mon, 30 Oct 2023 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698691198; x=1699295998; i=rwahl@gmx.de;
        bh=27RRESGc2uODi+u0giI2RrxmPZLNkWSIaKlElwaCV/U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=m4q/cNMHfPFXVDXhV7VC0poCbjnOHFxgFsSXoYHfsDCs4UVqSLbhuzVPrIX0jnwi
         PCvPBAMQVg5lLd0Zt2cz7GM+IOHPwOdpTNa1GaNGkytL2Nv7A5X2seQiOyovBhvbw
         8kME2mRTvRmA99OE3EmAdKBRz5qlOadn05coR8Va2RcEJSBKz3ABnDgwbUHNK+bkE
         JS1PZhFywJVmmQ4Eq7TUtx0J8MDOt36vcn2+xGB2D94LL63cpbywdGNgJGEjzjmV6
         /GMseLwBu0wzaWm9cKk8IGAIzuKF2AiAUl/XXKbDKkREXTIJwskNh8PzXQNZNc4uY
         k62IFBvNziD4n0LUbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhyc-1qjjep3kEk-00DkmI; Mon, 30
 Oct 2023 19:39:57 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
Date:   Mon, 30 Oct 2023 19:39:51 +0100
Message-ID: <20231030183951.15331-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fbjb7EBuSKecN9y3Stcy7ML/8gd17DauMMlKaSXlrmHhzRO8LyE
 82/lESIwfH+SOlwshww6Kpm1HY7efEV4oa+V1MlSutGd1Agxxdm71go6hgt7ehnRsDsrbMS
 nGRip/Q2fR46TGc3DxUKm3mq3a+bU9wlQlG2YvyCiIAhAaEbz7thw7Xa+61Gin+bjv63Sfi
 iMdfuEh3wZfmvTt7HCW9A==
UI-OutboundReport: notjunk:1;M01:P0:EqntbAvvnIk=;mVEf8wRMZgwoIkthCFxxD+snD6g
 6e4RlIqCJbvuax1Qou3ZZJuCE7hlgJObVxKaN1gKk4hxYPn3aBuhNlp0aYVNb8iS0EGPsojtq
 CqyYVNEpoM7pQN22SqqJTxCHVn8a+NpESnlqaojbmF5KzbHCC80yZ9UqyMZoeMhcD+Yotd6XB
 upXpnhsDFUiZ0gy++p0hEbefqIytYcaXAQDYCKIKcuxYmUkzdG6HSTV4eMj2FaIVuoZ7y7EuI
 DybgmeaFEALETCgP4r9FbLS8/SS9Q7hWoCU8DE17Cesn+GZZpKaNQnXkt3gFcoidAA1L92nVx
 DgkA9+tWAJZ9BHuq4KHa4JYTfsmxG0TJq7GmnwGQPFqkDctAvYTP9x3J6m9Lx61UbxtQNjFnU
 XrSTJ4kbZst/bu6VSGVW75S8kxHP8Vam7N8Y3QWaDRfWbhJCUMr850yKLJG13PewltD8+Yjk8
 5NpAjqpdsbcM3yZKjhHXBZYyThQ2TWBhJ4P8dUi4m/GDEENQ1VpNK0bjD8Zg0b/orwR4PuKqN
 fzJQsUfYiuDnk/+s5z75VMPcmCHZnxCrKt8ZHlfAPZTdiw9lSyMAffMosPrK9KcYe1+E78U0v
 MY5qwXwJcXPsvovbwRF4cOKcfHboghXm3kaFTOm3tMSldU+hWKPQ9o+iVn8fP2CXh4cCP9ltX
 WshWqyE5k8kRolxUHYhLOF8303eZD6X0HF7NiA/7UmsfA/bmRctRmsxfo/VxSEOBLjsKNXigA
 +YeWYCoCwFYWu1QYcLcnsZTeGvcX22uqX348yv4FugFtq9HROh8p3fJBrJsU02sPovR7WS+xg
 4TnL9UyEGlE+OAtSBMbnqeTs1kQlqbpHM9snBX2pYP3gYMonlCeRWkYx2h0XHjeOvG7d4CvmK
 ptSzsgMHZj0E0bTHUJCT6EKMWqFbNirBaOi4AeI5wH4R+cTXM2LJyxAnqrbhYKGuuY73Du3PI
 Vb2XQQfFDzOWZY7Lz29m5Y2FE4o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting RX DMA on THRI interrupt is too early because TX may not have
finished yet.

This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
an AM62 SoC that is using the 8250 OMAP variant.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/tty/serial/8250/8250_omap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250=
/8250_omap.c
index c7ab2963040b..f2f59ec6b50b 100644
=2D-- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1282,10 +1282,11 @@ static int omap_8250_dma_handle_irq(struct uart_po=
rt *port)

 	status =3D serial_port_in(port, UART_LSR);

-	if (priv->habit & UART_HAS_EFR2)
-		am654_8250_handle_rx_dma(up, iir, status);
-	else
-		status =3D omap_8250_handle_rx_dma(up, iir, status);
+	if ((iir & 0x3f) !=3D UART_IIR_THRI)
+		if (priv->habit & UART_HAS_EFR2)
+			am654_8250_handle_rx_dma(up, iir, status);
+		else
+			status =3D omap_8250_handle_rx_dma(up, iir, status);

 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
=2D-
2.41.0

