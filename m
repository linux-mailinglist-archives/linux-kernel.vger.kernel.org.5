Return-Path: <linux-kernel+bounces-107444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59187FC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED791C2231B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA217E585;
	Tue, 19 Mar 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K2d+yESc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B97B3F6;
	Tue, 19 Mar 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846757; cv=fail; b=mxJLYbXAy3+i+sYgBMkr03hOsF41AhJwxVl7/N5IYQ49HQbb7Zp4xUZX8RvzD5JHmiRufgeXJkfl9jPJrmjA6CmO7PjKBb00ftPebPtwB0MOkAJKyVMc8Wst0xNjs6QtQaMhwIoyxw9ZR+dATqjyZ0RjfiQXygFtenJ7kiON9a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846757; c=relaxed/simple;
	bh=czYLowt8c1HD7oJ0FENl8yiCqT/BjcBp1sGcoSndosE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dn2OEveJwCdfKG0tVvMRcrMF5sbC9UERab3i5eTGNl9dzICAqmPvkmRKXJny0L0sF0E/sKTFn5y2VHpzt8EwXUzHIOxRDd99MbRJY8bcQNK9YTiysfgAR/Qfvu42JSFezNB7LdQ1eWM6j7X3U9NGCcB7JB5K39cf3uNlAPYnQXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K2d+yESc; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBpU3+zc574kc+u1hs1AhLEn4ti6FfbfOYBwsiE9LAFi/REtdvnKbzWSgUYvFY3xFk6az9lJdyIfdz2eTiszJ//rJwCclaxEmy+GLzGFa6jjD2ECVKWbd8YRyyHndNRQd9o3bPGS6Jk/ycaa9O9n6MepZUuM99yJVBoL9hIvD5WO8JL1nRvEQN4m6A5wtf2PBeJL8xJ4vDG15W90od3ex27VUGgRONNqLqZ1E8cGIcGDoVnT30ivDgZxI7KNnhvD5bKarq8CCJsgESQP8Y/JYRxxpQfk2Bg9W44xMh1bQZu9c2xi3MyBRtwyB8m2QSlNIywP3cRHvv0vaQzsLhi/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOBwLDUfWw5joAJeQlWwsHK40AUXwyJN2xSxCNQWWzs=;
 b=CkKsEpVOOsw7dVcztI/Li6HowDe7ReigkkCKbdkCE2V0AqOuvqgoRcqrqcVKVyvVjRaJY9ZbmByrYtQgnnECMEkvm58SlnKS4LYYu8nvVxzLM/vonMeFbgg2smlzX2OvoKzgTd5gEgCUuwHqTRRyid/VrjpnMVjuWRZWDiUt2J3wSh4Wb7mc+209Ldv2B7SqFVnU/pryRp5sHiw3F1Dh1fmWFcV+ehpSa4B8FbKvzHzdR8JKMX/1XkdiEWhU3ODocurKx0BALiSWMEB/d4Prhhbg+IaAcHM0SACQgV3neGLX1xr8ZJhIEi0d+qN2ZkOrMaDiCVL8n4Iab6FA0GcEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOBwLDUfWw5joAJeQlWwsHK40AUXwyJN2xSxCNQWWzs=;
 b=K2d+yEScc/PG1fa+GW67k7dEus9nxI7R5VV9MV2dNdjBrGH+V+aVaF2P3+jFfWWlrbABjPU8w5eSShqqSMktqKnuQoEMsL2dy6RNI/4Px0ow8NqeOPAYrpNLy10PFIV8hJ9v0L6Clpdt6OYQK/XtZFDDSQJohqdPh2qGO4F82JA=
Received: from MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 11:12:33 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::96) by MW4PR04CA0279.outlook.office365.com
 (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 11:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 11:12:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 06:12:25 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 19 Mar 2024 06:12:22 -0500
From: Harini T <harini.t@amd.com>
To: <linux@roeck-us.net>, <michal.simek@amd.com>, <srinivas.neeli@amd.com>,
	<shubhrajyoti.datta@amd.com>
CC: <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
	<linux-watchdog@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH] watchdog: xilinx_wwdt: Add check for timeout limit and set maximum value if exceeded
Date: Tue, 19 Mar 2024 16:42:19 +0530
Message-ID: <20240319111219.21094-1-harini.t@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: af3f675e-6ad7-46cc-5b01-08dc48057998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lf0FlLdYa4ayzHD4qCvRMRtvLziOj9owRBI3u82vl89BYlFVMRJqKlqwq6Y6s6o/mje8c1j+ldcXqg5i39vp535ugi4AcMwplWrEDWi9YrZhhqipPT87yamvOWp124OrU5ILf8fHXi6xIBe3pvW3WREwkx074CFQI2y9w0/lNa6hQtk8DYrAgTnex5Al4MrPSALZZQVPoXZF2ede0eKE/PF3ORXO8FKDCEFKjKnvrNYIpJZdeH3unsUqp4Ndhn0tQ/w3DuHqr5aGKgP/taMFMSzUzUsX6s6LQpI3wIb32EqPCtkFXuWskx7NcqPbUNS8yjKiUXpOqVA8ocn7tYsciIPk86ryhhfIuyLjMYGMu8Il5dkUgIp/t3BGOjY9bClxoqqvXDOWq/JRB83CDwxKUgGBcXNu/x4RNjEc59yuTQ21dwQMH0nV3mzY7soEMxhHcsFAduHYubaInJee+ulfH1rRHIgUOLYsju3Rh7FUhjXfdOTHmd2xXKEDIkfOVd7a2QiNBGdTohdHfuNd5jjS3jYxsO84CnAdINK/LZscOn9Zm/fXMHPJLVyaTedBwn7B8NVF2byWzCG9ZE4saYGDdfP2Ok8FWQUWf9f3hgSr2IAMy1Mze9gMxYDWqT81SK/rorxdX49qLUNU5Ft8NyVKk8kEDEbM5HHrIbaKImzmokIvofzBmEJYz7gfFDhHZDMyDI+o7bDwbvkEmeQMPcSZk+zyN8zAT1ltesNQZ5h15MgXgO2THjb8Y+Pz7QXSwMIu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:12:32.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3f675e-6ad7-46cc-5b01-08dc48057998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

Current implementation fails to verify if the user input such as timeout
or closed window percentage exceeds the maximum value that the hardware
supports.

Maximum timeout is derived based on input clock frequency.
If the user input timeout exceeds the maximum timeout supported, limit
the timeout to maximum supported value.
Limit the close and open window percent to hardware supported value.

Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/watchdog/xilinx_wwdt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
index d271e2e8d6e2..86e2edc4f3c7 100644
--- a/drivers/watchdog/xilinx_wwdt.c
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -36,6 +36,12 @@
 
 #define XWWDT_CLOSE_WINDOW_PERCENT	50
 
+/* Maximum count value of each 32 bit window */
+#define XWWDT_MAX_COUNT_WINDOW		GENMASK(31, 0)
+
+/* Maximum count value of closed and open window combined*/
+#define XWWDT_MAX_COUNT_WINDOW_COMBINED GENMASK_ULL(32, 1)
+
 static int wwdt_timeout;
 static int closed_window_percent;
 
@@ -73,6 +79,24 @@ static int xilinx_wwdt_start(struct watchdog_device *wdd)
 	/* Calculate timeout count */
 	time_out = xdev->freq * wdd->timeout;
 	closed_timeout = div_u64(time_out * xdev->close_percent, 100);
+
+	if (time_out > XWWDT_MAX_COUNT_WINDOW) {
+		u64 min_close_timeout = time_out - XWWDT_MAX_COUNT_WINDOW;
+		u64 max_close_timeout = XWWDT_MAX_COUNT_WINDOW;
+
+		if (closed_timeout > max_close_timeout) {
+			dev_info(xilinx_wwdt_wdd->parent,
+				 "Closed window cannot be set to %d%%. Using maximum supported value.\n",
+				 xdev->close_percent);
+			closed_timeout = max_close_timeout;
+		} else if (closed_timeout < min_close_timeout) {
+			dev_info(xilinx_wwdt_wdd->parent,
+				 "Closed window cannot be set to %d%%. Using minimum supported value.\n",
+				 xdev->close_percent);
+			closed_timeout = min_close_timeout;
+		}
+	}
+
 	open_timeout = time_out - closed_timeout;
 	wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
 
@@ -132,6 +156,7 @@ static int xwwdt_probe(struct platform_device *pdev)
 {
 	struct watchdog_device *xilinx_wwdt_wdd;
 	struct device *dev = &pdev->dev;
+	unsigned int max_hw_heartbeat;
 	struct xwwdt_device *xdev;
 	struct clk *clk;
 	int ret;
@@ -157,9 +182,11 @@ static int xwwdt_probe(struct platform_device *pdev)
 	if (!xdev->freq)
 		return -EINVAL;
 
+	max_hw_heartbeat = div64_u64(XWWDT_MAX_COUNT_WINDOW_COMBINED, xdev->freq);
+
 	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
 	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
-	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
+	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * max_hw_heartbeat;
 
 	if (closed_window_percent == 0 || closed_window_percent >= 100)
 		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
@@ -167,6 +194,7 @@ static int xwwdt_probe(struct platform_device *pdev)
 		xdev->close_percent = closed_window_percent;
 
 	watchdog_init_timeout(xilinx_wwdt_wdd, wwdt_timeout, &pdev->dev);
+	xilinx_wwdt_wdd->timeout = min_not_zero(xilinx_wwdt_wdd->timeout, max_hw_heartbeat);
 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
 	watchdog_set_nowayout(xilinx_wwdt_wdd, 1);
-- 
2.17.1


