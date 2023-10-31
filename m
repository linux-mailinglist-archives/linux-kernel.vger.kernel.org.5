Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752067DCAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbjJaKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJaKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:22:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8083;
        Tue, 31 Oct 2023 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698747750; x=1699352550; i=rwahl@gmx.de;
        bh=poR96OMC9RD1sAVRSzLW30bdnlCU5++9LFuhwd2akO4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GEPr1Lft9tUDxT4PHrPxB1PBdSBh1t2igbDjHYoS5QrqunPe/kttbTzqE6aUwruy
         SwzKTcAxKy9G2/8Ew7drzJoyBm0d5PYByPFk0kVQS6+iYA0zBAs9Cc1DHxXNXd7uw
         Dnx+/FUOpjAofl4mCW6u999yr1IruT4q2M0Qkvo7F2GJnW9/az3LyZyiX8uxdjotq
         MevKs/lrd0KnIk2N0VaBxBUeVyovCygZiE3PEBVGl3y595rFXt8hIuKZ1UMenUH5C
         7QI8FvILKiyodpOHBBzqTuZvtoLAagRjMHc9MFk62G1vFBQW0pIGIcG16aflKNc1B
         N8z0LKJlIeFfUtFeFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1qjgJn00gX-00LGFu; Tue, 31
 Oct 2023 11:22:30 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH v2] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
Date:   Tue, 31 Oct 2023 11:22:20 +0100
Message-ID: <20231031102220.9997-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e6HHOuYrVh0LnuIqFJOV7BWCEgiS7pY1+DFs5Yv8/8/FH0zXKQT
 S4NK4QfQEtWegBMcf8v3XvmPj0fgS7kUm8gpqtyHgPiGrhrAwzMksLKIhq9pqkpRSIbfyY4
 G5KlUp9pMBPVC9c06EW+yU7FkJdlIacD+oTDGESL4Jv2jR5ZPzP+o53dJ6bEAfV+VD2RQsW
 0dp96thYghDJk3hqNuZ+A==
UI-OutboundReport: notjunk:1;M01:P0:HVl3KigxaB4=;yt2TC2UrYuhv6Z3xrSiB/idYLFZ
 R6ixz0tqwYy+Z8XEavbVpHlurd9C0WE5MY/mubAPpy9UIh6E8KtTO9/N8Pu8R7t+OKMxsIg4b
 RgeDylFltbB/13tq/Hcp7LfS+TLbVmIBAa4FZA7qbhjrtJafiYeKfXSIrc3A8xckHNr8tWhuT
 Kww4ySgEbIyKWLOfqUW0NlauWvgort4bZypVTA8KpKv/6n8J/Dea5y2+2Kw/vfnY5Zb7z5VCk
 lLqi5VGxkrDN599MiB6kmUP+hCOpLE03fYDuxJkl9HrlS/6+P39sJCMJGeH6/sXTVSflT7pj2
 Wh6/R1dGLhKjiQCV8FJKS7twPsL1iydOwpIjSK0w/0vsnxq2anRMR3YgRbr/pNaAQH3CkW00B
 pRTq8eOetqbkiloimJE3zVv4JmNI0yBQ8c+EwgT+RiRZr2uxyW/ybWVqXxaSn9Rti9P9Izwvk
 +57J40ZYW7C6XFI9VuxMV85/jYO2R8Xteb02LVNtFyqxpBpc6t8rK+ABq7cXOrzLLh4KGTRsN
 2/VxPBdCVAzqkz0py5YzoDMga008qImDlfH1rYfV6XLvQAE3msPmyoXGC5Y5q4i5R9FJAfGDL
 DrZZfq6kp9vpL0hSjvmVpZdODbylzzUGUXV282Wk2vhlKshk6Tk1urI1+d99CcTnOmXciVY5O
 +wGx5RATALF4l1+0f2Zt1pryV7ehBICRyysnT26Yl7EabOJhpmu6+XFzQd6Bk65WtXA9xQZvR
 Ascg9I+Nr2gfu9x3yv+kxOG6vZMadTumFCOwvkw0uMffQC8K0Zy3YIl9vNgkMKa+AJvosU/VQ
 /Tp6bbatcga53UBVsPhE11OCbcNXpR86ktbiRcQosVOjf/xqXwppnqfWoH4f2YBdlrZisVOAQ
 GgT8uW27L0simRlQxTi4yJOde2nU/ME6Yhyt/TT5nKlT75AFhI1vTFv0iiSkZuP2jxCwaOYv4
 +tQSB2uphBtOfjiwbxGFQo2V4cQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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

Fixes: c26389f998a8 ("serial: 8250: 8250_omap: Add DMA support for UARTs o=
n K3 SoCs")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
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

