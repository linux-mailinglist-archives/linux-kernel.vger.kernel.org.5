Return-Path: <linux-kernel+bounces-49770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78282846F39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89413B2A791
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5361419AE;
	Fri,  2 Feb 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NS7Chs2L"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49960140797;
	Fri,  2 Feb 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873965; cv=fail; b=Y8EF5iqzT6PAuJ2KwGn/+NJ7Td2MHjpOgpuAgGfxQMZwOdYTKbZb7RWrjgs12LZjpdeW1fqm25ummTmlnVT8gO/yojw2KNPD4Cl/5wyVYHzaqUMwhDvIzzAjhZoCxuoLT1ebKnfoZMjxBWpP7zU+x6Szo4c4lWl7yGzNGSbv2AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873965; c=relaxed/simple;
	bh=WFGcpeS7ktarcaNtMAN7aQNrUMbtH+5LShTUeF86Kaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKGoZ0ACvjAYOsRNblflP63LSW40Sm/COECxJ2SCAdDZgzAUw+IK8z6T9J1OBZcqEQSGSbCtsAfF9IVIVR03F1e651hpoN8jqyj+MfJdvsXgF2Jnl0PugBoEvpncIh4EXQdx32bQXRDMNxs/9Snk+oapbINj3Fp5DWquRxr4FI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NS7Chs2L; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP9WYoFlFWTSl7wNdPrzZ/bovf17q8AxU2tKzcPy5jAsKCQ6+81/W5sHijNWIch6sC0SdkQ6IX0dxawhFsSJ/SZLdu7OpaKgESnZJICcvTFQU0NB8CAohs3DPhSklRhLChzpw0TwRaXE9EDp89L5tXu2m8js223yUEpeYWHqHqTsCU9cJkICdSK3Z8wOeLWZhlVuXuXnAXqOGTRJnWSi5VQwbNRz3Gd+SOhwLFjleDaSzTN9C1++fsVIpoLGhGxVVALHjcB3ekzD2DAKIk7+CJ/6eRXzPYErIqSxjzLQJUPeiWA/lVcbzgRgn8GSqxScrkjKaYjRKCe3JvA3hctJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZz7eupGvLzz7ZD/jQ9T923lPBviWonhFPdvhDFGwpU=;
 b=XYHm5YGqLunShVtMizqSDd5uFjneGxFeiskAEx3pBjvUZQVraJeZkMWG4pWkLa7ErqB3NGC+JNr2OOjgCyQm7Hp4qk9AueUx+LET0M5TDacAZkSaTSfWjgAHZjD/cqwrEzbx021490n0aWFPrVmYKk2kmFq+RVJmifUeLNMnxdEnGFse+CLXk4XA0OE2JhkNjpoDbx+sp56fRSq0XNuCdDfTMXjjRix8g3ZGdl2wnXVfWqTGVEt+Gefdy51zlyJt254V68qj4EPkFCt0MHhl5hWiLw2RKhbUaso1BfzWzzcqhbcPr80TohzBkA/W+fG+y3YKFJBbZ5y3YLOW1CVZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZz7eupGvLzz7ZD/jQ9T923lPBviWonhFPdvhDFGwpU=;
 b=NS7Chs2Lu3oMJ0GosBwMWKISogArgTucVWPClpHB+X2hjgbcDBxj3C6pwF0i9s1Om3WdmyrKNMwdYe7PqGNyPqS4TgVS5CiwYv7+IV1m7mYUebyaNoC8T9VMd0563sNdtEYqRaerVLO0AQ0DiAW7RLQRFI8Sh/1y0m5dh4JgxrA=
Received: from CYZPR05CA0012.namprd05.prod.outlook.com (2603:10b6:930:89::22)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 11:39:21 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::86) by CYZPR05CA0012.outlook.office365.com
 (2603:10b6:930:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14 via Frontend
 Transport; Fri, 2 Feb 2024 11:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:39:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:39:20 -0600
Received: from xhdbharathm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:39:18 -0600
From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@amd.com>,
	<kalyani.akula@amd.com>, <praveen.teja.kundanala@amd.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 4/4] MAINTAINERS: Add maintainers for ZynqMP NVMEM driver
Date: Fri, 2 Feb 2024 17:08:43 +0530
Message-ID: <20240202113843.17999-5-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: a33eb591-8cf6-4ab3-7296-08dc23e3993b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h3zovQj89Vnf/0+pA/BLM8oPxrMIxJCfhMRGItPNVGoHWzWkz4vlWz09b3UbIPki4L2KM0194c9HNHqYF6ShXzFCnh1rzmn9zNg5qB4xJjFo1HPltdkiUHyAg83OyEWDKvrwfuvt5rV/NDUWsHcSNfeDrPV11mz8JD6q61/ld01HcVu1xv6UTBU/SvBOz+ztKFbJ2QbAd24bUcrwCoqYPnbdFL7L+oP7RDTsOQUPn8K5EZyEF3KMP8OI8kP8Ndy+fchg4yS+kuru5USCvATmrFocF36ZNDeRWUq8ty05/xnsSKj07nENEDaybuugGBLr15y6b8y9LvY/sNcslvug0YMsgfwLCgZiKJKj4Ht5x0GKQccRbYTxisSpNn++YoaNseeAt6t1XoSorRVA4++uxfy/R5pLr8lqw4kYjS5g9G8mH6D9EuoHWG/S41qd2e7EON224w59BKXbEEPsBaxvmdIyY14OYlBYgaJZeVoK3ldxVj0i8pz+jKWAZUjFozKwIkn6gNFKSfOpZD09Q9vQdpEPzyWBGaKcfdk00hEvQEbYvEnpj4rsYtVSWp/fRmKzpCdyWisq/ivEmE4UUChYKJEsh0iq+3P1yMuo/cAKFN26NnFkmrKO5HlvDlGUdJX2isogSJz/E8jMBjULcMBlx/AhnGudx0ZDt8uKZflCPrsCks0DA88I0mC3M6rTm1CDO61sqcLJv3XaUP37uZ1MrXHAkb5aLD4uqsZHCMdlqTiADtW4liEeuXlj82SaVUgDPVm1qWXe1yRaXnEH/BRrvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(1076003)(426003)(336012)(2616005)(40460700003)(40480700001)(316002)(41300700001)(26005)(36756003)(478600001)(356005)(6666004)(82740400003)(47076005)(81166007)(36860700001)(103116003)(2906002)(86362001)(8936002)(70586007)(70206006)(8676002)(110136005)(4744005)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:21.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33eb591-8cf6-4ab3-7296-08dc23e3993b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

Add maintainers for ZynqMP NVMEM driver and driver document.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..b3103e03015e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24233,6 +24233,14 @@ M:	Harsha <harsha.harsha@amd.com>
 S:	Maintained
 F:	drivers/crypto/xilinx/zynqmp-sha.c
 
+XILINX ZYNQMP NVMEM DRIVER
+M:	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+M:	Kalyani Akula <kalyani.akula@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+F:	drivers/nvmem/zynqmp_nvmem.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.37.6


