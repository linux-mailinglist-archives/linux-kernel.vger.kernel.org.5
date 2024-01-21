Return-Path: <linux-kernel+bounces-32035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A787D83558F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA6C1F21831
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2036AFD;
	Sun, 21 Jan 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FdwPngbQ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FA36AEB;
	Sun, 21 Jan 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705837727; cv=fail; b=Cee0FWIhQDzeFGGvgo2YX/c7fhNAJUH0ogSpj8RIDvVDU6D8aCfDWfnWjyVLrOqQQa/Azc773moTogIcPK6MCSXJ4of6GLg7BKaRrmaEP0SSfCg0wubisYqVBXr23Nkc0gYbdgdVgTsiTq16DNzsqRqixk46GTq4ENmhexvTqJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705837727; c=relaxed/simple;
	bh=RTAistZp9vaoBjKlc+Zp8egoetdwSyujpsBOBPfQw5w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XPF7Hixl8OJEbWRxtnfUr7EMmFL6P1AZSscbbCY8DKiBInhYi9sij1oLLw+ZdkxPGVPDS7il3DXfGQxmbVGhl4qt5J52dgKtgiZ91as1Q/DUeBUVhhnX+85aKqCnMcRtYhtLJmWGSFoKFO61+95A/zA6YxAcOMXZCHJv5Mmmv9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FdwPngbQ; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyxOPRZ3uGVxVy58xZpcicvic8PI+1exl3uBMvD+kQJ8o2naVYMYvuaw0LeVhVS/YoSRrtWB5gLDbY2z0KLr4d3HV8US0roXw3UMzj8CpwIrcaPPtBAy3X45v8E1fAxPP0u/gOgjh02/U0TynveWndh9Q4U+xN1z/YeXG/VuzXM3q1L47KnpTMffgKanAJoWj2pOf46VwRz7jkhMhu5d7ZVLlxEL1+d7N4g3kV7DMwCuT4SlFCpSRmjDoDi8rPDxOiAxqBAxeWQ0WsjsZ2lFmaKI9CtmPT/C0VkMVEIgP1kJci1XTGNR3JNZIM2F6w8a8OATT5ZlmxpAkVQWB2tfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfBiN53mVri51XJT/WaFRhaco7pv0NZ29+u8B5Kx1JA=;
 b=HmUDDm5GWXszKVlBSylhIRoTiRqlHI2hpXeqhYdXBpdvpqFx37voq/9OetjO9qZwekBMDXVhOHj4VmDu0h31rnZtlQKlQwwf0gKruENvMZ3Ga4Fu1k/bKjsqVvn964gA6yr2upTCOOR15ZsIeAF5QzPo4nZNgAwli+XNPVnaQqDpipcX7ILQkFhwSm+NohWK+eXrDGbemUO7WEeIybMOthP1n9/uGMbVVv9uZ/IoJzDFf4IC/5vn86e9e0ggRXd7YHpsZFwLSbqibkXZ5RctnuV0BeSHfOVJXjh/2TXUMPmZr7SokJkyu1WTB6J8rm29SxAHvy94PIIA8ulOCreiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfBiN53mVri51XJT/WaFRhaco7pv0NZ29+u8B5Kx1JA=;
 b=FdwPngbQ6ePz8b+2tXzjc7wR1GqBmC6EBOmr9+fX8iu1CVJnat0onBhdL1yGivsc6bCYidIOEGSS5KtgnOixgkMr+PLZyN18KKiQbaW3wZYIK22576bDGOjcUKeCwhhgNm+8p/Fidh+eedZlekvEDaEsuP0j67PV0zZPRKbq/F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7458.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Sun, 21 Jan
 2024 11:48:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 11:48:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	jirislaby@kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: serial: fsl-lpuart: support i.MX95
Date: Sun, 21 Jan 2024 19:53:01 +0800
Message-Id: <20240121115301.1420502-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a8ff13-5735-4ff5-cb4d-08dc1a76ea45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1NJYd89FdvzknolhtZMNwKnb7Vi9n8zReB9eQi+kArZugXKQIUHa4f1YWBnfHmNwjJJHWzMn62dcC2laaDLoPP22HZL4idgb5ZmuhMIfeGyXoH0Z8Mrm0ywl4c0+Jgo69nyIPM+TslZskvrGKKvwQ59GS0iwZjJeq2TfYdW27EtSRDmHVerh7bV4hnrR0/wkGWTrmZW8HluHfGKrGNhvzTK3WUntqLcBpDS1XIZzaas2NALK+TcuDl6QlMfP6g7odf7gah9mv01Ct9knO3RKVhjmb+0z8/kxAA3ZQHV8mXbmPe56+6GKk4Vmaxw9FTMaxsC+0MIkbNUOcTDg/JUYv/MIgovkKSUHISXjNN5E8Otws01gEyh0rglr7JZPQNf6+li0KFECBF7UwNN+0Z+LIc7qCjgTFdSv6JCSnVvDDh9h7OwN2uRMQMvxp7NHN3YUA3SYfJp51kTGW4fCnix6xkXcszRATwOD3rrxw3bB8ugTs024B4oVNqb9PLtdkyWaV/QjL2QSLmWUR2mx/gbbXUsIWfZt5oXEuOuRI/83Yy1qESLixLjKRqxgr727vsQjyodL7D6cwJGmBJ6bJDbJXRkJZfuiVRHC/dQ//IigiHCRYYr/bFnuqKJoF4jims0E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(8936002)(478600001)(6506007)(52116002)(6666004)(66946007)(66476007)(66556008)(6486002)(316002)(2616005)(26005)(1076003)(6512007)(41300700001)(2906002)(4326008)(5660300002)(4744005)(86362001)(38350700005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDhemonXcqoZwExhr+u62IY/EZc24+k4LV0uwtjjbcs/ESNRpw2NFsTswY0T?=
 =?us-ascii?Q?AYGISVv243cQttx8YBq+1ugdeF2x40nALR7v3JMkDWnE8w3yuo5dB/QIrn9f?=
 =?us-ascii?Q?MtXxR1i6dINepnT3LFONUnGxTNYzes9f3vwNcD9UqMUOfjfAUAzOeM0drGFU?=
 =?us-ascii?Q?Hk8YpZ9+EffN0oAPLptS7twHdMBOU637l4fwHWVc3eru4hRE2k2nRqQR13AL?=
 =?us-ascii?Q?f7/WCemZ0JWUWDdW7EMPL2iCgd0/wYfyfdhwI9p1Yb1irwOa2ThY76FhUvFj?=
 =?us-ascii?Q?aTSJF8ysJTsk3J43n/EnRnYuUu0LDGEWQ1kZtnx5PR1rGbulyHX+49q60s+7?=
 =?us-ascii?Q?ExF+Jt5HS9ZptsMwiidTbz1bHjkXxrtnAFaBIJRHu2HSyuVDCinpQ5+TwSRY?=
 =?us-ascii?Q?FpgmOHl/LiNZ5X1zeHphm2ulnjyOWUkx67ALpMNE/yZuK1QwNIKV0KuEXXYv?=
 =?us-ascii?Q?nAcsir8HoYXHG/fWnSGsFf1jO2ChTlB8BbDQFMc3yO5SloEr5nALiLi7kTFX?=
 =?us-ascii?Q?VX8DBWKrGpYX//5oQ6lFKyc0WYI8MKO07XIsAjR1GJ3y68vf+68Axsy/R8AA?=
 =?us-ascii?Q?AJv4ZCDSi8R7137sFVRnEtQZM1BDsFbcwsyu7oj9ucpecd7fbzUJ5BLzpe18?=
 =?us-ascii?Q?WuI5mDZSxu4DcAORLbaI6AC8q9VKZaeDzoIQGcgXvHfhdL8s2p6RHy/6A/ec?=
 =?us-ascii?Q?cSJlkiXhasLdmwmWuYwwoRgJVQBje+1EVvv2VkzF0Km+uUbzrCJDqMstMyvQ?=
 =?us-ascii?Q?TbS3NpUlp74ofoBHbeWgWdeQyfxvvT2iAWVG3KNlkjLc+WMUVdYKO6hwszUA?=
 =?us-ascii?Q?dx9VGRafrNcKXb1LLSV6tMgotqf9zsL/xDkO+1PeZWulo5wt/G8TbpuyAncJ?=
 =?us-ascii?Q?VuXwGkIvErKPz0hDZotQLA+LkkBq2t3M6cmfh4CEgpqf0FDPZIqykRA59zEz?=
 =?us-ascii?Q?x1jwJ+HrtiKPvJyWqHbSneuE4aiAFa8MPAkd0QeMl+zoS1R6AplQuGnivCiU?=
 =?us-ascii?Q?BXScF9mscBtiUfA3Jq15riMZSY4rqzHH9MA4BEj8BPa4qtDWG//kb9J7K8T3?=
 =?us-ascii?Q?jcxDEACeATtLN4DwLWOpl+XPJon8NKG6cCyjSEEBNegfuo0besuEYhHGIfoi?=
 =?us-ascii?Q?XC6kQ2b/2ZvC7NhURsjzlCCttJkslb3Z3Yt9+ATPXXjkjWYM3NSp7mM3o56i?=
 =?us-ascii?Q?JblEHsv0be7jEi9mTxBsJSS97pRy4OdsJVLSZb3vkXOPsTyAFPJu1dcZ+DAW?=
 =?us-ascii?Q?wMakvbK5L9vjgPWchWKc+c0U61pz9/6/9otBz/kbI6bQnq70fUiMUXmwkuAH?=
 =?us-ascii?Q?fM6Z2cdp+EzzOwABWQmOCHJ6SlE91jHNfL8N820zrRzBJAWCKAhmnNeuSvxS?=
 =?us-ascii?Q?oSEMNxHAY7ZwNKAzccKjx+4Z8tvvtTYAVZC/rBccxzLif8u4e0cbbK2R6Rmg?=
 =?us-ascii?Q?58r65sGjZWAJROZ3OzZi6Zfve2xZpABdpAE+bzgm42RL1skhkxRXjKNTXixq?=
 =?us-ascii?Q?Anr/azciOkcW6MQcHkwBk0tMLvMk0a52AZysq577m8zE0ZdKHl2SO4rdVgaq?=
 =?us-ascii?Q?pkctrpG43VYCTASIC2/Wis9Yp4zDxP3SSAV+IuAG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a8ff13-5735-4ff5-cb4d-08dc1a76ea45
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 11:48:42.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLsJF0KYoZPRflO9HqQ64+ww0ksa5ZWFdLbX5P/xw+yH2b1/ecUnFNo5Hnu4cy7Cz12ZtEgo2sHZ4woxfb6UmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7458

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 compatible string. Same as i.MX93, it is compatible
with i.MX8ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 3a5b59f5d3e3..3f9ace89dee9 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -30,6 +30,7 @@ properties:
       - items:
           - enum:
               - fsl,imx93-lpuart
+              - fsl,imx95-lpuart
           - const: fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
-- 
2.37.1


