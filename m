Return-Path: <linux-kernel+bounces-46033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A797843992
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A81C26F50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6E7AE61;
	Wed, 31 Jan 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="bdB2jLYt"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0517867D;
	Wed, 31 Jan 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690526; cv=fail; b=mRxYBtKKZkgcS3yNjP5UkvA3pYYGxRiyfZaEjIEbZSbXJjdsCmAVTYsZlXnobyFW7B5WxYwd4SqikyJzLfxKJHZ4eFtiNc8rlMmYsjdrw8j7VTiCHR7+jWQOKdGqs+ZfWDxVmViFMzJsSqFvazXAX95tIVKyYkJoycehgvYa5LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690526; c=relaxed/simple;
	bh=Os6OESlbEh2WOR1Xu0jRO4O8qHSClljUQ41VmT9VMno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayRwld58i2hZcAWQ6QhPrfjeytFEJA2K1uJkfGFtT6Yxu44yFMbXVkNrzOHKsq6xFWal0IEVUDU/1ZnfbXjmaSf1KRE8fTxf74OOFGMX6FvJs+sE874/rh0eXOdfykIT9OyIY68VirZN5ptO1euo7XflzH2EtcwzDtrGYvO0JkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=bdB2jLYt; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ4x6QZ7+nTbXS/DGo6YP42LIglwSUS1SRt7b3fWGDvNLSgD1XmEIq2Ixqc+0M/GEQSvWnnKNkmKJF/Nd44tiPZYqKCIk0n5/tjzjPUJSI5xHM75x481N8ZLIKhXaOmd3I6qhp45UOYshMGbQCNsWB0pVW09iyyOej7uNy8lShlnCjGuK0oe/zlRu+/JRejvW4HLqKZdIfAy104MMAC5vT8frxME2cAb+wAtn4JJRowrlAzndl1fvLMOI+nSLS57b3xPcXGWVuBVbk26PMWo3yNTmSlta3QFBUu1+kkm0fqJ6hpLtufVcWeRSbm/FKKGhAu1W2gN9tHyeFfA+HLE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=abGlQkj8nLh0UlLkCmG+tkOyIF42pnyV9/J48eFpHc7quNGypT7CxmTSyoE3CL/yqy5feJHr8WVO7M/vmyYxaHtG2ghSmFfd5sO6Gdl23tDJ4msA5VaJIh1DwsiVSFIAFcfwrwZDl4xHRm36WROj4PBCoD8Z43rSOV7ZI4YGcPI0Hq1TXKXQF0JLAe491y90LuAnAOE3jMCWL6AR3fTnap32zYZ+oCVtJYBB6wkb/13yjIYIQdKRHPp5xXT0coq0vfr+39NJnCJoxeUw7a9ALojPZ4XfWrKVm62YvWbRQQYNwtvsdD1q/lPxSYEADXTk+E+n4rkYxkax8x7KPTp7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=bdB2jLYt1dSJvDREDBG1uXbXfLGFRUMvMGHAh+XzdSH5mz3MWlyAMIYnU+uYf+p07VLBi+a5+QMhPbpZMrmSUFIPqvAAUwW/GdO+MV6Y/+bb7Tsop/Z2FPzSXRdrqKUdc+POXXH0EG8cxqvGFgK0KtjTF4amKGeSfYLuoESyQlt0SlT4vhjW/kD/Gyt/F13PyVNDgVYJDStK5vSTNw93nY8mFEyHZLMAxT8YQ5sKQ27OHSnZd2ekUNk2x/4Nt07UG3JgCj79jgQtnvi/DbonHrvUpsyE9p8l0QCYY/IwIjfS3s1d4ieStZ3LkEEcRH9IgE5j5NpZpu2e/i4WB1f0aw==
Received: from SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6) by
 SEYPR04MB7332.apcprd04.prod.outlook.com (2603:1096:101:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 08:41:59 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::9) by SG2P153CA0019.outlook.office365.com
 (2603:1096:4:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:41:57
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/21] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Wed, 31 Jan 2024 16:41:16 +0800
Message-Id: <20240131084134.328307-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR04MB7332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6dc2d661-3bd0-447d-25d1-08dc22387d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1pZwwgVIOYP3R1ptU0tG/XtbSZ4sE9ec+JEkkTj/b3SjDWB5JEuwm7rWY5Ru9uPLNW73oenDD1wILRXqFBoYpYktXsoATa3kvHk5IaMwXoP/JWgSq+Zbs3kcHWu/3JoL9kwUlv8mLWn4RL/l37HEWwfxoXi9RTX1WZdGi3Vz6M+JRnCh3pJUut5pObMubikPrVFUSCIIxCb/xNJtYptBGD0LD1fZqStYVLYBmPOCa/y2qjRXWnN47pkiaF1R+8ScFexh6ZTQa57xL8M7vHD+dn3vSJTkOvgXBVRhCrB6t6yVOB5RjK2I5AOgQIt3LHnHh5jLPWiquYYUJF5tEd1eCG8lhJKOus9g66myGrvDf6491F5C3Lwj2nPFKxuhoh6MfIXmghmSklRKpzWMywNbzyf3UCDxyOfn1yxAbHzDFkK9Rw2MuZtk1Qti3a78EjrtfRatCuJ+X6k5awnH68RUpSTSpkAY1HMVyuzNtov1p+wDVNmlTzq9ftigccMbi0Azwg6kkyGyBiXklMJX4TFmgodP3JVf2McDaHypjHnQsXHFZ3kugs0q80TdNrzJdRn6K3wRpwzzhP0ziWSkqixHlZC9IC8s/CWGBO3KruEzojB7ihmIrfaUuJGgmfyotReMzHMcD92KqKp3MY10anNlSKZNBJFvZELniHXJWbblTEJLJeY8tpEskpWmePVusIfdJMF8LsfF4Qe4XHV2S8uPCg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(9316004)(83380400001)(1076003)(6512007)(82740400003)(336012)(956004)(6506007)(26005)(2616005)(36860700001)(5660300002)(4326008)(356005)(8936002)(7416002)(478600001)(8676002)(6486002)(2906002)(6666004)(81166007)(70586007)(36736006)(316002)(110136005)(70206006)(86362001)(41300700001)(47076005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:41:57.9887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc2d661-3bd0-447d-25d1-08dc22387d0d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7332

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f8bfdefbefc6..23006dca5f26 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


