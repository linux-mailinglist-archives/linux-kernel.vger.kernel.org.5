Return-Path: <linux-kernel+bounces-35745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FF8395D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B705294EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE380032;
	Tue, 23 Jan 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lIAY/hpf"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD67FBCB;
	Tue, 23 Jan 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029350; cv=fail; b=s6mou2ZCZvGN3L9rZukn7iU7DNHhiGrw11wJdLuyNIhmp/IlviMp68NEbwhifrGaiP6iSu/EU9X8Md2G3Q/y/UAObKGw2DZ/PRHXxTT/SzgVknVpGpyc6dRZVw7sOq1+Wf9Xz0HpKbN48v1zJU2eYomA09QablmiLE/ZpCs4UQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029350; c=relaxed/simple;
	bh=vFGaPAcNUmPRh7akb95viCLjYpWW/0SORK33tKVln+k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kpebtAXCdpY0i8zyMd/8EiClbtMHYopyOAb1aBBfLL/2cJPQLtj6yDfGb79EHhVIHRYr7N6H10GZC6Xrkkh+KPFd5U1EL+CqrCanFY76J7qSDgqLcUdRmrcqjC+fx5lDgbZv4LjoWUYI043JFxUzcoUhMsgIcnxYB9GCd9iUQKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lIAY/hpf; arc=fail smtp.client-ip=40.107.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1MLjOPkQ98Nbq8isI5txiw+zGD/rGRTYa0B6sWUYnDYhiS79xO/B8uAM+5SetFIZj/zNHDvfmSC/2Yh9VPnO7ZZbIEqHvOyog3SLwi/A2VmZHhIeqAYm5VOAEyxIAQJGT/oUOl50QjLf/1bPZ25vcIWWClPXN7zJ/8T9g2H/2iAedi/PfsdezKyBk35P+IF0rs5yPa5IW7H37yij8IzKCB/Dy3ULTt2I0J16Z3r0V7GO1Px6IvIzVj6bVYQL4MTZuN1J/Vav8EIGEO/HURgFPTozTCJTIvV0Lo+BHe8izgc+WbS8Ea3PGZ85g3R6TTZsbe0T60borLz7yGsQzG9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzwFcTGpdJQ4kRlVNglsmMd3+dSjCH6FHmCQEDxfGqE=;
 b=W7YpnHyorUMZQv1rqDbvB/u3BNBNfPFGnhnzeM4x/ZiW7ugjA/y/KSuX39yKEXJPers1lj+BqZ2N0tIslwgFTTdmrW+mxUlP2X1UnlXtvRJ2HwzsgfFZd2/8IppEHI0RbitDJ4GJXFh/CBsmNmN4SKLeD6fATcEVLPJQSc9nZgQCo4et9jnQYjBvPB3gE1VsOBKsLvFdmm0GwkIBSs1F1Sr42BgbalcFSgiCZTQJYf2wmt/pLuxotre4yT9mhyvXvoGJFlDvGMNhZWqwWCOh+pab9Xt9Ijfrr0/oBdQk3/JWg78/FxJureYkh8n/Drm+K8Gz7qBUayGeouqgJF6ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzwFcTGpdJQ4kRlVNglsmMd3+dSjCH6FHmCQEDxfGqE=;
 b=lIAY/hpf66je/Z9P+k7+854NZPWQ9ra5UUhWb9dS1T7SYOLLr5+iVwguYfbHbWxwpee/uJnhTStYpgUYIXHZE/8OzFS0eicnCWqRT67THkbioja2jV+tS/hS01ojdR618y+J0OXmAKufk2qQoX4Z3ARrEXGPUaYIkmW9W/Kpa/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 17:02:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:02:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Frank.Li@nxp.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	mathias.nyman@intel.com,
	pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Date: Tue, 23 Jan 2024 12:02:05 -0500
Message-Id: <20240123170206.3702413-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f4ff8b-409c-4995-05fb-08dc1c351280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MyrWCc3b3mmzaUNY/EAfdLYtz2BXH8CY7uUzCNNSeqnbP0ZxgtETIu03UcJAU3iBeJopKznCrC+zAwDz5dr5AXERfZR20rzOAcQfOt5xdQ5pCntsz9obbFKxzNoG0KqvMavxMEoQkYPm6aS4JesX+/azqEVr0i/SP5OuAc9WwZW1waaWbTR49uOYPxqZdCxCEbKX1oWEyIVwDxrKHaIWXeOk8mDq67MgJRhfWxVCHZubheaijaOuAiczisbpwo0o2v6ENNrBxDlaQ7b1RE5HruIPK8xrWWD8CQTIzyAIIR/Z7P9ROQGrBiv+AGLp2UQ4yswXFWJIbWRTrBSJaDg5zYai0PYfW6gPX/wQQBQkDftrupntPmUjFPDGSgvYkMqhQOfNumD7OUCpIBZiuHS8POxFg6NAao7lldOyGxb4rafgeJ6sLjCmAuy9Y+zmNgTpq50YedbmvYi53NfZC8edlAsmuRbit5Q+Hr9UDcEnqblVMN8fmcCOOMgfSmXJXdIvG02vQvxmjY0yA73XvS67KGQNzrcewDLJStrvv1xTVIUdaFubUVVnYzyr39xxuGWZsnH/kU7uwvwOwqkjqWSMgHw/3WbZJJqoMOPgL9ewfi7ml1XF3wXKtFwkjzIClb8y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(2906002)(5660300002)(7416002)(36756003)(38350700005)(4326008)(6506007)(6512007)(6486002)(86362001)(52116002)(478600001)(2616005)(1076003)(6666004)(26005)(8676002)(8936002)(66946007)(316002)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIsfS7ScJ+LFABtRAS10wDMerIQZe7prITjjdXjbpaR1nM0hf5C9MOyXUCsp?=
 =?us-ascii?Q?YnD+bCrhIRquhHYDYq2FAcdQaGNnxo4eLVYPvJT5nuDrnGSZRIpwRjWJjUJ1?=
 =?us-ascii?Q?wIkaNuannEXxNkvrCfLxtP1Jhf24r3vrLZXVeSV56KStMPbvfh7FUoIzlJcQ?=
 =?us-ascii?Q?9nz0TawiFyu8WOxqBfnDWDymxPXk5X1n5vizXOH9dAltJGH4TrCvedTTnSVC?=
 =?us-ascii?Q?NYBAKxZMBznxNY6MlUPrU5FQWfZBLtTWFBVG/ChXKpRNpfxFgp7/JjV9hTcm?=
 =?us-ascii?Q?s+xVtqPUkPhMwqrei5XTAvFAvzUVp+2tNk/9IBNnA/ANEQnDUNVm5YA0RnVN?=
 =?us-ascii?Q?MaBljpEN2d3+ln/CYqjyOgEOv66z22G9BXC976+IUAQnIPCbH0PPFsDyDS9P?=
 =?us-ascii?Q?v3El9Mzc0r/5tLILZXJSq7pbi6BVfrgmIDMborDP+JY09FrJCHH3yKnv67p0?=
 =?us-ascii?Q?T1X2U++2MBuxuFMiRh7NDiVpo37djehJ4JzQRf9i7yOAO8aNRf0WKJOhpMJ9?=
 =?us-ascii?Q?TUPr4IlO88qiUOaRqpA6NQv7g+SS508UFCIZb5DzOG+/ghF+HqmmIUirZKTN?=
 =?us-ascii?Q?AHl7za66ym4WfncGWVkklnzTLDq1SMZgNdcsmn6xMD0NjDGE3wJfwa5R/D3G?=
 =?us-ascii?Q?DgzqQPty9HEuhtNm+FpB40PRRE3KNBrzg9u5j9IfLP2e/CeM5KC1guhaCg1j?=
 =?us-ascii?Q?4RYsaVuPL43CmnObUcL2k9T7Ks/QdgyS5kqpui9S8TIYsq4/1kqpMLjt1fs0?=
 =?us-ascii?Q?iaAXCeONDViERkpNbM8Vnmoe246s0EOP7gqfGiKGZVpnG/5MHmNV1uebp35t?=
 =?us-ascii?Q?jucV8Nc52jTckhKaQw0hLcUHIsZn6zBuXJ9KlF9ToLNDG2XR0ej7wSXhmwR+?=
 =?us-ascii?Q?lMB6nc867N+boQH+E3bdhKUBpm9279qT3HdOOgPhX3kO/Az1KxXBNAJ6Tg2q?=
 =?us-ascii?Q?knF5FOIUdJVc7hDpeY33Ynoj2ZDpPlrWE52iDPNcrPAaqHI8hPagM7EH4cL8?=
 =?us-ascii?Q?/m+j7wplgN0mvjgcNtnimYq+Q8i9uNbuuCe1j7xXCRK1fI8dcLYlkkRdbwWA?=
 =?us-ascii?Q?LyV6p9FF4XB1tqDOtOie6DPY/YRV2rl9AO3cvX+hGyZql2t/QYTq/qb/t2tf?=
 =?us-ascii?Q?YV+7kwo/81rBrljKpYmROlt1OmaN6Mk+eBjcombMEBcZi0OHseySaQ4TnW1S?=
 =?us-ascii?Q?ASvT6mlQgBTwD8gz4q0/1Ffbv8Jh97/M2CjUzZClI2Ej9JYsM9pT3cgtv2KY?=
 =?us-ascii?Q?HfLuW/AYa8GzmASluHj68bOUh/ukhcppkkQT70nC2SbnIJgyXOn31AOC4+7c?=
 =?us-ascii?Q?Ej01mEgBB8Dwqm+xVLEkWr4QM79e+KWIwAONdK+B9HaWZR0vsaqXw1sqMHKO?=
 =?us-ascii?Q?PLqqWcZsbcv9/TYJnQqUZTRdQGRCgj2nwJjxMiKyKch628Ul9SUaqnNYJwXJ?=
 =?us-ascii?Q?R+CSp2cbBFBNZ5FrC5zDfyQhcsz3gavx/lNGRIlE1WoMBAKx5rmUve5/2fCB?=
 =?us-ascii?Q?si23C+d+yGixMov5H13OKSMGZ5p7aWrTWwRsXn1TJPk86ZmpXMDKXsSaBiKH?=
 =?us-ascii?Q?pDzgyYoeknM3ooYq11C/couvnlqrNmibWbJx5cTl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f4ff8b-409c-4995-05fb-08dc1c351280
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:02:25.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh22ZGI5omvhQNrjNCYXV1XhctFLJjH73rzbzH8gdj/32zHF1jsFzEWgKFas1ZYLvFcJgLBPimBXskm87ukf5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Add device tree binding allow platform overwrite default value of *REQIN in
GSBUSCFG0.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 8f5d250070c78..43e7fea3f6798 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -439,6 +439,42 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]
 
+  snps,des-wr-reqinfo:
+    description: Value for DESEWRREQIN of GSBUSCFG0 register.
+      ----------------------------------------------------------------
+       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
+      ----------------------------------------------------------------
+       AHB      |Cacheable     |Bufferable   |Privilegge |Data
+       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
+       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
+       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
+       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
+      ----------------------------------------------------------------
+      The AHB, AXI3, AXI4, and PCIe busses use different names for certain
+      signals, which have the same meaning:
+      Bufferable = Posted
+      Cacheable = Modifiable = Snoop (negation of No Snoop)
+    $ref: /schemas/types.yaml#/definitions/uint8
+    maxItem: 15
+
+  snps,des-rd-reqinfo:
+    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
+      snps,des-wr-reqinfo
+    $ref: /schemas/types.yaml#/definitions/uint8
+    maxItem: 15
+
+  snps,dat-wr-reqinfo:
+    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
+      snps,des-wr-reqinfo
+    $ref: /schemas/types.yaml#/definitions/uint8
+    maxItem: 15
+
+  snps,des-wr-reqinfo:
+    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
+      snps,des-wr-reqinfo
+    $ref: /schemas/types.yaml#/definitions/uint8
+    maxItem: 15
+
   num-hc-interrupters:
     maximum: 8
     default: 1
-- 
2.34.1


