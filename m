Return-Path: <linux-kernel+bounces-32552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB2835D07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147E21F2355D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27E3A268;
	Mon, 22 Jan 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppZgUnQu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6F3A1C1;
	Mon, 22 Jan 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913196; cv=fail; b=lj49hLEV/yOwLUp5seeDPfR7ghC1w0OHZ8cnE3T6lRsaqz7M4gH9LGAxKeviKmtIMEh2Vx60TRwJWsuAGKpBdaRSgDF+eIH6uXltyIzimmCCuCSUV81LQorNqBMXQg0aRc9CNwzdAXOEFSctXPHUpoc3n/KpjZL/DBl9uqrXbRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913196; c=relaxed/simple;
	bh=zhuE1rZicWX2AXzR15Z31led0L/WimQNyXp5JoRx5U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU36z66+AA/TkE7lfR0xcwXomIU9op/DW/DmHp/0y8jYR+tEf/Q+PdgDKZSNa12zCSFDVMpU5+MZrKaluoRS2OPaazX5RRXj3sj18P0PEZ/Lw6u59DjLoc7R9PeUaFWDaONfLChv+zAO2+D59nRHMJuRgATPa4INEP1VmIwZRKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ppZgUnQu; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=absauFqjdcJoN45c/l7hcfcq5pi+YMRRaKlH6Db6g2SVQfv8764BzJdN6B/vLiKB2+jm7tO2R9uzklLTu0SNdCnXTG7Me/zS4w+6x2tFEkt/m3iGkWF9MMtqXcF3ic1t//eOAv93GAVcHDUtfeES5WYOHawGT6x5rHLRChjjh686vxlSpvihqp92LDPisAm8SF6Ena35FaJIKOptzQ5WrjN8pt6Tp3mG+wSiOx4UvtScpMRpHH+T7x9cOn484WENmrqC7NazReU3hkYlWU/NvY/yJuJFAJEAg2gD/gXnwXGAovNZiK2TsIg3iDaC7sY66Hf7OVkK73Th2ssH/MlFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QZQV4QjYbmSpID7F0sWWbLxTIFxC9ENB+fQ0lsSgbc=;
 b=cl15WE+8QpjgOn0x+C9Z9d1KB4aHvB4cw52Uk2qWP3eZyrujiZ+TbOB7VP5SQfiWxaSPJtHEqSSI7/IgSrQzshXniOKcZv0iilYlgahBrm5if3CwtwatzdgbIu7PmWqEx0OCtIKXBlOfx4hDyldUyZ/vlrgBZtBhLRErP75fxlcsIA/n58x0tlcbTeVDTjn3uTAC7TIFyNTKxVSdovxOSi2fkrISApKAYdgRSSfP7GFG78lZhQPsnPj//6qpd45tg1FGD7pjscy6dDonWYxk13LXVD1dOEXwnHb2zTCqydytXTGXfK1uZQ37unNy4a7bQVzCZtdtrbHL/Iu+/XD81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QZQV4QjYbmSpID7F0sWWbLxTIFxC9ENB+fQ0lsSgbc=;
 b=ppZgUnQu2Z0Yg9L6baS5DNJOXN6AQWwjtz8n3QejpZHJ6uehblXVlMWC7Vpa4cohvunp5H+TuCW9HTmZoMq30uSTWAB3uYU5/7mMLazw6XzMtqsd+gfYMBs7ds66yFkCS6PkhYLzXQ2q21GsHR/Ld552gq3GJWvwGVof2O4a4c1sQpR8NW5vwfQBc3L+pckMuki3fluvFHY032wX6wM06GyI2G+u44RDXpIeLA9cuospW6Dcw/HsU1CUxDOYELPCKWok3433WZgHOLjNov5dYNByKs3tSLmRvv5zEQyHJFWPI98DKZ35SSswW/IHG99U2LMn6K+WvgRCHNQkUCvPDw==
Received: from CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:46:32 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::3e) by CH0PR04CA0023.outlook.office365.com
 (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:46:24 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:46:18 -0800
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
Subject: [RFC PATCH net-next 6/9] net: sfp: Add more extended compliance codes
Date: Mon, 22 Jan 2024 10:45:27 +0200
Message-ID: <20240122084530.32451-7-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 445b04fb-4124-4ee6-8246-08dc1b26a263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wSOs/wH9MZgnOvMN9AXsj1npAgG+zTaMuNsrD5s5eD3ejbf3XyFNUKR/rdQNpViT6j0pDI+uGjBml/xZgqBczTth24cFf/GzCMTgrlmy8LrAo8iefmD6CuuAY/pvvLryL5g9QEPy97EAZvNgTAR76v6tzzyG8t0a3Dm0upwpWoV9DheZ/Dfy6cEAx7P8JLUWLPYGeB8UXC8a1Cx9BofGsYWJv6zgjrxCe/mJoWcL6pPOWnh5attAPgkJOhFQT+CQl5GgKApbtKDDU8HzxYB6UDDECl/ys9xKa1CHGE8MMUJLkvTizb7HSbtdFXVUl1GQeNzVS8RiuPzxHZ1+co3cZxSbr4ewRNSaqhwZWUiEQH6+LlmRGyS6qMyT9YH1dQRvfC0NjVuMKSVumaxAbzRLqIDLDPKfrKbMQ3xle3q9X5PWuI4uO2/+if+yjFfzU+uAqN8lQgZA5D8UdQd9pDEtejomLbHFmHt6PsBy1gqdD5ASWTzvskEyiKN0Kuk7aYkszegsPhxABDimcqwZFQlJZU4nuA8h2RsUV8zkRxHoM3fbscBrc2pJb8/sRsURgnK3zRKmcT5Fms5DRPr0UcgSwZUx/zdoBYGo61QBXA2EEbQE3Ld4A0/vd6g62QafKUtYIkg5XMw5WTjxEun9WoiTs8YOZGFl7XMDAUcMnccLI2/pyWP7rl/pwdLNkAQGL5rMWfjvgBeKV6j+Z9Yc3HNuK5rLrFIS8KgAYADufMiQOPGjlaYZT3I40cI0TWu6BYZZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(41300700001)(86362001)(36756003)(356005)(7636003)(82740400003)(36860700001)(336012)(426003)(107886003)(2616005)(26005)(16526019)(478600001)(2906002)(316002)(54906003)(70206006)(70586007)(6916009)(6666004)(4744005)(1076003)(4326008)(5660300002)(8676002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:32.5499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445b04fb-4124-4ee6-8246-08dc1b26a263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

SFF-8024 is used to define various constants re-used in several SFF
SFP-related specifications.

Add SFF-8024 extended compliance code definitions for CMIS compliant
modules and use them in the next patch to determine the firmware flashing
work.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/sfp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 9346cd44814d..df2eb988854f 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -284,6 +284,12 @@ enum {
 	SFF8024_ID_QSFP_8438		= 0x0c,
 	SFF8024_ID_QSFP_8436_8636	= 0x0d,
 	SFF8024_ID_QSFP28_8636		= 0x11,
+	SFF8024_ID_QSFP_DD		= 0x18,
+	SFF8024_ID_OSFP			= 0x19,
+	SFF8024_ID_DSFP			= 0x1B,
+	SFF8024_ID_QSFP_PLUS_CMIS	= 0x1E,
+	SFF8024_ID_SFP_DD_CMIS		= 0x1F,
+	SFF8024_ID_SFP_PLUS_CMIS	= 0x20,
 
 	SFF8024_ENCODING_UNSPEC		= 0x00,
 	SFF8024_ENCODING_8B10B		= 0x01,
-- 
2.40.1


