Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FC7DCB79
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjJaLKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjJaLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:10:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDF5129;
        Tue, 31 Oct 2023 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698750616; x=1699355416; i=rwahl@gmx.de;
        bh=zZ0KOKns7HR6ofh+Tzy/j3ph3TyGAWOjKTDiVz5/eR8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=l3N+s6YrpbaWayXZnOkB9+Ha7nyoLl4Hih7BzG4hcDkB3z772DdoeW8EMaF///Wl
         8ByoPnZineurUqm1S9Q5rAGWbkDAeFeNVvm3csfpymxd0wGmTYwANMOmDr+LZ+het
         yUWYBdS0KMRKXtInUhIUuEms6jkmFHmiOuJdyWAV2iVkgMkO2T4sZRqFyvWiMz1z+
         TphoThVnV7MS+72U9TwxPcJnCNcAOkVd00URQ55AVHn6S1Vx7CGwZWnU5at+YYF5w
         Ko59iePzi2GE/lETcz9/SN8a+ot/w8Q79or15wVKp0PredPGXjPLSBOFj4ee0CLzb
         a1BOtd7BSpax61EWMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1rBnGe1V35-00E9nZ; Tue, 31
 Oct 2023 12:10:15 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>, stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
Date:   Tue, 31 Oct 2023 12:09:50 +0100
Message-ID: <20231031110950.11714-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:07jTVbhnWKFmwFKlvfVVAJ0QXAb/H88H3CtDEUKEEywXftlUj7r
 pzaiN8CjtgB6KEG1TNrsgY8SjWI8bPGfn2Ed1o703l9JJyd+H3VViaj7UQQpfQKJ5QxIHaC
 i3bLKpoIEgdiDZQ+/DYF+g9wTYsMzFQaKd/F278/B5UMd7+HTfqILLX3d6oscqDyE3tb7dZ
 e02Ilvd2rBfM3dMMTtxyQ==
UI-OutboundReport: notjunk:1;M01:P0:Eps/ZI4hh+s=;oCtRH6IjutN9+AxQ9tORJHMLD5P
 LAoB5sID3t7insHkAzSLIHNkZhXZ4fR9/lYeMJ+ICTXjrQyq+WHGkr7ggteGGoRVsr+11hZYY
 614SfBZwknpoLnZ5CfgOzBIz4g01p42apPBpO5vE5GvnqrodR1V3a4tuI4JnjyR63soffQdUk
 VsZG8shjlCirgVh2Q+Fy0UCUEDC8oXtigS9dlDyZzr4bYU43mjiFrbbP+Zk1xTh/u6UeeMkgI
 TkuSngD9GD4RvqD0Dtqp4a4TirnwHrdDoQ0p58knIBxL1yNxXl73Qkqexa7JrGT0w4/U2+7JS
 guEnBodL1jOsyJyR9kZWYJF8NNI0FRP0DtCmPGh0a2T7LhwcbldTOtdY72JCForKqvSK/akTl
 6BGacVpdz6+DFbcqf0q+txOuizoNkh4Q84b6CPk5o+Abo6JEWfX0lHbWcwoskf5UjZEsMhkO2
 bheYN5Tp9L8uKQAI+qxzU6edNjxHm1Ljd97XjfPeqy6QCjwNRmlp/AuRXKG0oRi9Ur4KjqjOr
 /DcsYVTNgXw61RnsF2uya3JtnMadm8F2+EsuTVG6CQYLRwfYN6yV4/wjmhDMOKRMKQryY3BHu
 mtVxG58/YkIqiAcmB9XFX3PxO9y40lxAHLxd+pPtx8+fCxKu8S3HaeuxkW9EkcgSbg9jFrT0y
 +ErlcU5NRT/4z17hmVG3H++ml69CSFI/dniGoRhGvUkve407XaS04O/oHhouOUNnNK9BDdIzw
 8MwmGnMay/y0r8sBynREQxi1RkBJmmsrH56FKljRUXFr2ARGT49ICsQbPr/veF8vRaVmAHEFw
 PT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

Starting RX DMA on THRI interrupt is too early because TX may not have
finished yet.

This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
an AM62 SoC that is using the 8250 OMAP variant.

Cc: stable@vger.kernel.org
Fixes: c26389f998a8 ("serial: 8250: 8250_omap: Add DMA support for UARTs o=
n K3 SoCs")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
V3: - add Cc: stable@vger.kernel.org

V2: - add Fixes: tag
    - fix author

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

