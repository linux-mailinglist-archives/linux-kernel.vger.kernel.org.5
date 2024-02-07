Return-Path: <linux-kernel+bounces-56858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCA84D064
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5561D284340
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE48663B;
	Wed,  7 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="NyO8VW9j"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82682D9B;
	Wed,  7 Feb 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328746; cv=fail; b=Q3EHPZdqlNK1cj5IfwZhyMOfEEwAGviy+OvdizzeFdE0EfoqtjEVIhyqBc+ULqsOte5Jk+8UR8pq9jUdCGvL4gUsV70/fbRVUgFLdpfZ1XUgMQJT00r5VYIK33f5WSelJOua0DvZC8E8NHyDSdM75mQYxZvaupsVZ1lZqeOh3ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328746; c=relaxed/simple;
	bh=FR+7pUgsOECEYLp17qcZxbwpHXKO666klAFe5qy1qzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c0IYXxUnkPPWdkWu+dofZu7qzAnoqp9DoLhcAlL2o5bjrGAJbaazS1+hS4t2+fM4K4RvmXQRIIFJ0hYIcy9wUC8Oolhtlm3WjDqK7KKOJW+gowQv2kNyyJkvADjaN53/7cuLuYPlww/NAerdDv0dxXj1vI8bFpVp+T/qJjFouv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=NyO8VW9j; arc=fail smtp.client-ip=40.107.13.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0d+NY71lhBnksmc3G89cQKpkgTokAX8pCMuy4G30SYe4ULcz90juhHauycyJWnLf4JHHU50Kh6ult6jdXKobs9uTwOdBorf4UzfXe/sO2FtLVipFETzpNrOXz58oH7I6qyAG5Hu1EHzEY/q40W8ZEa4BLKj6tidwBftnZZKJPW8QsobB83X7rubeApPpjwop9sn5XKGnepOLHdYTT2ezilskXw2rNjxSuP7MWVjYHkCpdnKBwESlpVS5TUSHdoTlCxEKP8tmRUhFqxLRmR18IAxJT9cnSnYaIoJM1C7PRRj1hVVJ/bAVjG2a0djsyUtRmuIEW0qGJoWQgy42QeSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM6BQtTS1cSrcVSD0giPdOs0I0u9xAr+AU+kH6rAIKk=;
 b=ITFcDFB92JVvwN3Ppk0Z+HXuxnw3X5ZDR6Olo51UIR2TlPEZqOGIxLsnCZSaB2ZdBW/HpeSXln7YywCyH7F1BYMwNRkTlUjmpo6HwLr/Cg+qCTmGMiljqMzQugFmbzuXY8NNdY52nM3uHiiYshfOj3y/IMOEVR7nxreBfDi7m1L6qfLmsFiSvSsIP6M43DvUuGg3LOeYkL1zC9iuEsbc4hzo2Hr/M/O/ZJXvvRC3utFKWBPZ7APdWNzYxwhHuyE98XV46YR9whOm15kfFBb0KcWZ51IIU99eq/F1kOAh6KMGauwgnG4eEcyYQtJj8RUslSTgZEAA3/Hsnzd3iYifbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM6BQtTS1cSrcVSD0giPdOs0I0u9xAr+AU+kH6rAIKk=;
 b=NyO8VW9jfcFI8fXBJRUZWPYz1NRFRTq5lTmTML1vUKVaeVqXhnT+j1dd8nmCx2HHbj7/9g4GkYW6gVF+dn+5iEvM3gnGQNMNXX+EjXBMtcOwEcSgYmuEUa8dHQfDlCtr8y7GguxLEkSk16ZtMk9wZCGsNC1MHVmpvF8Cruacdi4=
Received: from AS4P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::16)
 by PAWPR06MB8990.eurprd06.prod.outlook.com (2603:10a6:102:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Wed, 7 Feb
 2024 17:58:58 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::e4) by AS4P190CA0009.outlook.office365.com
 (2603:10a6:20b:5de::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 17:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 17:58:57 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 7 Feb 2024 18:58:57 +0100
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data voltage tuning
Date: Wed,  7 Feb 2024 18:58:44 +0100
Message-Id: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2024 17:58:57.0434 (UTC) FILETIME=[5256FFA0:01DA59EF]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|PAWPR06MB8990:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cbd9edf6-771a-41d8-f74c-08dc2806750a
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2cFjyigbnqU2ejc/08Yth33a7dXlQEIedzufNgx0MXIc5xgoMvaafg8C9abJ7PummjhWHslMdDUHAztEpUgx9kkhPj/Fow4YfGGIh1oxfaTVhmBh2w8ONPz9v4opWPM4H5NHpnJy6uxA4D9eqX6RQ6+P9WsGcBuTqu/BCCoUS2dJtbaUwL57Hu55S0RbT4nicrAMgn3rcW2xi4P1aZ6f05pP9/4hPhHrntufJb4GNRIJfJT5W4h7iKzNN7Mv7pp4EBJgOyNPRvroxMuTEryd/SI/0Z9Gy8CPM8tFcls2BKoNO+DWV8ZHIsMrfesfKZkrNx1Al7LcdjOw4vb7lqugrneR2Sy5VuEf3SoGIXvv7y04VjC7UU/J86SnQkxhYWkZxzz+7HxkqUyeif/1lnaut+w68UDNF8qH8J1y+WetaIAKexHY5/wcMJLiF7oIcH+Q9l1dB7zPGchkfYU8hHRxodR6Ww4Y/AFc/2dkbmN5Po5WLIG0Y9zhlazzlSIVZeDCwirHerES/gSx6THp4N8zHX9nhV0u0f+4adA9lXo4XyjkT6a6Jy0etHMQ+nVJNBqGABq5EP5EpuFjH6+3ZvNQO40usLn6FZTRYwgNftr/y0KpMUEfpMJd4HXKXUbJggjYGx05j5Tz9dTY/hW2nm4Ol+vBh9LCnvao/E81Xl2mpDVcjmWEe3LDbnVQBQRG5DyAq5tzOvSiN6YKZKQAQjJxikuGZQq8eAqtFXUa7q2JukzLSobsZ+LGOC3Rj0fEXQUGI6GIHq1tqoyCIH1HBzm50Q==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(2616005)(107886003)(70206006)(70586007)(1076003)(316002)(336012)(26005)(86362001)(478600001)(921011)(36756003)(41300700001)(6666004)(8936002)(5660300002)(36860700001)(40460700003)(356005)(40480700001)(8676002)(4326008)(2906002)(44832011)(450100002)(47076005)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 17:58:57.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd9edf6-771a-41d8-f74c-08dc2806750a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8990

Add properties ti,cfg-dac-minus-one-milli-percent and
ti,cfg-dac-plus-one-milli-percent to support voltage tuning
of logical levels -1/+1 of the MLT-3 encoded TX data.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - squash the 2 DT bindings patches in one single patch
 - drop redundant "binding" from the DT bindings patch title
 - rename DT properties and define them as percentage
 - add default value for each new DT property
---
 .../devicetree/bindings/net/ti,dp83822.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..6bbd465e51d6 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -62,6 +62,24 @@ properties:
        for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
        to transmit data.
 
+  ti,cfg-dac-minus-one-milli-percent:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level -1 for the MLT-3 encoded TX data.
+    enum: [50000, 56250, 62500, 68750, 75000, 81250, 87500, 93750, 100000,
+           106250, 112500, 118750, 125000, 131250, 137500, 143750, 150000]
+    default: 100000
+
+  ti,cfg-dac-plus-one-milli-percent:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level +1 for the MLT-3 encoded TX data.
+    enum: [50000, 56250, 62500, 68750, 75000, 81250, 87500, 93750, 100000,
+           106250, 112500, 118750, 125000, 131250, 137500, 143750, 150000]
+    default: 100000
+
 required:
   - reg
 

base-commit: 6d280f4d760e3bcb4a8df302afebf085b65ec982
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


