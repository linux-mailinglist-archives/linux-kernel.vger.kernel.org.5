Return-Path: <linux-kernel+bounces-47959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C26845540
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3BC1C227D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030DC15B990;
	Thu,  1 Feb 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dd4SpRAj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC315AAC5;
	Thu,  1 Feb 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783073; cv=fail; b=UhTKOnn5M0hwyW/aXLWBqMvuk2e2KWTFy6uCTrfFUT8sxHAfaGyx/hLokutp8wUKH/0r8WOAOMmPdRrvj9YVXRLv8yvRHEHvq2u7OB/TlE8FrmTbFLc52TgQycJeXo+mD64381mRRC9Ru6B61BR/w3VUMXXeCYkAg3VAwxtJ60Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783073; c=relaxed/simple;
	bh=AruzUy0oZQRvVriAni58TpA0/6Bz16eb0bvcvLyXDE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ob7qpN5Vcimw19OP9okq3ET3yY2hqN6b7IaFEM4HQdj40lp6ncf778Wg92ShQPKPJBnR++l3FuvONfdzlTsXhPIhhZMxAcozKPwA4fSNuKdw/vBQkRz6XiXCpWe9O1Q4mz9QkYPeANBdukCSMkRIShpZMJgrEBWlezIeoJJn72g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dd4SpRAj; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0t4hrlOhSQaspli6ojX8feGcXWI1MLNBk6M7AqnRVQaRvEWQrflIUxarRnVo+4RnghQ+NGrTG/7uv/OHYSvZiV5B6L7HS3wW+HXz5sCYU5Jjp6vPYmPGEZEyI1BQAH3C3ymZetnjef3v2rtYhVorTh1uBoUjVn4rpx6epOHaeJ5V8g++YFw6RRmsa+XaUMvQvrxuay1CogkrB11UEuJ20Cspx/8pq2+E8/x83UZAHvNVmp9cuNuJ0kPMFhN4Pls67+60r4v3ZJQURMWAXPjZhlHB+WCOPQHPnrQmJxGh5tTnRIuIbkFUXjNrtxuUxILvr0EL5pWWpfAFV6Eel6cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEdS9GaHhGPHcgvWMZ2ZKIE+jWcGZd6SlHQKV8UHLB4=;
 b=DWUOGCxh500o+Hlj4j/05m95dnGZ7eO509ECjv2WcScCU+hMasoJaGQV0XjcHRl43kVuYLCype2vCDl5YPkaSQbXgagPmUyecsIKN89QLfKc7y9Aem3W9Tiw80NtY5j5LTjOI+uWb10I3H4hoOJ3MFUA2v2L5+/ijx6Y854bfz7rVUmTBQ62DM9POVye3GPEJWa5KhGc7Ec4e0zFWl9aygUEodc22miaEfrXNpx/OY/PFWZ+F74TvIXevUWZ7Z52wiUVC0z+dD/JVdoc9XGeyxsBCJGIGdQ/gMljPBZwaXlV/dRLSYWsqATfZD+hcEevi571L21a2qa3DPgNV+r0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEdS9GaHhGPHcgvWMZ2ZKIE+jWcGZd6SlHQKV8UHLB4=;
 b=dd4SpRAj47KkG+r2gMEtiVVGDKM5bp6ey71DqdAeih0rFQFmewrlu41SClYxYLlttLzyA5WC6n092kwjdlF3l7VKzb+1N5F4V32EqhdxENSivcGZ1v04N5H/AmOXVYTKf0xWtCclxfJWaB4/oBFbSFNLl/WcdkYTvQtCPrWWS58=
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 10:24:29 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::3e) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 10:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 10:24:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 04:24:25 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Sungbo Eo
	<mans0n@gorani.run>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:GPIO SUBSYSTEM"
	<linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: gpio: gpio-pca9570: Add label property
Date: Thu, 1 Feb 2024 11:24:20 +0100
Message-ID: <a8396308c995959349fd40e61199853a9b711ece.1706783050.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=michal.simek@amd.com; h=from:subject:message-id; bh=AruzUy0oZQRvVriAni58TpA0/6Bz16eb0bvcvLyXDE8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdhd6Cd6cbTa+9qqJapVPc1sH6ZpK7WcW9rT/L5NN7J ALyHE51xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgInwMjLMz15k2DVv5osvSfM/ qDb7dnEusdtozjA/c+4S66dby925f4qKJhdZHOY4JvsKAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8c3176-4d58-43d0-e90f-08dc230ff927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LTXrb0TjyVMb3HhI1+Q+SqevPmtw2gTM10K26OhS24X/+/2YNzIfT8yKb0GAqm7U7ZbdXo8ma1V1iO1emsbW3+GleF67cDpQhNsrbU8oWpE/R/RQqcSpWQpLEuvF6NlhVIjM9V7EYmx6z0jZi2dX5bWVmwtSh/Cm2EQRYb9HxLvC7ujIPJD+1TCFDr9aN5J8/nRsWlzUwKzakmPEZvmE0Kd14jesZKcxy7ymqvIjlK/VkGQu/IYvoU/+GUq0k0U4DimGqGJQuU4mgARZPgl92gW/uHByVHIOO6wVrLDDVs28MDghvXx/dS8BcVmhsJhiiVrNzrA8kz9GEuCt3E5hOhFD9rccOdRHfyTdGaeP+430Yai5Kxcolu4ZEJqqMAqTdUy/vmJwvkjwDb9sj91Q8AqrBd/c2vBae7eOL9WPoDGS0lcSBh8GcrVofAMMEIcYaCqfr4C2yIC92H0WB7/FmXIzN0+W7FywrxxILsV2T2BKaWrW81CNbMFNg6nqa5iZrKb/EMX/s/jyIraL1ap7NN6a5UxBu2rnKNWbFY74kIbnT9tXEHF/6QRcySCYlDbm779plKbVFW7/3jzhChSFa34dItIGAzDENlTBd3c7R0U7xeHFlG2DBAf8bs7che0haHOmUDfrFhlscI38BPMpJoegjUErKjI1rYwbh450ioZLU5bwIrBPT2oMwV6RuSN+Ah+BHLDTxNjIM/FBOlUY7oXZXP8J/D6Y3t7E767rCfoUO6QJL/U34dCkrbwmnRQhS85XY/oIlnveymta90/rhdReYN/7EsXDRkDUEJxa85A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(36756003)(47076005)(110136005)(40480700001)(54906003)(426003)(70206006)(4744005)(336012)(70586007)(2906002)(8936002)(40460700003)(5660300002)(478600001)(36860700001)(4326008)(8676002)(6666004)(16526019)(316002)(7416002)(26005)(2616005)(86362001)(44832011)(81166007)(356005)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:24:29.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c3176-4d58-43d0-e90f-08dc230ff927
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

Add a label property to allow a custom name to be used for identifying
a device on the board. This is useful when multiple devices are present on
the same board. Similar change was done by commit ffae65fb1ae4
("dt-bindings: spi: spi-cadence: Add label property") or by commit
a53faa6bfa3b ("dt-bindings: hwmon: ina2xx: Add label property").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
index 452f8972a965..6f73961001b7 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
@@ -28,6 +28,9 @@ properties:
     minItems: 4
     maxItems: 8
 
+  label:
+    description: A descriptive name for this device.
+
 required:
   - compatible
   - reg
-- 
2.36.1


