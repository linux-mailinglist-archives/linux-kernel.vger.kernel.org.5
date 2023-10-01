Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D37B4860
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjJAPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJAPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:20:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D3DA;
        Sun,  1 Oct 2023 08:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjUA+TRwDK345beSzl+7ZQLwdVEEwbWxmmeZwsZ18BezLdKhvyuN74ZKlNef1i7KZdwXJ9zl8gcnHksWCYSrzxjlN7OnqqJfGWFGB/2Hw9Z1agpK0gm3IG1moFWQp0EsslmIliO6bkmjkd531bgl+xqQGfId6bVQHH0DYr0/XMiZW4AzIuCnDCX37ltqnDFmtpdO5y4e3MwWLDW+Fjg/kb45d3VB5O/CH8BrixDvN6T5iyOsMMNpGJNGwkJI7NipAzXMo0wtlLjTHJFM3n4de2JxcTczM4KzjkTOJfA4h7ymIuVNc4OTf+XgqZtYFQj3p3TS3Cce+eB2ZkxcOd3l2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdnT5UI22ExutNgKdPeO+6ijC6x0qBz2aPHjv1708sQ=;
 b=QHnqZ2cHPBCMUJl2ny0IZD1XpGz0HWMoSzL5laknm3KfScN/nzJBfSYtMGXS1r0sJzBFPnwaXuBqbJ6hwh3/7amSC5o1vuJTzndKEaj4CVbpj5VrXxlAFGByeGc317lkuJqDq7/mXr9g3aD6ThoodaXEu3dIahA5Rb+/Xm+aWDBlX4ebZKxtEqzu2/1c+AjE4NH8MgajoaOl3wIULJqJxXeMESzfz9zGMPJknvLcGB/TFuYJq39CGNS8+BtoEvaZfbE4grxVPvF3sDonLhF8j0v7ENUJQWBWTTdytYIjWOGSMDo0M5c+CMNJQfiFFuPvCGCVF5H91zgeRT3eEMX1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdnT5UI22ExutNgKdPeO+6ijC6x0qBz2aPHjv1708sQ=;
 b=HBFwo8GHV7QbYGwShn2f1yJhE9vWB2BborticCytGK8YS9IZLNPFe2wqrKV3ZymKG70nfS0/INStzPrGV+1apxhiPTtak7VK0FMQHX/nz3Nbvvw1NAhbupDyjVYuZb7dHkcTPcA3YqkN+Fekfl0DL5kc4AuuKW20H3vMXOTnUCzDxh1hKxDsoVbuXdn6cnD38nhCQuW/oEBCpttuKPsFLV7sq9NoDIo/kbij+zBYPfMjsPw/zpIOaXObeMvNGalzeqa31XES3ehE65ViKItQ8igNfIt0cd1FtzB9cQjovAQSW+ipBneaYESVmXvIvbdSdd4F2Sw7cduRitfWh+4pgg==
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 15:19:55 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::b8) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Sun, 1 Oct 2023 15:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Sun, 1 Oct 2023 15:19:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 1 Oct 2023
 08:19:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 1 Oct 2023
 08:19:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 1 Oct
 2023 08:19:44 -0700
From:   Moshe Shemesh <moshe@nvidia.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>,
        "Moshe Shemesh" <moshe@nvidia.com>
Subject: [PATCH net] devlink: Hold devlink lock on health reporter dump get
Date:   Sun, 1 Oct 2023 18:19:40 +0300
Message-ID: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 527eb304-41fe-4ec9-6d7a-08dbc291dd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiiYzhjhAaWrBXH7rOnYIG8I6WYjFIeLgWtm8oyP4hZ80HRBd26p+OCgPhoHZ+l4IXjRZdkvmZ+QbOWqgjAhEdVtWpfaRuF0D8Ve85eV7WgoZ0q/kcPamoGcOsv2zduazBGaNxxBDXHvTLpi/0CyPJCbNzbVIGVGpsiW/CuZsFZfJa6EnnEJx7tNr8w8+eLWWut3YW3gnpfNLjrhNe0qWKLan5Vwb0pRihhpf25gQCY+uGjOxWYJz9OI7RcoR3BMzqxaOEYzI/hYGBN7722x+d/R1b5TzNi8m/HXfrf8LucDT2zkCddveWUF9AijlpIz0rojOXV2wsjMYacTY5c6a3mz6uXAdo0Kftm5bh9qYEKlzMY4Qp11kI341Js2+Sb1y8TbjAiVxRmSnZVedJoC6XBDfHaGNhDjhiqLBKihO5HGmaVYZVyT2xbfoNHCVC7mhR957tOX0eFMZSlhg2D2aXJ0j1H/CUk+6KmPPKVf2s5lXJs4f9uDryI5K++I2ZFfzDKpM/7wiJDosrdWRf29hVwdQY9gYQ7xeHSBStYKfqYMw4Vef4zf729eNu50ASFK2G8YrTYEIltNeXZrWTqsuuL9g4gX9rf3B81FmV55bX05wtEYY2JaSRXvPCdaN/Yv+JQTdhnuu4sTRojbOLQBZs2ibGFQJAG0APCr+PdIbkTSH2k7gkmuk4d3AIJnVREO/nrMat6nxqBqxwIntXJSnhRNZF4za839xP/jCfOVlCLD6L8/tVtkgr0QR9X8nhkdVj8YeOY6j9vGvYkdOt4LZg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(316002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(36756003)(40480700001)(54906003)(110136005)(70206006)(70586007)(478600001)(86362001)(6666004)(7696005)(2616005)(107886003)(82740400003)(336012)(426003)(356005)(26005)(7636003)(36860700001)(83380400001)(47076005)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 15:19:54.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527eb304-41fe-4ec9-6d7a-08dbc291dd75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devlink health dump get callback should take devlink lock as any other
devlink callback. Add devlink lock to the callback and to any call for
devlink_health_do_dump().

As devlink lock is added to any callback of dump, the reporter dump_lock
is now redundant and can be removed.

Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/health.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 638cad8d5c65..51e6e81e31bb 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -58,7 +58,6 @@ struct devlink_health_reporter {
 	struct devlink *devlink;
 	struct devlink_port *devlink_port;
 	struct devlink_fmsg *dump_fmsg;
-	struct mutex dump_lock; /* lock parallel read/write from dump buffers */
 	u64 graceful_period;
 	bool auto_recover;
 	bool auto_dump;
@@ -125,7 +124,6 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->graceful_period = graceful_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
-	mutex_init(&reporter->dump_lock);
 	return reporter;
 }
 
@@ -226,7 +224,6 @@ EXPORT_SYMBOL_GPL(devlink_health_reporter_create);
 static void
 devlink_health_reporter_free(struct devlink_health_reporter *reporter)
 {
-	mutex_destroy(&reporter->dump_lock);
 	if (reporter->dump_fmsg)
 		devlink_fmsg_free(reporter->dump_fmsg);
 	kfree(reporter);
@@ -625,10 +622,10 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	}
 
 	if (reporter->auto_dump) {
-		mutex_lock(&reporter->dump_lock);
+		devl_lock(devlink);
 		/* store current dump of current error, for later analysis */
 		devlink_health_do_dump(reporter, priv_ctx, NULL);
-		mutex_unlock(&reporter->dump_lock);
+		devl_unlock(devlink);
 	}
 
 	if (!reporter->auto_recover)
@@ -1262,7 +1259,7 @@ int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
 }
 
 static struct devlink_health_reporter *
-devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
+devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
 	struct devlink_health_reporter *reporter;
@@ -1272,10 +1269,12 @@ devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
 	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
 	if (IS_ERR(devlink))
 		return NULL;
-	devl_unlock(devlink);
 
 	reporter = devlink_health_reporter_get_from_attrs(devlink, attrs);
-	devlink_put(devlink);
+	if (!reporter) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
 	return reporter;
 }
 
@@ -1284,16 +1283,20 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
+	struct devlink *devlink;
 	int err;
 
-	reporter = devlink_health_reporter_get_from_cb(cb);
+	reporter = devlink_health_reporter_get_from_cb_lock(cb);
 	if (!reporter)
 		return -EINVAL;
 
-	if (!reporter->ops->dump)
+	devlink = reporter->devlink;
+	if (!reporter->ops->dump) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
 		return -EOPNOTSUPP;
+	}
 
-	mutex_lock(&reporter->dump_lock);
 	if (!state->idx) {
 		err = devlink_health_do_dump(reporter, NULL, cb->extack);
 		if (err)
@@ -1309,7 +1312,8 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 	err = devlink_fmsg_dumpit(reporter->dump_fmsg, skb, cb,
 				  DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET);
 unlock:
-	mutex_unlock(&reporter->dump_lock);
+	devl_unlock(devlink);
+	devlink_put(devlink);
 	return err;
 }
 
@@ -1326,9 +1330,7 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 	if (!reporter->ops->dump)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&reporter->dump_lock);
 	devlink_health_dump_clear(reporter);
-	mutex_unlock(&reporter->dump_lock);
 	return 0;
 }
 
-- 
2.27.0

