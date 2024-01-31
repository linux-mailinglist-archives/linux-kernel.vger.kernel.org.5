Return-Path: <linux-kernel+bounces-46047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F448439B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C71C27A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6D84A4C;
	Wed, 31 Jan 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Z5fxiQsq"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548F66B25;
	Wed, 31 Jan 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690567; cv=fail; b=fnmVHNuWe1KRT2CA49ojcNEpsLjjHYTqfbJaWHyvXJZ93Z6GTKUCwvBsVeaI+lRx1BSWIYJYSqnC5x7kNBkKKcLxQIDUznL3Pyjax0LjLf+SgUSRgxLHF6FTdCpbefJxCjrxMuDpGwupwMYeIENi395yDE9A0W6on9hgVz5JVlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690567; c=relaxed/simple;
	bh=pHREFFhwlOVJ+c1HJlEaq0Noh5MYW8giykiy57ShYiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XE0uKuK2Nx3TnwwIqxDbLxMo4oeZ5el9juUw1uBKvpKrkEPDKJ/mB6ks7/eDItC2etMInZ78S6wTyVKLwRbQ1VHFlXk2xCCMwIXDYneXSsOc46g7WQMpO5JzWBExtuzSest5m4Yv41jHmjDo8x+1o2UdHcacWA5ODUW5uFXh1JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Z5fxiQsq; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBUbA8aJScJqW9M/MTRaNOcpeRFeZWJy80LTx2h0cAhH4r9Xhyl50otMbTq8p2Td4byzmX5vuo7SSn8wVUb98upoEalJEvW7me0Ubahgb4TYixUVzOoqMc9TOCfS0L4M6GhdO9dKHjLWF4zYFQTvl4m1H93IfQQVHj7W57X2dvtufuoxhzMCv93CGmATOkZJv/f1kRf+i7ja4BKX6ywh8SYUPgZvFtaTFvBuOIVpRlcSmXvPn0u++8Gg3SZVrEV2oJ5X3dbqeZ5DYAMZEskLGEJy6Hhk4o29QFMssXMvwA4l5fJWbA5mmULXzfFS+s5pM8UoOOGpXOyWGfZ0aK4YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUNtvQ1Eth8qm1pnxm9kajQVaK4SrxDkTRzAWRlpwnI=;
 b=S4koOe94dmj0rBeXHsc7EKHkcy5Jbsl9HyabK+FJ7aPshr3/pjN9Abp82ZrGVuET60Gna3/aypAjak2bf2VNoW01ZtHOZdpQLDiHEJaQR/8BgEu89MGzfiva6/V78rFlQzTj4tn2tEtiLAYCUBrQCU8miUTus2ekKDU88Tighny0YrKIORsfHe5OWTjiu8WytJGgoHBErPgdoC5yadjEHSWD4RL5jlINHqX2UKXUHfRur8Tm/hyOxZiEv9D+dyqJwaWIz978nebxQ6KqvMmz5DTP/wdaQCr4yVq5mzQ8CnFQ0jJythcxGoBCaLyEOlq7MMah+Z25ebn3UX41zifC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUNtvQ1Eth8qm1pnxm9kajQVaK4SrxDkTRzAWRlpwnI=;
 b=Z5fxiQsquainld2hX5JE4B5XUUlU8Ld7gPMcRH4o8kUmsDvIiUCCGVdSGcwSyq3g+8ok2P4QHktzwy7JZqgMUDgVmj6At3ceaS2zCfmxcfiPa/S2Wj6OGLRT6tW58uJK6fkjSir9Na7ErorK342YcpIDt+smqvYHSSK9+B7TW2RT/jcQerch7JsmLvgOpT0wqmDm7YA+a+7cMLeZ1joEs/ztim9pAWztd5G+pjk5VpTEV/BImPsP5G5y5UFoiRIBCPiLuDyR+MoqkQxQmjUWtAD4TOk+pYK1c3bU/kJ88heqImH2qY/QbyjVMQdJHCFtHTAVc3o2LviL/usgDn12dA==
Received: from SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23) by
 KL1PR04MB6832.apcprd04.prod.outlook.com (2603:1096:820:d1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:42:41 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::7) by SG2P153CA0036.outlook.office365.com
 (2603:1096:4:c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:40
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
Subject: [PATCH v5 15/21] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Wed, 31 Jan 2024 16:41:26 +0800
Message-Id: <20240131084134.328307-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR04MB6832:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7bacad78-94ee-4369-ea0a-08dc22389634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMePLNBlZ8XKjHywBostY/W9D8NRPoCms9QXVtvlZLtD3Vk92Hi/CZV0VtGOLc+aVvwWV48OYkKU1xDDgP14EzwxmKHVhsP3IEBaofuTyjlU8o0D/wfv7+o8lDTEZz1KNsoig6qIXDXL3/+KBZctZOiPdV7ILGy0bNnkVjKd7RzskCXTdd4ZYzQdyRcEdqA8qZinX2BxZ1hU22Je/pa/qQEYRMSqhuXznUgMadjVF95l354ht4kfjaoS04PmvN0Ne24JDNAkpPc45ESBnb4Xp4EOv8SN5LUj+oAJAjaqyL6Q50Pn0bsDM8pj7+XEQ+G89HmYMiuusACKT4bYxWfEdX7Wa5WAnXk1jGdCeyoVsX3zDS8gpehddLTTawAUra/LTQQzQ9ATshQaHpkaNZmYRAcYsu56G8l+j6jOsTbW8vN8TxI/+E/+3gP9ntqLfmCOjaAUF6sSdaklLKMbForlDLMYd6CehHewXWfhMfpkjg++UOrA6iC1OjdiX43vSAuPVpMla4BSChEfxXXOBIhQvG85e0uC4VuI2fp7TU0iRnkpg8FFqwKb6/JWd5Zbjq+2KlN0hZks3Hh087tYsA3KhiC4ECuAgYxzdq0/pxXOi3mjRnvdUqea92fLiB2LncvxISA+gn2Vqy4SmPIHGLgZQnS72D/GzpM/4qbdvR9YP5dHNWnYSU5ijDvoH4CkUbateFw7zdKGEj2KcdgD3VedgQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(86362001)(26005)(2906002)(81166007)(9316004)(36756003)(41300700001)(4744005)(356005)(40480700001)(110136005)(336012)(70586007)(83380400001)(8936002)(36860700001)(8676002)(70206006)(316002)(6512007)(36736006)(6486002)(6506007)(47076005)(1076003)(478600001)(6666004)(2616005)(956004)(82740400003)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:40.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bacad78-94ee-4369-ea0a-08dc22389634
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6832

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f0e93c74003a..6d5710e5753c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1227,7 +1227,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


