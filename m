Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D927FD217
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjK2JP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjK2JOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:52 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B81FEC;
        Wed, 29 Nov 2023 01:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc/h3qc/PCA16PIDQ84blK0svASIL2XGkBmSEdWubcq2hxjDRuynzrXfQYyJpUZziLx/7X/+AadIClPcn4m0Mckonf14MfdQcNB9FAq7bXGcYZPnjiZvnjpqTzG0MBHeP51m1P+c2Ai5/aWOdMSBb/rkmSs0qpsPbW1KnOl4Nwh2mi1ysKQzGj1yWsqXDzXkJGwMh0Jtn6dYMJHSIc3vi//s54fVqllpz6ZrM/CwKvXAZ1FSrpavydCo30Bg+ttSlpOn66LXjwnZgK8bCsYXsrsop30pf9CDS/VdBy9CqpGExF6MzJtkK7D02zFJ3WTB07J/0xJXN+o7ei4mLAJNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYuDtvnVZanXhljP9hxBdIyFe/iV530N5ek5C/lOkMg=;
 b=abznsKiPKjT59EQ7XJZ7Em4pI30mwzi40yOs8n3XWCJ4U6CBu/W4POojzh6WBcaBMJnoJqkpRip6ndPaWFM6GTdodMaB2oqGr3H3gGrV2srzXEsPwbHFwD6n7VjmPFVifD5CaPpdtrEEPvgxmT3yYFhjM6VdX/cgrGj79V9BiwOcgstPjecYm1PhDrgUFDzaiCOpyFJijDiVo6l5BKcVXzcSoVeAi/es5pt5ciUTjLpRIojQgq+g2bvinrBFgv/oml628xe5tKjXsNrXsWhRlC5ahvU/0I96hkXmUbZssKctViK266vftPPlAmZZK2RlByIqbpgWhpyrGuGlod8rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYuDtvnVZanXhljP9hxBdIyFe/iV530N5ek5C/lOkMg=;
 b=vhNqAtQ76BtKG+WmakRk5QOcpNlTcfwY5RDNsGFDdjaE58lPaU/X9bspJcEUeHBIJe8uXaGF+ClbbuM7d6ohIV8n0Q/WZQu1Tdz0TgPSPbyacrG5wqgkyIcRLOWCBwr2YuH62wyXmcX+pXW8NCjL8puil8/jJCE3T98iyiNnb3Q=
Received: from BLAPR03CA0063.namprd03.prod.outlook.com (2603:10b6:208:329::8)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 09:14:43 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::50) by BLAPR03CA0063.outlook.office365.com
 (2603:10b6:208:329::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:43 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:38 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v14 4/9] wifi: mac80211: Add support for WBRF features
Date:   Wed, 29 Nov 2023 17:13:43 +0800
Message-ID: <20231129091348.3972539-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8907733a-1d35-4ecd-9042-08dbf0bb9ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGeGsOuoFbnNpWlk8rdJpCg6K1IQibkXkBILU/906tXBkOzrNZ56jjNB9PXwA+ri57rVtU1EwaEktWoX9Qel8TETs6htp6r4kgohRrphJjOj9UN4GYPISLWq2LLtCLiz7rXvTPtOpk3XZ68FvJF/46EJcKHLZ+Dl/mKVhp2bOPD+OE7zBKHj0NhxrisbeOsNpWU+5QhuhzL8oz+HZnUks3gCCD3CGH+q9XkN5jeLCUCdCYBtOlmybq2/bRIBkxktRD+BOXn4G3cMKnYf+SYEeT9hUeQkR7hpgIFUF79Vr0Tfx5MY95Ak65wdpTJOA8okKg/kEokRV1EWhKxxcgn+I4r5k0oXv3ZbgmwC6MhYRbmGQObIaVZQquNm5+/jAgpfEKfHM62f85sPJ5oLimQH1QoQ9nAvsygLjIGWJ2mwd57vtdSDcQ1z909HcG+mJ/sUgRhLneFFZuN1a3Mu9O9oHOIaiLKUsVoBQLxkgoyiJNSiVjv1M7PfiQ1EDg9MzJu8XyisKIReX2uN7dZnjCzZ0MKmU8esPcJt1ViM1wfHrBLdntEu01sRKPhub2A+labuoFFZqBYX67BGXChxKAPzFlic5xLEy+2bKAUytSsi2Vy1KuqlyqjCB+34/FGqR1eJHqMjktftjv10vZgex6xWYMgiufmQneexJBpf8S/OIVhgxKjQgbxcLNMxnZsUGunGYbtHWKBHsL7lT4SXAFINFuee78RFQw0rUJjRjx00uxeb9nbsLq8vA8/tDXeTI9pS4kRymNPN6gClk87NjM6Lb+VBu2PBL7CRQFeny2AsWrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(32650700002)(81166007)(356005)(921008)(7416002)(86362001)(2906002)(5660300002)(26005)(1076003)(7696005)(82740400003)(336012)(426003)(83380400001)(16526019)(2616005)(6666004)(110136005)(478600001)(45080400002)(36756003)(41300700001)(54906003)(316002)(4326008)(8936002)(70586007)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:43.6399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8907733a-1d35-4ecd-9042-08dbf0bb9ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

To support the WBRF mechanism, Wifi adapters utilized in the system must
register the frequencies in use (or unregister those frequencies no longer
used) via the dedicated calls. So that, other drivers responding to the
frequencies can take proper actions to mitigate possible interference.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
--
v1->v2:
  - place the new added member(`wbrf_supported`) in
    ieee80211_local(Johannes)
  - handle chandefs change scenario properly(Johannes)
  - some minor fixes around code sharing and possible invalid input
    checks(Johannes)
v2->v3:
  - drop unnecessary input checks and intermediate APIs(Mario)
  - Separate some mac80211 common code(Mario, Johannes)
v3->v4:
  - some minor fixes around return values(Johannes)
v9->v10:
  - get ranges_in->num_of_ranges set and passed in(Johannes)
v12:
  - use acpi_amd_wbrf_add_remove to replace the acpi_amd_wbrf_add_exclusion
    acpi_amd_wbrf_remove_exclusion
v13:
  - Fix the format issue (IIpo Jarvinen)
  - Remove KHZ_TO_HZ and use HZ_PER_KHZ in linux/units.h (IIpo Jarvinen)
v14:
  - Use KHZ_PER_MHZ in linux/units.h (IIpo Jarvinen)
---
 net/mac80211/Makefile      |  2 +
 net/mac80211/chan.c        |  9 ++++
 net/mac80211/ieee80211_i.h |  7 +++
 net/mac80211/main.c        |  2 +
 net/mac80211/wbrf.c        | 95 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 net/mac80211/wbrf.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index c9eb52768133..4406b4f8f3b9 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -67,4 +67,6 @@ mac80211-$(CONFIG_MAC80211_RC_MINSTREL) += $(rc80211_minstrel-y)
 
 obj-y += tests/
 
+mac80211-y += wbrf.o
+
 ccflags-y += -DDEBUG
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1d928f29ad6f..aa24585359ee 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -507,11 +507,16 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
 
+	ieee80211_remove_wbrf(local, &ctx->conf.def);
+
 	ctx->conf.def = *chandef;
 
 	/* check if min chanctx also changed */
 	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
 		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+
+	ieee80211_add_wbrf(local, &ctx->conf.def);
+
 	drv_change_chanctx(local, ctx, changed);
 
 	if (!local->use_chanctx) {
@@ -667,6 +672,8 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	ieee80211_add_wbrf(local, &ctx->conf.def);
+
 	if (!local->use_chanctx)
 		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
 
@@ -746,6 +753,8 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 	}
 
 	ieee80211_recalc_idle(local);
+
+	ieee80211_remove_wbrf(local, &ctx->conf.def);
 }
 
 static void ieee80211_free_chanctx(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..9dd51481fb87 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1559,6 +1559,8 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
+
+	bool wbrf_supported;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2600,4 +2602,9 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+
+void ieee80211_check_wbrf_support(struct ieee80211_local *local);
+void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 033a5261ac3a..f2ece7793573 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1405,6 +1405,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	debugfs_hw_add(local);
 	rate_control_add_debugfs(local);
 
+	ieee80211_check_wbrf_support(local);
+
 	rtnl_lock();
 	wiphy_lock(hw->wiphy);
 
diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
new file mode 100644
index 000000000000..a05c5b971789
--- /dev/null
+++ b/net/mac80211/wbrf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface for WLAN
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
+ */
+
+#include <linux/acpi_amd_wbrf.h>
+#include <linux/units.h>
+#include <net/cfg80211.h>
+#include "ieee80211_i.h"
+
+void ieee80211_check_wbrf_support(struct ieee80211_local *local)
+{
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct device *dev;
+
+	if (!wiphy)
+		return;
+
+	dev = wiphy->dev.parent;
+	if (!dev)
+		return;
+
+	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
+	dev_dbg(dev, "WBRF is %s supported\n",
+		local->wbrf_supported ? "" : "not");
+}
+
+static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64 *start, u64 *end)
+{
+	bandwidth *= KHZ_PER_MHZ;
+	center_freq *= KHZ_PER_MHZ;
+
+	*start = center_freq - bandwidth / 2;
+	*end = center_freq + bandwidth / 2;
+
+	/* Frequency in Hz is expected */
+	*start = *start * HZ_PER_KHZ;
+	*end = *end * HZ_PER_KHZ;
+}
+
+static void get_ranges_from_chandef(struct cfg80211_chan_def *chandef,
+				    struct wbrf_ranges_in_out *ranges_in)
+{
+	u64 start_freq1, end_freq1;
+	u64 start_freq2, end_freq2;
+	int bandwidth;
+
+	bandwidth = nl80211_chan_width_to_mhz(chandef->width);
+
+	get_chan_freq_boundary(chandef->center_freq1, bandwidth, &start_freq1, &end_freq1);
+
+	ranges_in->band_list[0].start = start_freq1;
+	ranges_in->band_list[0].end = end_freq1;
+	ranges_in->num_of_ranges = 1;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		get_chan_freq_boundary(chandef->center_freq2, bandwidth, &start_freq2, &end_freq2);
+
+		ranges_in->band_list[1].start = start_freq2;
+		ranges_in->band_list[1].end = end_freq2;
+		ranges_in->num_of_ranges++;
+	}
+}
+
+void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
+{
+	struct wbrf_ranges_in_out ranges_in = {0};
+	struct device *dev;
+
+	if (!local->wbrf_supported)
+		return;
+
+	dev = local->hw.wiphy->dev.parent;
+
+	get_ranges_from_chandef(chandef, &ranges_in);
+
+	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
+}
+
+void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
+{
+	struct wbrf_ranges_in_out ranges_in = {0};
+	struct device *dev;
+
+	if (!local->wbrf_supported)
+		return;
+
+	dev = local->hw.wiphy->dev.parent;
+
+	get_ranges_from_chandef(chandef, &ranges_in);
+
+	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_REMOVE, &ranges_in);
+}
-- 
2.34.1

