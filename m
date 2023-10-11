Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8997C4ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJKGh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjJKGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:37:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092C9B;
        Tue, 10 Oct 2023 23:37:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B6bA1p113973;
        Wed, 11 Oct 2023 01:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697006230;
        bh=ibJxl3VqApgkwXcPcBAZdilAPVeZ+ZobbrYoKmgyyBU=;
        h=From:To:CC:Subject:Date;
        b=s8naaFuYdAU+pPhK26H3cr/k2QuGyMYXKafJA97M2iSkBzh/Lj368qfPhBRDFv/4V
         JJVp2RQy2OoBBDdOcTVLgRUtP7CiWGw7XLpeAJhcUXJCSYeGH7dTmq5BzSModAnc0d
         /W+PAT4Fsbm1FlCq9uhyvDa8cUDSgiW9YAgKYf/k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B6bAnf121517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Oct 2023 01:37:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 01:37:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 01:37:10 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B6bAUS003485;
        Wed, 11 Oct 2023 01:37:10 -0500
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39B6b9tg008250;
        Wed, 11 Oct 2023 01:37:09 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Date:   Wed, 11 Oct 2023 12:07:00 +0530
Message-ID: <20231011063700.1824093-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
to this the tx_total_bytes of one interface doesn't match the
rx_total_bytes of other interface when two ICSSG interfaces are
connected with each other. There is no public errata available yet.

As a workaround to fix this, decrease tx_total_bytes by 8 bytes for every
tx frame.

Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index bb0b33927e3b..dc12edcbac02 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -18,6 +18,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	u32 base = stats_base[slice];
+	u32 tx_pkt_cnt = 0;
 	u32 val;
 	int i;
 
@@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 			     base + icssg_all_stats[i].offset,
 			     val);
 
+		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
+			tx_pkt_cnt = val;
+
 		emac->stats[i] += val;
+		if (!strncmp(icssg_ethtool_stats[i].name, "tx_total_bytes", ETH_GSTRING_LEN))
+			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
 }
 
-- 
2.34.1

