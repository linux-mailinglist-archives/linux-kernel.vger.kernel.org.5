Return-Path: <linux-kernel+bounces-63102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C782852AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1500A28252C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD48182B3;
	Tue, 13 Feb 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sGTkDRcU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2052.outbound.protection.outlook.com [40.92.42.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3422F02;
	Tue, 13 Feb 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812565; cv=fail; b=jC9BQxmiKeAL9QkUYYy1EUizL/YVpauqqHDGpY+nThvkLQRh/Nq/OwOUIljWfr+hyLrBXINz7tRfNEjx1gUpTdROpoxL19cxlBYojugwEkoO9AZSVbLu5/plCJgFDB9pxnxXYeT5fUvH7yAZD1xM9FLX91xGLqmXenEwxRCFnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812565; c=relaxed/simple;
	bh=WFqeXNneRsNzrrKti1n7b62ShuPEORM6XjF0PEekPVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUTlmkRTf7OE80OY1SLs+vs24dfy6lHGQfk3lJ2ZGMip+xb4JfiLgKP1R9EyBRjO8lRmspgql2HjMqUAWpJqXgzVSqMv6GfQoL5b/L+YYoOYfjBiu/8F0m2LEiSjH6gtvcZiONoFqrs+69WQILerBbEMcGKcmzDEPep/o1F/UGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sGTkDRcU; arc=fail smtp.client-ip=40.92.42.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWKyS9p0hn/auePnGHT/2magocLL9Ivk30HCefuI7DQbys/4DfPf0kXXUC7ZSxKrPjK/NCyXh/Chm9j9LNk//DLXRyOAGE2cYW45hp+glEYCM2AkvKMbC5/OnOZJ8q18bsi6YoGA960LHGRXe6fRBicnLdEeAzsiExeGb3vkvTg0SVBqaeTgyIQ8xURHBdECy7rVbHuoCB5Gk298Kxfm1FR+fIIRSyOCqtAmPUI3Kf4DW2H8/aj+uOQ1AZgkbcaJaJE47ik8PlZ2UudDxYz5+6YyUqljQSfnVv7rY90xB1zg+XZGRpHjBLW6taN8Vd16VnJgt720NsLnQbWCDZtFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba6FFyAPx8QK1pdJ0ILtPfj2w4jgDiOlPi+/vb1AilE=;
 b=O4Cj0hQoKYS6SFhgRzw0TI9namSMqF45ZQh215Y8//tValM0Cuh3T64cUNNUk4ahUYp1HaGvonFkSK5CSsXSI++aaoS26IgU+sj74XrStF/TAXD+equBchsYsP6WzKONVNljhbaOC5BYRSRnpYHU55kPO36hjYmTekV+ajyY4aa9ekF5YsbD+eQScF6r8X+TaHNAAtsknCYM8+JgKkODSge6FAE/Ee+p5Sza0UhE8DxD2dKxZHGe6Z3kkXzXiQ5R4dF+RpDrFl+u0xwxXvB6qjqhzPTfNWGddpk2jmeEbVWMVWi1TVSuP827ljWpwnmpvEdzg5yyMx0B2VdGdNMx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba6FFyAPx8QK1pdJ0ILtPfj2w4jgDiOlPi+/vb1AilE=;
 b=sGTkDRcUGoQyzWOZS/P6HY65CZ5NSayClcr5cX9P/W6NoZR+nTtBG14Z2j+ikOKrSZ07XjZEV2IITiIoBrB47qTTRaaxIixJzIsL/WGk3AIJdC6yOPcmWT0bA2XZKjgyn/UJ+R91MIGkr1bjvWXzMxjFwGDCUYgf/SzWDtvTIibA/thyZHOzGuAHMVI2MXgj1UI5IDzU2tZaKFXGS4wUl9bmUheL5ZjmAhTNVdwrytaMIkL5ORz6ow8K/rKIfx1nY7LHoqB5n6VaKvLF/JA1c33ub8fAkSr/WsbOypjK3C2vzim/Ox/0aA1NLdRSaA6tXJYEOrOA6kegzTcGbQ+NAw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:22:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:22:41 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/8] dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
Date: Tue, 13 Feb 2024 16:22:33 +0800
Message-ID:
 <IA1PR20MB4953EB8372891EAABED7EF9DBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cvnftW3s6JgOaeghsdBHGaKHOOCULzuR80ipTX9+BppPlpSRhmExIsx/+z/CYVhc]
X-ClientProxiedBy: TY2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:404:a6::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082243.591875-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8ddabc-83df-4446-988c-08dc2c6cf26e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdjXCMNwuTy1CJKB6KEBO7PwZJpAT9e7D8pfoxZsqrVJzi972EGqDnIXQ2v02LDB3TxZR3upTzP21sBTFxuSs6+Jz8E1ZBEtMDvgTuIQJFJAFZYyh/6XU4ha4IJPgnhBdr3FiO2DYIKtcjyYSB7dniOdgcHo+t1xaVwDtjavzD3KJSVJrzOrL822TVhYrjb9JMMT5OKTXFuWmtwyuZc1objvosWzIOTeI8KtdGXeh6KMx+rEw1/qQfRqDiiwW6sc1Yg7Ub18IV7BpW3lWJlnf7kQfGNMeDaUTSXJUmjw2DE55ZNAgM+n/2yF8Tr5Iyfkcs+XleEq4FybVBmQhhERGONf1AxC3PHWc5VyWGhmK5HSWkfXHCXS2x0IQGmei+XQw+E0SC+shV4Zzol0NIqYx/LuNe3Ut8mng/HU7TpEdhsjmkWvqmduEn73VIXU/v0qBGGDIvywNCPSjm2IR9rniC0MqGGopry9m1owgqgvxzZjaO3LspcnwPP7RQS9GXb09lviISLhKNuAbAGSkfhlPx6WnOPl8DThzZieOKSWK7VUDZ5dRvfyrauyXqnfnnEIXm7PalGXP6t8K9OZIi2qjFk2NJGkS22YSQIW9CyWfDpl4vsAdzKUF/EfQrLoQPvPwde1cWmKKN1JTJpKs15/toe8DgYeGzCJusb4N/b4XXo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BnMvyy2p3m2aeVyx3LOlMUH4os67DlRxoTaGdua3tbR7eoRdkyM61jWKObGh?=
 =?us-ascii?Q?DJFZFxivylqSQVxeke+kIMlNLDq7n+GlZ0rUikPrp9JkjH++ETzZI/76sWJK?=
 =?us-ascii?Q?90lxeEA8wv49w1pjZ34ZfR6MupddoYcXyic7GLAofhkszPjYpZxgg2FnN6/c?=
 =?us-ascii?Q?58wyqWDGSSzrsMc2Tj2nZEKIAFkHI4i1oD4vq3ufy0070y+QUmKQil1MPzmf?=
 =?us-ascii?Q?bz/Q3aKF90uMMwn7IA077Irgt4rHIH8DajhG/84hvysO+e/b9OmtuD6436OE?=
 =?us-ascii?Q?ibGRmEzv0bWdmighlqsVqBWxC/hRSe8oOghyq1GfWz1y+OtvpAqjBrKAeTtz?=
 =?us-ascii?Q?9LD6eXKzbylRUsNouee1qdhHhgEhxIEj2OrKQtAonB/yyZPxyP85TuMLKgH0?=
 =?us-ascii?Q?oOZ0GrX00b81R0dmxa4Zx1Xgy3q3ceGhF+2OXg9kKsl89yP5B76GrTQAAfhp?=
 =?us-ascii?Q?eKE59UYiDXQ1CyeAVLVnH0lpRPkcLG7/fGnwqXrfEBau1Uf+Krn3H/JxsM2v?=
 =?us-ascii?Q?VKO9m57M5TT0BkZPfC/kP+jyS/9x7+8ytpHNihrBtR8bdBDuTdJeSgMn7ktZ?=
 =?us-ascii?Q?dFuKnrZwyz43dgWAnLgJo5KDlEj15uLmoUntCcKcbjbvhHHCL1mcQho6WtH7?=
 =?us-ascii?Q?rAKe5cT2ERjQuadFFf40Dt82SXt3SzxdaFZsoi2Zc4XRQxAr85RNm08Yn6GZ?=
 =?us-ascii?Q?nxN9MP4zKEGD8HawmjpZuB6AZqIPuxN1Csc2Ggvl6SruNzaXTdiQ6AaHRWLi?=
 =?us-ascii?Q?x/mR/qNDpZKqv3ekz56BWkUeBucR1g5CBlcEK60kehGXiavllWx+YrGUBww8?=
 =?us-ascii?Q?D2azCir1OlyOr8td6GakrLtT6CbQCvv/y6sTwWxbKcRx5pVJkb37RzZLyhQw?=
 =?us-ascii?Q?vSG359qw/i/1AizDtBOa6W2MHF5vo0nhr3MJb9260qAVsuEyVsmHy9jPkn4n?=
 =?us-ascii?Q?Y4m/0bOzFainAZ0mN4OvvjNhReq47i9wUigvUoGiwze2NbJj2NPH7MAOAxTW?=
 =?us-ascii?Q?mqXgNNpx+ZLI5pDcr2Gkhryt9Oy2kLF/+XEQ3DXhz2HmAmi6nFNyGyh8PHQE?=
 =?us-ascii?Q?uxGthURiB9vpEaaVW2DQcYYqmbGswrfdXkc9cIKBbvUjk3W2WsYSco85Rdj3?=
 =?us-ascii?Q?gid66i8PHXxc3VBbv4GUWOL6NCy9gNnwGstvrCo17QCy2YFUxBAUsCPZ8eLg?=
 =?us-ascii?Q?FlQbwPEIIzrH8e2+xtvcHrNMwuXvmLTRsSaE/zDrQrpEXV1vyg5eb3wZahcN?=
 =?us-ascii?Q?FmexnInqrGewHRELKFb1lfxAMRZFSLtA8FhL53R5l+B1Gu644NKsWTV7+7Sf?=
 =?us-ascii?Q?3N8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8ddabc-83df-4446-988c-08dc2c6cf26e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:22:41.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

SG2000 series SoC has the same clock as CV1810 series, but the clock
related to A53 is functional in SG2000 series. So a new compatible
string is needed for the new SoC.

Add definition for the clock controller of the SG2000 series SoC.

Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
index c1dc24673c0d..59ef41adb539 100644
--- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#

-title: Sophgo CV1800 Series Clock Controller
+title: Sophgo CV1800/SG2000 Series Clock Controller

 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
@@ -14,6 +14,7 @@ properties:
     enum:
       - sophgo,cv1800-clk
       - sophgo,cv1810-clk
+      - sophgo,sg2000-clk

   reg:
     maxItems: 1
--
2.43.1


