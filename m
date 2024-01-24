Return-Path: <linux-kernel+bounces-37247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B083AD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15781C24672
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F97CF3A;
	Wed, 24 Jan 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTEFbzKU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65677C0A6;
	Wed, 24 Jan 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109954; cv=fail; b=quymFsTh/F3q5eDLXbCukprDsNakjZEG+3VI2Ud54wJNbYOS/nd23daeQ8MyHds7dJqp6Fv9K22KHUbhtQ4q4PNPZSdSPfI/UtpJvHxzKsgpBoJuGJ7gYot86HLWYWx7HCq3jDPGl1INAdHnChzor7j05Tfv2cMLtzoIdmAL520=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109954; c=relaxed/simple;
	bh=NqWfXzouQuD5pJi9v80L3T6A/gzQ0pETLZ1AH5q7uHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCGa1KT9VuKQasWB22vkENxg9gKh+M0ihydTCJTsSWsmxUqDrMPK3a5vhkXhLTOmOeRLrCL7Q8CsJ1Gt/C2eFKDmuai9HUGX/xVc9Cpv0IrZX3Vqi6xU868/rUbSIbZsZejmpTaP8rotekWoSO2tbQ0CMLbhOU6lfUj7tBMIgwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZTEFbzKU; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5lOg2FolcIEEKTXQQJtAmD9Re/w/S4f27KzPEnd9sIxygRrRDr/J/gPUKzfYbyQODCe1dAunHTTmWnqr/DEWmxraoLssXeASkRNUgG2ZrQ/FxiJD1LHfEsZQdxa5xavJaF45NSeCutQXC04XEEaqtlXieQNtVHruG6U3EMeF+cC9JfzSQDXvCBg2t6AMh4L0I/dULhdPi45dSOmjrZK8QGZI9bWhf1KYgvJclXhnbu50RQZKuES4QzrNhlMeB91Fper2YVzYHS+AIfi5w7d6C7SKtKMzoF5sNTiy3S1JITVehKfELjze9TZHeR/DAA75D/Iy5GfrM71rpFZvIaBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=ZXP2NndeMyy7HPl6OdZslPMvfX2ydLUKIi64CPnGKSoXqlubMJRi2iX6zrUbn50CD9oKRKATUp126BclJjlYt7aLsqIzH8UxZAafmHVJ4hubTcoB02Uz9aHKsSIjEneqL/Wu0j/O95tTce+BKWz3NjpH5a2JB/DayCOzsrnCdMNQ0Y5PILiMNGX0UMy0W1E1MQ40uI0Fw6XT2UWpaUeoZII/aYF2TMafkpHHmCk0Az6sIHySP/jd+SDVSgtI5ZAbkRvpwzwA0EKv3XEPiDLdOBZRLV41Ho8rhzkaeiI8Ov3D/tFQumYqbEat9Ji5x4xB1f928b16c6ugVkWwzfRx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=ZTEFbzKURNujy68Yi9iJvp6A+MfYqWT8a5RtB6dEQ1JhZNmJhqp2TLdS3Ycc0d102KStfuaG8TtWjswMes32fIzHLLrKKqe3+mPQtAjwhS+e30Uih00KrA7FZvVi/Xsw+tBeBpnh2/WnppJkxMCOZB8GG0NYT2YZqEzgMRNncEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:25:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 15:25:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com
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
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH v4 2/3] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
Date: Wed, 24 Jan 2024 10:25:24 -0500
Message-Id: <20240124152525.3910311-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124152525.3910311-1-Frank.Li@nxp.com>
References: <20240124152525.3910311-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 383ee606-6b83-44a8-a36f-08dc1cf0bdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6nuGzwLalJlvTsVHvBgEAlGS3wR8zSByTzErhHYa4LeLd0Q2EAp1G2E9qBBg9FK7ydPOTKPdXmm9OChosqiUbiHbyMPg7PR7PYoM/MzPDI11C++aGNBMDl21zsadDGIy9iljGpvJw+5wZDfqG4y2nNaFopQyGF5kiHVJEbF17qDeE9PGN+d4b6bwL/PCZwBNMROj6xGhlNEloh6/UY5d/QGk225Y7BXmZaPKPkNI5+yrL96fzhJgUE5X30lXmWvmphsDAeQthFmOVKj/i5M+tsspAADSKzpSMYCSh/08n9FvnzVZTN96d++J+cYypQAf6z5Os2ivmlzNu73IWnNpy+WTLCp7Be9EhGPCdJvUzmly83NhC4J7e3M6BLKAKtCkb2QWB2J9SJzQppwU50FmdilXGgQFT4Ki2xd+d4dNztjiiNGGpU3TRSpkRqYl1KqEkglFqJyZhIhrbDNOkhs28j1jpJlfJiJUbGFoz0anrZiEJDHJTJj1pXx8VbhmjK7ux1pShoQ0s51sQbPmdQl7tWA61cb3HCgDafqlNA0rwd/5wi1qMaY1EAfaCFLMa1r1IrMe5I6HDTj2SqNT5PKlc8xRzAlDnfyC6obl38un/hYYx24qAqzCrWUc4mWiztqxRWjpHt1vPyd+9wlwqGwC+uMBedNrT4u6BjM1XakGlLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(5660300002)(8936002)(66556008)(66946007)(316002)(66476007)(6916009)(2906002)(38350700005)(36756003)(86362001)(41300700001)(7416002)(38100700002)(52116002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ss7xsPAGANtFyHxi5Cah1AD5dRLCXRu1YLc0tOw5HTmVab0bblt9He1LcdIT?=
 =?us-ascii?Q?rKrO9Q7VuAn5WL1HRVk6IgqG/hDZQ2EGRKmY606CMHqu1NhjgWaZMduhGY89?=
 =?us-ascii?Q?Z8HPq6nTTJwrt0RYuFkcUwtRhn9VY+XDR8gV3ieYUfA/YQ3AcwvSmhdE9Igt?=
 =?us-ascii?Q?pBhtA8Ojg+xpnMEoopnxORPzjdzV5eSaDZF/scdshgdQj3xKuDIKmR4XNQAd?=
 =?us-ascii?Q?H28SCjn21IwhtxnsZdpmPkHTF11K+WQGWKcbnO/bQ8EFQ7tWN8Pe+/BIfx6v?=
 =?us-ascii?Q?0N+ZZHVV+T/X8cMhOBydZqqL1dj/uPnzOLZJTnfKHqQJlcSIWTFag/dVVNCg?=
 =?us-ascii?Q?vsKfWbOSctGbQqeXrDZn2u9mUP+rn1M4Re9UefVhXxSwVMb7VHW98BzqvKEW?=
 =?us-ascii?Q?b+cIPW7q7ObAVTSgWELd8y4iiS3fGBCYStrHVLvDz9umr9jdvDw591FrtoDw?=
 =?us-ascii?Q?iKnRmcXvB3dfMDSogJJKn0dpxnMRtkBbZi0ja/lrnzE0DuLBCcA8pqqFvRE2?=
 =?us-ascii?Q?2OUaw61VFNGBukuf2fbtQJ7gojSdKKo3D6ZEdZrVTG3VTJG/mLet/JjAFJPl?=
 =?us-ascii?Q?UTgDHOymzuGkMfp1SIRNXN7jJWRDQmSeJ7wVboZ/VNBsq3b3iej65MhPKupi?=
 =?us-ascii?Q?y+DXQbs21zw7Ha8HC4COJHCQUZmpFgC6psysl7na2wFynUvQRVny3vNGDMbm?=
 =?us-ascii?Q?Z7bOM0Ba/Ad5JhPIM/jpcayUWdJWHtFcSqx/o58vD3RxbIdN4PwI2SawAbYV?=
 =?us-ascii?Q?EHMuzVNQPkh0W/VTN/075H+Oo6Z/AHZouQT60ejrNAS0BXa3fhe4mfQWgzyy?=
 =?us-ascii?Q?dq08mehDSTEvAVAR3vB5Fq84wzpxhEvH2+FOFyiZg5dcoSvAATBCirxghR0u?=
 =?us-ascii?Q?cJNDzHf5iWhw9OD0a1Y4DUrsMiVXyD02/hTRtla8plON0qIuZrGgW+THxzNt?=
 =?us-ascii?Q?HpMxK7jdYrMG4T56iFD0Nwe0jnLDryCeab2kZCdGsccjfffU7cOkUrVSKMP7?=
 =?us-ascii?Q?/F4Eb2Sy2hDBZ+x+K6E8CgXOOlk4R8ECXtbAF3VO04rayQQoxqNIwERGGJ/5?=
 =?us-ascii?Q?bd1oUu5n2b7WU8v+Jjs97dSvFx80IrPod5wCtAt6azbGN1Aip7G6+Nezhabr?=
 =?us-ascii?Q?s9ctwwwVJXdrZzJG22QemvBHpuUIU3UwEhXLCrqSIryN/52b8OHv6UqYFWxN?=
 =?us-ascii?Q?pKGjEEX7mxTqdKvx6KpWzesbehd3GfiL59UkawwrEXglX6eqLyPJCNmSFDfy?=
 =?us-ascii?Q?eNAIksiBFkgQ1XQNJ99Y8TmLNWagRDHr/wMaQz/GJg0SmtkPQanOvkoMR2WD?=
 =?us-ascii?Q?ZLCSAAZlD0VLlyuVFpnCKCyxmwQezl4CEzmJfr0naAvhFmA77o7P2PlsAa6T?=
 =?us-ascii?Q?zyKhRH5aalJSeGiIrii4MeMR4lzpnfelLRroBiOMz18ZZCKlj/XESFwMvUKw?=
 =?us-ascii?Q?xdvZRBDAySKBgHd5FF5qgLk6HjCac4b8+xWp/jXGVdXC72rUPniriAq9UT4v?=
 =?us-ascii?Q?MnW+bvqOvN5uEVGmUou+iyOMLWrwceZkgRYab469eRAfROhM+V/8Gc4gbrRb?=
 =?us-ascii?Q?15bmTdClPH6MKLmCVnazpV10XF+2m1CoyLSrJbOS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ee606-6b83-44a8-a36f-08dc1cf0bdce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:25:48.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPds0q1iTZ7XAVWH79NK40UGrAeMU2FefCn2O453KxVBl3NLA6OBCeUUaz8gBioOu7nlCLrI70qKhopCl/EbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001

From: Ran Wang <ran.wang_1@nxp.com>

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will turn on immediately on related Root Hub
ports. Then the VBUS will be de-asserted for a little while during xhci
reset (conducted by xhci driver) for a little while and back to normal.

This VBUS glitch might cause some USB devices emuration fail if kernel
boot with them connected. One SW workaround which can fix this is to
program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
host mode in DWC3 driver(per signal measurement result, it will be too
late to do it in xhci-plat.c or xhci.c).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 203a1eb66691f..8f5d250070c78 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -273,6 +273,13 @@ properties:
       with an external supply.
     type: boolean
 
+  snps,host-vbus-glitches-quirk:
+    description:
+      When set, power off all Root Hub ports immediately after
+      setting host mode to avoid vbus (negative) glitch happen in later
+      xhci reset. And the vbus will back to 5V automatically when reset done.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.34.1


