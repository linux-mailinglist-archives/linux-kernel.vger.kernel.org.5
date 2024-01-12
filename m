Return-Path: <linux-kernel+bounces-24618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9316E82BF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4D1F24104
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A567E8D;
	Fri, 12 Jan 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXeTaMxU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576D67E6D;
	Fri, 12 Jan 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh3V5rVpVYyJoeE5KyLaPGKi+Aixv5BFq27pgZVf5UoDYPpiNjqMv8v1I1oKr6uYlqmo5Wq8ZrvAC8Vkz8Soof6XAWS9G36UvYNYEa+54iLKso6voRhJsLDr7INYTbx+eXUbb3QUXh4PqPLplZvQWIEVY8YcAI3csmPt7dyIshUDLUFgL/FDnEH4H3MJ6ZhnlRzSbjk1dUf+6Wic4brqq6+HRQVT4136uM6+VRqCH/eepDn1lfdVAH96jSW2GXiBHR356u2HUpd8AxXP1lh3U8TwR+EKyVM+f+aiqPNrPg/3ULCVFxTxzwTJHj+CQo16D+Cn28D+Rt9JFIsdOl8Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1eUKRQCJ8aMVcYJCY5+/LdtSabYaaCrSeYlLnwQZWI=;
 b=VIg8x/2nKlNXi2iA55cbTBfUgNoa0ktxFtXDMcTWIFiU6gb+xHaGouLy6/KtrqL+ar9W45jp2luZD9H/BrlJFZ2TpwapNRnUdtksbQ8W7zlvaPT0Fo9EzMpDcmFnSnLEP6y17in15xcyZVEeYF9mCGE/sC5b8RLpnO3+7X15T6PeMeMqzUUNjaCILtO95PqM4YN1R+8+CSlzzGmmN+huJiOSztNpnl/bMm2Y0hXXPaIGnEhtUo97+EZ1dpdoRcPzW8JFd+6oFz1+mYCeFPjhdrLttn5DpA8udBs7E7q4SdBXJMVotOLAQvE/WgXU01TaEcWY9B5YJwbNhr8JcuLE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1eUKRQCJ8aMVcYJCY5+/LdtSabYaaCrSeYlLnwQZWI=;
 b=SXeTaMxUxNr6Si6+2b1stHla9Zuf1XAqr4ArXsKv1LAmaC1d2+0PBIZm7SbmIVxzI2qUtl3AmEA1892ssEkvxidXHXEhTJxsRxCPI95xorp6StSeDYdwFo05P1IpDq6dYgLgQrYYaU1ucZ7a+Wn4rgvMa4EhyFAFsFlSyA2cpQU=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 11:33:14 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::2d) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 11:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 11:33:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:33:00 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM"
	<linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: gpio: xilinx: Fix node address in gpio
Date: Fri, 12 Jan 2024 12:32:58 +0100
Message-ID: <168de7084faeee0113cc7b93800cc24c49f308c7.1705059172.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=michal.simek@amd.com; h=from:subject:message-id; bh=iyf6+DnWqsXr2UFfesndSqIWENe/7JBlcZEPsr99N+E=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSFyql79pgFVkgvaWWYrnCk/PoKh85rl6xY0jnTnkwU2 M91R6alI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzk832G+Xn2wowfr+u1hl53 ssyOfp4Xum9LOMMcDl/dS57XerecdUp99ufglXy96B/vAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: a137b819-1ea7-4fad-b8c8-08dc136243a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1qOQW9C1a24TSLxJ8zwJQubvCGivk3MVLYwRwVdQaRByu7m32z8YjdqCvJB6ZLlW0E8YaC7ssAb7GqkpHKmes4USlD1gxDYItIJlSQtw94gFgCLluQUU9TPDYoJGJZy6fe6+4sSM8z4P3UCkOn7TpNOK3zFv5emDnD4s7MHScQ/0+gFgAz7XCkeyvTBG370fiF18GzYBhRXoXyN5BQcKS70AXSOYlw/F3QqWcEhh/NsS2BNJBHDTcs1bYqNpmXv/oNqZK/vur30hnzWdjj5hOMXFVhl/uYZAcddLnu8bigg4AcKCj7LUWrRr+NHOp72z/NPQo3VE7DNyosf/1IeVhAUnemXkmARhvNIhl0njvAjD5iXYS4jikl9JWD5WPbNivbpi24Onv38MnZQPFshvFF5tAW66i3HfBGgC7NihdLmxap2Gx8KWEHv0NQNPUpqu1QLdhvsVdga9mwLyrdqcf2Tr3bU/KXFZHV3YcoHd7XclT+KSo/B13upsreuhyMSiorXimszHl+CMt8hfte1rjecFBbhw0JZegUajvZQ0uQUHpl7xa3BUr9aROUKI53Pjtz7LmJrAk0Wvab7pqG2hpc+veEmaitm9WS1uJ6Bb8RpfCxulKex+RSwVFEU9JMlXf4n1rAnxggxJrL5gfexBh1gnIxudCyoLujA2u0X3GgU9Qy/J7+OkIgxsaMPAaSNqBm31L5/jyeuP7kOQKFkFgswF6ScIuNkK5D84AIEhi6EqQXjfK22Qcm/xSoiBdwOVV/sIYedEjbnfGsCneKV5p47J5IEGqCTGxuNZ1AX60Bg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(82740400003)(356005)(81166007)(36756003)(36860700001)(86362001)(16526019)(336012)(426003)(4326008)(5660300002)(478600001)(47076005)(83380400001)(8936002)(44832011)(8676002)(2616005)(41300700001)(316002)(2906002)(110136005)(4744005)(54906003)(70206006)(70586007)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:33:14.0756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a137b819-1ea7-4fad-b8c8-08dc136243a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

Node address doesn't match reg property which is not correct.

Fixes: ba96b2e7974b ("dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi gpio binding to YAML")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
index c1060e5fcef3..d3d8a2e143ed 100644
--- a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
+++ b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
@@ -126,7 +126,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-        gpio@e000a000 {
+        gpio@a0020000 {
             compatible = "xlnx,xps-gpio-1.00.a";
             reg = <0xa0020000 0x10000>;
             #gpio-cells = <2>;
-- 
2.36.1


