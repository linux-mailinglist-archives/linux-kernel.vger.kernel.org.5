Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA480C5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjLKKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A412B;
        Mon, 11 Dec 2023 02:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL3Kl6oapF1PBlqmpy5k8yJeptke1BziZ73YU5rKWNwJYsysGS7V4CzIQeHwkv79pHDIepO5n9GEU6yv2BSbTSmzPrfIlaMXsND99qeUC+sGX5WLypwB9oK3aZEYKhMeD1CR8MkfTQQCUhBcO64I91Ipf/5EJzsipoSDUoY0Ef0DJ54tyiwPo7/adYi3JWLBtG8KIXIskUM3SNtTOPJfD/IDCEvPGyrQGalewc1KniuIgIUr7yYXgke54zipXTrJDONmxpjyVmvJBVdcH/g3v93hmIXBco4qzCP9LGHpq6A8Mk4uypsyDUGBm3WKTkqL6WICLmgetyKukXqeXUHBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/wBKyGGIB45ndx95MMnM6Duag1kd0fpvxX7IeiP5XU=;
 b=Zk5uUPQAjDd35+LnCXAO/4iehricb1GKD/Xomavc7+yzSbfHsofX0b45ox6FDIJOmTX5ov9PisqAigftJXc4PiDA1Xc/msB2boA8gFIDmQZ/DHzfphNsP5gz9qDN9I6PxSjYA7WeGdCKGiW0jFi2eYbdQIonJb0wyDhWCNtkDF/aC1Qkri7fYnudPSuZLc9+lMA6jtVlcrvqiJjKkyhxDGG5O06RlGOcpIK0v0UMgvjFtqghEo6A0NB3nO5tgVjxV3SpmYtRtkheFYsoH7bjKD/pVzARyrXxtf68nUOeXHr20r/80Vo2GRq1n3IA2862lQDTkWfQ2rqu8z1MLtM9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/wBKyGGIB45ndx95MMnM6Duag1kd0fpvxX7IeiP5XU=;
 b=Ea8Tw1Va22FFkyLa7NEw1PsseYZF++QBM6BMG9rEQwQKgUm/HuPw7VMPwrZqEtCjTAwXJRzv6ZbHYcwUi3tyUcb/SmzpsxqW3H7WjMLZsseONZJmF12W/OVDrQ8S2ypkgeUgZY+oO4pMRpE6UjhSWYucapase0Po950lft4tWrM=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 10:07:20 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::86) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:20 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:10 -0600
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
Subject: [PATCH v16 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Mon, 11 Dec 2023 18:06:24 +0800
Message-ID: <20231211100630.2170152-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 03453d89-eb3a-4c2e-d3d6-08dbfa30f6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSQZmKYvrg6dyQbGc9WQYIohqNd6M+1XEHxWvyHjNUnOdFWpixueWKMnUfbSC+Ml/ZMMq38KX1sjQfCXm4jrbWw8YUEJt1jpEV1PAE4sw4rLCNYI2apHPZpVChQJ6BgvRi222//S1qjt2SOBG9k7NDke4zcig6N1oLrcU7NQuqOJfZUvItlZik7+wROhFMAVMQIKygS3weOY5tWxkQFg+RAb8oNuqRJkERD810tYQQsOckV1db9qaj3Os2+/Z1qFbDI4o2ly/IJVRX14BcHglHsJpA7SsfM1uQ+xyKkbbBcLITVGNKaxoGShB+2brLqAm3O71JRrcex2MsY+oPiO6hv1IexASO48QxUtwKGb983jPrinkV/OYjRPPsKxe6s1xgE+hFtFLGszgrDdbBiewwiqpMwAcfL2aahuZlb1NYRtAiFo2PezKfn42x7thi16wCGBptiFkrIFgWyTxF0R4+xkzlp0ZZOb1d0fPJVK0gTRmx8RsTA1hovFIYRltPCfptkBsj4ZZ/DrHXUfQPda0kONUY4X37gjg/ay5aBO16B1mHWgzxEAeGDybs6TGmpMj+BaVQcq2vm4fHTaJ2FGxLFSjdMADTrrve2g6JJsk1BWWE1wJfyMxC8aMGGVFXiauDGCoEUOFG3zO47VLx4h7JZTMGyx9FtTqYk3n6t2RPVPOcgdsOOEqsy7TDsDGDmawHOdIZ0ir77t4qaACoIg8J07ySCSRYjXIqof9NNwe45x4OVn6cXYIhZUi3a14K4ijl2iPy2wwocGzxe9bEhhqCb9PA3wc9z/nw7Zar2EhVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(1076003)(26005)(16526019)(45080400002)(2616005)(478600001)(7696005)(6666004)(32650700002)(336012)(426003)(83380400001)(7416002)(5660300002)(41300700001)(2906002)(70586007)(54906003)(70206006)(110136005)(316002)(8936002)(8676002)(4326008)(81166007)(356005)(82740400003)(36860700001)(921008)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:20.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03453d89-eb3a-4c2e-d3d6-08dbfa30f6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
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

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
v13:
 - Fix the format issue (IIpo Jarvinen)
---
 include/net/cfg80211.h | 9 +++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ecfb06c413d..c784e86a6d99 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -976,6 +976,15 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+/**
+ * nl80211_chan_width_to_mhz - get the channel width in MHz
+ * @chan_width: the channel width from &enum nl80211_chan_width
+ *
+ * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
+ * is valid. -1 otherwise.
+ */
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2d21e423abdb..dfb4893421d7 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
-static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 {
 	int mhz;
 
@@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	}
 	return mhz;
 }
+EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
 
 static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 {
-- 
2.34.1

