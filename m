Return-Path: <linux-kernel+bounces-145035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F68A4E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86071C20FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5C6F07A;
	Mon, 15 Apr 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A0wvO9L9"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F76997F;
	Mon, 15 Apr 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182914; cv=fail; b=ZP53y4VT+T+CQakLg8AEsEThFKjRyjt6Ow43FHr5h+Hr0xdr0sccwkrKWrYaD8QBL665M229jqHqmfxt0Rr3wGKPYAMvJWztLdQZD5jT4WlPwXfGoqz7s7vezhVcA2k/jFvSUTELs5DNyyGlA7PK39ikhCcGze1vM1ZOBVzHPms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182914; c=relaxed/simple;
	bh=QyEJTv+ju1WUuRomf/6VJUg5R13KnCo2VxHBZutDlq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mesLSqVN7QtAcR2sIUxKy5cXtptZODRLDJsaavKqA0E2jfwz8LLoKYfERMp/vv6b+PLemryE0mSh71bg9f9NHXtbQdBP7ZXsVdw+j6+vSfqICTUgf/cpBtKSd0cYQy7fXsHPgKXA4XoCiPk3GZsGP5Rj2qkgWTBe4ios0qA899M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A0wvO9L9; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihi4EgQM1d2ytX2rSU6ARbjNYQZhpMVVwVs5R3tHZ4gD/+4KdigWNbwgv+mH/TKaBqpnSeAU78v3M+rKtVCBwQQbArIBtFNtkb2DuWQuMbVWa1Ds/Q6X+thfY/FCUXibR95/RfIZHm3RZXNMMU1qELyLzpUwRf+I49qH5EULqg5cEBsPNu1DWeWArPLAjJqms7rEM2LNbTVRKYe+o58KaWOo1BmFPJL7pX+OmbUVAS7umgR9R8gElsUny1Ndg3KVQQ0cp//SVhYcPXiwzLnWyA7y2Mpyg1IO271o2c2w/9BKZ2Qr0YDNb4EUKWjkT3TS1N6sS1ZIImyrnPCitlDgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=D6hGpA9Nn9CvjEAgrcVqPXVcYTlMn40ThS6hEAJvK9/Z2LQDw9KVhYQnkQvY/XRMt0dti81PBzqFyyF+9xUvcb8SoiRYwDo8yD4D2GmIzHKh25fw0JiKCmYymKDO24EF0D1/Tbnf4TFpLctJBfclDhYH4lK5dsq16bqkln+Tte3VDvKvMeyibmmgF8s/VoigxiI5g7tPZbnhI0r2fG3QAGeQIst3GURAxMv54FRFqu4xSuBa1Y1LePidf8z8lr48GUHl8L89FcNxH7Vb3nIM/UCMXDjBbhKWOMt9p/Y9vACqW6xBSnZwyUVoTauIK8PbQFaJqmNGbWN0BoS245orqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmEPOJp/OF4fh6S7KCaOH+lyLGhpUOti9wiz1S7s9Nc=;
 b=A0wvO9L93iyrXjFInnRI1meS93LFAzXEqGMN5EgC1uBmq8ouOmrn8LJPR16fMKVFxdHX6wcBdpFig4515z8KQKLfECWK3OdO08NmsWmnt6kzB+k1m/rxJWTP4eeoUX7SJhBtbX9rSMn8197Y6nQgf+B3+RwJ2w4R00exIRDqfEGkMa90r/Sflm4cz0Kmw+//4ubKqySAAs8auS41k2GO+EjFIWDsQZ4nkh+jr8C6rL6NDr8qyYnzzkhTTofSXdSBCAUE0G2TLCRPs/DlZ2dZ2tpa9DDkfmrgyRCsZ6XHS4ZsVMrzoaJuoxTB4XK7xfNS++TdHSh7/DttmHG2gPk1Qw==
Received: from BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 12:08:24 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::e0) by BL0PR02CA0082.outlook.office365.com
 (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:06 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:08:00 -0700
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
Subject: [PATCH net-next v2 05/10] include: netdevice: Add module firmware flashing in progress flag to net_device
Date: Mon, 15 Apr 2024 15:07:12 +0300
Message-ID: <20240415120717.1251864-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415120717.1251864-1-danieller@nvidia.com>
References: <20240415120717.1251864-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: fad5ea08-45b0-43ce-18c6-08dc5d44c00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtHDKfYhoqIw0v9+regJDu+tQVycJM4q/g2U9f4BcnfrWVU342bZLNWPo0+4sbVOkf2QNTNzQU/uA6/kt/bTB+PFgSLndS9AW/MolDKsvmjGY6DlDTxawnk7tVxuC1XsvGgOervaANRu0vZckh5NGXus0Tz7kGpNMSxFTOe+pPezvOUw3yYyYzphHaMYPJSEWtC7XQEvQqyKpJKOo2xOoUFtR5wyp590sC8CuxD8yUeEHI0qauq3VGgAKu4rVV420M7YZ8gGPhNXpxr9W8Ks0bDkVhHmzNhmrproI9f0Hh1VC+CZcxxGz5z9byKQ1/8Ekab0a6UeumIeDekujbgGphXVGIAOgMwz1E/WVum9NgbZZAVjnFqSS/pE+Pq68w8p2WDWeO4IBvY9mvm4Pf/DDpgPMb65V2H3YhIP5Llixt6Z5kT+ERnsv1ES9hcOetqmGeWGN5qU/lvhg4rDF32jfQdFfJdMcafKXwqePXVayXYLpn6NGhx10gSkG1RaXl+0f33mBko2aolxqDBtz18VeAFCaKz9b8N7c/cErE869Uc2J+9F6v6vZCyejOfMSGizjmwzh/2qc/TKlrDnlbDUTmEWr/2va5mlKBm+FioCIyYArRUC0RX6yI+a2j/uIskaV5uX9LeG2RQAcwDlIpTGJPTYq3InXDW8bPHDm0G69qOqEFXRulw8HsMac5kEXx2E1HJ3iaPBFucRVrpDCVmnT2O3TCK2h+im50pKmS265lNJS3CdRimLjiU4ahr1Wb5R
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:23.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad5ea08-45b0-43ce-18c6-08dc5d44c00d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

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


