Return-Path: <linux-kernel+bounces-39685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6083D4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A01F29DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C682262F;
	Fri, 26 Jan 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NAq0/Rnh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80D225DC;
	Fri, 26 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252710; cv=fail; b=aThodqYsocL2XR+2Kz2PX6DO4BoQne/QiRFQxL0eeMq2uJQboA8q++RfiWrxZD5bpqm3bB5ZbmklQFIOVca0PW83zXRkxszrgztLqWO9sUSIE2+YEyNelDqQkLCv4pfzfSbxNEWzTewI6hMUTuKu3vVplwzUF4DQnImxALj05W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252710; c=relaxed/simple;
	bh=2pt3qB6MXThX/ysSjn71EKZeu4mGBlQGH/8rQBrPb7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pTFQu3hcXR9CL8pR8HlU++MUmeyCmGGj0idnfD7i/9Zujy99z8nCGNP9g3CIwP3PUwFNSuqokvW+vQpCpzg4JfQ9hwGVVzTe4FT+njmUEsWWsIW8vmULMd48a5llek61LCu1ocDOvhwmoY+hB2UOPqjyHLd2PmcZeLq0qMjy4AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NAq0/Rnh; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFUyLOZLsTrT/2B6uGeRipQtFzdk0YcVIgPdvIAmgnb6rZKa9LYxemJUzPQrj2/n41qMzKnWKZUXFKKTKtgZd0mxVwInvRJtOB6GqwOAiJAfiGrVbLq8kVBWCBtRCthgkKFJDa0u/KpKEK9gAe4NiJlTLYqizndr7kwz7jVlp8XuNJBkhowPmXh3F4OeKr7iuWl6ewA7ENtASapHQVWeOWMafYIUrwykn3ljbHi4tm23tqMRS8VLr64d8u1bzKwmIGXaBMDymtq9U5BmhatL9zzp+PS8i22/1Nx8sg6irf2e4etIVWIhuHQlgQZk+BHJzxD4a/vCzQcVfK7x4gIyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG/hXtUzmakq+m1jt1j14ll0N4okk88EMn++WGWtT5A=;
 b=Xob8vMR9F6htIx8h1MmuB/8UXg7VP9vJqI6BXmIpxVHwwtCiD4ONpfm6c8mU1XvBEH5zAl3GtThez2h7plvR6AJvs+vctjt+gBMbmFMHKAp0dz/J4aNp67jMa6S6CshHTmtZSDlGhtaom26kxafOhLzyNep7PvmfWtb2yZN+4c5lN5Gycj0eMdqbd13Hq1fCqsTX5Acb2AaWBobYvlu1zUOi+tGc0XMB1Lf+rldcM/JIhWMhV3oHLmRfeR4eerqI7i9iba0V40AdtFeUA86OwLc+aW5gU2WBpSZoWkc1jc/26q4s0KVyO1pBvsIO38uEiDbyPHMNGbRCdkcdtZUYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG/hXtUzmakq+m1jt1j14ll0N4okk88EMn++WGWtT5A=;
 b=NAq0/Rnha3iu6kZDEimzlXjOnEgeZCf4j5X9Qu4EHJlfQUYlemDVFv63G7SvCVQVBiD1PKTnjfL0q+AA4sMDW5ywczBc2X+Umf6DPVOH41hmRozca7/HWOz1bQpOTjYSAO24HBTG/8ZnFy9P+eZhsY5tpccsc1CeT7rZ2ptLSVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:05:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:05:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 15:09:18 +0800
Subject: [PATCH v3 1/3] dt-bindings: timer: nxp,sysctr-timer: support
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-sysctr-v3-1-33fe801d5f31@nxp.com>
References: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
In-Reply-To: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706252968; l=866;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=cjsWYdjBFkj2DyyNJGJXUMOsSan0x/ZKOMQwVw8ko2k=;
 b=9Nt3ufd4JfgFOa6yva/dce7Dcx54UqwgAHnpFamv0IF5CugTuyrthuYRLruYDrefptYkL1/5g
 SjYQB4juvEyBQdsJq1301dke46BWbeFtpw3YFE4VtqbTCts/m3x3eu5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a3c580-906a-441b-7951-08dc1e3d1f6e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ne+fdbHVICA2kPdVMQHW5AwqdwDWcjDXIrOiFHDjPMhS4Y7F1Tpoijw0VgNuSQFqrbaCj08iFxECHR7IXtJWFO3FQAjkQO4gUSQs3PMVzWRHi3vNS/uHXvYMIkNZzbehjckZPaSIl/S2f2VOPmN5VN67wE0Zdy2fXLp9itkOegIMkZcUr17kSBTlObjUIOJy20W9eNoq2i1SchzOd9EZ6oCrCQQq4cMyxGDvhztW2RgHa0zWlB/zPxjJ53iSXQJ+rctZaicfUOYIa4PETQpGdrZaFvB/yBzXZq3wwAxKQPBgVQ0knD/+NxBgNxmTYAaX2+4PB24xi3X/dLZ4CI3GkXiXEyl6Za5HMo4B0XC9Hl4SB3GzcVc2qx0YyWlh0jcyW/387vRLVBPl3WSxY+F1cZX5cmlUZC6qMUSba4PXInQCZEaFMrHk7xv4kYa0tA+sc72RQzpez1/HwOa5rnaP3SpIoQVnGlLE3/NOFiWK1X9IF8dGgR9YakFv9JU5PzoYMOwlR72lpZFgLgUzJvFZP6MmsaJe/JjwpAheBytppvCHqO89d0k9/qy+oGcGceaMMlBx/OFtQ6d3uksPXFaiwhasjKcdfRNcr4d//5RcTpnyOGyZZHijPV+LynUwOve
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(921011)(110136005)(36756003)(86362001)(41300700001)(38350700005)(38100700002)(26005)(9686003)(6512007)(6486002)(52116002)(6506007)(4744005)(2906002)(478600001)(66946007)(316002)(6666004)(66476007)(66556008)(5660300002)(8676002)(4326008)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNYUXVTcEJlcnlwR3BKU21odXBZWFZBcVVSdXk5Q3Z2YXp2WndqekRGT2pp?=
 =?utf-8?B?ZWtQczZmd3h2NFMzTnp5V21nczlOSTZ4K0xOK0MycU1wWkpkMXFGRDZCREpV?=
 =?utf-8?B?YzI1QnZZRjJCWnRPUEQ5ZGI5M2dBc0VVVndsVis1Tk9rWVgrN3ZabzlYb3hB?=
 =?utf-8?B?ZjhqYXpueE9ob2h2cjdtYU5pbjVFN0dMWmpsSCtwZEVQOHoxVkNwNzBVdGVz?=
 =?utf-8?B?MDJDUUR0Q0Q2UHdOc2JuYXZWQ25sQVFSMitseTRUNXRKVWVhUnNSMHdhQjF4?=
 =?utf-8?B?VDN5emxaN1R0bDV3RDF2TWwvRlFCRks5SUFzOU5HdUN5V0puemJ5NktLNjJN?=
 =?utf-8?B?cEdLd2VpZ3B6YXpzaFQrWXlhcGhCUFpTekdiRGoyM3k2OTR6bVovWUVSOHVN?=
 =?utf-8?B?ZGUvNGwzTFkrbjkzOE9VNnkyZ0RTNGJ6S2xzYTRGMmZ2LzlrMDhldDAxNTJV?=
 =?utf-8?B?U09aUTJsOTgwYnFDcmM1bGNIZDB0MG00a2d1QkVzWmQ3RDJwS01oVUNmUURa?=
 =?utf-8?B?QmV1ckR4LzMyazhma1h2N2RaemI3aEJzNWlCQU82bjRHYWRFdEgzTnIxbGxB?=
 =?utf-8?B?MlphVThYSCtCSXdsc1pqMkd6aUFmUXYxamJiYzAyc25Ka3NXN241b0FzL1cw?=
 =?utf-8?B?MDYxbkI0TXpTS2Z0SHArbU1DejcxTlFKcW1McE5XaWpEQitmZU9PbFY0dUo1?=
 =?utf-8?B?emlJUjBDUTlmdTF2a2IrejJSM3NpaFBZZHkwOEVKUmhJNDNUTEhKRzZGejhE?=
 =?utf-8?B?b00vUzlVVmxvOWQwdDBkcEhzSTJxTDZPZ1p0TUx3dHBkNHpuZkZvWE9IRGxo?=
 =?utf-8?B?MzcwUGVKQy9zVjR1R2ZjZ1BkcFhOSWY2blZmd05wb3pIWkxhVWhVMFg5U0Jp?=
 =?utf-8?B?ck9IVEp4Si92cmJFYmp1TytPTE5FQk1pTTVhR2lDYm80TFI1TzhBNm5MWWFM?=
 =?utf-8?B?blBzSWR2YU9zTUVqWmczZDlzNDZVbkcyWlE3bTBkQlZmZlNtWjRueEo4azF1?=
 =?utf-8?B?K0Z4KzFnWEN3eDJZMkVKS2lob21BUTFUbHFlNTg1My92OTg0ME9kL01qeDhi?=
 =?utf-8?B?TWxnYUFVV3UyNEYvUUJIMFRCQ1ljWmtRSktwWGtqWnhXclU1dFBZMU9lZjZS?=
 =?utf-8?B?WlZVdU5oT1hSTXBrc1VYRUhEWUR2ZVV6YThPc0tnZFhDcXJNeE5tcHpWcVFH?=
 =?utf-8?B?SGRsdUNCMytvbytCcEE3UjFhSklYK1F6aUpzTUNmZTVsazJicmVyTVdlRFpw?=
 =?utf-8?B?YmVTclVmYVMyMDUwcmQ1YU9WZnd6R2JnZHc0WkFvZGFkL0tmdnpudkt0eit2?=
 =?utf-8?B?d3pQSXp2NkhUOGsyeVNaa0hKNCtzOXBrbzVJWThTb3dtOS9BeTVkcE0zOTZz?=
 =?utf-8?B?QWlJVzNBZEpSTzVvUUQrM2JadG96dGRPOFQzYmZPYUtKZVBMOWRRTjlvLzIw?=
 =?utf-8?B?V2diQWx0UEIyWU4vMGlVRXVuckIwZ2xtVWFhWG5RQjU4djU3VkxCdnRYYjN5?=
 =?utf-8?B?cE1ua1Rwc0d6cXUvVUk2cytHWnhKTXJQSGEwQnRuS1J2U2E1Z3RjdzhzOFdz?=
 =?utf-8?B?QVJtRnViYnJIZG5HcVNrSjFzcjRSbDRyTWlLL2xxbWh2bkNpbGJkNU12Tmha?=
 =?utf-8?B?V1BSVkp6V0lOOFRBa25wUm5RbFdFQVM1RmxjWUhlV0pCclpVaDI4QnQ5ajZ4?=
 =?utf-8?B?QlJnOXhGa0ZENGtqd1k4eXBvamxqM1FsZmpjZ0Z1RzJPQXhUTWNXZCtubUht?=
 =?utf-8?B?YlhqcThDWVl2NHY5dGR4a3dFcG8zNGN0Y29jd1NRSldlclR0b04zSXcycTJO?=
 =?utf-8?B?SUgrWFR0OVhySm95Q1NRTFN0TEw0eGliVEtKb3pTbkRqT1pqNnBxUHNmdC9D?=
 =?utf-8?B?MlhHYVRrRjRHNzhQRDdndVFiOC80QmVqT2U3dVdCeTVCaFdzbWtGRUxiOExw?=
 =?utf-8?B?NkdoejZ0SzJlTCtTZEprbzU4MUVKVmlhM2tySTNRRUgyVWs4SHZBUEN0WUcx?=
 =?utf-8?B?VE1YQjZWVkZMU0lOaTVIZFB0Tm9QRmw5amh5bUZLS1hqSDZLZnFHbEgwbVc4?=
 =?utf-8?B?SEx3Nm0yN29hL081TGl1WG1Gcy9PaWF5WlhpblRHeSs5dm42MVA0L2NTR2pS?=
 =?utf-8?Q?h8RaquWk6eIShwxmlq4UkZriQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a3c580-906a-441b-7951-08dc1e3d1f6e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:05:05.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hCV0ptX994q4IU9fkIebfeGqXYmJZBKPHmMZmJbPj7HR4Y2bueLF3MMYm5csrhaRwMT0WeDGa4q9HGl+M3XSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 System counter module compatible string, the SCMI
firmware blocks access to control register, so should not
add "nxp,sysctr-timer" as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653dafab8..891cca009528 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    enum:
+      - nxp,imx95-sysctr-timer
+      - nxp,sysctr-timer
 
   reg:
     maxItems: 1

-- 
2.37.1


