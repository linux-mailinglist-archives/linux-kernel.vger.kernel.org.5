Return-Path: <linux-kernel+bounces-67544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C2856D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4421C23C80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC4139568;
	Thu, 15 Feb 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQjQs6ZV"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF46131E54;
	Thu, 15 Feb 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023686; cv=fail; b=vBCyo/HQCFeZOM1O+hjMJSPtQhAJUR44gdk9bzKOVOoBc+jWe6p7dTkEAeUgme9AfhxyPNalNaXPMpUYiXE/sTy4FT+Fvs29LJ5ZDVDKIN5mNt3wHHCBpbEU9K8R9DViP9qwazUUheIUpzucAqqmqAVu9CBsOtJcVWa+rHRkOxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023686; c=relaxed/simple;
	bh=ZTPPiqSJ4fxWlUSl+O+OlkqfsnrMjoJ6Y/rdyzMy1f0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6b6qNukOohtTmHWKu0W0MYQExqDkQb1+A2gbmg/wiVWHaGzt6a1+XE7gaakoLZ8tXLcwwYmLfutGvKI5vwkh1KWoeQSVyoIYSPeGvYfAXxb055bre0Ai/mFCIBqmCWUwk/HiNuR5nbBN225PaTjB0B2fCn/PWY9cM9Zdc/sjA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQjQs6ZV; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebt2CtzeTf0lF6prHFUKrLTgJ5xC6tCV1F0VBAMEffBDHn//hAS8IREApvyBEoC4o9BIbkNZBCVDseRc27clyjZ0BDyOy0BhAT3OrMog6FcNWAJj3NXQmUTkfHubf1Tr60mkqlMUNb/JqCL2Eo8OQuusYYu34RfzqDac1+ZKDcQBFSbbBCEm2Yf6j9Apt1ATyhRkQ3IDTCTKVnwKU55/cd5HBYSbd2JyWVtP9j0xJvx/v6iai3qsUjifIP9g93oWRzBjz42c9q2+rgXnNI9r/+FCPaqWJxn46QyF7vpSHBY3eCGhqbyg1fktr4BejRfSptp7jsprdwAihQq93w/I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/8bZdg/+y3zoH0XMoYVJW3n/0LhQuxiQ95/17pVOTc=;
 b=NzJgofH+9mqXHK++C7ZCglaFlR/uOCOKxmB0r0JaQDWMu2Q+kCvmR+9du42jv+9k/7W2UK0ZwNkPIUtsMB/xQphOh/jdWvsHgoAibFbw03nXYHe3Lf0+CHnC3eSPJmb6fKCQuR+ZPG5x/rNUUk4f2Ott/e3bbIxWV5cAK7SwAkqEj9mB4kNQRP7ByNAaQDMuvgq7xUFV0yBTLgxHSOT0fWv4MnSbgUG1SicQy95euy25b8uMtz4/fbzMjg1V1KvKH93vKOra4DW8NjUBXVokO3lVYTTyHbwOcYDxUz1EC8UiEw21aewtW213BHAUHlCc3xdIsiLKVpbEoa2B+msg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/8bZdg/+y3zoH0XMoYVJW3n/0LhQuxiQ95/17pVOTc=;
 b=SQjQs6ZVLmjNuPHbI8hXxvPRLpksmXbWpuQBe1DH+x2YDFDGubETGAj53cXN2CYbfwReqLMoyXeg28ZJ0QnsoBcTa+t7ZbV0cU1TYIgQpMA63SF6Wy9kjrE5g10rwx3HQA74dwz2XqhVeBGNQ1ZeMwNVCj9hRZ8LC9VjGJfDljw=
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Thu, 15 Feb
 2024 19:01:21 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::55) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 19:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:01:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 13:01:20 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 15 Feb 2024 13:01:17 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<balbi@kernel.org>, <Thinh.Nguyen@synopsys.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Piyush Mehta
	<piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dt-bindings: usb: dwc3: Add snps,enable_guctl1_ipd_quirk
Date: Fri, 16 Feb 2024 00:31:05 +0530
Message-ID: <1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 6781bbae-18b9-4f16-0f8c-08dc2e587fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RD34AIs4PgXaFYN2d8qk1v1UPibFqnWwBeS110bcRPO5eBpc9YzLToOaA92fCDiRm64KxQyBqPos2vqHjEzyVxB8zZbHOomE6aJOPMNhGzFQA07CJHRBgnieAHNN6eAI3Qz8hw/yWwm9507vGwVim35QjVJ/wQU+6zx+kLPEJ95yFO66k1eA9m4ZtsSRCiPj/m7bKDs+QdlC2krGmApE+30Ign9mZ+JwrGRWgFSZxOfGn5bd5mxTsOH7XHkA/EEnqokaJ0Q5TObF70UNvibzZWbmGz6QwEQtNVkudbOHx/SxnGrI2Q5+XGBezjoURIcziZwU6uEqBreDZfqgVO2TY2nUHETvm0GGMNndRD5tISOA9LEKa8IcaNUY+GMinU+0uEQEHHGLS7Bor6OLaaoDKkcVqRcUFoDBH1ZWPHb40G+Viv8lSNLYrrlTdKE+LPkUB5ffG2PyPLBdLiU5ENo8g7le04zlNF/oEsfx9n+8gzib/ojpCdqfLQq8W4LAoPQOLggfdNAUmxvuEbUoe3x3as8g7iJnFnIPlFckqqlcNitGrLaQZxyTGLtbgK9Fg1uyI/k8ZKJZ7DWf0ZK6O9/a78KaDwcU6DzFLxKESSThTc7TVDPgNKbSxQyj+GLmhOK6Ox+lCIwIyp8DIFeyY84MDLzgbt88kpuOhiDd4eBzr0E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(36860700004)(82310400011)(64100799003)(46966006)(40470700004)(110136005)(8936002)(70586007)(26005)(41300700001)(336012)(478600001)(2616005)(83380400001)(8676002)(4326008)(5660300002)(36756003)(54906003)(6666004)(316002)(86362001)(82740400003)(81166007)(356005)(426003)(70206006)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:01:21.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6781bbae-18b9-4f16-0f8c-08dc2e587fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

From: Piyush Mehta <piyush.mehta@amd.com>

SNPS controller when configured in HOST mode maintains Inter Packet
Delay (IPD) of ~380ns which works with most of the super-speed hubs
except VIA-LAB hubs. When IPD is ~380ns HOST controller fails to
enumerate FS/LS devices when connected behind VIA-LAB hubs.

To address the above issue, add 'snps,enable_guctl1_ipd_quirk' quirk,
This quirk set the bit 9 of GUCTL1 that enables the workaround in HW to
reduce the ULPI clock latency by 1 cycle, thus reducing the IPD (~360ns).

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
In the zynqmp public database GUCTL1 bit 9 is reserved but it is used to
enable a fix related to Inter Packet Delay in HW. The documentation team
is working to update GUCTL1 bit 9 description.
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 8f5d250070c7..b226457a6e50 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -280,6 +280,13 @@ properties:
       xhci reset. And the vbus will back to 5V automatically when reset done.
     type: boolean
 
+  snps,enable_guctl1_ipd_quirk:
+    description:
+      When set, HW reduce the ULPI clock latency by 1 cycle, thus reducing
+      the IPD (~360ns) and making controller enumerate FS/LS devices
+      connected behind via-hubs.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.34.1


