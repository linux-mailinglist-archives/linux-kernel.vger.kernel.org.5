Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F497D85EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjJZPYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjJZPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12879D7;
        Thu, 26 Oct 2023 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698333824; x=1698938624; i=estl@gmx.net;
        bh=hrkvAOte+Th3rpsByV7vWGNWnYjhb3jN9HoUWbKJ61c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=OLZANmlaBqktCjzeDAwa6XgaP5O8HNALrlBsXopEztBlFwCFqJ3Arz89BQwzEYpq
         86vbRqblqhx9GGWy1eqy1xmH++Dt0Ymrukrbvembq4Bj8e67gi8AIhvkFyACmIwaL
         Mz5ACJ34KSvPZlZwm7o3SGl7hiW7zgG/xINCaFYj86oeDqNz3nkP1CLSMa6wQolfC
         Mf57KvFYBq9NM0vTx9kfpuze9PFGg1utXH+dKUEF4CqcUjIAkmFzIiyPU/jjdM9zo
         ai1Bj8xVGTo83r0ce2tHG1Ac1XFEvaSU+2j4uvPRyFkiglRhcHW+ylXdzoNaeouuE
         rD5LFo9Puv+6QlX1/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([77.246.119.226]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9nxn-1qt1Xh3eR3-005qmX; Thu, 26 Oct 2023 17:23:44 +0200
From:   Eberhard Stoll <estl@gmx.net>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 1/4] spi: Add parameter for clock to rx delay
Date:   Thu, 26 Oct 2023 17:23:02 +0200
Message-Id: <20231026152316.2729575-2-estl@gmx.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026152316.2729575-1-estl@gmx.net>
References: <20231026152316.2729575-1-estl@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZjH2xhKzqHPS+vXFJ+4XQ4H7/hsilX8+hpIYcpOOyrNBd2VVTAp
 MIAdABQsqj9eI3Z2ADyQE1HeFdIIjm+NjEkIuKv4NSLvB+8floGvBVoi4G/Ss3BdIS1s+i8
 J3e7NzN2fO2fSvhHzyI1MfoIg+pslsOhhHWsIT0VVgMP0zq3ElpBd464D98fu8ZEDFeE888
 DLMJcj8cTGvdIp/LZ3GoA==
UI-OutboundReport: notjunk:1;M01:P0:cVFpXz6rkM8=;b9OZjyEbm3a/50Q/VVJoLXW3AJK
 UOVel7zUZX+gvp9oIwgSYIW80wXXRZO/0HxPKNxPdVtf3CPMi3v72dD+aFjMWFdMdGlwZg/ga
 2RHsqasDn0pc/iVTUbn+lKmWsNFy6Sfn4NhHMo8MvRFtejIyn29M3jmpRBQnonR9cA+usdG6e
 Ty0pTYliCv+skZ4lXsRiTTdBgIXIBCJdoqaRSs4ejDqPFC8H/H/WNk+LakJRZZHwJVIJ0cK5T
 w2kvj5Np0He7VWmdUU2Q43NW2W1U+oeCv2QAoH1yoGPVlApEv5r1Z/UJodLRFspeb1hg4mjPt
 M5hqP8BZytDpqekUBzh5m+/vyxLwoc7g4u9xIfEZJ6zUW739xVAvCbSigay+41F4e6gy07XZi
 ZmJujFIcevq8qYC+mQ86WhXrKIS2XilI7yN+sEo7Pv22e8XYh3+tdTX96bS5+F4k+BJkq+oxJ
 wRaIArvaV5QiFliCheogerfYKTNcswTmoTW0yDRdFCzt6V/F+5av23pVD5IuQa70ip6qmiHg/
 YnbA7rwoheaKZtv7+55wt2iog6ry0+NL4iKnEBuLTUlChIaTXnzXJvxkPqOJhi7LXL7tK3cmB
 dF7v3aB6vJqQXIsxj09WlXZktsuSK5lSIv3+2yweD+l3MlAvLgNi7J0A5v+I+nFApmtE4s/6L
 qfuhffL0PZHfSOYo6EghNLaLaU28Pauwx+Bg0bbUOe44em5IOizO2xGYdU3npN7QntyQRxHzJ
 eXyEGCHVrDnShdR/KHgJHNIYYMhcdXbaG9lC1TTlIWE280nZeErm8/miyNbJOUwg6XElzPsGc
 9/mL17gV8JJPmm+2gvkmntMTXgog0tc5PW+yZ+1BRydb+bmyo8vYDn82nBSFooeol3Mlne9fG
 qQLgeOrkKKPEaNBDc6zmQUWZbng7CYBgOypiOeo7L2IcRMWxfXIbG8RUWkZHw+1Fv17iF5Oiu
 A2yoThlxsILXrUMdO7ESHjp5xXM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eberhard Stoll <eberhard.stoll@kontron.de>

For spi devices the master clock output defines the sampling point
for receive data input stream (rising or falling edge). The receive
data stream from the device is delayed in relation to the master
clock output.

For some devices this delay is larger than one half clock period,
which is normally the sampling point for receive data. In this case
receive data is sampled too early and the device fails to operate.
In consequence the spi clock has to be reduced to match the delay
characteristics and this reduces performance and is therefore not
recommended.

Some spi controllers implement a 'clock to receive data delay'
compensation which shifts the receive sampling point. So we need
a property to set this value for each spi device.

Add a parameter 'rx_sample_delay_ns' to enable setting the clock
to rx data delay for each spi device separately.

The 'clock to receive data delay' value is often referenced as tCLQV
in spi device data sheets.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
=2D--
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7f8b478fdeb3..14622d47f44f 100644
=2D-- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -166,6 +166,7 @@ extern void spi_transfer_cs_change_delay_exec(struct s=
pi_message *msg,
  * @cs_inactive: delay to be introduced by the controller after CS is
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
+ * @rx_sample_delay_ns: spi clk to spi rx data delay
  * @pcpu_statistics: statistics for the spi_device
  *
  * A @spi_device is used to interchange data between an SPI slave
@@ -219,6 +220,8 @@ struct spi_device {
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
+	/* Transfer characteristics */
+	u32			rx_sample_delay_ns; /* Clock to RX data delay */

 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
=2D-
2.25.1

