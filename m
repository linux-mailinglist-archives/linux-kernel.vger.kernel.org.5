Return-Path: <linux-kernel+bounces-68275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFFA857818
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8677E1F215F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6819BBA;
	Fri, 16 Feb 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="clRIr+4B"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D51CD0C;
	Fri, 16 Feb 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073530; cv=fail; b=l9t8SSaMFJ9lCREmvbhq4rgxAJ7Yjt5QGuwMJzNhdFo0U3LAe7A/1VxIsdJZc2VOLjDP5YkMtSesAve2nCAZhhr7ItDYa4Bae/P2Pfaeyhi3dqCux5mkLMeUCvuLCl8413vRRI7SDQul72Syq4MRzZRYyeXAotkfOPe9XIp+kI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073530; c=relaxed/simple;
	bh=uzGUKZkA35cfvb0lxc8UTkoY4tPSpMZXusm76D3HBbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VzjKGLXkAIlg3aVA0rNP21EKM0EhN4MvUri2PaSUk5moRel9VJg0k9d3spIZz7u9rW4rZQuh+NGFvmwe66/gjHP5oyc0djeTscVIRlad0XuBC091Zle9nOeX986CvNzrFjAQkMtQvQoeaUAmv9U0OU6Hv+lgYPSKbjT0ZnvGl6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=clRIr+4B; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQaTFNpY0eKDV2UXVmuyZEGumtd2QTwg5et0ThNnpM+a2OfrRt+rxN/wLPi6K5JZyIkk485ZU37GTwqHNhFP7skALsY3sSV/XPZxfvMAG6BMfEQGVwmsxvQ56xreh/lr5ucNe9w9nYqUQXgLCw9p5IkmuUk1SvkLFjsWi1Jcj7871nXYp+9MeArO+LMZiU4z2La9/tekJE6Z627yJKdrcFMkxcqfvsBXtNn6CQFpCmGm7vKuSV1oT/zSE/ZlY8JmrvfM7e23zqltbI5OCrSzAC8CaxCxY7vQxX81mBHL8ttQss90SmHzGJuPRUXkM8n0JleJWAQGEfqR9ibfdchuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAiLflcdaxRsQA+ukyhWqRlOnL1nXucEBnpaPOGamVk=;
 b=fsedyp1O9vjuCgo4hPsbheaC9210rxUNHHELmpixX0wEfgGchuY7guze2UJN4MVOXql3zV+pexVyAhMo/7NJ7pqj+JbbzH6ctX5Pz1s4TmwODB9/lHSNuhP9rhTnJLEOm4oRKVBEFmtMzhbZMWXBZzV96lQkdZAWGgVtUJn79cAXUunyC3mHH6ksHg1i57Fj+amrSdM/+uhbk5RcCXL+53G0OxcgGBUDhF5QGrHnSjpGX5p1MUz9Tq/qGJ6TNEOP0/rUY6DhlQxiPiWciDeWtpDfHuU+ZzENXu0aJ/9NK8/vnfw8PgYyZXP+quFFTROOk8+bX33oIgK12fpnQSozaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAiLflcdaxRsQA+ukyhWqRlOnL1nXucEBnpaPOGamVk=;
 b=clRIr+4Busbs1VBi6L0CWfgtr2lM9TruGvSUkH+4j6QvsopKm6NJAYuRlUokcBXeDvQMV5osSJcMsus/Dyx9wHLL4QpDw1VX+71/cSp7DfvToBBYw+qCb3jxnD7xT0IeKm9UMJncPAvbgHoO2TQTekP1VUL7u8AmoqRYQ7kHlAc=
Received: from CY5PR15CA0163.namprd15.prod.outlook.com (2603:10b6:930:81::10)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 08:52:05 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::56) by CY5PR15CA0163.outlook.office365.com
 (2603:10b6:930:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 08:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 16 Feb 2024 08:52:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 02:52:02 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:REAL TIME CLOCK (RTC)
 SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Date: Fri, 16 Feb 2024 09:51:59 +0100
Message-ID: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=michal.simek@amd.com; h=from:subject:message-id; bh=uzGUKZkA35cfvb0lxc8UTkoY4tPSpMZXusm76D3HBbo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTzSlqzG9yv5+a+z2DxlPz6fn7Gzn16m/iEWRTlfRrdN 7653JndEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyZDbD/OQrZVeOsmyevW3W 1rcNEgY2ORwJTxjm+6tdTw3kWNY1v3HVX9HMVwUXu+8FAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 96392112-90d4-4959-3a9b-08dc2ecc8ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h7Sz6k2k0mFr27in2dRghdpSNwiKsKpbp8OIVGf/vFfL5KcA+4E8Q+8zDQaInHhjtOt35ris9Pr0r7vX/Lhnu/vqA3e2iJy+XgBCoFF5ovkpi24OGZAPTzdJ2dzp55wEzY99xBovO+bmJS+FO2mPLYNUgqNLnSL75i3vIbLUMDqrpR3lrr7ggwOFqgNNBMo/DmA5n0pGm0WaSIfWHoYgslMqxsHnOeG0vtj6yeuHCYVWSfh+IhAVDXb1dAFIposRkwVbgKlzjVLmvgXVGKTDaIVYZXppGP2+WItaGsxiRjM/41B4cXrhBGGkAKzAe41YUbyxo0gCoqGpGUcL7UXQgYxHD+WoONKDuPaGonfV/kHiACSc1ZPbE2ekcdIBlARi0FfdZklz3bKnbeE7MRAlpiAie/vM/b7xy4j7zCM+m7jqi3YnSfelKtgpeFxP8YDbC/cuFHAjYGs6U1PbVLzTQFSxyRUbMSqe1fcEpUyP5bYZaVUhMnnR9DBwAWcgCJhNXSwS6BxVK9QbRz8veqmdywmOJrxTURFnAA9EHGC9Q4f6b4ropaCyNqKi1CutWsszv4kHl+Kw3jRPgZimaqtg1FFvVuNV65diUbRpcu9UB2QARe+CLtwRc3A5deNb10ATeMSwNR45XrqEXt3CKAUiM6D4gFUFr1oL+mmzp3mQBfY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(36860700004)(451199024)(82310400011)(40470700004)(46966006)(36756003)(86362001)(5660300002)(70206006)(8676002)(70586007)(4744005)(4326008)(356005)(2906002)(81166007)(8936002)(44832011)(82740400003)(426003)(16526019)(110136005)(478600001)(54906003)(6666004)(336012)(2616005)(26005)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:52:05.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96392112-90d4-4959-3a9b-08dc2ecc8ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

RTC has its own power domain on Xilinx Versal SOC that's why describe it as
optional property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index d1f5eb996dba..838c3ce494de 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -48,6 +48,9 @@ properties:
     default: 0x198233
     deprecated: true
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.1


