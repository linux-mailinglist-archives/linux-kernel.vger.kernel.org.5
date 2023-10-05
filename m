Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFC7BA047
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjJEOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjJEOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF226A6B;
        Thu,  5 Oct 2023 05:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps7XX/EA43at2OEwmBV3rRV/rYuPHk/7i+8cRQPsZ+ZM967SCH52fLxA+1YfOd57ac7jwWbPSWEJgSw4nb1LsJF665WeojmIMaKnR6pqNKRkl57aLLaaj/n/bCV1OPirgtWiDh2vejUfIebnWIlr4f8yOrPlBNDTBWaJPXouxGQDTd1ixhnKoaL0DC5y6d00Z8qyEsEONE9F1pp3P9Dtq9R7dtFY1V83bABaD4birryOakkXsXiE7OPw8rPHKld+JWw/uX++yIV6Jp+Icpyh07sp//qjEwwh9pPGkxIukrdfL8aGhvwlE8PjsrdzEElIH0QQ0/BMp5cbIQe60sVhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDghO7FeGezB8BfHg2/kDTYuJ2uXqEpjQB5q4O+a+WQ=;
 b=HmyYtazz7K70i/VzuXXZkjUovJPN6GbAfyiQwU7cmJudTUjOEgkBrJWmTLB+0nucoPeKOqrCq25U/O8kgCTYAjkq8J86rOkjS40hpu3CvNVnulI+7bmqlChpQZOIazgLkkIkRyaVSQ5W2HwUNCy8EfKu96CrIOH36NzvjsKhkJt1YLx3Z59gtswTKPH8H0MR7J6v4waUxCB7p7q8a6ai0VSybABrZ3Cg9myQ1u6PMDvVzieOv5vgzWyfAS3mHo1CWrwujRkMErZ+5bX228ZRjXH7Fd/WIJO2MfAJEPMHvf1sO/aPn4oHBAmwmSVyuctMOTwQyy75mxosqzLUDAlYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDghO7FeGezB8BfHg2/kDTYuJ2uXqEpjQB5q4O+a+WQ=;
 b=GqgvvE19cLpsPwqBjn84tHes40B2bN9XMUuJRQJ2FCuqCcPtoOiXUpXv077R0J06jeEcCH4xIOz2iEyZVA/YGJZC0GC25ANIWVgpmVRHKNjAPHGkms/+k8dbqcHDw1dIN3CYDo0em10S7WpV+t7TEyVnYpCuCnp8VG3yUtS/LjVWrj0O1vVAUPPVf80JMfypFubUTctWAmj7irt+9Jrdh/lQ6GTOBQur+ca5MUVrqbzP+ryKRquzr++NgKM85ZW/2FXHCNOpNZLNxA8MvA5/gqMhTXUu8AjmpyCojGrP6N5BQRwJcYFneUsLSo2RyOT7dusUR2s3Q/HvtGN6nPXQDA==
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 12:54:57 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::f6) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Thu, 5 Oct 2023 12:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.17 via Frontend Transport; Thu, 5 Oct 2023 12:54:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 05:54:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 05:54:43 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 5 Oct
 2023 05:54:42 -0700
From:   Moshe Shemesh <moshe@nvidia.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>,
        "Moshe Shemesh" <moshe@nvidia.com>
Subject: [PATCH net v2] devlink: Hold devlink lock on health reporter dump get
Date:   Thu, 5 Oct 2023 15:50:16 +0300
Message-ID: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a5252d-50e1-40ab-1525-08dbc5a246ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb+iadGWbKzPXpRgwmHS74RKikJFturjwymSXwHkD+YUqzcz182b+x9Y6Nl0pjV9lUssAugYukpFRWP2l5zWR11rbT9i+0bCI6rHUAIbM7gusXif9Rh0D0s6TeeU/IVSAjzY4n2ycakd5hpj1U+6wZurEvGmeLz9WVNxXQS5FIgVh/tRMgzWDwG4RLAO58TbwJ51NtRZbDJkjXA199Vgf8PqXvKQdVWCEmO+dDYAMT3tjB0U1MRDC8T2NuuTaBuzdFgwNo7MmSJ1STx2I9u9Bt5hmwwXIGlZjdhLQ2Hm0HEu17ZT0qSEQtvT+dEHTXQk1n9eEEf/s9PMaVb4KCjwkTkSQ8MWtgPwNS6QCf3NO2R0KPtbaX30N4ropaPyHTpocNCG8phskSWmnyGGd+iQFR6bwQh6ig/MDegV3nZPgRAZdeOn9eVGw0g07KAm1wBwewiscMsB3NwXwwyTTPIkaEWuWUonwhXdr4Oj94q9CGpA20LcA3OpwPDGZmjlAAFpRA9DJAf7mw0HyRzClW4CkjZZVtT7ntnCJRjI10hVNld+jlVhQNoxsRj0fFNuCTHmK1SuYlvh1bBANA/f8aao6XheqyRQC6Y5IauZG7H+l5vTOXQdkMfgyVZcyTntBLFAuh6TpVlLetvyM5amOmN7CovUi3ahIfe6WYt//wepMS9pfwkqYKspIevwpmRztbiHyCAnQHlV13GyKFcje5hDtSiT45Cw8inabmbR6k/2sLDRVihA/V6OHP5cdbYegUT7mS7yWb2dtmdGIqU8mXe/Uw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(107886003)(6666004)(7696005)(478600001)(47076005)(26005)(336012)(426003)(83380400001)(2616005)(2906002)(316002)(54906003)(110136005)(5660300002)(70206006)(70586007)(8676002)(8936002)(41300700001)(4326008)(36756003)(36860700001)(82740400003)(86362001)(356005)(7636003)(40480700001)(40460700003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:54:56.2485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a5252d-50e1-40ab-1525-08dbc5a246ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devlink health dump get callback should take devlink lock as any other
devlink callback. Otherwise, since devlink_mutex was removed, this
callback is not protected from a race of the reporter being destroyed
while handling the callback.

Add devlink lock to the callback and to any call for
devlink_health_do_dump(). This should be safe as non of the drivers dump
callback implementation takes devlink lock.

As devlink lock is added to any callback of dump, the reporter dump_lock
is now redundant and can be removed.

Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- Commit message, added why this fix is necessary and why its safe to do.
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

