Return-Path: <linux-kernel+bounces-104930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFD87D602
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE7283E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226B5676C;
	Fri, 15 Mar 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xDD3cOal"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431445972;
	Fri, 15 Mar 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537383; cv=fail; b=fiq/OEjPivCNF4dI/j8nyuXyhAJAsIMpY+kWnd4na9SWsr12fjrJ6sujO6KtOHV+cyta4FLgrhSVNHCYmMKHHIUk1WFJpMObJp3g9YAF6qL88zX5u3sEXUanRBJpaECDtHH03ncyPINy0Lay53Dn2Kfr3WWf0qX5oVGbogpXH9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537383; c=relaxed/simple;
	bh=wDsDV1c7svjqRtZ5j+DN6KnViEfq84OlloGRiL4gokY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjMNUyCnHUK1UF61l0xj9GL3MDRUjQjKyxk+e+6DwtZ4tCrsC2FDp/vEsf7Xc5qB6uLx5Pzr0n/+rYCNX15l3DtrOqczb3PIBF5pGASISjeFs0Ny4tkC8TXriHC9PVigKoN20vsAKiLYulvqCcFZg9lMRHKF6q+x/vrHbxN9i1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xDD3cOal; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqEK/a7pajDMQNNiF5eWaduyuRL+Q7bzkJRTiDM4qPkS48bVxsdPx3Tupkv51lUXntgpDIXq651aalWFBM/eOga0XY7Eqb8mnPWotzK3DYD3zOE4FgBnsTMM9ULYwm9y+9KZpG68c9PWorqAoIeup2DJMEYcg7Qz29iXuvxzoniM+iqdFcP8LFn7zsKtS81R0sj+3ERCI3vLXkV9iZL3iM0KNlZ18YY+5qWSF38kLOpKuGZi0omZnQi5VaaOSIP8bPgnPb+1p10JYkMPor8azMLrMcrejDRm625eA0Mw7lgcK/2NWvZy7Me8JmiHvXUEG0Hay24AZoQUZdv2V02bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXglosEm1/uXHZN1v2o5jUrGABE3+HbTQArZbktGcEo=;
 b=N8sUM+R+ffYbW2JnmqUwzax4Bl/iCD/lpO55EWKl3ko3xFndM2asZd/qeVRrtHtSnihm/yrlft7UgX7qVIPU8WUExzwtef0y2fb0UaCTZQE9kGmCFskopGbvinx8T7g0Uiy6XgmrKcQ68nut8VnL2qCRXqOoWsAOcJM8UQ1HgRdOa/Dy6dIbYN4WMwzDieYTgEW14Uzs6L641bs96QP0no+/9pwxQJaX1fj2LXK+t1O0YMEEU8GyZPKlR9Gv4EFL5BdfRiavELlJsOH51AhYNKps64D7EpHJr6+U62VQxNiVLp6Dz51AmuElbLMNiEtLKFwYw7oMvR1EcwyeRMEIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXglosEm1/uXHZN1v2o5jUrGABE3+HbTQArZbktGcEo=;
 b=xDD3cOalDpleSorbN0i+mV7ZlR2KLj313ZJb3K6z5MRTfqcVONGzlkUiBzZtc4YFg/88XVu+6Rbr5/JH+lrE+nzEm+ICCHuSFc2BmfLoHlORKTjC/YfiOzUktqob09oxjBQ3N3VjIZX1NsB6tEstZAtzv4Mpd+4ybubsND/G+IY=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 21:16:14 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::2d) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 21:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 21:16:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:13 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 16:16:12 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
Date: Fri, 15 Mar 2024 14:15:31 -0700
Message-ID: <20240315211533.1996543-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240315211533.1996543-1-tanmay.shah@amd.com>
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: b000f914-8009-44d5-3583-08dc453525a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	COPB4pwMqRLVgeZBBQELsYBaLV+4HJ29mE73lSePpMSt186coy28mI2kRAakfDnszhV++TTr73PpQoa5SaZc8e0ttRmY5gZPw33TzB0Re7PH1tg9sBXr9Y360tdbgyeHy9jEZhmSkGcKcFA3vLQ6qcVCJOK4DEj2N+4ND45ajjtpC2oJy4Pj3XfKUXDMXqSbasyBb/jlqwghUxhL/wAAnXHxXD2speEbLkvomyEodxdlkiIMPG2fPJsN5X21aQe6JqVM3bh0BRNjI4qbmm5SCETIrXFWAJyhEgqMTHxdNma4VmNymKiG0aR9go6Y54n4YNcduXLYcpw9hYhh+ltSt418EmrFagGDF60XDtvTB3YvpNRhpVnTJBDx2ujm9RHzNFm0N4U4pF2yvDYswbQVRLniTnxMNC3EM72EUL5gjc1ebM5oflJ7e1laX8bNafxhY9PjoNUHUX1tFcECZfjpMMbEfigrSV9VYpY7Z4IQfLC59QppkfrSz9MdrZPZ7inOajQxjN4rz1Il6jcHjyq4fpDZkS3RdFbbSG+stQ0YHw2zoWS8c7EMsAUzEecMDxrECERadwYT+sxMS6ZkRUErpH8y9MkCcvv2Lyx9pCAtQpnFvJPRSMMiQRPR1nvpSGoTjrUu+nV2ejC0hGYAYF6gzy9kU0AZ0DqIs0poqUk00QXQ9lfRwcpRoQLIYfiIVVCxew/nnyHY7CToJq4LUTOegeFce0X7DTA2GvQx0H3m3nAEV6FM4lmgbOM0pPu6Nhxm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 21:16:14.5775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b000f914-8009-44d5-3583-08dc453525a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
Only difference is power-domains ID needed by power management firmware.
Hence, keeping the compatible property same as of zynqmp node.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 629084a84ce6..711da0272250 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -293,4 +293,97 @@ examples:
             };
         };
     };
+
+  - |
+    // Versal Split mode configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <0>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+                     <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+                     <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&versal_firmware 0x18110005>,
+                                <&versal_firmware 0x1831800b>,
+                                <&versal_firmware 0x1831800c>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&versal_firmware 0x18110006>,
+                                <&versal_firmware 0x1831800d>,
+                                <&versal_firmware 0x1831800e>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
+        };
+    };
+
+  - |
+    // Versal Lockstep configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <1>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x10000>,
+                      <0x0 0x20000 0x0 0x10000>,
+                      <0x0 0x10000 0x0 0x10000>,
+                      <0x0 0x30000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
+                power-domains = <&versal_firmware 0x18110005>,
+                                <&versal_firmware 0x1831800b>,
+                                <&versal_firmware 0x1831800c>,
+                                <&versal_firmware 0x1831800d>,
+                                <&versal_firmware 0x1831800e>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm0", "btcm0";
+                power-domains = <&versal_firmware 0x18110006>,
+                                <&versal_firmware 0x1831800d>,
+                                <&versal_firmware 0x1831800e>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
+        };
+    };
 ...
-- 
2.25.1


