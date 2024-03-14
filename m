Return-Path: <linux-kernel+bounces-102742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472E87B6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E1FB22C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF858F55;
	Thu, 14 Mar 2024 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCwrPaZF"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2071.outbound.protection.outlook.com [40.107.249.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6C8BF7;
	Thu, 14 Mar 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386494; cv=fail; b=dHZyIUedLT13FlOnJEF0WakpWW8TcE/G2dPDCvYF/5KRvXkfjEDpBJjV1zc9Ro0E35F0dPpfuOkrUvlXpbkslHjJQhScelL4J55ptJ7ZbsAU02aPL+FhSBTDzFD20TSdPoFCt2cK5Hgqk4QlH2D/WQmbunILxTs8YYuV6wehEVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386494; c=relaxed/simple;
	bh=Pqw6txsZ2rC3PcvL8JI9YJXr6Ow/ZJRt15XGgfedm08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnqXNKKNWqGe3YaKsQ4RRRkyFduXuRrHpYawElkoNPY3Pu2UemkIdklxunRxLF521ywtd6L+Eh5GLZV1fEXnZ0B/EjvKxgcwt2IwtPourBTkaLzue6/1Wxb9HgZWOVe0/rs7hNkFSkOaiKrWyicKNA8ENkdgJqbFIW/lBfk/lFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kCwrPaZF; arc=fail smtp.client-ip=40.107.249.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn06HFsesqgjbLMbJapt1cHnAr4KB9e4CXYb19GwRKbquMNXd87cypXK1kjOWdi8rV+uzt1wmtGHO5quCHHeEXoc8Jnc5RmbuJz7jQNdnwAAu3OV5q8mvA8XkFjFhbOUZX5rDeSv216bXQz9RxTgE878RR2WdfuKlT/kOfqYR9sOxLvf+766bIr7G93HlRQbNGKLpAlGK74RXIiA44o2NFDGKjB47HGI9gT6uuQ2XJUjkut8z+V89dkOFB6yTJDbD3ctBXvLyYEeMpbOto2NK7NMONsOikHyNrDMErpN1OFXdkWcuVtShumFcqXPVTvbG0zeF90ghWQBwGq0rIedhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=JAP2EY1asZV5MSriSuxknxN7OJJnsPe04YKpojExPqpMiPbZ9vvWO28h1Jarg5axNCgfXMWD/tovsj7GfH6wcFvOQ/HPVmDVwb569xcHq0cEqWJmOd59Bx/0V1/lCEfFbmYYScpvCUdL+OBT0+hrvuAqsCgmLl3l992QYGrWnDB//1rVNAM8VjQ7jsKJfB9nugkQ+yUpxEYE+dFw2VfRjYKk9qVy7B42Vj/LwhDs1G5ZCLOC+G7tXe9YVz6Z9Wk/4o/qXNM8nlhTp0VDrwaUplQH8i+D+edPsawRx69QABJWWLKbXtv6OVmyCRdetH0eXRr1NDE8E+3xq3XjfPnTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=kCwrPaZFdR7B8KY/VXsVojS4IWXkMSfr/sKa7npm7b/tT/lSyGzrxU3jjA+5/wrWlYZYyxbVTubP8RnnLu2KG+jEMuNfqiZM1s6lWoYFOhXKROSapVdASr99q7Kr70lLDLHB9/x0zPkit7m17LahNK9L86SK8ACcvVtI9Rsz95E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 03:21:30 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 03:21:30 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 1/3] regulator: dt-bindings: pca9450: add pca9451a support
Date: Thu, 14 Mar 2024 11:29:21 +0800
Message-Id: <20240314032923.2360248-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240314032923.2360248-1-joy.zou@nxp.com>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 9251fb68-7e6b-4627-fb0a-08dc43d5d78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Oc5My2zQKc+8S2fFu/auYJMkl+SDENFg5lkH2gj7RBY4j0wPexMYGUBmtqW/BnHTsHA2ym25M6ZmclDFJ/rbbeM9WPhBVqdk3EPVgNav/kxlKLvNbQp0TI3A+CTb2knwqV0EZcpAogv41zn53flojlhXHyVYJwm+wqZMJWJhSYhi4IOLUrrWblgHEBN111XCvmBRckACIVamykx7b0T2RlAcXPQK4umA1uAbZ74+mLyCm+RNbv/M8AgqeNlHonf3R4GeokkRgSucV4lOZlEE6hxacAPBbmdCeW/l5eNJAAVrMG32cooxMRsIKXp1RJfS6/TginSZxxdtmumenO5QL3+dSeMDVbWaNQB2aUGBRKlqJq4AvJXryf2DD5w5UygqojdHAVu8z1X5/OYpp5nbi6czmkm8Sm75fQEmie/ZsM1lsZx0TNOFAN13NHtIF/VWs2K6v4IvO1n5AQFSoFuiK1n613IxGIeV28bJLzQcoWXUyyMG0IoINe4LAnpj+WFoASwqfHcJ4by70S09rreMcUb8bckLFK9ATmmBY6ZrncVcyw2alak3dUkZXcBoTKjUKOVKKFu2/CJWg3AwkeJxkHm7oqJZ2s8k48LfOw10Tap1FyVcgpTEhpVtfUp4ZzeyCCW779qi9k2hBPFF4M9mA+oJ+ex7mc7Ac4BEv9LAoBJi9m8u4byZLl98GiSIrnjhRPPaqnlJ8DvVR5mNdcfkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hywTYzXKLgrggJ1uwa8K94R60ogbHL2beGZLupPNv3cccCAneucCDZnO2VtC?=
 =?us-ascii?Q?xHgbUx7Pnfg9iVjVXiNpYzP7vJcjWtUXUlSZyjBpzK5Y1xrrMBM0iQZ0Sd5Z?=
 =?us-ascii?Q?FvD2VJ28bOB3up/KV4G4LPsaTnqlUwMkJ1XGlaKRUsLiXDTN+49wFz4DxOCY?=
 =?us-ascii?Q?33nKErPv7MRv4wwT+tmeIz0l4I8sitUkWSbXZy26XVUv2C5Hq0f1yliKseAO?=
 =?us-ascii?Q?95FB2uxiAfXwyUTceP3Kiub+tAXaB2OnpwkvnWl9iWGMP8+K5QhgfQ2RAotg?=
 =?us-ascii?Q?PFqSjf+bc7l85WFA+0loJsaFI5hNYMfuiHMcGIzURh5IpkSL7AJyyPO+J3m+?=
 =?us-ascii?Q?aT21LkAswA/GbZ9A9L2SfaWX4CAcMW0Cg5zO89DmPQV4kp6fRhwELpIrXdAG?=
 =?us-ascii?Q?5f5GepugGrrwUyzfA+Yrax2PHvnpFS3DIs2qoT09EQOAs/m9B0taKTc+qDmP?=
 =?us-ascii?Q?IcUZk+Er8L/QBGlXEdMf0Up6DsFRna6ft3N4HdC9bcBUrYWV06elOLZ0kU+1?=
 =?us-ascii?Q?NJ9Kr37mppPbJuajQziBmqJaYLBYUIFSWfYAWmBrD/XBOpl4gz4S8/XcZMvw?=
 =?us-ascii?Q?pUpwl3x/VXGOx4YNL4RJAcAYEnRo7+xxMOV7M585IIPUcrURuMdV5nqkoUBr?=
 =?us-ascii?Q?TCAvWa4nibd9+2XDLREZ1Nh7aqu36yuvJ3p1y1c09PwhvMme6oTUqtbFUm9Z?=
 =?us-ascii?Q?ogIqRNZNNNomrfH81+9G83Ra30wjVK/JGLAEDk79MEB2DhYg7211rnJpT5CY?=
 =?us-ascii?Q?aow/NRnTaZBDxXgaU9D9cmhJ4qyj2TYTzOJjTDkGaBws9i45zy5Xv941+6RA?=
 =?us-ascii?Q?4+O0OWi+Pj7S9TlyP4tNPwyp8P/fH2zBisINHa+vZ1TmAjW86UIpEqU48Fxc?=
 =?us-ascii?Q?5DagtDTA505HkPw0s020lffwo6bL/+YRRpwLDed2F4MZ0scqoOXUBrBU2ZaS?=
 =?us-ascii?Q?BTo6jL6PN3DjevN/3aqZo0lOa1M/ixwaU5rQCybcnZn0sokCs0mpV4YlO26c?=
 =?us-ascii?Q?heV1Plu3RgvJmoydpFW8tC6pOyWQbdm4y7G58/P7zDVsgqBg1Htx/DdS4mMh?=
 =?us-ascii?Q?J7sPBFYUyM6YbHQJLW/FVwadZWL5x+DAGOWtDMSgyKodQfCXyVuou722sOyJ?=
 =?us-ascii?Q?Zoa2oIEXEEP5v/4Ql3XIQgXsbUHAgUWt7+l3kNC8BJXwk5wuvOteqhUQTUeY?=
 =?us-ascii?Q?vwIokV0RwaIl67hZCrG2bMTd1B5zP3cfLaaZ2b3GAuDFeQTznOacjIT/Wa8r?=
 =?us-ascii?Q?vQL+obUW+im28YfJ81BK+JA3sRmGmtraSdhyYsw7eEu+eCHLWBUrMzB3avrj?=
 =?us-ascii?Q?rBMTInot7SplrJeVQptBbnLOHRlROXicxmiioaf86kW5QLq4KjIg0svOn0F3?=
 =?us-ascii?Q?gSFy6FZgp8CdXtX0dPhlyCrB6W6jV11AWvE/fIgUaBN1QrradKvd9oGlk59E?=
 =?us-ascii?Q?DRGjYjZBq8YOC+TgvOJ4qJg7W5sqH9lexdp9jreHW579ZAveBT5F0vJjEhO5?=
 =?us-ascii?Q?61gOuqvPmtbrxyQnADdelKdoXc59lDxvDsnsuoMo3PNPndNlncNv6RoyWkql?=
 =?us-ascii?Q?GJZ2kykP7bc8exn0RM/IMJ3u+vl8ZOnzZiWAaEXx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251fb68-7e6b-4627-fb0a-08dc43d5d78e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:21:30.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5sgk1rd4ic5SM31+h/uoBjnLIWd4h6CxJ+t/TrD59EYuX4Ws6Us9BogjEiYBlbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

Update pca9450 bindings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes in v3:
1. add Acked-by tag.

changes in v2:
1. adjust the subject prefix sequence.
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e9774..849bfa50bdba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -28,6 +28,7 @@ properties:
       - nxp,pca9450a
       - nxp,pca9450b
       - nxp,pca9450c
+      - nxp,pca9451a
 
   reg:
     maxItems: 1
-- 
2.37.1


