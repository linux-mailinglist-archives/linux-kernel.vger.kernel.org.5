Return-Path: <linux-kernel+bounces-48401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A866A845B79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9261C2557F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601D015B984;
	Thu,  1 Feb 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoxSgqw3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38E78687;
	Thu,  1 Feb 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801171; cv=fail; b=lcBC1y8CrcZR7mf+qye4fYeNUGj7/N4plHPmuettLuvRSk09hP933eXJ01ZdlWnxuxhSxmo0PsQ1WFXHhXq5iPonfb+PfPeBw0KzkeJvwfpT63fXnppinqO5yJap+cvIkpi+4P9rqBG1zyG3M1lC/CuJXGOR9kVFdMVMzgU0yz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801171; c=relaxed/simple;
	bh=1eETqnIZ+N5byJgyBmUWyK2NXqBoPQv2UGjGXOA6N3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue//++FKmbRrLIGR2Rwbqyp4s1Ez3YEZzI27MhlUMzromE0xsdGGd3lbv5lxPN57wfv6+DxBjPF9GKA2AakjGDh2EBI16lMsYnDj09tKWBYD+jffUHfKQ3MfGfv8zNHVF5DKmm6h6qS/L5YOWkS+7+c2S+FpP11SghAIDgvpHI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoxSgqw3; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnltIAUxoaqX3ht88dg1oEy5prV9d7VvtiGB/U1+SyS/HqZ/u81P379yUvsXrI+ZDNqyOxJ4AjcN/x+nTydoNqZiI76NA7yTcnoGNw0tr9HroSmVMOWcdhu3M9r9hewrOc4TOX4iEYKy+2R9JecEJHfzEogIbSmDwh/IwI5DZxMm2eJ798uq0LpvEmKJJJdSzMmAqcn7w5WdMx4Nl+SyYf29Wz0EUNDwGWsAyU6SK3VO24pIexlkEiM2M3AV7vzw9iTtHwwTmR4zzoGmfzKEipRIWVDIQRnOsjg5Sq+JyFso0Za83QzzkipUb/x+bt0QQGChGv5xqmWiQrvNm4HqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hO50i8u3SENJk4lf3SwUSfxiU3EEL2Ohm8aDjO+dUY=;
 b=fMoPQiQsAA+3S8k8ZG8Xil5b8ujPFdZ5zVbiVuK1XAotBo4ddYhxavfHD4VMMPw1dFehYpTvmpHXPG8iWh69HuEUqvDWxwm4kJ3i5mui2YJMWmRS9N5h/XgaepPXFjYwD21LDF6w1E4I0XEdsmrZALQouIH9Iy37rn/pdReI02WawFmzjsa5ppOy4v+Sk1PvxBlVUwAZRuy5BYhIvSdMThRbVXi0jsmbpKkWKGCfzRaH/DLeXSpHWjkzxh7SnY+8WCY3UpnSq1e5aeyFQCINeCw7O2q7W0QM6c1Ltz/KkHTgNjovzu1zh3LG9UNTMcDg3R1IAJRLajcc9yK0uxDuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hO50i8u3SENJk4lf3SwUSfxiU3EEL2Ohm8aDjO+dUY=;
 b=RoxSgqw3qKV2Hi6jRwvvofp8YsQCi0JGbwlYRQmUzXW8eLjTShmRF0ipjPUpKNV/s6AYyJB8ArcUG1h1WaYdrBsu9r3l5LuyKmXMtm1xdwQGwzw52Ltrf6GYS+2f6YBGWQe9XJQ5VQCEDTthlsn4jM1cskS/6McapMJYGMqotMGCtRH82v99CDa2pWU0Wqw7S+yXc/lf59vtgPpdWwXU77RatmLvdQyaoXexBDT6L/k16yWP8rUTeNdG6dVJOYRDhh9vqYzZSxfRGhwREOuk4+pqg/3cGoc+LzciqkTS645PzIFjMlhvcfpCeHBW3lmdgrcWrTVj9nAi4293HrNzEQ==
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 15:26:06 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::bc) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 15:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:26:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:50 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:44 -0800
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
Subject: [RFC PATCH net-next v2 5/9] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Thu, 1 Feb 2024 17:24:57 +0200
Message-ID: <20240201152501.3955887-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1e897e-33a1-40cd-1810-08dc233a1bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ZA0gpv1RBE9o+viZRXReSGfrfrAu09SkHUGVEjq/Kp9j1RwCYsgwD2pZjpJScAdfP52/W9IDTiHZmWIJzm4VHWGtcgAr6qA9ZgntUt+R5XEEPVAk2SP2tsK7PuPnTxk+OXSJsjm71RruWwW4fYlcsXLB1oPImDEia/tvZdjCv+kfhXatgIIqT2dK+sB73qKWkVWtDCpO5oDahPt6aUk3XzlfYHEn8z0aw0os8PT0B2Ifm4RDxh096ctzLGPxr3ldxY4Z9OCRjpkDvOiAR+ZbMU9dNfR1jzwFrZDYj6ea8fxQu+6YdXY1v3o04iKEFbgmAIRhhIANE3BZmfnuAjj2DDsaZT5FNF4650CQ5dEqAXny6GMgOuz+Av1pBJqENXiAXEoUnw6EAQ73tSZT2s/YuHBcW2CIK5EEgxouBPgn6P790tIdeeItxw2CDJ57pV9TESzstrcEmWSUHcwhzeu8WsVoy1058DpkH1qiofuZiI/y7TWhCcX71DltXLFtK8QfWHfTMfW0J0AGQmmY3JjdzcFxtyDDKCLq+F9bGw6ubivYqFSs3zD3NlxJWJzuHaAyju372//iiDlLkqC87svk07WyVnPznQfZAKw3JgwZ+llwixjhi1O3CmziF2eQoJtAwCD8NeiLGfiTipJGJZp3O2Rw6oEfW76Q75g7y8Pue1YO0ci/rEhFgJcsthzzLV8pUxmFIGrFSuL1Yo35CH1w2PQUjy/LAxZPnqqQvwrWopXAonkD7NeZxwJZo+TwIe4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(36756003)(86362001)(356005)(41300700001)(36860700001)(426003)(47076005)(2616005)(26005)(107886003)(1076003)(336012)(16526019)(2906002)(478600001)(70586007)(6916009)(70206006)(316002)(6666004)(82740400003)(7636003)(54906003)(4326008)(5660300002)(8676002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:26:05.8254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1e897e-33a1-40cd-1810-08dc233a1bbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

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
index 1845dd5043b4..df8937ead7d4 100644
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
2.43.0


