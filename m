Return-Path: <linux-kernel+bounces-151395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB48AAE12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88A71C20FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76E8562A;
	Fri, 19 Apr 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EQwpANOI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374C8562C;
	Fri, 19 Apr 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528367; cv=fail; b=gv1w9cvRg6LqotOXI/EisZV65H3We9TqEVFVtAdbXuE5/R+n/Tylibg20dcOIMI2RwaI3QAUw5QbLUkgybsvLePIsWeUNZh8zTaN1JvFxnKw2Q/x2Y0u5ssR2HqMPn2wwVuBnA96U5i38DvWVCQK9hlP+XYBmhJLpKD4jeOfZu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528367; c=relaxed/simple;
	bh=LUT4q/fe5ziOxYOguB6voiPfz2gXsHHf0FPPjxikuRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRvAffUwZZaY/A1JEvFM7eReoSbI3FzB7/JxFzCxFiPTkYiBm4HBzhJ4hZ3XErf+R4wKB2BPsRqgxXnTFSaSSmYfzaTpS+kpepM51H31yf/zVjrOuN+wbcYliFhJ9do5ncTTEbUiyD4te0ylx9VL/oIZNf4rwxS/uxWkir3A6qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EQwpANOI; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyozL+axCFsRbMa2ZPQd73VzyXRzS3NyLQy+gG6U90LxOMYRIjtpz47I6naNVLRXFh/oM/mwHi9n/W1KcR+wnxDyBmvc23ImdxlJAS7uog74UBP7o/T3rV1wiCDSftMZqg//7MG3S2ddgDMEuffObX/t/bXreLVvaSJ92Fqlsixd4ui5aJaR07uCSbjclhI/zSzzNA+L28RNWZtLBmPBzVO+Vk5oubb7PNM3E2TgoYZffk2/3SEo183XvYxuIo3CCh7iQ8H4HeQLuc/LRuzl57m79nOnW1QLr5XIB+o71A/5AFl67dW5iRiqBSttEDCFckW9hWtRgOpbe2mUOPLQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiz1FPoT3sl9O8FPM8GsDCdprKE2enADj2N1v5tWa/8=;
 b=iSzs59+wuVB3dW+SLDgyCU+BtRz865tUH4r0p37O6Yor7sIUPZv6hoST0n5jrYBDH6rfpdQKnmgzuSFVtfiqYTF+rTfvGQu6vyLldmGyJ+Joh/c0sUfm5W0uV+DYyZUFoPA3nvwGzbi8tna0O8swLaAsnb2We9Dkqm0B237FxFI+MNdkKFx8fDIsCNKICd36P6wOaUmGAOmoO/XtbdJ9HP72vOmV+qBbW7Knqf0eab27WZWTTK+whcNxvDnFVwY7th9ytjkxy/XkIHzTT+vm11VKBI/ta+/qhdq0RfySf73jdYA06/l4a8gmgvORFi4HOzNjEMKV0vxJoHTtjVYSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiz1FPoT3sl9O8FPM8GsDCdprKE2enADj2N1v5tWa/8=;
 b=EQwpANOIVFQyt22eYcAgva7WVSq+yHZnKb4yLv0R09xRRiLrx4t8ZpHiD6+r8IoRfL66mbKKhgeiNTy3AYYYDFqMyrMy8CdCWgrYPWjjxJN+FsLWp5OW+JxL9TzCzl/7YKHJE0luSnXa+LgupkZlZ1EDnlePrrZqVcthsQCMM9o=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 12:06:00 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::92) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Fri, 19 Apr 2024 12:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 12:06:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 07:06:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 07:05:59 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Apr 2024 07:05:54 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH 1/3] dt-bindings: serial: cdsn,uart: Add optional reset property
Date: Fri, 19 Apr 2024 17:35:29 +0530
Message-ID: <20240419120531.3775919-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
References: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e2bcd0-53ba-4093-79e9-08dc60691424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kmEyHcbKp0XgJjtttflhLeOd6v/cgLEPw3pyV7L7Z8UTKkP3vvyoaR7kp1/gpC0HNPXG0PGN4iukFcPqyT+Qsb6sfnHYFCaOKeFhC0PM/Nb67suu1C7iS263MahdRW4UXrqpbKoNLuUv3nLZqPP1fkmNBSY9MUrJ2fjZA1DHHGgmFu2LNzBXrNKESIsvxa8GsHVIsT7tNr3wo2o8/tM1WdpkPdbBv1/XNDHO+ULKZD7l7TN1x4c/F8tjyCOjaUNW27qmbADZNrt4lRBnJPcSg5h6aeL+QwLpyPfJvVPcDjVzMCsDs4RvifWDdcuCFHjqrXmBHzXaDWT+doX8EdY4amzMKJe7gSe8xHGepW0bqhl5KeKMJxRSoGh3+fmkRRno8sgA0tLTbnc9Y8y7HJHQXTur1vjajdbXzvFWbubvqp9AOS132uJWxeoVKyUd0Om+50AewEgi5XPEjv2eEUIBt7wLt6QbOgxAlfqwtZReHYu460jiKdkVNgMVYJH4l7trS9uiQiCL1Lj4Tk1fxcT0t+3fhybrXyvFNGDsaDLemBIezCB1mtXWX4mSKSwcOeuhtst1L+O4nbhmwggRDyVbHB2s42TuFjd/J5vFr8YmyPhJm5qQOLP0cF45xiLTBAlmRCH3HnfvdAFpXAXohKBjXBPT+9TNrVobwzoaAtwe5W+O5QlUsWQiPG6ImOjLl50RlNmdrmsQWkM0cCLVr4zQuavyRGL3vBNxh5PJa76K7g+eu9XJ7URloU/aop9siQ8AHrDlYgKXdLD3RduG0ja+og==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 12:06:00.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e2bcd0-53ba-4093-79e9-08dc60691424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

Add optional reset device-tree property to the uartps controller.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 2129247d7c81..d7f047b0bf24 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.25.1


