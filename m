Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2177F419
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbjHQKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349949AbjHQKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:10:34 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660442D5A;
        Thu, 17 Aug 2023 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=D/VeZqbHWVUYZkOsppXhQk3Rq5983G47lAe3d6GP5/Y=; b=ijuMRbSXPWk0dieiYbCyGXWNIL
        dGd8m59gWWh962Bz+Iq+ns8th5Y9WWFdjbn733vcSfoe2zeNOXok+YnrFfKUaoK0WgSgC7O9n6M/x
        9se5Zd7JLzz4RCtbbC+q3C9xY93mgAyN14Mup6sA5kUBgbPZR2No1v/+kCSbTfRuRU6Jr1viigG1v
        E0yoj+0x3d7dEtFLpIvGC7AlTCOYpBELRNruEzAwRWNzHTzhug/d/VAdkqs6ZFYgBiwHhA2gmi/7Z
        DiCb2Xovv7KVN8OIUtrfhPVX7P0io41Az1m2X5/cfZ5TvSR0irIiYUG12IDN0gUiYCmZe8hnP0sE3
        Jn8Q4UkA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qWZxV-0009wm-LE; Thu, 17 Aug 2023 12:10:29 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qWZxV-000TfR-3z; Thu, 17 Aug 2023 12:10:29 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] can: m_can: support setting hw filters
Date:   Thu, 17 Aug 2023 12:10:14 +0200
Message-ID: <20230817101014.3484715-3-martin@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817101014.3484715-1-martin@geanix.com>
References: <20230817101014.3484715-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the validate_hw_filter() callback to allow setting hardware
filter for m_can-based devices, and configure the filters when starting
the device.

The m_can chip requires separate configuration for standard and extended
ID filters, so the implementation considers filters with an ID or a mask
larger than 0x7ff to be an extended ID. Users needing to filter on the
lower 11 bits on extended message IDs can do so by passing an ID greater
than 0x7ff, while masking in the lower 11 bits only.

The number of allowed filters depends on the MRAM configuration. See
`sidf_elems` and `xidf_elems` elements in the bosch,mram-cfg device tree
binding for further information.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 137 +++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..7c8110076256 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -223,6 +223,52 @@ enum m_can_reg {
 #define ILE_EINT1	BIT(1)
 #define ILE_EINT0	BIT(0)
 
+/* Standard ID message filters (SIDF) */
+#define SIDF_SFT_MASK		GENMASK(31, 30)
+#define SIDF_SFEC_MASK		GENMASK(29, 27)
+#define SIDF_SFID1_MASK		GENMASK(26, 16)
+#define SIDF_SFID2_MASK		GENMASK(10, 0)
+
+/* Extended ID message filters (XIDF) */
+#define XIDF_EFT_MASK		GENMASK_ULL(63, 62)
+#define XIDF_EFID2_MASK		GENMASK_ULL(60, 32)
+#define XIDF_EFEC_MASK		GENMASK_ULL(31, 29)
+#define XIDF_EFID1_MASK		GENMASK_ULL(28, 0)
+
+/* Standard Filter Type */
+#define SFT_RANGE	0x0
+#define SFT_DUAL	0x1
+#define SFT_CLASSIC	0x2
+#define SFT_DISABLED	0x3
+
+/* Standard Filter Element Configuration */
+#define SFEC_DISABLE	0x0
+#define SFEC_RXF0	0x1
+#define SFEC_RXF1	0x2
+#define SFEC_REJECT	0x3
+#define SFEC_PRIO	0x4
+#define SFEC_PRIO_RXF0	0x5
+#define SFEC_PRIO_RXF1	0x6
+#define SFEC_DEBUG	0x7
+
+/* Global Filter Configuration Field */
+#define GFC_ANFS	GENMASK(5, 4)
+#define GFC_ANFE	GENMASK(3, 2)
+#define GFC_RRFS	BIT(1)
+#define GFC_RRFE	BIT(0)
+
+#define ANFS_ACCEPT_RXF0	0x0
+#define ANFS_ACCEPT_RXF1	0x1
+#define ANFS_REJECT		0x2
+
+/* Standard ID Filter Configuration */
+#define SIDFC_LSS	GENMASK(23, 16)
+#define SIDFC_FLSSA	GENMASK(15, 0)
+
+/* Extended ID Filter Configuration */
+#define XIDFC_LSE	GENMASK(22, 16)
+#define XIDFC_FLSAE	GENMASK(15, 0)
+
 /* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
 #define RXFC_FWM_MASK	GENMASK(30, 24)
 #define RXFC_FS_MASK	GENMASK(22, 16)
@@ -382,6 +428,56 @@ static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
 	return _m_can_tx_fifo_full(m_can_read(cdev, M_CAN_TXFQS));
 }
 
+static int m_can_validate_hw_filter(struct net_device *dev,
+				    struct can_filter *hwf,
+				    unsigned int hwf_cnt)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	size_t sff_filter_cnt = 0;
+	size_t eff_filter_cnt = 0;
+	int i;
+
+	for (i = 0; i < hwf_cnt; i++)
+		if (hwf[i].can_id <= CAN_SFF_MASK || hwf[i].can_mask <= CAN_SFF_MASK)
+			sff_filter_cnt++;
+		else
+			eff_filter_cnt++;
+
+	if (sff_filter_cnt > cdev->mcfg[MRAM_SIDF].num)
+		return -EINVAL;
+
+	if (eff_filter_cnt > cdev->mcfg[MRAM_XIDF].num)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int m_can_sid_filter_write(struct m_can_classdev *cdev,
+				  struct can_filter *filter,
+				  size_t index)
+{
+	u32 addr_offset = cdev->mcfg[MRAM_SIDF].off + SIDF_ELEMENT_SIZE * index;
+	u32 sidf = FIELD_PREP(SIDF_SFT_MASK, SFT_CLASSIC) |
+		   FIELD_PREP(SIDF_SFEC_MASK, SFEC_RXF0) |
+		   FIELD_PREP(SIDF_SFID1_MASK, filter->can_id) |
+		   FIELD_PREP(SIDF_SFID2_MASK, filter->can_mask);
+
+	return cdev->ops->write_fifo(cdev, addr_offset, &sidf, sizeof(sidf));
+}
+
+static int m_can_xid_filter_write(struct m_can_classdev *cdev,
+				  struct can_filter *filter,
+				  size_t index)
+{
+	u32 addr_offset = cdev->mcfg[MRAM_XIDF].off + XIDF_ELEMENT_SIZE * index;
+	u64 xidf = FIELD_PREP(XIDF_EFT_MASK, SFT_CLASSIC) |
+		   FIELD_PREP(XIDF_EFEC_MASK, SFEC_RXF0) |
+		   FIELD_PREP(XIDF_EFID1_MASK, filter->can_id) |
+		   FIELD_PREP(XIDF_EFID2_MASK, filter->can_mask);
+
+	return cdev->ops->write_fifo(cdev, addr_offset, &xidf, sizeof(xidf));
+}
+
 static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 {
 	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
@@ -1266,8 +1362,10 @@ static int m_can_chip_config(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 interrupts = IR_ALL_INT;
-	u32 cccr, test;
-	int err;
+	size_t sff_filter_cnt = 0;
+	size_t eff_filter_cnt = 0;
+	u32 cccr, test, anfs;
+	int err, i;
 
 	err = m_can_init_ram(cdev);
 	if (err) {
@@ -1288,8 +1386,38 @@ static int m_can_chip_config(struct net_device *dev)
 		    FIELD_PREP(RXESC_F1DS_MASK, RXESC_64B) |
 		    FIELD_PREP(RXESC_F0DS_MASK, RXESC_64B));
 
-	/* Accept Non-matching Frames Into FIFO 0 */
-	m_can_write(cdev, M_CAN_GFC, 0x0);
+	/* Configure HW filters and count standard vs extended id filters */
+	for (i = 0; i < cdev->can.hw_filter_cnt; i++) {
+		struct can_filter *filter = &cdev->can.hw_filter[i];
+
+		if (filter->can_id <= CAN_SFF_MASK ||
+		    filter->can_mask <= CAN_SFF_MASK)
+			err = m_can_sid_filter_write(cdev, filter,
+						     sff_filter_cnt++);
+		else
+			err = m_can_xid_filter_write(cdev, filter,
+						     eff_filter_cnt++);
+
+		if (err)
+			return err;
+	}
+
+	/* Configure offset to and number of standard id filters in MRAM */
+	m_can_write(cdev, M_CAN_SIDFC,
+		    FIELD_PREP(SIDFC_FLSSA, cdev->mcfg[MRAM_SIDF].off) |
+		    FIELD_PREP(SIDFC_LSS, sff_filter_cnt));
+	/* Configure offset to and number of extended id filters in MRAM */
+	m_can_write(cdev, M_CAN_XIDFC,
+		    FIELD_PREP(XIDFC_FLSAE, cdev->mcfg[MRAM_XIDF].off) |
+		    FIELD_PREP(XIDFC_LSE, sff_filter_cnt));
+
+	/* If any filter is configured, the Global Filter Configuration is set
+	 * to reject non-matching frames.
+	 */
+	anfs = cdev->can.hw_filter_cnt ? ANFS_REJECT : ANFS_ACCEPT_RXF0;
+	m_can_write(cdev, M_CAN_GFC,
+		    FIELD_PREP(GFC_ANFS, anfs) | FIELD_PREP(GFC_ANFE, anfs));
+
 
 	if (cdev->version == 30) {
 		/* only support one Tx Buffer currently */
@@ -1524,6 +1652,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 	/* Shared properties of all M_CAN versions */
 	cdev->version = m_can_version;
 	cdev->can.do_set_mode = m_can_set_mode;
+	cdev->can.validate_hw_filter = m_can_validate_hw_filter;
 	cdev->can.do_get_berr_counter = m_can_get_berr_counter;
 
 	/* Set M_CAN supported operations */
-- 
2.41.0

