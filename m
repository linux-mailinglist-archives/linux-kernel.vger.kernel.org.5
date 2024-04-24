Return-Path: <linux-kernel+bounces-156964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9008B0AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA858285D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3615ECFA;
	Wed, 24 Apr 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2lOAn9a"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B215B98B;
	Wed, 24 Apr 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965498; cv=fail; b=PzAXIPRnm/nld1fSASK4t7/qZOjfqPRygwYR1hCO5Gxa+GnTRC5mH0NMACGMIffDks1CGknnyUUuAfpw8VM4W7qeIxvnpL/mAeZQnRo1ucvPPno4oDC0EmdJcxhdCS4VLZmHXmEkh2pTDAVHs/byitxKUrDEb3QybLy7/u3Uu60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965498; c=relaxed/simple;
	bh=HBfSUAE8HO2a2X4SMNsQ9y/bEwbRmPnNjz/sM1xZotc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7LebpI8bDKjkfvIahLP1RI6SikRRB1ke2hDmVUuHOkWOhsuFGeQcn3fXgYuUqhKI/CL5pkmqniKaRDYkmDta0Vvw4wI4NehBGe33/UjAzVWmAvENO+nKfD4nfID7xBN0+wMIye9sYY9lApUgnlJylAptCQVUirp+NlpxO/q3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2lOAn9a; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld8bgV8G8DGWxu2SdrY+Dc5c6aVWsibhGdAFrZocweJ/u597NyHCmCbtUEGnd7leB7a2k0X3bdnQqwwS+SrqKjeWeofifCKH53W8d6haj4pazStzI/9emFYnADxIHRbXnx4sPSidPjh5KCe0HUao8aWqFoOb5GtWsqKIR2WHqfZWEztAgXhy5hSY7Okv74zDDwgQBIoTpOlU7/D30PGNtSS8eWbIWRYiKnbHmFxHFW+wOilMjF7KOISYojEI7DHO3N2a3510iYanUBdk/EL5zPyCRBkASETQBZW0JcXCthm/qATKa/ZG5Iv4eTYwUPmkQKuWAgDFQgmYuOJEWpCmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQK9sDNvbYSG4SJBkS7m1rJ72xo8vJ6F7v1calLBY8E=;
 b=TbxMQeaLgBLMVQG1y/T5midNxcOgTLkhAuwB8gesko/PBK/6DOAguBKGpm4bVj9wFlvllCBi/xGvy8QZ7QArbqV7QaSM0sFcOQpuCoHYr0y9cNdcjxCoMTIw3W2re2OU2dDmAZsPy8VIfxBft+ygdRFlHyuyS0n2suicdw0fAwwtVq24WCvbn0KMjoAKLvzsoxSfVVfhVsnFulNUg0nNUcG2/YQ6Gx9EYd9/Jq3ZGC9+Udlo9ejbmmGZyd/vvk/gjChHWawNXiUDi1v+YcTlVI3gqkC8EfGhpwWY+QqfYB4XF5PvPVs+XiXE1crXUUrbjcHsgcisAgmIv9WvF7bnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQK9sDNvbYSG4SJBkS7m1rJ72xo8vJ6F7v1calLBY8E=;
 b=H2lOAn9aeam0+ni+xesRhy+Zkg1xsL+ZTLhf720R1A/90G7WlPsjCEgxBF7r1R+3k9eHRMak7zO2duPR8lJ/ZJZXDuAtcLF0qjznnZEjKjxir5pT6sk8d0EgRtVr99xeAF9epkaPekswKDnB8vBhRkVxl+X8g6gIApwFEWXSXyeS7DjrhyYq37JMd5OkwguRD2ql2d4hlKU8whNGUSzRgCuXUKYbL1p6A2QPxSL+DKXcJQCS5Fho/PTlyu1PI6fcWwaK7pdVbnc9H0AbWr6DzSAzPhwUCzKycr4vlNN+agMHz4kAp5O8s7hO9j5ZEUTIOd9b7JRT2xteVkzpUKl/Jg==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:31:35 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ce) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:31:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:31:05 -0700
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
Subject: [PATCH net-next v5 05/10] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Wed, 24 Apr 2024 16:30:18 +0300
Message-ID: <20240424133023.4150624-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133023.4150624-1-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0217bd7b-569d-4357-3954-08dc6462dc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWkqy4nbr7bH0g1LTp4JBn8dMTzP6BkanG6QeW/BiX/BNMSjg63y/kNrel/t?=
 =?us-ascii?Q?h/9deJEAXEcawfKY0nMqIwIdb0EjfOKPdHu0iU9H80R5zykTuvkerSL2rLvH?=
 =?us-ascii?Q?ew9Cc4MY7CP49Sy7FZzGD4UgdcOVcl1t/UWIpbYseUUGgYUs7FOUQ9FdeLfu?=
 =?us-ascii?Q?KFSaW2mtXOOHzDRLgZ+F1cGjfhGCjXf2o+Y3HrDV9vZB9ym/fEH80+YAcfXR?=
 =?us-ascii?Q?FhqujY/s4CK4Tf/q121Qz9Ln4heSZWr5iYa6klE/sVMLO6MMq3VFqVBQE5en?=
 =?us-ascii?Q?iUQcL9TJZW/6LtNAvmzUKfVKsc/hDP8k9wBNn+Jf/cpLpaouFEPBqAlKb0Jw?=
 =?us-ascii?Q?ziLjpMhtyt5E6SmnrgYazOEs0eeSmdLiwqE4ffQQE9V6PbXQxfGMaWEpM7H/?=
 =?us-ascii?Q?viXIdrQBWSOHXUYZEySikrwNUqKjQcqWkuc9UA9j6qTkrMYyAI951Ccebz8G?=
 =?us-ascii?Q?IJzZyLfeFV0Cy6cBMy+vMeHrOGaa9jWovy3gd8bEjbWg9L+16FR+dlKu62zu?=
 =?us-ascii?Q?ACcY8Wf3pIkXXXzKivBNEdEB1nMQEK5KndRE3Q9B2sVjm8FxbUI2ZAvlFsM1?=
 =?us-ascii?Q?k8Q0sxR3Q/jbwOFDyjTGFpuVjUkMviJSJjVSvGCYreXtqYdb23NeI4D5pbhB?=
 =?us-ascii?Q?0hBgv0gz/Se7OOl2631B2MfRor+e3tNmSamh7WnQlxOrRPZ1L4U+IWRkrWuj?=
 =?us-ascii?Q?yFWkE8it2/UJN8+F8DGyTx890bwOWszOBzVG/AO/u+SkLz1RQx72dPBg+qot?=
 =?us-ascii?Q?L/qDG3MUGP2DMNKrZ3CAEmd8eGOpmaUnCd47EFlz8k7yh1PYjCjkznMYRuXD?=
 =?us-ascii?Q?OhuLxlVo4FfBPCHFjOu4amyFsDTMtlaBu+rWFMQz4d3ft5rPqJtdDq4eZifA?=
 =?us-ascii?Q?e+Uq8Dd9j1RyaFaYk7A2edfcuBhPh8hD05hVZa85cEMCW3KuI6yQSPSzoByy?=
 =?us-ascii?Q?nG/9s3H0LI02JqnIOq6niLeNu5sCosy3ERUHm23fnEmyrR4qvi1k+ebIRmp2?=
 =?us-ascii?Q?yE3dpkh5l6Hn5RuvG1nF7E0qm7XeW3jQrNb9Dl2J+XLvm7gOAaM9fEHUB56j?=
 =?us-ascii?Q?El1ePCPPWcDdKDs5LJTxzpg46mzJeixVydIi7m+D1cPFhRAIOGcx6/UL2ACv?=
 =?us-ascii?Q?EP3xLy5mHWZFcxTt6xBUme+QVj4hbQ7h06/NKAcTphL8Rof8HPonvTjHe7KI?=
 =?us-ascii?Q?6+dEGCh/NXgYLwoHwc6TAYoBCVxR2krEHPxsU7xYIvuvoyX1lsp1kB/xk63N?=
 =?us-ascii?Q?RxrQuYGimdPLrtd4gCIF0fEV/Xl+DqMp1m1XAwByBwfOuu4L75HgS9XwIIFD?=
 =?us-ascii?Q?twlVEAjHwDviB+OnouZTrIHPN52nf/8JhZc20pWVyADKsFP1jxSfcRa5fq0T?=
 =?us-ascii?Q?OgvX35A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:34.6740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0217bd7b-569d-4357-3954-08dc6462dc83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

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
index f849e7d110ed..68a18911c8cf 100644
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


