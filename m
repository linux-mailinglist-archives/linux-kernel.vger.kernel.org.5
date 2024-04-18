Return-Path: <linux-kernel+bounces-149897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F608A9786
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB361C20D90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E215EFD3;
	Thu, 18 Apr 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J99RFltK"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65154FAB;
	Thu, 18 Apr 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436564; cv=fail; b=hdseA66XxJVXqbgKWfviG267hDyBuxHYE3qEeddgnY52r852ZFzwnOU1zT8xcl90C7Fgvx6fexHG0Fhpa58hqIABO8b00F5O4G286wKaXgQcJgH81EC6vkML9AkTiIkJmR3wxPEA321zmvOPZQ9geB7b1cp2r5MZc0cjaSmjXkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436564; c=relaxed/simple;
	bh=QyEJTv+ju1WUuRomf/6VJUg5R13KnCo2VxHBZutDlq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akY166XnS357Ih7w0p0DfaVGak4iNwSd4tD25K4mZ2iHrDBg+7eFZi9BIn/GFYwkIYltD3FTXLvyQgz6vAjdFFfHXrgu1Qh1S8Rrjn1sxx8I2z2v6t1FmYzoZeZVtxHiHmBfz+ePRDABAkCiKHlnb/UH7mA7sXf79v6aoG2U29Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J99RFltK; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcm3AkQr9ejkzoXKl2gtuxxHU6dhL+PZoV74ACBf9FA8tCn8e+ix05R0KcZdSGuURMl0niCmAMZLNQbaAfVtiQxGjHOfPQ51hNs48zxZiUGfOAZctFiBY8DbeiDqj7nIHte5rjTCRjGzj0z7T4YahKrXIgXch0NtbPMfzGnevb2UTVRkKSJjbxjQp2b+sWehSYg6C7g4zA6QXcUSzrgNrPcVFgTayoGYr49lMP1u/9/M60zvoc2Ql7akRo0mioBvPo0G6JkCfQ6iKHtlS87pEJQdKouRyJFs+HgHWS0g6fazMDuBiiKVsdmuSXZD5UefyEjrEchD0+5OoYTHsF10Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=XmrgmVhsmeLH95pOxCkidbE5+SQvYlYxLZQsbu4vMboTTA+ldfe3K7YWvHZnt7rxx2xuFN06CAVtzW3JoQuNsugouSrqKzkwRmqwTUS8wBODbTj9k6HENSqAnFl2hhR022+pZL1VMyZwnFPjdzQlMLQjLDB97vEvPINDAiudxhynalPrn9HRQHRnt0JCrHHBf/4YvS6cBqXDwaNTwwrDsj8B/GoDRIwq4Su8uIR3C0WHP6rjHcSIcKJcDhZE+t6s5zjQlIxhUXGYpuezn4I1vyJo2yzjfFx1E6SZqBLg7BTSOFu8uRSxbNhPbvm18ebo4xdBFwhfqVWD2kZ19U40Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=J99RFltK3ybfSy3IoUOTkM6Qs00Ym7jE40CGmQx4koNbyx9SfM2ayF4eI0cag3LXbTHQRyK78h58/Z8mJvzIDl7A4y2XY6crDsqtcCEzmZ/tlIUS9zXR3r9bodAEAhnqPFuZOVwLF+qRwF0f4bE+YOSJVcCWaOfNPdxYAVIirv+J/I/BUa4XAA5fszL15EmBfUsPyk+jhuMBWTDlskerTTdUxMQesEM8y+jL916BCIjpt6S8K//7XpRkCkDbBWaTw4G1vKawRIiOB13xTMsxQOIK8Wq4lKgoN0ZtJ1t0eZ7FNUU6PNAKf2M0XX9G6RbLG0ALL9LHHsKqjWS9Piczdg==
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:36:00 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::76) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:41 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:35 -0700
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
Subject: [PATCH net-next v4 05/10] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Thu, 18 Apr 2024 13:34:50 +0300
Message-ID: <20240418103455.3297870-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418103455.3297870-1-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 738c1269-e7b6-4cd0-6fcb-08dc5f9356de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p5uTIQg37wUyXD+B5Q+YQcspx0+YG2MY4BKWkbxpGgVG+n2Ae8B9hzko4dpvlgsb7S3OiYOmrF4kdRxRyP30yaxEyGJcMnLCr6qt+fvcpQKBLJnTZbOr3gdW3BCcvQZZ9Io2sjkKDGNyoAN0cem5WmLVyJyUSl7cVqOgU/Yokl8f9ZzzV7GB9K/r3joeWBl1avvmXmFbrovgsyGxHaOyOR3MZ0auR3S8bbMg8T4NlTUhkfVQaEaNGWhfb/CsMp7PibCWS9QDGyHPTo3Dpq41iMgr2ol+ywqKi8dUSA6/tP9TPvIbOaaQmciIpah81p/k7oq5JLxrcrFTsyF7F+xT3jOnpDUCvLi2MXhwnesumy6HXhoGOamM/NgDmCc/Zbw34mljmi4fvG24TGUFPW4jf1ivAR57/5sOhr7Yx9geX00C6Wwysa+JxBuqotFVRbC55AaEKFZ9TLhgXVLAxYGv5T6SD07+bNnq2Cn6pnwxdkNafRfOE1jFrpkqkQXPVlesmxJPXtpzdyriha4h+HyaxiujZ0N10+9G5ytOAXzXpsTZIj9MlQuVmCApSIlHIbEo53geiXqXKxer4V1pkMiMYczA0lYNdf/FzhHoNs1WfSv+tjUfKAwwY2GusJeuJIOvje01DLRsJWkcjp65anvOuo3lWqC6NmMTdRlwR3Yi9PUOqcVQuc/fQRqEG6Z6YKKVP9za1GImVZBpDTwricujfrEl7aA09LPuStobl+Lk5hWv5/EJBFqW5rrJUz0nn+Td
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:00.0454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738c1269-e7b6-4cd0-6fcb-08dc5f9356de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

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


