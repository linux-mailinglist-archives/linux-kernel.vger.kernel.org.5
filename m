Return-Path: <linux-kernel+bounces-35454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C0839177
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530C5B2667D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481750A6D;
	Tue, 23 Jan 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JZQvuka+"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578221104;
	Tue, 23 Jan 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020474; cv=fail; b=RdDHH0mDXo/olaG8X/onqetT55nntRVrCYzZLb+41evyiW0wmAp8siObO1qx7FZ/yw9yhpq5Tb59P3OGTpXptn+0d/lL+e6YmsMj/V0cwLqS7wVKH0AnvSRDZXndtpn3EtNeAZsCTIm2P7MbP88Y/B4mFlcb602t0UUZ4YNPrSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020474; c=relaxed/simple;
	bh=JPdXYYM/6UcnJLmlaY1Mld+UholQG4bzIYP/LyYzyRY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vEDIooj7ucmr9eUovwuDmFxPtE8AX6CMw+inlMOJJu5n2/vVoxZp6KEA1yQpQMjXb/2LolsODhY6DkMqy0b+qtreiCOZmcy1WNWjzx68VdBCAHO3bq/3Ty6S0On5XCh53LXDMRpCmVcmKCxCzutV0fhPv1XaBGPnbUtATVWK3Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JZQvuka+; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpBXhKvfI3enPvHp3/vqt/siMpWZfs1l4bkSuYuXXUjgu6IL4uGFNMRyQnUlVLeFKyudXwey34hdYslsco3rVv/HIexTuk1je6QMFxOq4u4st82jDP0hE1buZjRaq5bvJjNNQTgSwpSDpRzKrJdrEl4XR7nJ08FvDA0BeuH0NJD9SD7YrzGgybQS+pK0qlxmy+/7AP8XmE5R96goVLU6A67fd6vnyGIMtWY1fk7KsxGwS2uCVk8J0vbFRTUUJ6v+qmrSPS4P6XjTxM8XvSFY3DC3ivWjXh04u5n54Ve4gx11KgHIIWrR8AsQBWOm+f6aRw8+RfSRCRpwAoJHyFKuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3XHHpStksUO4GcHGUVcQ9dgS7D7luR0kd4G1utidJ0=;
 b=b6KG4G4DXVCx6FwuYs521qO78rFXJXLnUSFJ33Yf/DiOr8OHVl65+YCWglJ40xx45tV0X/S3mXQgb56A0osMU7ISXxStHukmEvpViYdWwgxAVPckRNUSOAcv3Ej3iRDE1WkTEoM57q4BNtZdu6dyLz/9tgBpXygMJhmyr5qOOsnt2MHPEciANho8oXIa/dPZeNzvRdJ1rqCGGyKHtIgDtKOEcqJ9rr8TVS4AioHU5g591kpJ6zQxEzZzQxrcfX0yogKoOEGpUsWajQEZFmjpFm9GmNy17oKnUmbHcF9uEzz2XfQlbTWfpIMi/zQKJnWjGcZtDkwP8lwWUymqNldabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3XHHpStksUO4GcHGUVcQ9dgS7D7luR0kd4G1utidJ0=;
 b=JZQvuka+OS6htvbrQgUjwxcQU2mPST1h4fd4eMHOLa49ryUh6se6MtmXVrFpUt/B3LxqEyZ2c/wS6VWuFKYw1s4xA8+YOcxTy5GkmKHsmEaf1vXrsw4xDLI2QJPKNv9NuqM0xB7iSPm8/NHxgEO5FPOImH8sbYzjpg8ciDVxHS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:34:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 14:34:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 23 Jan 2024 22:38:42 +0800
Subject: [PATCH v3 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-imx-mailbox-v3-1-ed932945e0bf@nxp.com>
References: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
In-Reply-To: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706020734; l=2485;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WhIUeH5L6Tjf2c1SPOoBHhGiEQ/e6lVAYjkS8AaH3kk=;
 b=8D0rE/JC8HyIfQqoDriZ2LdyTXRoxX9/396kquwdLZ3tLcRWXOWWe8ruhjRB1ffVkVjdbYZ1w
 9RxmNH532OyAG9L0pDrOofamFjE3p5nKNZLwlQfNIo/OrjXIba+d/AV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee0c847-216f-4b3f-fe5e-08dc1c2067fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xnbsR9SlT9SuZf47sG8ujXqDkf/N3ZbwGyuHLp0alL7C/1/sZ+wGpi3F56A+ka/rlUjqCqew4uYFgOY0EnsXnHNrnw+bi5mhc9oc+pekP3+EXejaG97b/jwP5flSntvVr6DojMNwy3+Kj3tOalNS5fzlIQWjc/1jbhfdxOlgdO6THe8CoHYhkDNTfNbN0YnG6FqCjJY1eq7I8Pm5RtiMcERQabgBmb2nwDGtItZohuDtLadoeLf2HVxYW+gfY+tKc1WwscsOAus1p0gbTaYEHI/qvL63+rqTbdPMnoT6CQXN3m73XS7iHp3vuVK+3ccKSNK4nk59Ero7+MWZk9xhBfzbRGpigy1kVDVRbRBk1q92TV8pIeDkIxHVpbeQwFTOjs1rb3X17PNaWIMZBqFMIIrCQJwMkwTkAR987/FHGBLE1fkuehY8S2b7sVC0HRP1N7tBrLjmiwPzSK/qOL2a06c3erW4sAcjeeyuC0TSghata+jE8lpDu5utTyqQSPsifJ+0IausUzb89+BDpItF9/Ylh8p8b6ZTEuZ2dWgtH7koJm7VvsPc2WeaVNrM8X5OBqEmeKiTrOBvAD+WduWf/aeIxeufZ1ZccF58LsN4lqNcFz1JEAiGxSh86kh1W/HdwD8CWfo/rEZF3cC45+7SZHVxfqCfvY+m9RGiF4Mq1WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(6486002)(6512007)(6506007)(6666004)(9686003)(52116002)(478600001)(83380400001)(4326008)(2906002)(36756003)(86362001)(38100700002)(41300700001)(15650500001)(38350700005)(8936002)(8676002)(921011)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmlnTEY2YWFNSUo3RFgwQTRXdjlqK2VuV0l4aHJnb0NHYVdseGZiUEdBMVZi?=
 =?utf-8?B?Qng2anZ3cHhiMGc0ejZBd0Rta2JKNVZhZWp2MktHR3B1K0IvN0VPejdkeXZP?=
 =?utf-8?B?SWYvcnhEQ1VlRGFGQUtEMW5ITnV6TGJ4VXFsTEUrNmVlSHJteDRpRitkVm9S?=
 =?utf-8?B?TVZiTkZ0NTdTaXlxT2lwYjkvdG1mVkcwaTJNdVdxNEpham9PZWJqOFVJTXZE?=
 =?utf-8?B?ZHAxVlBUQnJPWVB6a3pmQ3MxUHVEczBEVUhBc0VLQTM5cjQzUHRxcGlyU3k5?=
 =?utf-8?B?cGxqNVJPTXBGWFh5YWFQN08ySDN1Q0p1V01VZjh2cTVMTmxBakdTZHI1b2NY?=
 =?utf-8?B?eEQ0UTk5dUpaa3lPN2M5ZnRpVkF3Yzd6bWFWdXZsZHUzTDRTOTZrbEpSMmlG?=
 =?utf-8?B?aFJIMXBHWWtTaXVpMDhKL2grZCtCN3VGRnBTRlpzNGlwelUwcUdtYlR3aWFm?=
 =?utf-8?B?d20ybmxEbkoxU1ZWSkpjM2E4TzVwQ21veERkTWhoRVBQRFVEa0lTWUpCRzh3?=
 =?utf-8?B?SEJRZGZlUkZkK294b3lvZnVSS1BURzFKbFI1bWdRK24za3NvVjViMmczQ3d2?=
 =?utf-8?B?UzdDK3pCcW4xbXR5d1VvazRiMUt5c3ZJSXpuSVc0MjV6cGQ3NjhvK1h2ZDUz?=
 =?utf-8?B?MlE2VWxESFlnM0crR2RnbGlkRFgyV3cvbGdhRDJmWlB0UC93eHJZaGlIN0pu?=
 =?utf-8?B?SVphUlJIaWNPWHg2MUkxRlRWcm1uSVpWSEI1dHUxLzEreWFlb2htbjNRMmhG?=
 =?utf-8?B?M1ZkNDJWRGlxRzhlT290NFp6OTBTblJ0RnBEZERYcmxpRlNQcFY3S2VEOFg2?=
 =?utf-8?B?THJJME1Md2lIY1VNRFE4ZVkzRUJxaURNYmxiMlhLalh6UnV4MVRXVFNXaWJZ?=
 =?utf-8?B?d3ExMlRsSUxNVFB2aElaM2VPSzd1bWJtZDhzNkc1VzVHaWdKQkl0S3VLa1E1?=
 =?utf-8?B?dnFYbzJTVFAyUk5pZCszQnB6WGE3bkVqQXE0UytISU5yNmkyU2N2STJkeDdI?=
 =?utf-8?B?c1BnelNMSFFiQ09IdFRnUk1MNnhVWFV1bkJFcHdiNnVGK2crYkk1UnVMT1Bx?=
 =?utf-8?B?Zy9YcHpYMWY4TGRXcXJtNnVaYTFyTkNLbFN1Mkw5YWdRTGdkQ1NFZk0zRGYr?=
 =?utf-8?B?TnptK1daM1ovMTBYTkJMR1BteWllVjhTQnNEZnBublhrbDhvOWZEc1FzL0VH?=
 =?utf-8?B?YytmajVZWVRDR2F0Z2wyY1I5VGR1Q1hwMnAzVnFGUnlZanNYQ2xTOS9wMDQy?=
 =?utf-8?B?bW9MUHA5QktydmFkOWVxTjZSSzZrOFJDSWhsdS9OMGo1RHVqS2o0VHpKaXJK?=
 =?utf-8?B?U3FaL25JNzF1VHpFekhxRUdnYzFHVjhOczZBWE9rZHo1R2tmcFQ5VHRyR3ZU?=
 =?utf-8?B?bGhzTXBLcGpKM2pNUVVjejE1NWRsMCt5RjNSMEkxbzNDVGlFSTNqYm9BZm1x?=
 =?utf-8?B?TTdLeC85L1BJemJGdURoQ3E1QXdTdEJVZ3pVUVdLSWUrZ2s4NGtweitVTTJx?=
 =?utf-8?B?RU1vbjNSL2V5VzhwQjRZVnlvbERMYnZIY2tScVVhajZKRk82dFZDUlV0SFJ6?=
 =?utf-8?B?bFhMUklpRGxYVWMxdTI0cWloOUJSMkFKd2tNRDB1WWw1VVZ4QUNJWk9KMFlU?=
 =?utf-8?B?ZDc0OFEwTjh1YzZNekVrMzU1cXN6WjZMNHRvKzhwMy92Qm1ieHRxM1FZRGZV?=
 =?utf-8?B?Z1FHWEdFWUJHQTJnelZuNjBCTzFjS09JZXF1R0p4Q3JCTUw0K0N2RDhpaHBl?=
 =?utf-8?B?UzNRVmVHMHN4ZHRjVmJIMVRnN3F5ZlNNNVFsQVRIMnVCQmFEZmNDWS9iZnNN?=
 =?utf-8?B?MFl4Q3hjVy9xVGxXRmtXUlVXZ2dxdXVMZEg2Wk9HeDc0WXlwNEpRTTV3dGhB?=
 =?utf-8?B?Wk5qclJ3dzFNeUdXWVAzZzc3bXlGMzdqMVFUM3JjTHROMWZOUGRpRlIyRkFx?=
 =?utf-8?B?U1h3R2cwOGs0VXg2QTJVOHJ0NDQ0b2VhM2hYc1ljUkFwUFNVcllSYlRHRzQx?=
 =?utf-8?B?NUJmcmt6NU42MXVMREFxQWpEa2JLN2ZzQzFHQTZNUnhpbU92QU1CeWNCUjFW?=
 =?utf-8?B?blpLbXpOaHVReTJwWVljcE5OcFo3NEwrQ1o2OGxEUWhLQUV0QUxtVGhvNzU2?=
 =?utf-8?Q?xdOwz5qiNYBEDm5u5vD4VSAsd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee0c847-216f-4b3f-fe5e-08dc1c2067fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:34:29.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crBhhd9uTRB6h8tdpj9Oh3VYJpNc9EpnnfIH/VJg1avti0IoHH1OctEkWq24WixmWnqG+Tm5mfdBgBZw/2hVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And some MUs has internal RAMs for SCMI shared buffer usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 50 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..569fabc5285c 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,10 +29,14 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
-          - const: fsl,imx93-mu
+          - enum:
+              - fsl,imx93-mu
+              - fsl,imx95-mu
           - const: fsl,imx8ulp-mu
       - items:
           - enum:
@@ -95,6 +99,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  ranges: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "^sram@[a-z0-9]+":
+    $ref: /schemas/sram/sram.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -134,3 +149,34 @@ examples:
         interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
         #mbox-cells = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mu2: mailbox@445b0000 {
+        compatible = "fsl,imx95-mu", "fsl,imx8ulp-mu";
+        reg = <0x445b0000 0x10000>;
+        ranges;
+        interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #mbox-cells = <2>;
+
+        sram@445b1000 {
+            compatible = "mmio-sram";
+            reg = <0x445b1000 0x400>;
+            ranges = <0x0 0x445b1000 0x400>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            scmi_buf0: scmi-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+
+            scmi_buf1: scmi-sram-section@80 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x80 0x80>;
+            };
+        };
+    };

-- 
2.37.1


