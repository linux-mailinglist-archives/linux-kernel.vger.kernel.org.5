Return-Path: <linux-kernel+bounces-135368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A996789BF95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0592811D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB77D413;
	Mon,  8 Apr 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnSb2cap"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAC7D3E3;
	Mon,  8 Apr 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580892; cv=fail; b=kEkYd3Jym5KXyrDK3kIVUJfadVfshytDTH8vnf+0mm5yf9uhqS/UNTh23bHaV6CL55XYcuyVtypQlOO8T0eMlBPZ/SRQHSiKQb4ukGaQk8XDix8+4WuDAw76I0LY0gQYM8BL6YJhdpftYH4zShNpKXXIjpnJaGWOXcssdjm08pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580892; c=relaxed/simple;
	bh=wZ4ewcjhNRpk8BiB1HPgoKPxngnbewRfM7N1GGoKjao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IngylfJeAl7km7J5vvhFf1I9gH02McW79AOXTV+lSb8g75C3nbUW2qAIEQuKBUYeRz1PQWq2FnfZA7p+gvBxHnWWMNAzqUfBZgcDrjOBbsP2LPClb9otveAkxMyn/haG5l5jpIvNxQHEy1510ipXBtCr9HmN62jkHegv2EEfZSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnSb2cap; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBhg97iQJNGBnQ6l9UHwO9x302lMPmrICa2lFfTU7Lh2qnNeiPiu9//BqyVd1yJEmm1VXJQH5mgE5VJU/6rbMFXrPhFPrYYc+O8nvIV9Ujmgsy7XP7jOAApqBkd1hvzfP/OG/+eEbDbMUdR97okAh6x2JP7tKZZ6JDA8fQL7pMAOgTOoK7nBkF2JyN7i7u6a848cUxvLR5gyaxKfYdgiCwEih9R+o+KzpCvAXsA+E1+TtLZCto2z39XLLHqnW5rutmSYnOajI/0vaVjk9d0ErCO6B054ZtFirVhPijgcQl4aEpSXw8/SwzBocsWh+d/a4tDWyGCr4+nrVkdlcoMdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwmBrBe6U0U7406Q3Q57tjDTxL9Na6CGq95n6NnZN8Y=;
 b=HKrCUpvKhq0QVk0Q3TArGxp8JXFdZYoUt/q2aV55M6+psa9/obSs0KRrUF4aWkd6j2SKfX1lkkkTYDtB7z4h/xiHxjwDolW3Yk3qwVywrMNyBvSbf1akBXpWMQldMQjzpaAzZxaxUbx9DHOhKUUDwZO233ULwT02tIcuSMVfMNV8chunvtHk7CrbIJDbnijAuAfxvubZEpNkV035OokQKogfsus/FZF1w1JyjXuswJOQJ9ZIh99o2cmS6Hl0mSA3gz14qfHOB1KDgZWDrKpABGYCRH5SRTbl5HepcJDBXdclIc9DrY1NliOh8RcPviMktVGDj2owtR22BGta+dK5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwmBrBe6U0U7406Q3Q57tjDTxL9Na6CGq95n6NnZN8Y=;
 b=pnSb2capKXuZE7Qw2dUhqdJPZWbAlYJnVCfH5rGbjPU7dQHSzI7Qf/LHm8gH1QYFQL8qTkPqoC+48sa1OG8rpATLLjB/4QJ1zcdvkzS7oZ7YGktmxwpGYhIggmWBaPXV8+gxNDWYRGKtskSo8/QKGBh11Xwx/P+ltV5vyfhZgEtQoLsmYc//ptabmbliN+yGOIl/KFGJDurawNiZnhfyP5UAOL3aL+eUCmGVjlv4Tyn1ReJgNCWl3Sb+G+mu+INuA6sq1ueOE3rz+jzBQkbWxw6dU1y86b7kUbYbNy3JrPVwxJ8Cgf9lDNUfyDjJUWNXg60oB5G8+aFKuS8Am+j87Q==
Received: from BN9PR03CA0682.namprd03.prod.outlook.com (2603:10b6:408:10e::27)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:48 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::b3) by BN9PR03CA0682.outlook.office365.com
 (2603:10b6:408:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:32 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:26 -0700
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
Subject: [PATCH net-next 05/10] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Mon, 8 Apr 2024 15:53:35 +0300
Message-ID: <20240408125340.2084269-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408125340.2084269-1-danieller@nvidia.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430a6ed-a81d-4ff1-dda4-08dc57cb12a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qLIcIEuR2jNj1JNOcqbrUC0JgzOUYWSKMyIc4hmeIRkI1B0wSuBjO7R+YfOfrojJ2XBR1G5n3NuEjqik/gMvXJjv7P0OaAEZKEdxAZrXWxQK5/6+Z97DLcWOX/Gu0CpMFCwL9cqOe7DkK/rBlyC1BqRSkL1izcW+eqCSi4F7E9WGpeC2YEUMUMqLPoSxj83oW9UoTDMLTNeOLJGsnXuA4PHW1dWm9VhdRgXDA+baab/eF0sTgdkj1k5qMH9RkExqG5RsgIT8/Wo8K2ealleTgDwYA/57zWMTifayY2a8RIwVYshynnGiw/IohBLs0BEDzODf7ug1k3vTqRdNk/JQIk6GJ6YV6qBLaWd6OeUJe40D3TA1MxdOryv6393RGEJezenLpUh0yLO+7+7tbJHYqAy6SLr4t0GxfQnJSs1R3q2flsdIr9/ekUu1mRsfR0hRRINpR8n7CddRumSoeipoxOqRwyyfnHX28rVq8WGST77ppRERS9whwqchd0+LSoptGdTRsYEFunPZBv5l9i1xZ8uybU5yHR6/9YFYJCetT1fG5UU0RqgxEeGK62q8GiwYjO1bib6q8w7sI0el+weHLmz3lB70hcfrXsKTQtJRP/8vbGvYy/45AsZJrVHyz9znpw8EmH2LAM1sjQm9kqAOnUMrIfvuFHbf7jbj89b3LVqEjiwsPc82r58dJtcHrS3HePbtg7evl2y0xmAEg7hlT6X8G4FcHsjwIxAomecE6dt0tUvYGRTyEGoFp9PW18P6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:48.0770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430a6ed-a81d-4ff1-dda4-08dc57cb12a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101

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
index c41019f34179..878e29084b18 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2070,6 +2070,8 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
+ *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2450,7 +2452,7 @@ struct net_device {
 	bool			proto_down;
 	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
-
+	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.43.0


