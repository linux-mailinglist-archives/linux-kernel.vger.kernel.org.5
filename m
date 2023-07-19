Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617117597C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGSOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGSOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:11:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB878E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:11:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qM7tG-0003ij-5J; Wed, 19 Jul 2023 16:10:54 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qM7tC-000cnD-8D; Wed, 19 Jul 2023 16:10:50 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qM7tB-003DGO-Bm; Wed, 19 Jul 2023 16:10:49 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Wed, 19 Jul 2023 16:10:38 +0200
Subject: [PATCH] net: stmmac: correct MAC propagation delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-stmmac_correct_mac_delay-v1-1-768aa4d09334@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAN3ut2QC/x2NUQrCMBBEr1L220ATCzVeRaRsNqtdSFPZtKKU3
 r3Rv3kDb2aDwipc4NpsoPyWInOuYE8N0Ij5yUZiZXCtO7e99aYs04Q00KzKtAy/HDnh13Suv1D
 w0QeyUPWAhU1QzDTWgbymVMuX8kM+/7/bfd8PVFGWSX8AAAA=
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IEEE1588 Standard specifies that the timestamps of Packets must be
captured when the PTP message timestamp point (leading edge of first
octet after the start of frame delimiter) crosses the boundary between
the node and the network. As the MAC latches the timestamp at an
internal point, the captured timestamp must be corrected for the
additional path latency, as described in the publicly available
datasheet [1].

This patch only corrects for the MAC-Internal delay, which can be read
out from the MAC_Ingress_Timestamp_Latency register, since the Phy
framework currently does not support querying the Phy ingress and egress
latency. The Closs Domain Crossing Circuits errors as indicated in [1]
are already being accounted in the stmmac_get_tx_hwtstamp() function and
are not corrected here.

As the Latency varies for different link speeds and MII
modes of operation, the correction value needs to be updated on each
link state change.

As the delay also causes a phase shift in the timestamp counter compared
to the rest of the network, this correction will also reduce phase error
when generating PPS outputs from the timestamp counter.

[1] i.MX8MP Reference Manual, rev.1 Section 11.7.2.5.3 "Timestamp
correction"

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 42 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  4 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |  6 ++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 6ee7cf07cfd7..95a4d6099577 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -536,6 +536,7 @@ struct stmmac_hwtimestamp {
 	void (*get_systime) (void __iomem *ioaddr, u64 *systime);
 	void (*get_ptptime)(void __iomem *ioaddr, u64 *ptp_time);
 	void (*timestamp_interrupt)(struct stmmac_priv *priv);
+	void (*correct_latency)(struct stmmac_priv *priv);
 };
 
 #define stmmac_config_hw_tstamping(__priv, __args...) \
@@ -554,6 +555,8 @@ struct stmmac_hwtimestamp {
 	stmmac_do_void_callback(__priv, ptp, get_ptptime, __args)
 #define stmmac_timestamp_interrupt(__priv, __args...) \
 	stmmac_do_void_callback(__priv, ptp, timestamp_interrupt, __args)
+#define stmmac_correct_latency(__priv, __args...) \
+	stmmac_do_void_callback(__priv, ptp, correct_latency, __args)
 
 struct stmmac_tx_queue;
 struct stmmac_rx_queue;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index fa2c3ba7e9fe..1749cba7b206 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -60,6 +60,47 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 		*ssinc = data;
 }
 
+static void correct_latency(struct stmmac_priv *priv)
+{
+	void __iomem *ioaddr = priv->ptpaddr;
+	u32 reg_tsic, reg_tsicsns;
+	u32 reg_tsec, reg_tsecsns;
+	u64 scaled_ns;
+	u32 val;
+
+	/* MAC-internal ingress latency */
+	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
+
+	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
+	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
+	 */
+	val = readl(ioaddr + PTP_TCR);
+	if (val & PTP_TCR_TSCTRLSSR)
+		/* nanoseconds field is in decimal format with granularity of 1ns/bit */
+		scaled_ns = (NSEC_PER_SEC << 16) - scaled_ns;
+	else
+		/* nanoseconds field is in binary format with granularity of ~0.466ns/bit */
+		scaled_ns = ((1ULL << 31) << 16) - scaled_ns * PSEC_PER_NSEC / 466;
+
+	reg_tsic = scaled_ns >> 16;
+	reg_tsicsns = scaled_ns & 0xff00;
+
+	/* set bit 31 for 2's compliment */
+	reg_tsic |= BIT(31);
+
+	writel(reg_tsic, ioaddr + PTP_TS_INGR_CORR_NS);
+	writel(reg_tsicsns, ioaddr + PTP_TS_INGR_CORR_SNS);
+
+	/* MAC-internal egress latency */
+	scaled_ns = readl(ioaddr + PTP_TS_EGR_LAT);
+
+	reg_tsec = scaled_ns >> 16;
+	reg_tsecsns = scaled_ns & 0xff00;
+
+	writel(reg_tsec, ioaddr + PTP_TS_EGR_CORR_NS);
+	writel(reg_tsecsns, ioaddr + PTP_TS_EGR_CORR_SNS);
+}
+
 static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 {
 	u32 value;
@@ -221,4 +262,5 @@ const struct stmmac_hwtimestamp stmmac_ptp = {
 	.get_systime = get_systime,
 	.get_ptptime = get_ptptime,
 	.timestamp_interrupt = timestamp_interrupt,
+	.correct_latency = correct_latency,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efe85b086abe..ee78e69e9ae3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -909,6 +909,8 @@ static int stmmac_init_ptp(struct stmmac_priv *priv)
 	priv->hwts_tx_en = 0;
 	priv->hwts_rx_en = 0;
 
+	stmmac_correct_latency(priv, priv);
+
 	return 0;
 }
 
@@ -1094,6 +1096,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->dma_cap.fpesel)
 		stmmac_fpe_link_state_handle(priv, true);
+
+	stmmac_correct_latency(priv, priv);
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index bf619295d079..d1fe4b46f162 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -26,6 +26,12 @@
 #define	PTP_ACR		0x40	/* Auxiliary Control Reg */
 #define	PTP_ATNR	0x48	/* Auxiliary Timestamp - Nanoseconds Reg */
 #define	PTP_ATSR	0x4c	/* Auxiliary Timestamp - Seconds Reg */
+#define	PTP_TS_INGR_CORR_NS	0x58	/* Ingress timestamp correction nanoseconds */
+#define	PTP_TS_EGR_CORR_NS	0x5C	/* Egress timestamp correction nanoseconds*/
+#define	PTP_TS_INGR_CORR_SNS	0x60	/* Ingress timestamp correction subnanoseconds */
+#define	PTP_TS_EGR_CORR_SNS	0x64	/* Egress timestamp correction subnanoseconds */
+#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
+#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
 
 #define	PTP_STNSUR_ADDSUB_SHIFT	31
 #define	PTP_DIGITAL_ROLLOVER_MODE	0x3B9ACA00	/* 10e9-1 ns */

---
base-commit: 36395b2efe905650cd179d67411ffee3b770268b
change-id: 20230719-stmmac_correct_mac_delay-4278cb9d9bc1

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

