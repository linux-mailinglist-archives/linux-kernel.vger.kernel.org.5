Return-Path: <linux-kernel+bounces-48811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79F8461E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60282B24CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC18127B7C;
	Thu,  1 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KnXPDo0O"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAB127B5A;
	Thu,  1 Feb 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818998; cv=fail; b=TmWnyNkMCJFXrJWg+qpTD8NU2S2xfnuHGmcihMUkA7TPPl5lHmTCb9tG4Brbav6thYqP8SygocTCPrRpEgAb4p5OdYSk0LhoMBAjEsmaqGjnafHJg0ZcP+i9wjAa4b5LBYhKEhD6MS4n8LYmWbv/qAmWpA3DaHx5d6BMW8olACs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818998; c=relaxed/simple;
	bh=UQfzJNubfOdP8iFCuypP8/Va/j7L7oqf/pMInW5ooYk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dy0FOlZpw/51Wevzr+WLz0XXmxSqYJXPI476rVQPe7wu2ilTitqezf8Bo/p1EbR/zd23RDbAFr02h/XbYEC4v/LNduZcca48fIh2mDUrK1yq+jt+cRIzh+8UuobY/A42H1KfIlasUh46r0tVlVAfT8+SBfgr+p6YXGaT/n3QU4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KnXPDo0O; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGOsmSZQw3XMO8eNd2OjYNFeP/v0KXOvyUkkJtqFZa+AraANfQueLDN4Ts6zs6jlAUKHv1zjeSm5Zie/pVbmMU8ithObg8bIT0KpLKgcWuk8hrSt7SDM8ZwepW+4Mbq6hgrICyfE+knqvNWu1SKMN4CJkNfOU6bpUp2PiJSEuABwiZgbi5kgv4wCrcwVRPkz2mc7+4F7Y2WENBjrQoavxnjNi/dWiOR2UC9/CaFeOY+nFqLgGf3kyc97NpcYcIlqGYxUmAClLTEz4tAJFtcpolor9J317sam27NcL4CqPVT1uuLbFUt42o0y/sl/iYlYud68j8nYKXQw0hN0hr5NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6qDKsJbxXjl8uHpX+tiAtEy0kJUHgClMUhYnhBkLBw=;
 b=FOlsOGNboXsR4qNXBNt4KVfrC8CGz8NzeciUQsdOqM5/YMLNYDrP+dm3iI0/u9LMQfXjySVblyvxczfcMc3q6jMrAvpG7PStOK5q+pIZZKxG3lgOs+Y3F1eyFLGIsuKPTlyvpMQq4dSmJpo6rDz0EVwmGJAfC2nCVt5nNyWEcRIJHE8ZL3pv+1vSKEtprHPqMJ2AyPN5UoIfqdhAjeQ1bb2XWlbLxN3IfbSNfdBNw3+WsPkwP7IrW3YoSYZR6I8QfxiQEiMKOt3UXXC8McQMi+6vQgwEakqUq6TZA93uNAnUkpRQcs+/ef9lo180Shsgtq+sG+58222AOeiTfw0JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6qDKsJbxXjl8uHpX+tiAtEy0kJUHgClMUhYnhBkLBw=;
 b=KnXPDo0OEkfbNL8UmIZ3YewM/xxP8hpnlMZ5wg+LHv2KgUBb1GKWkbBREuUJRi00h66T4N+BeqeG00H609OppenfvegfnpTugwBDEkjZC0UEw7jvMIB9OGJ/9P//PW10QLbddRrefhgdPqq9mk+oDcIIumvE0/ELNM/BYgZ7908=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:23:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 20:23:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 15:22:41 -0500
Subject: [PATCH v2 1/4] dt-bindings: mmc: fsl-imx-esdhc: add iommus
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-8qm_smmu-v2-1-3d12a80201a3@nxp.com>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
In-Reply-To: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706818983; l=673;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UQfzJNubfOdP8iFCuypP8/Va/j7L7oqf/pMInW5ooYk=;
 b=hgD6HyiHUfyPKMn+4AxGgyjrAwtXmMr1vVJ6z/FW8zAmVQKbAFEJyc85FcbcQyCffqU9OdXWR
 mYpt57Gx+lxAx7DWTRDwolY74H7Xl+zXYsuY8tFyaIPvKt1gceaFN2N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ad6ccb-b3af-40fa-c469-08dc23639e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M9zKK8LOiS8h2wFXYsBbgzxYDwTbSgoh0SchGEDI/HrSqNKiz7MFmfWCw7DRCX+rutuNUCsxohhkWoYAMhaZaPxuTBCjUfYm0d3/QK8ZD6HJp4PNaZH+cWGtYSJqaOhXXOXmXJ2LdpE4cVROJ8KkozpYV+fSvjV/JOoB3d9zGdDNRJHhDA8dRShEPlp9sIWFjxKey8oE7Pz9pCL0rTTINOr+MQ6tjRxxe/yniQmR2QsG1Mg/zYZHKzettXOLuRRTIorf2tSWt3BUxuZvG+Lt9G44S3PXaKG+aS2KNyMImOQH/FlU8h3YX7Mb37xSNBAvbm5qkKsB0lFE/Yng/SQsKkpf19q4rnYEli4WNOW+llSxNteZZHwntFCZZByLJOHNd4a7NLVi+6+MkFZyKpqddgHiiee/Wr5xEOkRjojNSmXqbAgZGsyH4Y8VtW9cYpHJVZ7T4QOu0oMGD4cRzE1bAukNCMHjMzIX9wKrVWQujW64rVf9fZOPtZAtRd2wf8r8Z5mLNT+n+5H2ShGj84INhvev8/RNr88Qh/M7OsPjLsMRRLXPRBTvikz6b+uFDFtGpsGf5D0oRzpRAXjqZ+k8Ned10qGh7YvnvoR7YX6v9n30evA/3Prwmom7+i8n5rYjZmZyOYDL6rxoZ/7Al3oJFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(921011)(41300700001)(478600001)(6666004)(6512007)(6486002)(6506007)(316002)(52116002)(7416002)(110136005)(66946007)(66556008)(66476007)(36756003)(8936002)(4326008)(8676002)(5660300002)(38100700002)(2906002)(86362001)(38350700005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZytDMXgzOFVIcitlR1FOZFpUc2tPT2lsZkN3aUJva0I3VG1zeWxVbi9nbHZ5?=
 =?utf-8?B?dDZNNVV4V2Y2VlJhUE1oUkc1aGdqQTA5cEpwa1RWL2tDS1BHS3Jib1NGaFRw?=
 =?utf-8?B?YytiUStTNUZ1L0VneXRQMEJSMG81TStBOEFzQ3NsV0JaMUdEKzYvRFdmS3dQ?=
 =?utf-8?B?blhQQXZaU3VlTG9KcjlGL2VaR3l4ek5PdmhrNnZWNnBTeWE2SjlZNGdtNE8r?=
 =?utf-8?B?bnQ0VDlla3NWS3IwbXBNdWIwVzJsZ1FlK2tvVlR0d1FCUDlZWDVHUTJSNitO?=
 =?utf-8?B?OFYrYUM5RGVaZ3lPaVdudGpLZ2tFQlNJYWRYK2pLbzRNdFZ3TW1KNVFWU3Qr?=
 =?utf-8?B?TTloTU81RkwyU2c5R1RnWWZxMmFNMFlPcEpBTzE0c2FEdXY0b3p3NDh3eTY4?=
 =?utf-8?B?MzN0Qjg5MWVreXgwSnVhUkQwL3Vtb0tvRzI0T2x2U1BHb1Ixa2hWTm5pNG93?=
 =?utf-8?B?QnVxNUtpQVJMU0c2MHJ0V3lNSi83SE8xSXNyNkhCMGFid1pjQlVMZ2NnOGtQ?=
 =?utf-8?B?MTdyL0ZtWmpKY2FzSy8yMnZ1blJXNzZSeTByNFEvbjdzMndFd01tY21uaEpQ?=
 =?utf-8?B?b2d1VHh5OE4rWnUwUzBralNZTkpUSzdQTjU0SFZkVzhXdHF0UitBa1BrbHpK?=
 =?utf-8?B?R0IzV0Z5TlRwTElCY2Z5YnVOZlhmNmZ6N293c0c0ZE4vaW1ucjVKT2pqbkNB?=
 =?utf-8?B?OUdnODUxZE9yb2J1a013cUI5eGMrRm44Y3lpbXF0VFhMUDFHeGJzMlMxcGUw?=
 =?utf-8?B?UkFmQzBUeWVYTkRuYjRSeVpuWVoyNG5sR0tqdks0ZVZmTGdkemRlL2xRRGwy?=
 =?utf-8?B?Z0tWUXlXTFJJeCtjK1ovMDF1NFBjeHBSYzFnL24yQyt0aU1rYUdTZGhzK0tm?=
 =?utf-8?B?LzFxb3FkcG5JeGxtK0FJL1UyZExYVzZIcWdHSU9NY3JSVUQ3K0V5WWtTdVVa?=
 =?utf-8?B?RThUUmdPRVFQVGZSdDYvcnhNVDdUQnVyUGdwVk11SnZGT1ExS3QrRzcxdHZl?=
 =?utf-8?B?ZFVTdWJkYWtGMDNXTDBQazRSRWM2bjVNVHFpTGUzbmt0T1FKeitYRFJKbWRm?=
 =?utf-8?B?SXdualUvUE5jdmdsTFJScWJQWGtVaVhYYmFhNDRKVm1uT3Zjd2ltWVRYOTBJ?=
 =?utf-8?B?SldQOVA1dFpuZDRRV053OEQ2d0ZBck1EY2JIODZ1NmVaVHJsL2JzZUx6TnVi?=
 =?utf-8?B?SEtVZWR6bGxJcERPZHhqVXE2eG92clVCc3lBeW5KdXNGOTR3OUxEYmpreHZo?=
 =?utf-8?B?LzRXSlZ2UnM5R2hvRlB3bTlrUStsbitaZEdWVVNpSzY5ZE5XZlEvU05iWFIy?=
 =?utf-8?B?aDdtZEgyQ1dIZHBjcE9pZHYzZG1VbmhZd09ueTIyVjhZbklGU0hDZjg5cGt1?=
 =?utf-8?B?MjFyRzZvMDVlcGNDTUhtQU9jYW5nRGRCWHRwakQ4RFNDNDhHVyt6ajhnMCs4?=
 =?utf-8?B?WTJQVFZQbDRVOEdaWXRkekRWNDVzUjRLNXlsdWlUTldScXNuKzR6TGZEMTBF?=
 =?utf-8?B?TUtMYk5WdFpya3U5eFJ2VVUwWDQzM3VhV1MyWjVwRVB6SWo3TFdZem1BQVAr?=
 =?utf-8?B?Ui9hTmorQS9lNll2T05Nc1E1VE9mbXZERkNtcUxHV3RQekI1bEZTVzl3TDlT?=
 =?utf-8?B?YzR6eVlYYmNZN2hqTktHZWlWYlJaSVFmRzJFWEZOYlNQc0Uvdkp1cE5TSC9O?=
 =?utf-8?B?TFRya3NGSXNrcU1DVTRMWnRjcHdKY3FyTWphaGJrN1VLK2QvcGxwV21MYmhC?=
 =?utf-8?B?RXlBWkN1ZFd3bTVTcThnblgxam0zK2g1M3NucGRXNzZwZGphT1U4WmVxK25q?=
 =?utf-8?B?U1BiaitrT2ZOUnVEbzl5Q0hJQU5SdFFGVWd3OXhNTzFidUZCVngrT3lZa3pa?=
 =?utf-8?B?OUcvNk9zdkVIVGpTWkhpK0ZBWDZsYkxTT0VqdFpMMFBOTDh3VkRxR01uSitk?=
 =?utf-8?B?QWgydHA2MElUeFhkSjZvM3VIYVU3Qzh2Y2F6cWZDbGl2QVpROVpraUpNbEhU?=
 =?utf-8?B?OXkvKy80c1hJeHVxOFYxaEhMMEI3Tk9qMzJJZXQrRzB0OXAvWWNVQTAvOUJ1?=
 =?utf-8?B?QlFBREpUTWx6bXd1N0xlaGoyUTc1RmhUcmhGOUEyNERCaGMzcWI3U3NLMUFH?=
 =?utf-8?Q?MIcfkJcsX5Qk4bH3Bu2nOkZ4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ad6ccb-b3af-40fa-c469-08dc23639e08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:23:14.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvohHrhBImRN4ahUX5U82VowWnjCZoei2Jl3+zMCGsmXotKZRyeaVWTpOZV8EcH1KQqWORZb1ofKLGkI51XckA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

iMX95 and iMX8QM have smmu. Add property "iommus".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 82eb7a24c8578..0d8ed9d055ffe 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -162,6 +162,9 @@ properties:
       - const: ahb
       - const: per
 
+  iommus:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 

-- 
2.34.1


