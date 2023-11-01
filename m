Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22D7DE524
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjKARPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbjKARO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:14:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B87A6;
        Wed,  1 Nov 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698858884; x=1699463684; i=rwahl@gmx.de;
        bh=EriKGdVhkjZE/JW8h0Day4T4RmUpBJKLvzPhAYNXNLI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=T6QKpQEh0+ITgaCW1YWnQiQak5N89ZYBJQnfNlOwVsmEG/2+NECZ6AVpinFbGtaL
         owz8ZMeiYQYpjAqGwKM0ZIjR/GKuxgl9fWtdnQaxunAhNJOGT/Un31eojphAAfEP3
         SSrjMUOwPg+4EXCPM6m3ntizj5kXT/liJ3K/7dN+8/nFU+G7H16b6SIcWIBn9TIgE
         Jfu0A2O8jpQ03prOswovmX7xOavcQb23cdcIYfjA5fQtyGMX2hZZTf/UrSjuN+AI+
         0WqBdmJhA/Lkkjxd/cyZlpxQS+M7uJ/whYkWhd5zywMCQ2PjViKCu9aci4o30bCLu
         8TT6DVoPh0Jx/n1ZyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1qpGPH2S4B-00RJT5; Wed, 01
 Nov 2023 18:14:44 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>, stable@vger.kernel.org
Subject: [PATCH v4] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
Date:   Wed,  1 Nov 2023 18:14:31 +0100
Message-ID: <20231101171431.16495-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OU2kS9jqgy2fT3w5uBLnJbbnDx7Tjfr6MYf8PnuM07Qq6IGpNSX
 /2D7bW0HTTX0RYxg/DoeuwfkkyrUX8LBM4jCVaMMcfFlx0lzfkAdkzlUzyLIUHiPsvCc1q6
 OOOAice4sEsIUqqmEIKhbqatANdaPcZM5bO4EjGDFleJnfx+7VkiFc23QK+qFEepIgmjhhZ
 jD7DcXK6lcx/vIFmdSkbg==
UI-OutboundReport: notjunk:1;M01:P0:53AjFZVSRN4=;5723rBi+1Md/zfc/YkPrOSPr4iD
 930nbU4C6fvaWXJ1VOKaJLLD0KqLaYNaI1A93BIPSoqsIyu92H440hXkvnGz15siwq6rrqDDY
 iXqf81ls9hgcaLZVJunD+B3mzlxy02KS5IihNpAxKay+NdSq2Cg0rFnK3SAkdhIIhz9CQkKlB
 55//g62HUPPis0UhiHehtXJXim3/rSkHmEaihyBjb9w3+gi+8vpGLPXVX/AgEyjSrxHDjiGKi
 VNY2Cq+pIVg60Prb8/+fCGe6pVJp9DXttKSkLC/IxC53sp3OKmKqost13Jlix96pziAdeImff
 pFOFOg0ym6BXoBeAB2k/RfuRBUJ8aurqgvA/24CghJ3E1bDZZs+1vN1dmYgzNLBGqEcqSpdrR
 Hbr6pferUVBVWCvVJiORwc/w1+0gNfvezxBZTEE3gLD/ix6KE7ZPPweJ3Otbo3+YMv1kL/1fj
 nGRx+SI8fXLualUzbXk3ilW1oJlnYxiN67Ttz6mLh3F26keInVNPjracBXZtqDeinUjBuAaY+
 5GegC59OGOzpcv3rnMaG9HLcyVbGqobXCCq5Qu4pnPn9Yj+sqYLBEFKroTd1XxoniDsydggE3
 xy8WIPkbl1BHBPg7PYDELlAWTn7F6zMTyO4scxJ2SnhY3TByUtHfil2eVUQQhjPgxMSRVvl2Z
 wRzIz11MmCIhuWUzkpGEl/07rM+E0P5ZzzinDMWCUM4tO+9pyl9Scc2wuPePpoQl51w0YsCbR
 GBjG4ITVgoFKyzvRlAZ0ZQ18RrdnVRxjOhjlb4uj+OfrtCRwSrqAqEslbUchNr8TNtCxYFfE0
 9Gl7fC9R+xu7d+j4L09O6G34toosBZNwta87IU0LBWas1sP8T7Ti4xG65QVrbxTT9Dc7ItfYK
 WO7tDyT+uosO39kUJqoh3lQbEaDcA1rcsGn0QVT66UdjMDLveGsZGsvFZg0U5i+JzVR1l8e2w
 i2bqMw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
V4: - add missing braces to fix build warning

V3: - add Cc: stable@vger.kernel.org

V2: - add Fixes: tag
    - fix author

 drivers/tty/serial/8250/8250_omap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250=
/8250_omap.c
index c7ab2963040b..1122f37fe744 100644
=2D-- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1282,10 +1282,12 @@ static int omap_8250_dma_handle_irq(struct uart_po=
rt *port)

 	status =3D serial_port_in(port, UART_LSR);

-	if (priv->habit & UART_HAS_EFR2)
-		am654_8250_handle_rx_dma(up, iir, status);
-	else
-		status =3D omap_8250_handle_rx_dma(up, iir, status);
+	if ((iir & 0x3f) !=3D UART_IIR_THRI) {
+		if (priv->habit & UART_HAS_EFR2)
+			am654_8250_handle_rx_dma(up, iir, status);
+		else
+			status =3D omap_8250_handle_rx_dma(up, iir, status);
+	}

 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
=2D-
2.41.0

