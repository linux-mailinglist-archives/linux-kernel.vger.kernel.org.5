Return-Path: <linux-kernel+bounces-107228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546187F999
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374B1282F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D183548F3;
	Tue, 19 Mar 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OagVWmtv"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110E7C6DE;
	Tue, 19 Mar 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836683; cv=fail; b=Hr3GbK7edUxlPxY02HXnBs3hQnkKYEH+Fa4GO0jMKuGZ1lknlYlSosVtKI+rnTJ3PJs5lHmuf3nhbKuNdExuAbPeXftax5AHLTa4WKCgRScWQ0SQeu7ypSNgJv4ATVWOAMApwWIt84Ln0qXd2B8TGtvU40GcH2M+Pm5VNKvjRUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836683; c=relaxed/simple;
	bh=lt92jjJlbT5xE/Uw2WAR3GCPO/H4u86jjFW8BR73cHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4SRkHyVFktiotaRtWE8qGN5PHfV5VC50IbnxyaYgEwPLlwYYS6/NuQooYgPUDcb1YVeDSMZINvhaFxyWPy7qGthW1X/Wl/2WtRWm7pyUbSG5xarOOQ7YZAVbvKBv3n7ZFZgbuKbfpH9ILfu4zCm7mP+SFoC/qDtzOfWLGfyCqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OagVWmtv; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1DbaLmGeP0XlRj9GwlrOeX5Bm7fBBWMd44XTRIapfYZIFypbUmEx9u7lj/OOgEpq34OSwTH91mr1BwNGa2Zk+ICDbQENXrlrmDwTG9ZphoGwY7p9PMV/fmHKtuC+4jkMZ+O+B+UjVco6/DMihxyqpxJJuZmM6pDxNhwsfzHy+HfIixEo+gNOOo4XFaMn1eDJ/mqhhhyMalKN6OYPyhRyLGXUNmBxnIsMPs+SeX4pXfjdfVNXE3zp3DRfsYcxffz4YOLa6NYdRa2ymPFYfvcE3b5J3YqO7YlaOXMD7ZD6+cM9fD2nPQ9/Im6bXr77hISRNur4dzKhUvCYDNXVEIglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfu8fInnNBhPuA4WVCxmhq7yixSV4IpD3ZmHzXMU2So=;
 b=g/PGJEz+lYFZhmG1e4PTuyBtuGE1Rl0hqdHIFmdc9Bk6Q60FAytWejTZZ0tTTzubkYTrGMnQhykG0i4i5U75+pd+5IChIypb3VEXlt5YWVg2HZ4+uXCbupTO48iELxD1jRlEU0Zd7pZF85PVrboSkQTr49Te7W+P1wtXo4vrHecp6b1c1WIeWKmGzRa+u8O2UR3j/8KlMDrWQ2/cznPCmgi7U7MKtMC/sp7773WHNPfTQjJC5wcOBBKN2H+qPV+BtfqM2Owy4+nJ30pnibcbYpaMF2Zfq91DA/q7aKTaARiC+gxpD/y+KUHn946pFBqgnBQgPXqWs7oafPTqai3e/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfu8fInnNBhPuA4WVCxmhq7yixSV4IpD3ZmHzXMU2So=;
 b=OagVWmtv65qui4tPKTYqrqIkyykw+YRZmnOhgAbqGnCRGcctco3JV+GKOsfVZ7b+SwOz4WQCuXm0pzHRMv9WXQB5l7NH1xov+SrAjuFOX7/YB3QC5fXvRkleAbiJ19xoM+//m4bRYmKkltw6g33JRQA2TFwaGLY6FcAQQvVVxcxN6QznXJrg5lxg0eXvz9hA2XhzXVujmR38i931p2zH6h+3KEs+f4eIMk4H5eh2Ojx+HH4P3rQkk9n6Z3sYY8sLD4tDl6pTR7UIkrakIJm6eIvjUlbdBT9cRw451EzMnx/HpXZTWkO7x7nTAlK34zGjtPajfyH2kI7PYXIw2S7XBg==
Received: from MN2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:208:23c::34)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:24:38 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::ad) by MN2PR18CA0029.outlook.office365.com
 (2603:10b6:208:23c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:24:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Mar
 2024 01:24:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 01:24:20 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 19 Mar 2024 01:24:15 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 2/5] gpu: host1x: Add Tegra SE to SID table
Date: Tue, 19 Mar 2024 13:53:03 +0530
Message-ID: <20240319082306.34716-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319082306.34716-1-akhilrajeev@nvidia.com>
References: <20240319082306.34716-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: afcb80b5-cc52-490c-5314-08dc47ee0421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZGx3M8sTcEtYhk6CrbCVEeHwfMdGGza5YGucomDiSFDGuFlaFR/Va7nXpx7E3FNQ6zRWXejrW+zG37pFHRWCPEqahXd5mmcuS8MHViHui+iLNT/B2rdvd0X/nTYA61/pY+jVr+3AYm7tmtdM68dHUYsHnYcb0xC6PUsxf5nk3Q/D1uPj9W9ZU+2sZDOGHkD5QsoAyxuvZiJcQiuUhzmq6X8xMcc7YZNdBKk8+qlNp5tSk0Hib7ZLS6ypU67aRQ8AldYNvuG+ac2/sfrwx13wt5xlfBHsk2taD4ECA/BQDrZZE+BgkUtPN5ZqsP78JVzZoeSi8F7UaD7l2UfHUL9ApDWvNNuhsSXvaq/BfJR4M/RfK3YUG8w+AwlYyM4BqKqFXdhVbqr38iGUCaoCqEXa7kPmKu3ttD8we0wDWX067lBl8Qse0rEK/a+Sma3JaFQBJbvrxNNUH/ChalBd1cM6C0B5TWGOEp3IWG2DSmbq8ItBxACurjCbBw03Hr7JrkNptCuZEEMizAvtfeQb1RYgHsQabxMXDTa7FA3/0OwB5aaXfhsjBijXthGaN0xM5IFIOasQucHzg279C8Oa3BJ+DeTYpiOLzw53VF4RlJGGDpPDWgI5q9Gwxk6ud0Ci/Fx8GVQl/PxZ4qckmoNIh5V5oQer3uQR9myBLPOKndhmjBoObcLiOc2GWJj1T4sowxA8BkJQf6KLD6kZoRlJUZAJcGdFXynDMTfWgWqswDNs4VVZ2uFf4z71uH5EgUsaMz0Ce/kR3D8MJqTJxNqcvS+KYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400014)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:24:37.4505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afcb80b5-cc52-490c-5314-08dc47ee0421
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

Add Tegra Security Engine details to the SID table in host1x driver.
These entries are required to be in place to configure the stream ID
for SE. Register writes to stream ID registers fail otherwise.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 89983d7d73ca..3a0aaa68ac8d 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -215,6 +215,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.43.2


