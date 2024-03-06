Return-Path: <linux-kernel+bounces-94329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D955873D77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D79B25676
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668313BACA;
	Wed,  6 Mar 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="nUYB3w69"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D378605DC;
	Wed,  6 Mar 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745856; cv=fail; b=ex0tRqGk3E7hVEzx7IDcNqvbKYB7eJPjD6mjl2KSr35MCqie5tl07GAF0gLP+sfWU8O9qviO3C2tjQxciEU4uHGgGFq1uu6dwHET8vKdfOqbO2ANnrd+cJmUq+3o7wdQa5imLDnGCrLEih9SjNK3g+Hp75kcaJz1odr/oQVbcGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745856; c=relaxed/simple;
	bh=RgngnF///VPJb0YSM1SFRzIFtD+7xEZBFxcwX7gxwPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iKdhowBpjOCwBMmLpAf4ZpgQlIwNA8GBLiIZDjgZh9c/gPAYe0UGQJtTJrCJoyD6KNhsAwqRSpNtgrT6y1OCHtW1ptioRqQqPpyMYT7IEs5aF5F7pXtiE0kcA34Q/E4Rh258ZjJc6Izn3koCCEitfMgAKXzfNdh/qFVBSyrRBA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=nUYB3w69; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH49yqx+71fXM6bmCEm+fNLw40f92AYozeXBgPmTFIYJS6Gi+8Kma/v4ir3jrS9qhD2AiH7kw93VR5BYbQZaMxoa2aYdg18bN5dYHjIGLkOe5KJVfnjeKZbspNhvFwwDSNLYv+71m7tAbjCxJxZEFUu+4M1dawo+vSAiG5aH5csrU3VPfkE2Kc/WFxf8V+9C15HvHChpUiAYLvWe/XUhkkaGC5pKU80C+PZRxAGJWXnEzv0KHYXOBpkQwVJgsAmUVsJO1ZQI0OeI2EDmBZrBHjfH7eCmoZxynKgw8XS6f5TW4VUc0BtIaolAQtpAmFpFCfPwUCKSEpeB8RoZBSNwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sl16cHBNQAbXFgM02+tz761jWn2RvyeXV/YFlT1QP4=;
 b=nT7mtss+MadhAYEmHw8PMLWUnPRjUzR8xLrTQ0IXaIR7XEc5NyIbVMU0xAURRAGClII1pPsxt7mxhNcIeS3Eys+dfaFITftluVNrZ5zDDT0Yaj3WpgVnu02ISyfPhbsRWAak2uKLl+qLoolVgBBHrS0mLWbIIUbiMbw+GpjCQwHVX7BU+p6toHJ8f+cuR8myNSPitr71Dp3KYSbihKscBuHKiXcVFflIWsdDD5REvK5w74fYTj1ZZIbpIAx6MWOKS0cIF0SigiFRDhcTa/LKLTxZX0m1/xR0LqCorxGXeMQa4vHoaPRYlbj1DNaqFHRHcmkBOCpJQsbf1GTiFn6gwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Sl16cHBNQAbXFgM02+tz761jWn2RvyeXV/YFlT1QP4=;
 b=nUYB3w69Gke6HzaaUchh6znea0WAz2bq8xLihC6GoPNgVJhCnOvLybIyGcJAO6YV79wCnmTg5UuPpXlRcwau6quWyHHwlByPIG/fXmaBpkoEwgKYOSNhApD4GlSYvKviuLEB0UsY7xFu1BqmwV6FtnQAk8c50Qeq7nI4JIQ0FBE=
Received: from AS8PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:20b:310::26)
 by AM9PR06MB8147.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:24:11 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:310:cafe::4a) by AS8PR04CA0021.outlook.office365.com
 (2603:10a6:20b:310::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 17:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 17:24:11 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 6 Mar 2024 18:24:11 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	xiaoning.wang@nxp.com,
	linux-imx@nxp.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: dwmac-imx: add nxp,phy-wol
Date: Wed,  6 Mar 2024 18:24:08 +0100
Message-Id: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Mar 2024 17:24:11.0104 (UTC) FILETIME=[1A5B4E00:01DA6FEB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AM9PR06MB8147:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93792a1e-7ed4-4d92-66a5-08dc3e023d24
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIIzsi2DgD3xpVWr6BllZ7nYJvOxyObliKpiafRIv/jyf1RxiDNiEngtQgVYXgw7nQVzUF0ipjwDz7PnVghmycso7bLTeMDppcdj+GOdADNhBcUHSvFePPUbD8XlJgyixBy1VwUf5m3aelC5VTujhnrzwK59P0woCchbIdSSdniTg/BLgOX8fgtSLC5ktjI+OEiNyjGh6UHS/1t1b9CL7YT9GWOSNmrPldZTwCUms96zRYIAlePOqOpfVl0FLU+7SRP5eHGwz5dj/P/N4uoT2emtZAgiVOh4fokxDJvbEwEfDD4F6w5ugfc/aYMSOvcOFy+DcG08T1jEcBWh88U6AJwjnUdL1EXVaG4DJAScReo+vxuAPqDJopr8r24GAHYZdJyHLtUuf9FLv6lMJQCaOuyjLzpyv3DLNNp+vUOr98m80G+rXzBh1jPj0yPbugEyWZVb4mw6AyEdPL5cje3HS3sKVKXRqrUVrq0pl6klRIclmRJk9cmyTMnu4Lne/cJnTIt3CBaXFK3hmglNMLM5kEVLiwEE7ecsgtP/4U6TXl0Bd2NsJchL6EEZc+UDOkmLBwc937n7BNYzqwx2DvSsJpqh4isV6LAOtTQqzqXOxDJWEY9gb0r5xm6G2M6jkOPt+ItarVneoDJXTe+UxewMv/HRG/BQtSyOkRBuT37MqJdJuJDhnD0oNTnMDSVn9k15jkrPxGy+3fyen8093xIf2lJH93ITSxcJQTAmLofh90DyPwTN1iEFfrDgZ4WRjexdauO3fSTD49kT112wkS47JA==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:24:11.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93792a1e-7ed4-4d92-66a5-08dc3e023d24
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8147

Add support for PHY WOL capability to dwmac-imx MAC driver.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
index 4c01cae7c93a..6cf373772eb1 100644
--- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
@@ -71,6 +71,12 @@ properties:
     description:
       To select RMII reference clock from external.
 
+  nxp,phy-wol:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, indicates that PHY supports WOL(Wake-On-LAN), and PHY WOL will be enabled.
+      Otherwise, MAC WOL is preferred.
+
 required:
   - compatible
   - clocks

base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


