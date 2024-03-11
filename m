Return-Path: <linux-kernel+bounces-98751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64DB877EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADE91F21658
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633413FBA0;
	Mon, 11 Mar 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s1G90KTj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2105.outbound.protection.outlook.com [40.107.94.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075163FB3F;
	Mon, 11 Mar 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155688; cv=fail; b=BFtOczp+HAe8TI9vIIibDetppQ+gUrZjTyxjvUunvql3GLkq9HuJ0Do+xWszy5sxOgo/2U2NTX/3v4tFPo4doYmyHdFmFsyOsj6S5wZ51BMCxQPlVDL4MBKy9aUQBBbBjjk47TiAQK2Rk647bFn9i7vqIJNCQB4T7VquFUAIBnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155688; c=relaxed/simple;
	bh=dk7zeckYvc3h1JTLbU/DSqpPs3kUnRmv8pB6RjaNkJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTttL6GBvfYtW7P29EwYV8wslDaRU8JzjfIo+pRDFYXozl1w3z1rgd6rNtTzuznDc4ahD5Q8px1sSEBeCzewkaWwg385xMHXpO5i214FHRKtxCVH99/LxQ/fGNCGKY9VwG8c2ery6vMQSxMBzjvx3qu+HtTDjojWaAnKnNtKfQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s1G90KTj; arc=fail smtp.client-ip=40.107.94.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNiiAd7EdFw+fCc8kUUVPejPtSbG1H0h8raJSwp7s+3l53qHM1PVj3HKzPxjONhHcWtmsl0xNNNyFJXrunwKMOYDbufS8jXbp+TxSMYi1UAEO0sO4qeMpbgCPRtj6rGUtIbHZhJl7IeAPKWHGYyGcSrL6djzfG8n6K7JyF0TvGNffKsasxP3KmIDn0RRRqRYf3YdAjpsANUDlecAb/80UqcozPoBf1TBfbUoj6oQ4bExOOZ9gJASOV7XcMfi4fU44H6Zhl5iqcQlykbgkrv5PAcg7KqIYEU4k7fjuvu+lGb+JlvvX3jtI0B4ZCTPaFdN/YLzoBp3hMlRDeqotYZk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGrsfpr8kddf+r3NIPH7kWJRZ4GtaZcqmvZ4cJ4kxBQ=;
 b=fFSEA3e7rur2dlvi4lGU7qHB4XWiOVl3rOMMhiXuf5LpMFFaLdEsqNzcJ0gPYoGa0tyortTmM/VlxIXSkDB0EmMYnQBDOUZWWFCff3J0eWfbyoYKbT6c66n4Gtz/nXbkeogrEI9zWROyoT68Lyz0shNlfOSOBmu8yYFGNw/PoOCEWinimhgRXiCuQVTodHKgLYLcjLxC2bCD596NgSQjkFNynPyKFwXLS5+ABWyf2XTw7YXQ9ViEnDBNn1v6fNoZleqoh3ySd5CqmkVo+cARFxYsGxWHdO29xyJpcapaAZqjdvhEcGW2hWpgjez4KWSIGmWzr9aRIB/+16wIXeFIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGrsfpr8kddf+r3NIPH7kWJRZ4GtaZcqmvZ4cJ4kxBQ=;
 b=s1G90KTjM5km68hxQ1eg6bj8Tu9a7HvRaL8A5XiK3EDz+C7DjR47tGgzIqXEeH7q/vgPkNHjamzRv/+nVRUwHBWumMkYB93po+LN2FSRdLnXPG2jkMyP2eoo6peRu9jERmgqqAJyww0KMvRz1tg6NP6YDHUsKhLu3T9AwO2uo8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 CO1PR01MB6741.prod.exchangelabs.com (2603:10b6:303:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:14:45 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 11:14:45 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 3/3] dt-bindings: hwmon: max31790: Add pwmout-pin-as-tach-input property
Date: Mon, 11 Mar 2024 18:13:47 +0700
Message-Id: <20240311111347.23067-4-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311111347.23067-1-chanh@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|CO1PR01MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eff549e-bd93-40c7-b8dd-08dc41bc749b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1VtqW6QcZ8pZgP/P4KwAYCoWZuuStw4BpanccSgkxGSKabyq3a1pKm/BynngWkjk+Hi93fFcA0b/JE/Kn0zdMZuBaNgHtl2lr1OPf5Xo87cTejY0Yc9yKdCyt8uIrmhQnNm/xOHtAxHknyd2abMLjQtaCfrMs1cbXsxUOfW9S6xbANowGxbuYmaCvSU50BomwE5/6MyyCmuPkg3qvyHIdq+YU5FZfwEN4KDP53kL9MjZlGJSjF4WZ4U7Sq1iZOqyQuCUnYVkuKGd1jD5KIo6b+o7gOFUvED9b6aLCcWirnVWoIGWQKldeEQNhS6zbLmTI+eFjy/+ufmLpUkDro/ffQ8oxyIN2Ocv4BhHozpOUWI9NArlzA/9jvw4sQKSbGQO+0c4K+h2n3J0LYWvMpZjZFr4hK1rRFBKImti1ZOC0NO8ExrZknAlp7pv5dtf0t8u14sAy/b6wKuii+szqhCZhN0dDuhbrHFN5JSPFjGZwPVIa4sJgCiK4mA7ND4u2g9VBvE8Wiw7UynP1Vv3yihK+qVCu9HI1g6V3x1A64xz8zEaxoApLAp2yyMF/TaC+KNBhITYNSCqEojKOVhElExETPcEf1H6+KKJlHvYJ/7vMa42A7qp1LCurWflkcLUNT7JYfIv2fpZpVdBUlKwzfQzs48aFBQmY0FXA+fgBiHwgvQPL7Hh+g7NM9OeKBPIqXQ0PZJllzBE1QknU5VsOHh3tpahpSSsgITEl8Tt334X7FI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szkRY/PzyCVt/sxKllyr9IdXc48kd25xDf+DfBF02XDb/wew5yjXpzanU/Oj?=
 =?us-ascii?Q?BsVtJELamI79dUhPKFBQX4dfVJghwe4PFVfA11GZRvFB6X/IH/zH6C0GERZ0?=
 =?us-ascii?Q?EE+uCTLS4H0uILFm2LZF6prmtUkoIQdDTwFRVmdc5L+8/YcZWcdGPX+NEPFh?=
 =?us-ascii?Q?B3lXxuf1FXb5Y/d5qPwCXruWdn3YwTYHN94vbuAyMhI3ABz6sI2s0JYsUMI1?=
 =?us-ascii?Q?zMUG8ISQBwYxSShKyGXhHpInuuQGFY402g98Ijsj4DpDJmyXco3Ff3iqWVDk?=
 =?us-ascii?Q?a1aKfBXFkKFHot2f1YLDvCS+6GrI9L3sEKmxTDzqGQdPxakvBcvfo4xy9j1N?=
 =?us-ascii?Q?H4afahhWrVY0+LRZPzzVGmhWwUia40RFTf7Ud1use9ndkqbkAyseLm/b5t7j?=
 =?us-ascii?Q?bsRlFtJszq/kjF6MiaVgPnk2RdqSGGJNv/aXqprnPHJJe7+PKFI1rntvnim4?=
 =?us-ascii?Q?JrV2hF3Pa58kSRIrH955A+NSHVeeHBRgUhM6lYxBo6FS0wJFCNyOM5k+t8ZZ?=
 =?us-ascii?Q?RCE0RsINhMwvXfdmM04gTCtgEuDd533MZtl6My4aCTZJD3eVI+G1bTYGxqqS?=
 =?us-ascii?Q?n/VYbih2K2MptwMVaGLFk07vN1jZDESG3+JEjq4BSUuuxvfDybVktcF4ZPpF?=
 =?us-ascii?Q?mg/nr+LE4s2RjeOO2d0Sbx3Uh0bjvTwwWGHr7jpjTImpr4hpzYP+k4H2d/lS?=
 =?us-ascii?Q?9ZhXtqB3CNSzNoTNSRwHib0sEs4YrFEZ0HgdVKnlF5KnFWAXQrFv/U5dWFKJ?=
 =?us-ascii?Q?iRPU/iDd89d+lduUYdXgB6s+r6Tl07gvHyIOBtsJhKkHV5ulV2G7ByEq5U25?=
 =?us-ascii?Q?390A7vT3+esFdPth0pQC+/4dz1BdTu0Ng2f/l794zQkx4x+KMD/xwA8491AB?=
 =?us-ascii?Q?Xjlz2qY5U/p5rPsC+qMejKGcxOa/07F8v9+AmPeBSxNCkMpZuByoZnglxseQ?=
 =?us-ascii?Q?cc5T3XNRE1OTKITAtFwctnA+EwgKf8NI1ygtgP1/wPMu05gpfsyINUwXcv1L?=
 =?us-ascii?Q?8t6iNM6wdy3QeMoE32azHZkjooTIWTcI37YvZueXgT/vrYIQUR5Kk3e62/+u?=
 =?us-ascii?Q?9bxZ3msSMe4le/PWlQDzaXdPCr3G3aAc924KUy4XR8N+I+9DMhAwCMb45Zui?=
 =?us-ascii?Q?eBuMqN7HtHDELMg/FEaFkJIfSMQk++NmsE979YB/r6GEcQgiWCiUW/AhJ2/Y?=
 =?us-ascii?Q?cjbxz10SfkYiA892aGhdlTxUJThIYtv9wvWEiGr4Ja/ihNghrqJV0Pvx3/VW?=
 =?us-ascii?Q?P/7mk4alwnmR4CKZn7oWQ/e6PsLIEROrSmGK23XhVIsQb0aVt5iw1m5Pdbpu?=
 =?us-ascii?Q?7iSWvrN1fRMdZGgPlpAmIkctTattNCeIZQW62s8loQ8UJ9hB52A9q+Dsn9bs?=
 =?us-ascii?Q?DfxyS/4WrcmmkIApM0ms2hXumIXnoKiJT/B/7dc1+xGxC+AlAS+45HY6R824?=
 =?us-ascii?Q?0VcRA6JQR9OcliPZhMxZn/VrwIzJZ1ZrTEcMkRa7oGMqHZ6lIwf36IqwwiyX?=
 =?us-ascii?Q?rVlZOBAZ79urhhuLCyRCkpVyoFZK9/UDNsExWxm7M2D8xdIhg30n/ibZy2Qm?=
 =?us-ascii?Q?lU9ok1ZsUC6CAny1rwq8U/Mx/CXeriPsQMbn4NYFtYM4sIq+k93AskH/syQ/?=
 =?us-ascii?Q?26BPEqQuhhznlp6dQ6LVrd0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eff549e-bd93-40c7-b8dd-08dc41bc749b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:14:45.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYtUISoU6MW80aIoC/mUyXqcW6rfV+YVxr14jzRUfJYenkzPMi8wp27Ns1QtJmWcrncF7FW8k0BMrIhAH5D+hD2D79XpkU65d8l941cNCJ8bF7jStXkBcaWoHV/AKIuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6741

Add pwmout-pin-as-tach-input property.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 Documentation/devicetree/bindings/hwmon/max31790.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
index 5a93e6bdebda..447cac17053a 100644
--- a/Documentation/devicetree/bindings/hwmon/max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
@@ -25,6 +25,16 @@ properties:
   reg:
     maxItems: 1
 
+  pwmout-pin-as-tach-input:
+    description: |
+      An array of six integers responds to six PWM channels for
+      configuring the pwm to tach mode.
+      When set to 0, the associated PWMOUT produces a PWM waveform for
+      control of fan speed. When set to 1, PWMOUT becomes a TACH input
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    maxItems: 6
+    minItems: 6
+
 required:
   - compatible
   - reg
@@ -40,5 +50,6 @@ examples:
       max31790@20 {
         compatible = "maxim,max31790";
         reg = <0x20>;
+        pwmout-pin-as-tach-input = /bits/ 8 <0 0 0 0 1 1>;
       };
     };
-- 
2.17.1


