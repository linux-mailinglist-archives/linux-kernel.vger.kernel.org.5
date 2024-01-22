Return-Path: <linux-kernel+bounces-32551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD6835D04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC1B24A80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EE3A1AE;
	Mon, 22 Jan 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoREH7k3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF9383B2;
	Mon, 22 Jan 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913193; cv=fail; b=O+t5x0oyJ3ceR7QJbOPu2Ci3jupV21sMJXNiUDFpNXKHZ5b/q/+PQT23N8PClRr8nfJUPAFpc7YdAN1KoHhX18UuwBu3fV4Gjx48O4Th6QprmMr9cYPH6TBSAx82bL8AvHBwr75D9qUCixH+EZxmusOIL6pW3se7yWBYLt+hdMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913193; c=relaxed/simple;
	bh=befG10zAJisEI2oqZKTRP6IogoAhrWj0v9++9UzuBM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYMhA6k2wdkXHXgc6yw7skDzWWlTTTa+7Hter2DZ0z12jHiLSUjNleF+zyiEeBpoFR+sqBbzcj3PSrEmhkEJQrUQlt68Odx15Y91NhFu0g7C+QmZIdfUE1uPXPk7EPHwdS2IND4m9va6FOi011X4YMYojOxTGhGyqUkVSvkePyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoREH7k3; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jry4qKnuzh5BMMg/e3HyAt1Nqrj1o7gu3Yg08GMj+2R022hcWjk3LIMhhFlsmLY2Y+VWVFgK5gwUO/iloiePiElgdAdWt+NFLTh6n3dXz62iIIwm/M3ZYfeQGgiYCVz7A+4qwf6W9poLxHWI+2VZyD2uYsOb4CTm5Lmer/0GHw5KEoN6Pp3I5tswBJSBMr7LWEAJIV1iKZ2Dq/wUFXXfZXsnTTu6PzTSOq+S16hjWT/EbAZLIWNT7se9f3hfiWFLWHBwK7ghQyqxaJYSlEKkmM8qdG7ThqHgqdw0vHjqDLms8q0n+/Cy+/3260QRe01n3KJVn5tFtk2wJWZ8SGKHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKcWA3CsWvDr8aJryflbVSJ+UKItcmsrl24ATk1Bn1M=;
 b=EdWlXzNXM2nYhTeHMP8E0m3oMqMAr8tW0ouuEphjRf3hd+NO3lwE9uJv0C0igmtvlGEWteyqHU8lvBX8AfZTuSpHkPrkN9Wrn/CxsJFtfysaxyRgkU0/QKJ6t3Kl4BUVo2cHEf92Oy6Rwz+yhaq5g/PKmzgHJbIG+df00WEUwDln45bbB8qsetO95PP6/IwFEg6pKLdKMGsRWdlO0vE8xaXt4Wrf3rVjvMZg4v2n96VnugaFuuHf9YuLduHdduYDhuKIA+L1bw0NCdxIMgGwQpiCoAgyHnHWZYvYvnX6T1no5klmoV/32Q05kiaK5mngnTMpvlrm08ts5sJ+mbsn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKcWA3CsWvDr8aJryflbVSJ+UKItcmsrl24ATk1Bn1M=;
 b=uoREH7k39bcQ1v4uENXgvZrcJcF+PiIjzcPMG7UeKgvu9NoCR4rVK5sdbZGppR5q8TcG9vI2WxRVrM6MmUhu/DeeOhSTIK2MMOJfDM1O5Mtv3HHyqpNRtQnNiHXuyval8EV8AQj8GgF7kIhLcy9OElSDpiNnp9aqOkMTmhzujSpKBQ8Mnchx9c1/rNSZ6B2PGGFw62RqzHxjHy13/DLX4zHdc1e7UZdtiUNDhKWmy+aOKutdINHejk7cwoIT92i5qE4y03vR025IXFwkLVr65Chs4HGvxjGYLq7iv5OSto5kvVyGbAJFsaNHf4qQnHQO/z2jlxia5lWE8hah3+GDNA==
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 08:46:29 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::15) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:46:18 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:46:12 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [RFC PATCH net-next 5/9] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Mon, 22 Jan 2024 10:45:26 +0200
Message-ID: <20240122084530.32451-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122084530.32451-1-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 31847263-1f48-47fe-f0c3-08dc1b26a01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uRlPuDvZevb/oa9LgVsCfESEYIyzuJmRaCXmvJALNgvC3ei6cDk2sE+5Ws97N8JPhn94bQOttqQBlIHJMcozoyZEbc4a0ImX+myUvZ9XznHFgs5edC/s+MxNK1Qu96xGjmHe9uFGETDf+zkt/33n8V8LpfSKAD0RCM6GryPB+sdGsvAvo1aTVvVRnjJeCDgM1tI8LxbU2JEdxl21e8wazlobcwO5XhzWwubvfEQ2cIphSOdvgp4Cd/wonptKC/Jj34G+KnIoTSuAZEbLYmKcM358ZNhAHGpTM1PjpVOSYNztg1uFCFQWgI411p8dze2jn+VZpAfZzOysZKAwQR+oTBstU1+Wv5R46zcuYltwAIJ8xHSk3aPK8+5EdSTka5UXIcbLNgKJagbWL9M94SVaebSS+bu6LeiZ0m6R20R4Iz9ZVrROnpgC9f8e9+VZabNT2qEDlrsbfvOhmiBRCGs/7Q2bIDIBu3bqXpy3R/xwEctQ2g1/eFfMwNittuh7qlJ3QfKVPQIKYFkpgekEQFjdMVCDG44Bpbd0QnZXH+j282xhCj/k7OrlIApbYRIIXhlTfLFEHWApr33VHRL/E8hhObW01zU9rqcGHDJL6fs5hOgYBlqwqWKo6h168jal5QcD8s+0ZjVH9oZ6vQS7dQ/aRLQstWM2iNlEVUQoAkCv7HiFrREC0t6vdf9LowrP91QZnOSYoONv8102Qbj/O8y4zreUtxE2XpkOcDHc4LuTyi7WF1FR3MeZL59dtsmE6LcD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(70206006)(316002)(6916009)(70586007)(54906003)(40480700001)(40460700003)(6666004)(2906002)(47076005)(5660300002)(7416002)(8936002)(8676002)(7636003)(356005)(426003)(1076003)(2616005)(36860700001)(336012)(26005)(83380400001)(82740400003)(4326008)(478600001)(16526019)(36756003)(107886003)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:28.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31847263-1f48-47fe-f0c3-08dc1b26a01d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

Some operations cannot be performed during the firmware flashing
process. For example, flashing firmware on a device which is already in
a flashing process should be forbidden.

In order to veto those scenarios, add a flag in 'struct net_device' that
indicates when a firmware flash is taking place on the module.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/netdevice.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..af42125ead69 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2061,6 +2061,8 @@ enum netdev_stat_type {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
+ *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2447,7 +2449,7 @@ struct net_device {
 	bool			proto_down;
 	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
-
+	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.40.1


