Return-Path: <linux-kernel+bounces-144465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5328A46B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08717B2250A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C9125C1;
	Mon, 15 Apr 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8UFUxLq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015517736;
	Mon, 15 Apr 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146605; cv=fail; b=Vmm2LXu0tHRzinnFSuiOlYmLy2hQj/9B0MghcoudvSSXu3btAsoNWXfTL3YlZpzNkVNiM8VY76jjw4NeKMVhQ+n2/RP6RMN5q2LKlAV6UKpoyeIYq1xasYikOJi8AhoG2iNmL87CQ3urfKze0avyNSrhpYebQUMxzQXxO6LSoOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146605; c=relaxed/simple;
	bh=iOJP5acItSLMrD1lOviofzbdtqxN2ucOHYLWKv4I12U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a/QHcnBS3nT9y8aQhur/JAyMpCr3LNs5sxhbZp9SHNIXLp6UOQk/IV+SG0ycvP3ogNWRtVhVprxT9rE2G+NutpJY7oJSF4lW+I59fHo20o0sulF8ZQolcvxhMc19iIa+mw4P5nWt/uYPlMJkTax/u0jODDch5XHJD+lpZENXZJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8UFUxLq; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fappIUpI8X4jQEgg8s5yBHy6zAOjOuk7j+k64zrdgZ3NarWMOy7Tro0AG3tjrqsZMY9R6iwO4/jk2q/x2aOauquI175kCpCD3ShuLuvRIVWD692JhQnUnlOi1T78rU+wW93wnrg1WhYBBuk2GdzzKkRn5R2uTBqIzUmR3bDxWOP/9sluMT0pQQIYlaOhP1cdiVSoyUZv742DcasL9519Gu1F+uKMebtec8LsNehwx0gl2X6x6HJ0iyE5j1jJ6AUtPYWJfAQuNrxjaxERrwRNm4yQGtJuk36ytM5UwmPW1N3HnB2s7Jpu9nhElM2O4AJ2JlJJz6/yykuJhvY0oQRugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AC9rRb45bI9McUjccAWwlf3JW1sBVKpMmgHqdwdE8o=;
 b=h16H6KPJ2Te/ot6LX0YzriEt2dBLbnExWSSpRNEc4VoVwSERHkBgTCPS3Yi505rmvU3v7Xdfq4xtQZUMy3MWR1P6I0FvZIqmo4Rd2OoKUUZQTVNRUtWJz4ctgko78McfBeTsddQSbDLKNIiVrz3Ptrxx353dQyTAdU2PWj4I07w+hCPiNi2rDdFbty/rHSzL9lJXvaW+FsKIaSr4fh3BHiuRCS8VH0IKttV1o0P+wJB2vmdG+mwy4oIX2pA1aC5pEWcT0QJJXinj7hVudgTCgIMvsJYmg8n3fiivk4DtPof8mZZb5zXr7p4fylqbvsVPn4RSoWnyZEux/nyH08R91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AC9rRb45bI9McUjccAWwlf3JW1sBVKpMmgHqdwdE8o=;
 b=f8UFUxLqln4W4KZSSW8VHCzkYShUgfgSPiZ4lQWHudHUi0y1f/67nIOSLH9iJmIax6toPA0ZVsepS/t+u9p8zImh3vKCL7zSe0g++T4mpg3EB3hEkOPmKRDnWPuqPA68E7+QetTZaG7e50iA//I04hSV5IuTSTJ3Fku53g5U9bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:20 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:20 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Mon, 15 Apr 2024 10:03:46 +0800
Message-Id: <20240415020353.3833367-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6ecf4b-72af-479a-d165-08dc5cf03904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tOjPbg2hIeyYEGi2JtDgEvk6qP8JVWvPn1d1U/cLc3moIoQeU/L+3waH+b+bdxsfx1vl97oUwC/C0FO3+U8GyRLHspmKae4msUZv2aZNsu6Y/IF6zkYWAhDZ0UHeqIbR8hurk7DVk8LeDmKLf+YnvF468FlI9Z+c4Wa9wzBhBC1G9zhw0AMc3QA2qT4xZmn8zAxHXqEn+XnsMHfU0ORg85z4FpqGKzsA9XBE1RFr7+EU2CRJ1RxsBWYPm/c4BM1Px66CsFaccjsW7gT4Tof+Uopp58A/c3rO9dJTYnGughBZA7f1sGT5EMlW0LmVTl8RgXNxQoujhxIymqXDFUQCagb3S9StycxNR21rcG5ea7LEnQzsxZEKAiMLcOTTRtda0CFfueblTEuxaRIyta9mvnwl1VKi++rEULnv/BXJ5hXvKu25YcYwyqPvXabK5pROhGZinNo6r5Tt9xM9Kxv1YGXXl98y+z5jrm0VNbIhYqsVH30Ew1LYuCPoa3GF20wxt96xZisxsWUNFANJSrzB6T4QfjQNOyM8OYuxOC9tXECX8XdJCX2PoVwfX0oAsB06BL3tCnCko/BYygzDqjOgMBRVJNAyfQhEU7DYQepINfg6E8pmnd4f2Xst29p7EAHJF81/M2kCbrT1DUmm/aTGgqd4f1o4yF/5T1bIuTgktwSOMGrg0fFZ8JCfK8P9sB1o30CyMJtFrUel/oCxk3QkN+2CldE6wEya3qUWkghX1kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pjqa5cVTafIUwrRq8/yjHbuI5lj15elS8bCoBzP/hpPt7RSGjy+y6ZpRQHQW?=
 =?us-ascii?Q?IpV0GOJkwoF31qQ0Zd7vACeOR82uq3jfLVOZ04GDwdGVLEM39dVQTJCtsYFS?=
 =?us-ascii?Q?faGMD/68AKo2KcmnnnINFmla5GVz6dCMlV/F56jCKanWKW2HH4Pvf9R4HB4a?=
 =?us-ascii?Q?U/9mvPl42ZKgqspZbOd1pVsOCpMLefCN0YNZKsWV7MBI4kI0s3n0ElKEEfs6?=
 =?us-ascii?Q?2QXt8bL6Uxcxs93xMbkNQt1FDTJdvG6t4fwTzB8FhEY4NWqlxXHWd58kJcUL?=
 =?us-ascii?Q?QfmXfUW5YGg0ohxM6O2k2SqpvX+TGMXj0lWlINHWLowXDPwR5XhoiGmFbvb0?=
 =?us-ascii?Q?MwJcdkG8WRIcbF0lOKOPBMJLyLNVUYQt8QhB/HkuLbQ7I6HtWFwVNW0FWLGQ?=
 =?us-ascii?Q?rOSA8abZizohK3LIfhEHvj0B1tAyGoFoxnc2xxxqPER41slmblg4L1DAtmkE?=
 =?us-ascii?Q?+8J9xbBf0uf9hicqBrkgnPGHgq2KndvmjhHYRn/T5SXJ/fWzPRI6cZPkGHjw?=
 =?us-ascii?Q?Qeg+9XJvhfL7ldeFCiDdQ/geiJYlUdfJVioR3tEfaEsK8IFRkfzC0KHdGdsE?=
 =?us-ascii?Q?hRFhsRuE6diX1cxvDwORLyhUI/5UvFGZoCaS/wTX7gPUfdvIq0U6275jpkit?=
 =?us-ascii?Q?q3jbO/yHciJZoAiUZ4Jop6XazGoJebDom9jjHKw6rRFicqubBnkQmnb8Gts2?=
 =?us-ascii?Q?QJwa+UBqfgSTuSjVftPQeV6EENTUlsAN5V7PW+175mELotGEo01wQj4ExbFz?=
 =?us-ascii?Q?Tq9UE6pXZtgdrDlcgh2aUpTlherUrv8oEAzsreP77yZ8k0xlqeXRDwNf4y93?=
 =?us-ascii?Q?SQr6+CB+B9km4s+LB5PfXiWpLTvtYhA5KjvAf5y80L6HJte9RLQGmoYbJGsk?=
 =?us-ascii?Q?dZDoAdvOL8v5D3fhlz1DRvrit/wyiB1YGH6VYtHSwUdRITJa17ePoQk4r+bA?=
 =?us-ascii?Q?i4rdZkIQtYRtIOBytkWPEnQQDcQekvLV/owLkIYxb4VgkWuflCbwLnbaKkvH?=
 =?us-ascii?Q?CV9hlkEfy/voT92K0kmgnS1+coNtQkQAFpGaeKb8jA2Cx6o2u/4dOwT+yZDL?=
 =?us-ascii?Q?YAzaKeBHjS3kuepl1A4SaKLXyI6P3Ld2Kg6wEpZRjQaMgMnuGeHGz/0Xxo+a?=
 =?us-ascii?Q?IdWLKQy8mKwiIU7cY/Ph5N6AcLvDHiZ0VASaVj7kNDG85IM7/tS5L4fQ7zxK?=
 =?us-ascii?Q?9IOV+ua7TzYkZymJiy4dOh0Hif/Jdvi7y5yW97IZcQzftzTdknzba0Pk2i+H?=
 =?us-ascii?Q?OngyLOjos/k924ZobcKbHwbXV/WfJdZ28XAACmlSo8O5r6dDMLinTa+6mpK7?=
 =?us-ascii?Q?AABMKneFqSztLl+Ro8FhPdFdLrwIoSxb8nWizJkAYZENmi81kTFvlR5AK1f2?=
 =?us-ascii?Q?9BgZSdvySSHFbxTY43b9/pusEtkEDCJCq7CN9dF5Q5ILW/Q1cTpltaJhurzm?=
 =?us-ascii?Q?5aPv2yLkTD5qyK5xB5TbqDJeHMXi4rjhHWQRojsNmj2LyGirQ+AM0ewN191M?=
 =?us-ascii?Q?/rhrG5vnhqDjBqOOEnMqWWJ3izWqV4TwcMfYGfQ64JubR7Z/nbGyd8MRgJfY?=
 =?us-ascii?Q?BsDjvwuXRfYuA5C8qi+W4J9uIjZzDHgqnHVxsxMn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ecf4b-72af-479a-d165-08dc5cf03904
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:20.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUmsIUWyiyZiMObTn18r9OR+ApU9BafyvjC0zOKrXMUKTBeTyXFPyhIIZ+MNgT6x5ukazX/2NmF+h/e42/b9Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

i.MX95 has a DDR pmu. This will add a compatible for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
Changes in v4:
 - add Acked-by tag
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 6c96a4204e5d..37e8b98f2cdc 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -30,6 +30,9 @@ properties:
       - items:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
+      - items:
+          - const: fsl,imx95-ddr-pmu
+          - const: fsl,imx93-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.34.1


