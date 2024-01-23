Return-Path: <linux-kernel+bounces-34759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7E838732
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B26A1C21FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243051036;
	Tue, 23 Jan 2024 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AM7EJzSD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE15026A;
	Tue, 23 Jan 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990643; cv=fail; b=EyZfbBPAEuLNok5lKD41EkAHHusM9t2n0a0wNq6c0yW4MOkpfoH+ihfgmrkAv5/gx5ZC0lCZ6I7wKwpg6YtFgivPO+q2Mtaf+vwqWy227mRg953RJu4rm+XTc7hGyMo+WSGx4SsVBISdlSKvaP1A3TZ0WqyqSrNspiqHAFHq+KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990643; c=relaxed/simple;
	bh=r92KWvxbrB2T4nbJC1eGRI5odvWtwZtpwMtBxI2Da9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4Yk71ONl1tmsG4+BmWQzwuhiA3GhHVs4TPAOzcVveBCcN4HHealhsfcdnNyRN5kCrrKGirdAhJkQZikWuhV8RiVzO7lNAqtNWL7Job8M4cEbURnHbPl5lZ5yHhaL95ACzwcDkQmq/WNHnQhqqqXOSBtkxiEmi3PEc5rWQMskRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AM7EJzSD; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fujXB1RxhQfGsFrhmrQSpf0N0+IWgs8xzUVy140VcZGtBZH0EZjyY2WefjeW0pfvJnV9VZSAuwk+IoTDdzZL1BccDO2MSMKnqcAXehvXbeJ+ZcZv+05jp7uu/Qg1i0viko9G55OKEUbeKVc6LWH0OZWXMzd9LK5W4McwaYx6xyCREcqr3wwpQ3AnoWQdnMqIrLDv/upeKl23l8n3ebnP2170dLgrOIsU4pfkZf0K5GZR68AEMMnXLNudPzUH+ovkTbRAoUmCmwin54tSJPkPzNWXEYbA6XvLcDZ3V3RMFpnuip8oDUdATFKSPlkw+RI4sbS2jHnAhQnjkl2BJKtFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grl+RZ1TCvyv4uTGolZ1MGMAaAU9UAqV7wITS4zYe6o=;
 b=m9Eo3FPn69uo++S0BIAJrXOfoX1R2xCM0S/NZ/W02+Zgy0xaKtsyU0fvcILRUnzK79FjFoT17riJAjgIsDkhKpiNzRuP9J+M54MQ6QnzZK5DFaVTgyiltqCX7d/nelCHEYCBwE81ktZe9l0R6XyyzUbvRIg2fvkdT0T1fqsnbSBYrUBrWRMc0dFPb/y6OxNkESwW71dJrypRXi+aUCl+apZk+EXHs5WS2bmch5O9FUAhPQ2vtZHTVF6ArkxQh9OLo1DJKYtIjc7+15eh05JJNvMdt4TZ6qfPtYulJ4m1TT9ZyBjiVI3AusxJMWW+jtXuNlHOsc2NggCtGKa5YWeK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grl+RZ1TCvyv4uTGolZ1MGMAaAU9UAqV7wITS4zYe6o=;
 b=AM7EJzSDXbKy/aKPp5r2eMKXW51XTnf0QDf1vrWSRxkdF7T9S00I4L55kpZSGYpHoEkM+Oi02QjDSHjqS4+rkyF+jlLQvhleqWifiS/aYFcb27Mii4NcSaxJ5lgKKZCh28KkMTMFZ6ydhQ7pkb/RD9lpqS8GtAZCjDcv/bo/xIM=
Received: from PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::7) by
 SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 06:17:19 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::d5) by PH0P220CA0026.outlook.office365.com
 (2603:10b6:510:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Tue, 23 Jan 2024 06:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 06:17:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:18 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 23 Jan 2024 00:17:14 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V10 1/3] dt-bindings: Add reference to rs485.yaml
Date: Tue, 23 Jan 2024 11:46:53 +0530
Message-ID: <20240123061655.2150946-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123061655.2150946-1-manikanta.guntupalli@amd.com>
References: <20240123061655.2150946-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: c81b5f29-cd21-4c81-747f-08dc1bdaf44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kxz2t1BFAMwiUxaQz+Jodd+mCj2EVpJQKwGuqtB1BDtvL/h06YQlxC0ve1Jr4h3LZvPN6pkYlAxAjooGbEEg1ZRS3Ztj/2ORHd5JOEZ+1RPuHmpPbhquzbsNtgCNreGkugAYcdkywr7Va7TZL20X/bWkcgKkzUzoEFR/qWp1GdQxZJTJ++po6QoadLwUIcjfdNKY8eX4Q4kemtfpJJ6gIps72jvKRWxCW5ZR8LOTnRhnRCQqnLbxeErOYNrZHmWGyOspUjBw6GOhcWjk2tpNJMmMXHYk6a7g8s9tTqg4ccbYJFrl6/Ol0Jm9jIAbWUcjHDhbHx+cYS1BcyIMcOhZgDHRJai+KFZvorXHX0WmdfyqNYq+cA4DPrCEeF4JNyNoXhKEr+ClmOHWJFw5w/nPuTEGKzxWO6ww2n6B/shueJH1hxC+ZQRSgo09nXOOt+evxTL+Y94zpDkn8bww++JPX6Lqv0UJTWpO1fSATSvmLRvCrbcBI9A2ee3Eh13KZUsVRQDkmGQdEnZSA6EjLv0w6mchcfbukPgRfnJ/hYghVM9cMNCqb6p3glZuHT8Vx09k0+CJO057hOCbeWAopvNcKxBECiOzpeVw7blE81reteWi9z56PFaAkr3dXMjMX3Fa1azx8YjhSgDskrmx3u950ZP6qOd2ZkUjjPPVXXvVnuVt859sw07Lk5MIZDPvA8nkFMRa+defX+2lOvjQx2iSW/KNBOpx6o4xD1wxiDML0vL/9xKZ68stIQim7LfTK44s4wkBtSMT6dDuJX9WeGmYfYtcklq/hGkFR7P308x5qE4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(86362001)(921011)(70586007)(36756003)(2616005)(426003)(83380400001)(81166007)(336012)(47076005)(1076003)(26005)(2906002)(7416002)(316002)(5660300002)(110136005)(54906003)(6666004)(478600001)(70206006)(4326008)(44832011)(82740400003)(36860700001)(356005)(41300700001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:17:19.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b5f29-cd21-4c81-747f-08dc1bdaf44b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203

Xilinx/AMD Kria SOM KD240 board has a rs485 compatible peripheral.
Update the binding to have rs485 support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.

Changes for V7:
Update commit description.

Changes for V8:
None.

Changes for V9:
None.

Changes for V10:
None.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1


