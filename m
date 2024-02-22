Return-Path: <linux-kernel+bounces-76788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9485FC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F91D1C24513
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605414E2C3;
	Thu, 22 Feb 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dK8fP4oy"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EA135A67;
	Thu, 22 Feb 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616346; cv=fail; b=lPxSPJAh46c4gMAW4dRSRjngFag3wWfPp/OYJTZp0hpaWyOsOhTuRJm4Mzml9NDc2+obYEIYNPN1zloz8qLBUre9U5nRJyZ0WPKoevc3P+czMktImki14z+TrkuDUfGB9pfl9qpMksBpa+/ujuhBLfy7xPvJBAqdNsvsVJQD3Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616346; c=relaxed/simple;
	bh=qI4WOQwWTn+7M5bezZhlzLvBL+cT/Ltoieh1NkonlHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kd25vDVcOubwZ5n1QUgATGgQj6ZfoNfthx9v4Hnzt5nJO0NAy2ERyBcfDfwUR8J5NOeATMBDgfptnGP2/hIimoIS6iDhtQJa+JNR8mot9klmpr50ku3mrpOOcd6O6CdaU0Pl6EjMTa+jHk/rrdUdPoKdQL0bpox+c/p5LR+/RHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dK8fP4oy; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVEXMyYY3ZcnSH+yt6T7F9t+X8j5iTwNFf8/zTh1F3qJXMi153L+QB46pCsj5vV6eZGk7wzz2YYQ2ZMLmJmwQ780fA/Mh1KVYu6sLhRJd9u8gV/3oLdiiqAZ3Gyh7zMT6AZoeqfTphSelie3uUe8wMbyZZNng6YcHo8QCKhAdgMeeMEcjWk2hWq63bl4PJtSBH6Kn7sE5GW4atgBV9nIV4kB7DaqYaRnOJG7onOWkRT/vnNaMvgdbbdro3xtKDOMoIDLXbtxEG2t6GuD5bPHi+G9eFpiWhYS/V7EcZD3xze7WRhdVCttOnOrZWcaUBBWfNgVu8D1jeFSYCCZD3iCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=462XqMe00tZB/KAoaobwvlb80Meg/13cV2cDWHRgkxE=;
 b=ZGhFLD5n4h7XHw9wxQnCzXUoFESGGNnnWeEMt60GYXOXP+NZav0M6oZLQqI/SodevC9fK1TpC24qoLf/D/BY0tMWzrqG/GMdVD0DLPIfoealPb7D+VwFlZIixtefv4/zHjnPV+pFv04gbFpRHylvUrPDiCaru17oRX1Mzux9Dz+epUtDor4hjmNkHDtT7JrT7dbbyQmfok0VtOEJEKu6TuUCnNVSX2PZl36xEw5+AQDEeT7wc3wDIhDyAwa/Nd22Y8R8K21MuwUPwTuKzJz/hlkvBwpvmepF3aT8QNLKEWuPZbNl4RjJmtVKYM8nb6/SBUZfU+5CCJa3F5lVbFHRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=462XqMe00tZB/KAoaobwvlb80Meg/13cV2cDWHRgkxE=;
 b=dK8fP4oyAB/6BhcwgC9akOtHuR4mnU1YsVhEu5UBWMvE7b4/ebsXMNhgKUqt+hL/HkoeC9r3cRTo5WTzS/UDN9377Fx+RGPpvFBgx8IaTITUsxin97saHivwUQlILc7nQHNWPAcpP5+Wfog1mIORhAGn7U1kFtBhvJQitiliza4=
Received: from BN1PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:e1::8)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:38:59 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::5b) by BN1PR12CA0003.outlook.office365.com
 (2603:10b6:408:e1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 15:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:38:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 09:38:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 07:38:58 -0800
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:38:54 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v2 0/4] net: macb: WOL enhancements 
Date: Thu, 22 Feb 2024 21:08:44 +0530
Message-ID: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: ea097517-a497-4ab6-d29e-08dc33bc634b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3hGPNg54zE0vvPDy3oLZ5pvDMWIpwybei+Ntzf385j8msCqpfwtQNhWxH2kZaN2f3gcw2ZIKYeAtV9k5aQp8wVSsIwfWxJZ9U+8LX7j5Fkr5wraUX/z9C4ebcprWgjR/TingJvmhtpRQT7SytDCc7GPH7QiX5rQG00kZdjd/p9ksh/T5Eb3YcBbV7zMUkx00d9JDLzDd5xRF016EbcgGd2+XZYE7EApCWRmlLwO5crcrmyTCFVHtDknoeF9lm3oMYqbN9r+uH6jzUQDG+nESflpUOlvcvAaV2edZHmKHnfXw87ArSqMknDZqoyJ+OdiSzDoSD5QjiHSoZHFYn6wLSyt1QBxUjKMJVJYGQn1zTmZqAVbZSACCEEreZSpvPoCfjUCBUCH5JSKaNARD5czxou0C1Injkx5jYVC4VLFle/NEo3JV+GBVEGC2bwCtESQ64c5wV2unlK1rGjGwiA/40VxBFzFa0AIiSGE/sq8Bd/O//rcZlvEI/Fv8zwQMJPl7B5Oui1OSyJM/rpibeq1jg59odg7oiFdbIxWCHgpBqm/KNh2HyDrMpWErITY5/5uCseCUCCVeuWfbAjcNdPSZegr3daWdRHAWEyf9hWcqynTUs5fXS/m5o3O5k2PL7S4BaMU/5uT+HambIb3ielZtPDLu6xPiCA/eme9IastLDCE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:38:59.2080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea097517-a497-4ab6-d29e-08dc33bc634b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

- Add provisioning for queue tie-off and queue disable during suspend.
- Add WOL caps to support magic-packet and ARP modes.
- Depricate magic-packet property.

Changes in v2:
- Re-implement WOL using CAPS instead of device-tree attribute.
- Deprecate device-tree "magic-packet" property.
- Sorted CAPS values.
- New Bit fields inline with existing implementation.
- Optimize code.
- Fix sparse warnings.
- Addressed minor review comments.

v1 link : https://lore.kernel.org/lkml/20240130104845.3995341-1-vineeth.karumanchi@amd.com/#t

Vineeth Karumanchi (4):
  net: macb: queue tie-off or disable during WOL suspend
  net: macb: Add ARP support to WOL
  net: macb: Enable queue disable and WOL
  dt-bindings: net: cdns,macb: Deprecate magic-packet property

 .../devicetree/bindings/net/cdns,macb.yaml    |   1 +
 drivers/net/ethernet/cadence/macb.h           |   9 ++
 drivers/net/ethernet/cadence/macb_main.c      | 118 +++++++++++++++---
 3 files changed, 109 insertions(+), 19 deletions(-)

-- 
2.34.1


