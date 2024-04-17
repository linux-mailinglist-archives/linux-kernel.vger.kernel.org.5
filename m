Return-Path: <linux-kernel+bounces-148184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C748A7ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B781F22AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02A13BAE4;
	Wed, 17 Apr 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6PxIzDy"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017913AD15;
	Wed, 17 Apr 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344094; cv=fail; b=C/BQF/JcdlrkOG0ZmhLwzIappSGQt0hOGYH27HuciUzohSIKcAMu/zjlKIvHHNjrds6XAMx2rYuHxA2ZiqEg887oVLAkOtyOpZqPF5auFqchNogy1GIRCoygYNteHakNrzstdjJtWwsgHLrJ1zNS0XdOm/5r6ITFcX/LwzcQmiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344094; c=relaxed/simple;
	bh=QyEJTv+ju1WUuRomf/6VJUg5R13KnCo2VxHBZutDlq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7mCjfV+uwnhbuchFnrfRMsMlzLe08cGQ0SAfBWgXq0l6UzIMnk2L7QpX3ypU9rOFA50YlgcZ1qIuQVA6cErabA1UydHulxAXpN6/Z3iRBeBgtHLjWO4NhBHzTJz3lQkPi/Ka55dWxohjP1raSAtGDXByrGwIBdu010yXO7UGbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6PxIzDy; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FteMxxS0TJqKly+wie098FbUR1fyXgB54XqvqYrBDWh7wtedy31luS0OLNaOfvFZQAud6gU3RiN1gUdLdF3Z2Q8dI5Wy99IbG1jm6GWIRtv+haorTz5NfNSpYda1IJ8pDir/FcZ2bSWHM89ZFe+iwxStyXNAjBlW0FX8iFCVI/mWiZKI+VvbrHS5DPXrKvdHwSACKCBDuAdDXFR0KZWWJbtFabD0aHJid6MxY1dhF7TCfbo6FD0/x/dzXvwQxDCrg6JelMIWI5RaEsjlo7e2tVTBb2k92mnh3HwnLhBH6D159WVMfvAPhl8M6Lr2I4VKLDnQ07WC8a2xsax1VO0brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=BlpbBJ/hgJegJ2kX66zncWMPgvxImYVPYadk+WHNMR0FWNeSOjxWfMtBRaNWGl7xoyqJvFSgRwwiEjoCcX3RUfB+fSGKzuXhvD5g+F2sDKR2T8b9eT+egjvcvmnA+CwYXxeaElM5zl3/APsIAuXVtc1sOFUC9uR94YEY8nJEaYL2HtFXnHeBbGyw+mwmpM4tFjtPQnRZbYYjEmootWB3156gWvvb7/pzvyjAA9Obs3NqTbML9C+uMleqhZ5mKSKJ3KcUvo2kNLFtMhPutvjmJjr6qqbRnerX/cLUCx86FwvCW0HZxgjpTrvY8haISymksEovHTSt+ZpWWEyQSDd4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=Z6PxIzDyxzUHbUIc9XF31X4qRS4T+cW0sfd9BGuhwxCdCRvXBrJKzPvSGgqku4nKRjnOZE20XvnbK7JCPlcyXsEWRnutFtOZV4lRa2dZt+NuTRQggxzwu0uw8EtGuLxIDmLPSE20gUfuU07PLWq7VWq3IEZU3bGpoGL64JpdxP6f0tmn/YSCvrQTO4sgnQZdTGVIAwp3oIA+6TDFRYoCWdDNCP5/PAjIARaHtat2v2BMjCHYZesOmvSsMBxo+FVjK2+HTLuQ+SfkmgvQOG7W5Y5q9G24AYdqDhtI+ewyzsWQGfYP7tFwLt+kumM7cCkwN1dHKcy0ZdPHM1mV3kamdQ==
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:54:50 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::6e) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:37 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:31 -0700
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
	<idosch@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v3 05/10] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Wed, 17 Apr 2024 11:53:42 +0300
Message-ID: <20240417085347.2836385-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417085347.2836385-1-danieller@nvidia.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: d9060071-20d9-4229-b675-08dc5ebc0a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qdzfZUs7Q8FgIq1TmHbe1PXm+HgNa5t+0ZZ5uFwIQ7cpes97o/ewtMZGqQzcRXpzSJDgAOekCqTA/iU3CpCW0PdUDK7fW0CCWQin5Xe/kq8FrZgITZ5Z3raNIBnDAoERwtTmOR2dVxep3AQddcaYRD5PB+rfnsb4SC47nrxzlVIm2uGhhfWz8WYxnEZqj3UHAc5upLaGL/uFfdmf2fVpMIjv+R14lirhD+jnq1bU3JkjrOISpg0Ka85ZUQmGpUozLsmjTMnPwqCEaqdA2qbzSB5fsmRpci2AwbCeWu/85CaMienqEkGAqQKRk+mIAJPCOtMnycWQUhrNafWoxDGV3QVXxAaDm6IBD+QYkwPvr2fiPyrApzUGqQdvs6BG9WmVpWo4xpuFQDaP+S33Sp99i/flCs2WU5qHJoWhRGw9Z9Og0gA4hHufnNc7a9/gbpI8umcOwmCQbxK6cmWdWdG0nKQXfpFloB5FooqeCfMxC6XVKxm25RiUlwNP6pFYU6hT44Zg4tSgQdCIfyXbskCuVSMN0d0zgmSUxXaokkdkWkBNo5xpHxZO2FUDLSps21yK9yhPC5FQdEN5/XG1kk8zRRurJ+WVWsxAgdawXWicF3cF3ZwESKDsHT+4LYXL+BIRtUj5qaEZJWMV9iSlEHn38pRcqGkeM86LK2WJ8EaXJSmf+R/sJHHlsZqa3FtmVOVZg7ktLfwGBpMT8x2k+0eAEOaMwrD9tJfkUPU1KFJI44nZ8mjLtDgydH/s/vMyahB0
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:50.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9060071-20d9-4229-b675-08dc5ebc0a99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

Some operations cannot be performed during the firmware flashing
process and will be vetoed later in the patchset.
For example, flashing firmware on a device which is already in a flashing
process should be forbidden.

In order to veto those scenarios, add a flag in 'struct net_device' that
indicates when a firmware flash is taking place on the module.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/netdevice.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d45f330d083d..5dfcacff1db0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1989,6 +1989,8 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
+ *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2372,7 +2374,7 @@ struct net_device {
 	bool			proto_down;
 	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
-
+	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.43.0


