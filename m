Return-Path: <linux-kernel+bounces-144761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B838A4A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED58D1C214D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4712E636;
	Mon, 15 Apr 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Snec/UWe"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E51C6A8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169850; cv=fail; b=q+OtCFnIYACZ33XPW4xiQgHCNT38IkVzrk3k66up+DK4+1zMCifG5fcQQuzFDEhwv9Lyg6jLyNNQMkJnHZ5RVYeARKos5gioECI3amRdWGLwvo6lns398e72STdaQun7aKlcR1wStj9CWCOzSyUsM5TgyKCKdwoepU8O57BYgwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169850; c=relaxed/simple;
	bh=sjLiqRy1vcjPlbNmQQYWnaNAOp7+V/57ILKT53WgsfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwVZ07RmYoRfZi9i82WeLIn0Qk1hJa6kLppZ+XyxjDFgt3yVKGcAhO84+K6srjUr6/0qvgDvxLi20Nvuuja6wf8siYG2njIb4uQysg2CUZMtk+Pc3kp/RcpRzH9ZvR5MTl5DnYj7byvC4TS6l9fVVNxMujFCavSR4lFgsJvopSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Snec/UWe; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4bGVvSpS0KCouXl0ULciC933tuD1nBm2fp+H5XMPZvUCr3/MfznEJOc0F/LsKBkurMrgvtQnkmCzQCjEryR7b5H0v2gyqiQ3U45TD3441yc3UVZT/8kjDKxJ4TChGQa7M1xJAlkYJExRXrWHoLpsya6DvnS7IZTctuaWqXxUHcQ4XBkOaH44FszVL4zKFvP83LBIEyYp3XY3tFwX4hYrKDBWTYL1tQF8S5UUIBwfvqKT1nEmAXAC+u+i7UBGQJTkvRPXa8fakgtgJOwJGrv5No4WILrbCOJfL0AWUj23d0Z3xW8nVxmxE0WmV/p/kuN6CuhiOKbM9fDp/aLt9yPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDkxnG8Gt6wd1KTyafS5bzG3UKgjFJ4cQ7lr2XpaiK4=;
 b=KNYv4YiznQ5W5GUk43kD7u9ZL9WQz9F+04iU/238O9fR8ve7n9zCfQ7hhptTclpVlIUwDM2iwtcMPSeS8NWlTkW9Tg1R0FbbM6FRh6e904upp6LoWxdIIjX+QQWM5s63ffEt4vUNOd09nxlxWVgOHON+VTcNTwoMtdW+A3adSouMnCQ6utQfae1iUWNVqlXsdha6equ3J4XEEHLa3OEvF0AH+C2fnX3hDRl162rZCxXirEaCHHA/k+bDssqXM9fAgjTe5B66QlMZirhmLL8OZV5I16W7L97GXSSe51kFfbe9hwhfd3wF+Vm9LaKCplApae2YkYpUYu+y0uto9uuPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDkxnG8Gt6wd1KTyafS5bzG3UKgjFJ4cQ7lr2XpaiK4=;
 b=Snec/UWeHtLpb3NaPdeEciEl90YT31mLXevfZ9yKJl6/MHm1gmmoJyL3nm98KGfeKITRBaiSKvyMvcOZ1Si4eftjpHfIoX+djpAPykJdsjQ9zB9nOQfY/Gj0+TRlHZn+F9+5z/LF4yIdoz0R+d/rhoSeXAs862Bjof7pcKCkRBE9hFXqeUzP9lfiR3c2ljjlQ1OL5afPegs/IeT3CO4ONgmyP3LKtU/K18cq/XxnBDT/B8yYIrxHAmCuxs8pWoJPhGDDQMVG9DaH6DGZCs858YkX8EKOyc1YSeHvp1fNFK7GAw1ECTIh2P1QtwgdY2P9H3IR6WJwYu3stjXV4SdgBw==
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:30:45 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::64) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:30:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 01:30:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Apr 2024 01:30:28 -0700
Received: from jckuo-lt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 15 Apr 2024 01:30:26 -0700
From: JC Kuo <jckuo@nvidia.com>
To: <linux-firmware@kernel.org>, <jwboyer@kernel.org>, <jonathanh@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v1] nvidia: Update Tegra210 XUSB firmware to v50.29
Date: Mon, 15 Apr 2024 16:30:24 +0800
Message-ID: <20240415083024.635437-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b58555-47c5-4d8c-6fd6-08dc5d265807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o4bRzZv7fZTPPqxJMNfwDtdme/tB124wBimij6UJ0v1dIAa4LnnlxBV+BKlDVCYYh86YkObyjAFfcjBFqpy9SGeaPPPRSsq45ZARSvvJ6+TK/nj+bRIs9ILhSOfolbxjGbnnS2VyaCGx1UBXoGXZwewBrXEQZG1eGndbTbahgYmaxciGKkVc4ahaLOkX+0g1aa1u/Gr3NxFZdyqGd7Sg+znEKm83g1r0QRKnvk/QX/bja7RlxLJ61YjVLBaEM7QNCl667dteDQ4dNfa0wLPjrrbatc01+gj0zialT8SKWCvULq5DNcvsPbvWX02l6rtR+DbDSTWysncFbRwYTTp8ctcU5tyYCMcwH3cM74t1Me7jn26UKPHiD1thtH1L1F5jIHoSugp0pQVUs3mZ+dADw4GtmGTXjjUZuAeghKVoe+gm1m00dxEZpPaEv7MG7vnU7WybDBA+Jc86OEf40n9kknjH/xHGTX9y8tuMC2OFKjjHs0dNTqr6lCUFN0yYgdr4NW2t82BKLQ6eMD4elhZIVf2Sg5nGohFrH3CoqNpOL/dMhCI8DMho2rp2HSRBA7V5BTBgA87/31DOjrv1bmkQgXuUb5Vg8ZImn02H7mX2OvfkV7tt4pC+/khtEb+CRdIY+eHdiZwPmcYtT3p4ufTgqGoDOSYh1waQtFzPQDrzkhdM2bD4Bcyg9qDhIEn6W1s9Qp8jl6+KvAl1vPGrPSsjJDOEAF9H3Ml4ok9TWQjDaXJn2r6UnB1U4jdPLs5cebBL
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:30:44.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b58555-47c5-4d8c-6fd6-08dc5d265807
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

Update firmware file for the XUSB controller found on Tegra210.
This is version 50.29 of the Tegra210 XUSB firmware.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 nvidia/tegra210/xusb.bin | Bin 126464 -> 126464 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/nvidia/tegra210/xusb.bin b/nvidia/tegra210/xusb.bin
index 10365f1fa5435d665925cd254ea0a333df822fb9..233c79e21978f6c308a229ae2475c5eabc2bb693 100644
GIT binary patch
delta 9304
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

delta 9242
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

-- 
2.25.1


