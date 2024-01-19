Return-Path: <linux-kernel+bounces-31014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D8832792
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C806BB237B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA413D0B8;
	Fri, 19 Jan 2024 10:22:44 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1D3C498;
	Fri, 19 Jan 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659763; cv=fail; b=tVUeNr1IrAa9dweGDQ3Ahk9r3DNuMmd3D2Lyh6LgFdYq5z3OsSf41WZCiFlYDG0/yfrVTnE3hffD3lUWJWqb3C5B4NMcECkUBBhE3K+6h1K5+6Y6JA/ba4GeE6Nxg9TrFMTj+1ckXrp5Swi/gcjq7dc81xF4RMKZpxn7+y3Xy4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659763; c=relaxed/simple;
	bh=LF1edr2NpoDY/9q176SlFNEPz2pYlq/Wzih5E4xAnAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeY8M9fVlt+lqORnWWid0QG2eFWmOmWgCwuv2mb6dzKH41UVo39B+78rsluQXv4+r5XBCEX4PlNpjHiQa7lcdhRyZLDCT9Ua+vNOm/5weN3nfp2t8J7jiV+dyLHbLYpSoKhVOPLrQ0K9EWZMpDU9noyx+PqL+QFZI0mxaAJNWmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvyOKeJe6oX/QJgi9/eKZzJRtcExFn3ajqt5hni3CqA0KqbGbmW5dQ0G2g2u4SGdwtmDGPb1/7WV3hp1TaX/Yjr7oH8lLBLuavkJMmL4z/q0mPXBBWKj1O3k1U+JON7KPG9/sgtiJifnrVkJ5Gyh7ULuoTI+11QUuv+ncqmaZ6BCbKGNiOBxx8P4mJcTdwwGFfOIoEZiHljh3a0ZfC2YcYI6wQtDlSwCZ9rwOEe7QLe9BNvv5Q6EwNgq5UxMft6Swj1UhdcL0MGxPpDEtlNkR4jjCpJox7yNEON/Bn83si3gWPqGGauSnNCusm5T1NTKFo5vKrV7hUU1xJfszAQXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuq6DMHG+gQtUK2jN9u+8NXVXG39IIeDA/ptEob6S8Q=;
 b=ANzmmzXC/LMiBz72Q0fF7E4YkGwkfYchFiRDvJ0d16uKAyJjnXdTosnOaishtEWjEj2gZ3SULqCOB9YEZ5ezDI4cxCnzNqirz97sPbzK72oGVlYFLz2TUukUJU4mR0y9icNPHPSeaQYhe9Oz7LqvxV5Oitwu0FvZu6g8pw1GYSU8qevKk4ecsPkV+IIe1CA+KzCAp/WM/2CHvAvwnk2Jz6m+AB1nQeLjRSuih+/g7RXc2GzcBIqrzWxz3lXnus0H+lsQjMQROXaYzHp0vGTlHEcGiYuHbQds+Dk+mEag6ZBjnJ8TxaxkiOZlgoSlUhMYPKuhRRYUAt/Z3pEVedWv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0558.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.32; Fri, 19 Jan
 2024 10:06:46 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7135.033; Fri, 19 Jan 2024 10:06:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: media: starfive: Match driver and yaml property names
Date: Fri, 19 Jan 2024 02:06:38 -0800
Message-Id: <20240119100639.84029-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::9) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0558:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4da847-879f-432b-58e4-08dc18d65853
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uY52Nz575HapAElcpacSYW2jAIIHBY2TjcmLj5RAZZxHLopLUHCRTGhvBh70ZdRNLI7W6ayY9EPDGphN7xCIsV3aHw52J53ounr+pmFwTmm3bV48jYR6GFwa4Rryawb9gz+6WeE+j8R/9WKwgT3SXjR/yFvEGZXyPAZnUFa3fCO2KZF8DMHv1H7ONjQvs04m7lDGA3sLYC9UXEDvdPGUAOnTq6MCYB+UfQJ5pNBe1ywW9N+v/fOL/RN0jVOO3+X04Ct7mOJsa+AzQbN1FhKcPaOeI2HehpJVaogenMoNz74nVazNctTzQaycTnGZZGJpRR6Hefv+9cq1yGSin8tY7TCAASebMF4Mcg8JCZqRlq8xKFpwjQWGi9RPA1mKgPkN+iYORxDzCRJX3DYuqyCquYTEmIBLlbxhxyOa+76LPtQ7TYPQ/R8WmpMAMXZIYA5x8AXVwKWYhYfwtx4hIzVFIhE9C3D42nTjYlEvZQxkua7LWSff3AT900EnImfZWkCq4bgF8UjYfi8npncLbUfXe9lBhq0DaPpcZ+96/fEAirC2YhGfJ88EVoByzio0VX3Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(8676002)(6666004)(966005)(8936002)(83380400001)(5660300002)(4326008)(508600001)(66946007)(66476007)(110136005)(66556008)(54906003)(2616005)(44832011)(26005)(1076003)(52116002)(38100700002)(41320700001)(40160700002)(2906002)(7416002)(41300700001)(36756003)(86362001)(40180700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXUbulth/UBr+b3lbp1N2ZIskiOlKvz93tKouXQeGw0+mjpxzmU1TmsiYWbj?=
 =?us-ascii?Q?VECYyfxkSwySnlabrDdE/dEkg8Cmy2hIqHpUTIe2P3lt+avYQmWhwYXj2uCi?=
 =?us-ascii?Q?i6ncZ0N6kmxXbYlBs3YFm94+FnO69h8BG5pgoR/rtRfijLrJGpJ5AUxOR1t2?=
 =?us-ascii?Q?eKDMrwQp1RiI0ru4Xdu2lE8qp7bJ3aBKFFCZWyJZGfKedKOq3sjxSRsdXHpP?=
 =?us-ascii?Q?O2Tix5fNSgZsC9ZNoBU91nufDHy1m6+mbVitSGWv5Y2r31KFkY4n3GoVe5JO?=
 =?us-ascii?Q?DSs7/j2geHzNWvgaStxOaH6zf9Kl6jOiE3tMRkJs5fTl1V03d02rSHSeix0i?=
 =?us-ascii?Q?HWE5jWrzRgfLdj1AR3SqD9Y1L9YyN1YlhqCLBsu//BL8Q4D+f87GV3i7wm2P?=
 =?us-ascii?Q?i3Spi55UoORtydibtYwy9Cn9jT8FVIkgAluBeRwegyqECbpQ2iI8cSB8bSto?=
 =?us-ascii?Q?JIWSeYOPBH5nbyHluTVObHYlSAB9stjAK7UGrpnOHLADQKzjEPzZh12QY1BT?=
 =?us-ascii?Q?+1O92XAzGdVSbGTbJrqVZwnghi6WkErH2eqBRGXxvP4bmvN/68B99Kg06eG1?=
 =?us-ascii?Q?w/y+9aYIRGJiYoCrf+lh7Q8kSQEhu09Y3H/gxqidWeww7EMdv0iC2mlasmjH?=
 =?us-ascii?Q?rU8cFe167UpBYxXMcj+sNNcHMoNxiuniuFZfQuZaJ/BrTuDnemJMYRaBtkDG?=
 =?us-ascii?Q?pn48h7oaaXYkUDeBMwaSNOJ7MGXjxrI9XeeBPB6EzlAjn6E9DLdhRJbtK66M?=
 =?us-ascii?Q?WgDOdvXsR/EseBypnXppYsshJ5BY09VLv+xIiE8kA4eSo8OWoEuHxb9nPhGv?=
 =?us-ascii?Q?IPDIPLEpQ94P5Dp6tu1TcZ7rAC3BcYxHq4lH/xgUgjJOKFsCwd0pAx6b2cpm?=
 =?us-ascii?Q?3LyET5Y6FdeVY18+ojSMDW9KtMsHElHlvI8FTrRKE/nmRmIx7yTRsOpSc2hY?=
 =?us-ascii?Q?+wSsxz4FnwV+L4bf4eC+tjRR40avSDPyw4LwB6fZIah38FMrNNJPTn2xGx9m?=
 =?us-ascii?Q?sbZVWME/VEbEDFcAjLZspEwIqvZ5x9XytFTr6H/cTvqStgMVHi8xlBhpa+zb?=
 =?us-ascii?Q?SKvoQxLioYqMSAoUfGR8MOqwZyzZ945o6cXE9dRH68d6hoYtGcP8338PEtUL?=
 =?us-ascii?Q?sTju4dU3HlcnyVDPXpUG68c+bG07mD8fM7VgRW0gIYuHU984TCIRXtLqWlXb?=
 =?us-ascii?Q?ayUfX+Zs3Ls0PvHwt5U+fzA9dvM14/0TvZapxinCrw7x1siGlQJGFUJSGtxX?=
 =?us-ascii?Q?GyzWmqPemKbjTZGh/MRi3lwiD1ChJwNyHxvQcmPSH7NNcYc30Elrrj2ESRtc?=
 =?us-ascii?Q?DdvGDNaBi9fijPZ1rQVTGqwSF5sdWxSWJkLy1ViGZ32tonLcIRSNHgMTad4Z?=
 =?us-ascii?Q?LmmWcd2RK+4T7t9z7EutUnAwJ0NQId1Gs8qD198k+tofefyTKbQgMcjkaXhu?=
 =?us-ascii?Q?08xWLE/R2Q5u7F8v4TSwlsKBsguFY+fY3eCnA70QXdQUu8k/pD9PdI89yWWg?=
 =?us-ascii?Q?CGBUDS4l+fKxEv+mcr3zFmMDByWGljMlfdEVMpRsdwm+tH4paXp/zHGdMtqE?=
 =?us-ascii?Q?byuo2k1s17oOizK9JOBhezg/dDp2J38dAFKIVnC3GeNaEjnOxfMbHByNxygT?=
 =?us-ascii?Q?kgv8uSSobfhtZ5XrFMJN/1E=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4da847-879f-432b-58e4-08dc18d65853
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:06:46.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFP+KU/PizCKzPAQ6mPl9zdMxB2ekaS+967ylR+R+rkimMTWBgGJ/hGtqOIU0w96MUUEVq4TE5EqOgD2HJU8ygcdq0FeTQBR3TqNM+/JR68R0IvjSjkAMfhPJqzgx68d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0558

Drop some unused properties for clocks, resets and interrupts for
StarFive JH7110 camera subsystem.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Jack Zhu <jack.zhu@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../bindings/media/starfive,jh7110-camss.yaml | 31 +++++--------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
index c66586d90fa2..2504381058b3 100644
--- a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Starfive SoC CAMSS ISP
+title: StarFive SoC CAMSS ISP
 
 maintainers:
   - Jack Zhu <jack.zhu@starfivetech.com>
   - Changhuang Liang <changhuang.liang@starfivetech.com>
 
 description:
-  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
+  The StarFive CAMSS ISP is a Camera interface for StarFive JH7110 SoC. It
   consists of a VIN controller (Video In Controller, a top-level control unit)
   and an ISP.
 
@@ -28,26 +28,21 @@ properties:
       - const: isp
 
   clocks:
-    maxItems: 7
+    maxItems: 3
 
   clock-names:
     items:
-      - const: apb_func
       - const: wrapper_clk_c
-      - const: dvp_inv
-      - const: axiwr
-      - const: mipi_rx0_pxl
       - const: ispcore_2x
       - const: isp_axi
 
   resets:
-    maxItems: 6
+    maxItems: 5
 
   reset-names:
     items:
       - const: wrapper_p
       - const: wrapper_c
-      - const: axird
       - const: axiwr
       - const: isp_top_n
       - const: isp_top_axi
@@ -57,7 +52,7 @@ properties:
       - description: JH7110 ISP Power Domain Switch Controller.
 
   interrupts:
-    maxItems: 4
+    maxItems: 3
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -125,34 +120,24 @@ examples:
         reg = <0x19840000 0x10000>,
               <0x19870000 0x30000>;
         reg-names = "syscon", "isp";
-        clocks = <&ispcrg 0>,
-                 <&ispcrg 13>,
-                 <&ispcrg 2>,
-                 <&ispcrg 12>,
-                 <&ispcrg 1>,
+        clocks = <&ispcrg 13>,
                  <&syscrg 51>,
                  <&syscrg 52>;
-        clock-names = "apb_func",
-                      "wrapper_clk_c",
-                      "dvp_inv",
-                      "axiwr",
-                      "mipi_rx0_pxl",
+        clock-names = "wrapper_clk_c",
                       "ispcore_2x",
                       "isp_axi";
         resets = <&ispcrg 0>,
                  <&ispcrg 1>,
-                 <&ispcrg 10>,
                  <&ispcrg 11>,
                  <&syscrg 41>,
                  <&syscrg 42>;
         reset-names = "wrapper_p",
                       "wrapper_c",
-                      "axird",
                       "axiwr",
                       "isp_top_n",
                       "isp_top_axi";
         power-domains = <&pwrc 5>;
-        interrupts = <92>, <87>, <88>, <90>;
+        interrupts = <92>, <87>, <90>;
 
         ports {
             #address-cells = <1>;
-- 
2.25.1


