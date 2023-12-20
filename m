Return-Path: <linux-kernel+bounces-6674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18695819BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0671C2574A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FE20DF4;
	Wed, 20 Dec 2023 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vfcb73sc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE320B1C;
	Wed, 20 Dec 2023 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcUq9pGPtzxZElYs0ZY8FdDho8b/90Uieicw/t6BpeXSugK4enU4xI2fUJniflEY1qKVsZ2t5PCmaVYbzWdURHMxkINxtSEdCtLLKEvDKyqSfNqth9XzrecC9NltaF15Ax/shAP/z6Ydiro7sNbCybLdw+NArrkwfLzq8q2EFufWUUS4tsr6zjqZKejGkl5Y2B3eAuWUO4USMkTKoagLx/wj6JUeUTWYFJkFVpkgZltVsjuvHZHxLuZhl8SI+byVYXzhGVXHQ6PQ8LmxNByfTqtnrkH7SPP/MvoRlRw0FZGZcwOkunDjO6qp2LlSjpatP2N1mD5pYnsBLCXcv4FHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxrPliRaSLG+4ucFGUuynqgmd4ZemmwjgycZKVhlQXI=;
 b=ZFHWy6MXftRdONkr1iZPBq+oGDvcZFTtczEya9L2YfULhgy5OEXU7gniAKOubEQx/6BH3Wn0Pfut3UjpPolvkZCIcnj0R5bBprkc38TOwRz6vGhVb60CMEGoe1zpJYjy+mPV6LgvOuNU5vNW9xBIYHcqiLSj60cQbrZO8TU07MhyToNhzszjmnME3N2zwuwY7oLVxi8V60pmHZKXbNw1d6JUGfAJabGguaOQw7KLFrXYmg4SSkdUPmio5L7khUwY1iF31E76XvFBNwj14p5mVrJe28edQJCeqw1pZOfuL0JvWYy5Qeg+Vv72Qkk79m2gwqzODEVW6+wMBSSEZUzzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxrPliRaSLG+4ucFGUuynqgmd4ZemmwjgycZKVhlQXI=;
 b=vfcb73sccBSgQDSqJCQwfbOMXoXfLJpkTyDAw+oBmydFzrF2xgXEW4HxTRfGwpXhSUHyqD2t8Nsqep4CEtv/EvdXdlvgJiCtdmAHujRjioCg3Y/qvnmU6oPhAgt/p5FVuqms5bIcQ+tT8JoNi6Y9R9o8HXZm24skS5CiPrg9KNo=
Received: from DS7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:3b8::35)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:01:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::17) by DS7PR03CA0030.outlook.office365.com
 (2603:10b6:5:3b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:01:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 04:00:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: power: reset: xilinx: Rename node names in examples
Date: Wed, 20 Dec 2023 11:00:29 +0100
Message-ID: <26aa3459310ba4624ccb5865ca32017357591e4d.1703066422.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703066422.git.michal.simek@amd.com>
References: <cover.1703066422.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=michal.simek@amd.com; h=from:subject:message-id; bh=PBMOJKmEoYLybR+BPGOcp/BMqeXNaNr8CUTNmDvboyk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm3dapMzffDfZ1beMTTu249v3Q6oO7X89JY7rx6U9+b YOY3r34jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARsVCG+eUMtr1WjBPfTsld 427nIbG1nv9IKsP8LMH3P37vWXylnOXtn4pbVdmBX2O5AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: bd636346-1a92-4588-c1f7-08dc01429df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4CMjrrvVfu1mAXGBAU/fu9ExicL6U4qMLpn8B00XlMn5deAqywzWz0dp6M9v2T4xlzEcxWWTG8ij5naU2q/MKeIAnsgL0SR6zZ/y+X/qmGvLxhDIfzhoGxcjzGupDEKT8iCHhdWfMXef76QtDptzs1ZDfVP9/jKebWsRTDS7IWW691dPZu637SeHbgnDYbddfRbbzaYC98yhok/P/WUjMD19g0RBwIFZL0Fc0NpnV7VbM7J2DG6zmtpXhPVO1TZN8qtC6Rz4ao8OfiGZW/1dGr3wiyvNzSkb7Ni3OYZHbI/ktS5PUDa3Hqb7+Tm9O7aU8ZE6Mh8xZLc15W+jSpyflQ3x9SA5iWMPaPpj/XNs16qKNXBqyx0vivD0T83GgHYpe/QYODEgu3HpFNRMe8+KT2Ne/G0Uevry/3spoOmh8t+ZlCvf1q6BSmfp6eh9vqBQGJfe25MyeS8tkEs19fCkRnA6zQlv9X8Y4O2dFylb5+qhz49Xe1jhNJIyB4eYibXigxGqKbKem39GdVgP1UmRNH91gSxdu/6gB2WIo162vj8uTM4eH9Nj+1Y9M4tLSqC9uukpb2ae3Ncd60wqF2GpSr8QBVDldU97jiblzXx50ChzkwylpoMl+Leu+HFnxUNefhNWTnCKyF7yx7iuFf7nYNJrfgzJry0TyInmE/xQ4K/86m4hlX5XIzOVWeoE4DXauKueYaLC50Si/T74Qda0HcxYSqJUOLNfbFqUCfQClq61ZPEISQdoQ8OkFazcBVT6E7VrB5xl4DHElqlOsrlz6o+WExFSjB+VzH1RDFDrok=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(426003)(336012)(16526019)(41300700001)(82740400003)(81166007)(83380400001)(36860700001)(86362001)(47076005)(356005)(2616005)(36756003)(7416002)(26005)(2906002)(40480700001)(316002)(478600001)(8936002)(8676002)(4326008)(70206006)(110136005)(54906003)(6666004)(40460700003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:01:20.8362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd636346-1a92-4588-c1f7-08dc01429df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

Rename zynqmp-power node name to power-controller which is more aligned
with generic node name recommendation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch is series

 .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
index 45792e216981..3484be1c89d3 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -57,7 +57,7 @@ examples:
 
     firmware {
       zynqmp-firmware {
-        zynqmp-power {
+        power-controller {
           compatible = "xlnx,zynqmp-power";
           interrupts = <0 35 4>;
         };
@@ -70,7 +70,7 @@ examples:
 
     firmware {
       zynqmp-firmware {
-        zynqmp-power {
+        power-controller {
           compatible = "xlnx,zynqmp-power";
           interrupt-parent = <&gic>;
           interrupts = <0 35 4>;
-- 
2.36.1


