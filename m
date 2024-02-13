Return-Path: <linux-kernel+bounces-63074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADDF852A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E31C21BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6B18B15;
	Tue, 13 Feb 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="k2PxWHFg"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323618654;
	Tue, 13 Feb 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811633; cv=fail; b=dBMqGSU3K4eLov1lVLRri0JC39kU+g2CFOjcb8jLjY7Byqfdq/FTk0GG7XdJcvd5ftvQ0NB9yOyGMx+SUIuXfwdXVhgB3RgHrxKlKmms4jDRNSmKzcQIJ3dSVD//H9LJzJvCgRNAs9W1a+63uElHbHeFUZ9mx2OKjbx5WQ3sWX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811633; c=relaxed/simple;
	bh=5wXVzS/XJamkrudF8d5GPL73oahsHPeQ4/VL7d/Qkxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Iozrn4vuyq2XCrF+6wAQbMwHOwZjzSn5SeAbr2yt3wZPcFI1GOkoIvNRbfED/71s6yCjByWQ/a1bi2dmYq4eBSqRZHz++6Vc2L3yl9DWhOUQrLFmZfTefYoiZWI9iR7mnVE4x56Puh2/SkRVjyyQGB3EBQiHu/KRuAfpzwof5pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=k2PxWHFg; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1bldCCVVYwhm0JO1q3m7gUkkHPuHbpTGQqy4BPtm7WDpfesmnGWhHE5W1iiNgNylyUuiXlO08G/3E3HiNrn9mjhRDyXVF52obHi9bCTwjBWylmPVHsNJrAJtTLmoFsCBieBIRKav894rUw7vSVlhpFAvur5Aqf6q3yxJOyoPqTUhIfHv6MqE2yWE05ru3yTYGAQ7X4autj+deaHnOfgHwMOKkgkshY+6ODKJYv/uLnsnGp6bbykXmLvHOF0NbZtExR5lkmnHaFol4Sx9r83M67KRj/MBg9c1SJfirUaBlVTGX7J31KbfB7Q2Tt4fTCfhzeStR3g8XUk1frK5OoK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK7JMUGHKOnZd1g7l/7doSMJhnVWxCWXjsiExT6lZhE=;
 b=O2jQi1Tt0LcntS3SBR/e4mFa8zf6PGLS1eXeVQMY8N0HkN36dL3g0A8Or2n/Xq1LoJK0ryA1ZTcN3lC1xXFKv9U55dv4h4w/nf2EcxAWS6jr5paSIZ4z0AH5P2E+QXlMq0AT2QevYXrXVEhtL21Py8HFzlghH//0vXGflSeIHhEmW0+13GNDLP/j2YvwYACPN1XJkv9+LTZ9ZQ0JfW07V+YQ2+73kQ+pWuk/3rst82i1R1Ci7szJDATZMCV98UIE1GRZq6oWxXXI/gPEorpDdPlvR5e7g7olfZXwlUxLDY0AEZTCeybeXYz6ZkwKxYgPLQuF+v5m09bvIw6otNKnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK7JMUGHKOnZd1g7l/7doSMJhnVWxCWXjsiExT6lZhE=;
 b=k2PxWHFgD8GPTvNgop8gjEs+lluJJW4/bj/ivpnB1blm7eQoxae2JrbZROXIlUcNh0mamfKcGwDRe2WTPIhzgAsY4YXEzcuu8RsvW+pzXodQdtv8upOUAaBt5ndyWSzL6uArnpi7MRhW3ERJ/omuvuMKpjHSBQhVBKqONQT4WdY=
Received: from AS8PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:20b:313::31)
 by PR3PR06MB6860.eurprd06.prod.outlook.com (2603:10a6:102:8e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 08:07:07 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:313:cafe::dd) by AS8PR04CA0086.outlook.office365.com
 (2603:10a6:20b:313::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 08:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 08:07:07 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 13 Feb 2024 09:07:07 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	afd@ti.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: net: dp83826: support TX data voltage tuning
Date: Tue, 13 Feb 2024 09:07:04 +0100
Message-Id: <20240213080705.4184566-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Feb 2024 08:07:07.0564 (UTC) FILETIME=[A34956C0:01DA5E53]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|PR3PR06MB6860:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f8baa9f-fa4b-467b-e051-08dc2c6ac5ee
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GV2bXQB0JNpcSjAF717Q0HWIt9CLESMiIni8PnWnKcnQyynHNUo9YSScCSeWzxQQnSBZYufyId9hzERwoZa+Lj4o7JcVci29daeWTPOmsp87Zaph/UG5dOKy7uiMpfzhAFpQRFpVHzvZCmVKIcYT/ZGbqhwadmnFuACq5a6UOoDH9invgs3gnEbSt65fdW5zI3bMNY1M+avNJV0v9FVTB/DMZOovZ3Ue/a0TaCiZo6arLKdWr50nV8I1SCO3q0dvVxN2ztDdhOQ8cnaPjM/5gCACWM+mfa2ygMo7sR1oiSexixmHYtoarMG9hxnpITo1IfJAVeM96SWxujAeHKaIcciUaAAj5jHHIYL8qu44jGIXuiV3xMWhg+Wg9vKQwUwuNyYcWpC9tz8kL4XnYn6IRDuJU5WwSo7y/3Wy50T5sQ8kgOAC6cnxlIScHn2l47j4z8NV1pzfsy9WnSGeUC/qYoEaBwDAgT4wTsy+lHHjXi5Whg3LnuAhZMelX0ybm2E/750g1QdSfWY+D5vWycRitqRO2X/6sG+jo1qhYVaO3p9ECkIgb8I7e2mSkQwIvguzGm80Bo+iOPvcZl/QaTNfNx8gU8QW8GFJkA3ZbSE4iWo4Cg0aKsmkEaAGJFZW+wcCZShqJ4kile/tjLfsqEW3qw==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(5660300002)(44832011)(2906002)(107886003)(36756003)(2616005)(26005)(1076003)(41300700001)(478600001)(82740400003)(356005)(81166007)(336012)(86362001)(8936002)(450100002)(70586007)(70206006)(8676002)(4326008)(921011)(54906003)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:07:07.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8baa9f-fa4b-467b-e051-08dc2c6ac5ee
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6860

Add properties ti,cfg-dac-minus-one-bp/ti,cfg-dac-plus-one-bp
to support voltage tuning of logical levels -1/+1 of the MLT-3
encoded TX data.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - squash the 2 DT bindings patches in one single patch
 - drop redundant "binding" from the DT bindings patch title
 - rename DT properties and define them as percentage
 - add default value for each new DT property

Changes in v3:
 - rename properties to "-bp" and change their admissible values
   accordingly

Changes in v4:
 - add reviewed-by tag
---
 .../devicetree/bindings/net/ti,dp83822.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..8f4350be689c 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -62,6 +62,24 @@ properties:
        for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
        to transmit data.
 
+  ti,cfg-dac-minus-one-bp:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level -1 for the MLT-3 encoded TX data.
+    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
+           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
+    default: 10000
+
+  ti,cfg-dac-plus-one-bp:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level +1 for the MLT-3 encoded TX data.
+    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
+           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
+    default: 10000
+
 required:
   - reg
 

base-commit: 1f719a2f3fa67665578c759ac34fd3d3690c1a20
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


