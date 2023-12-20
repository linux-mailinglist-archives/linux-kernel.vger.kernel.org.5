Return-Path: <linux-kernel+bounces-6942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A631819F93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E97E1C20B37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394A25768;
	Wed, 20 Dec 2023 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m6lMySBa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACE25558;
	Wed, 20 Dec 2023 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITkTyQMMt5SXQNexvTxALTnq0hpNUMwHJDTnwvccGOMVwtfsUY5XWgnMfTw2y6e1dHf+a66IPpEzdG9qgD1Rd93cXFl9tbxCgCWmUxGj0cdxOMvMmKNe0ixdG3TfOIpvXZx4gBhhzSOspMgfkzbltxnjdegVeaYF9pwORtZ5rD2g1jV9l4IKy0qoJYLCFzxQC+AWSW15heyfO/bVmgbqwib6zuQdxg4+amDD2OQQi2uNWpKAlXYBIJgMEbHhE9tkFARuvi3H49slNAgOovYFo4FND+SWmg8Ak8r1C3+ikKIPYA+OcZusA22r9VYU7MSEySuKjXMa+0Y/VeOuPFsIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3sKi8TfuWcwlsxXpOcB1qVyPPFt2DbrQKdd94NgoE8=;
 b=mor/B1UMdaQ8oeCtkLNjqcRghfC3jIDiE+x3BSYyLYtQWkA4dITClh5rwX4wTCVi/G2GZ2Htr5OM1ZOfL0Wo9/3LKv3fz4Rz6BDWORFfcYwlm+qm1QvILTYLA53QoeHVFOoZqMucdMV/UAw6wwBAqaAf/o/i5zwH81wmAu1Dk+G3l4Fcf0211pFA1TF/IhBL0QEWa2yulnee8aSmUmzXv3kwlpW8t7gTCZNxB7mqNpfnkpXX2NUFm3Jkw7+9A/Af09wI+BNV7isErKbACVcrlNk6gdvpy0zNdzdvIEFTxAm3FmYaHVPkhfJXHqjSco03IucMcpSpHx4JuXXw5B1H7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3sKi8TfuWcwlsxXpOcB1qVyPPFt2DbrQKdd94NgoE8=;
 b=m6lMySBaqpMKA6tG8U9tz2N2ZWj4kT5jKA3jBoBWzoJ0KacmN4YPy06DUtd6v79Cl5BShjWo2uJnv/6HkCreNCJTQfsrLifgWQhlTSeC5yiifnMAQIbGqIlhfpGKYV+qzetovPBcg3SAsU07OmoC0LpXNsMF132h5Yy9O6FKsnw=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 13:12:19 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::b8) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 13:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 13:12:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 07:12:16 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: ina2xx: Add label property
Date: Wed, 20 Dec 2023 14:12:13 +0100
Message-ID: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=michal.simek@amd.com; h=from:subject:message-id; bh=ve/b8OlbuRSruohi903a9UbbkfSD/UMMq+jJ2Am02Us=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSmF2q37m16E3ZE8ralXrnybMUdreLdEZkr7ti1fZoUE Lhl7z/jjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRs24M8z11lpo2/2r9ucDm cya/Vsbhy3/SzRnmWQQF16cH6J19y9m02M/puaP3abF+AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cba849a-11d6-4d71-14f7-08dc015d4b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jIKimKRSS3uvrnYMVOiqUdC3j6rCjeW+5RJDjuA38vTco5CFMVfTfkXl7WshCTVd+UWimMv7mNUAp9zaodVK4ik6NEH9zR0BlwFsKsMzFHP/s9YtirJlxBffkyJpedfDNTcD8BnVzFohOEC7l9f2q4hdZgI/GBchwKxuyUZuGpJI3fyEUshwpDQcM3yeeIL1gbe+nBSvctkGtk9ZLFPTtBI6m4/ED8b19K363O1zprhO8+f8RWt0xCY+3RwpOIcnTX30hRMdTdKuwR8sAndr8LdohCAlkQ0xq6rUXCadg2ZOMuZOhavAU197do3MxpdJxJE0uUO4U4LU6wvWVzatFf0Dq2UtJT3RdgzXJoi75eFB3S3fk+NGgU7AnYdlqZzplp6sLMrbscO/pnQ9bXsJ4W/LKa9MA+YjxvY3BwyZKSpy8ts4/sgkdpvcUqKm2eD7EkqQ5hyH0GjtjPOct9SkUW8LlBbpILFySfWI8wC9qb0GbUywlZoKWlEOlJPhlJ4rxse82dyv73O2Xz3DPFyBGpsoQdxlxV15jlr3yW1ZVc1QS30EM4iiLBRfrIkegS2KmWmCfbqif9aWHQR+m+zjd8h0e0/p4UX2eZesiH6MGsMS2+QURiQeDUYMPyISViihE9hiohcZljiLwPM5x+G2OmCUiZRa+ClPhXhzQunE+MdABWMA2Rpp+gxpu95176FZgJ3dMA9E7P/u6vX5DHLR1fmb3qFaSnJ+88XKx9amX7UE1jR6rsXzmrGnpamBUzuZlg04bt6PjmphI6MwZqyn9C0//BnFuEaNTGm6hU92Xtk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(47076005)(36756003)(356005)(82740400003)(8936002)(8676002)(5660300002)(7416002)(44832011)(4326008)(36860700001)(478600001)(26005)(81166007)(2616005)(40480700001)(41300700001)(16526019)(336012)(426003)(6666004)(86362001)(70206006)(70586007)(40460700003)(316002)(54906003)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:12:18.9716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cba849a-11d6-4d71-14f7-08dc015d4b87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

Add a label property to allow a custom name to be used for identifying
a device on the board. This is useful when multiple devices are present on
the same board. Similar change was done by commit ffae65fb1ae4
("dt-bindings: spi: spi-cadence: Add label property").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

zcu102 is using this feature
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 378d1f6aeeb3..8e5c1935b5f4 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -32,6 +32,9 @@ properties:
   reg:
     maxItems: 1
 
+  label:
+    description: A descriptive name for this device.
+
   shunt-resistor:
     description:
       Shunt resistor value in micro-Ohm.
@@ -77,6 +80,7 @@ examples:
         power-sensor@44 {
             compatible = "ti,ina220";
             reg = <0x44>;
+            label = "vdd_3v0";
             shunt-resistor = <1000>;
             vs-supply = <&vdd_3v0>;
         };
-- 
2.36.1


