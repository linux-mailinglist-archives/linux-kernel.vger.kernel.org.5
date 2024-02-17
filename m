Return-Path: <linux-kernel+bounces-69868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CA858FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D05D1F22797
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF77A73E;
	Sat, 17 Feb 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="A0bqeoZl"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2064.outbound.protection.outlook.com [40.107.113.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8F65BCA;
	Sat, 17 Feb 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175672; cv=fail; b=KIdVmdkeHHasSzRA8aygmweAx2/hwN/9cwAmK9+vA0CZ2MrMVmj8ef9mB+q5wkcqhS2G/GB242/ZKzYT1OMKY1XnfkWTWB996eosBHJ5gkS2iLj7gB+celCQPZv3sI7m5cLdrYhToIvwZ2wcktj76BRSC0omyXo6enEIpK2KqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175672; c=relaxed/simple;
	bh=juTATYbB79wKGg+yfedvWvcFR7M8/40RnEDQL0NWIYg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Kqd7gZh5wcOjj8Eo9UoIn1L9pfYMqG+GZ+/P+e6lOOcX+LyBt07IDhSGFFIT0rbT+i9oNBodETa/EU6RHZLtOB7iND53ljK1KT7SGFIS4z20SNwwPOohONysJJ+ZjgNcyCsu0HUx8U6Phw80K21aiSeaNQzMJSo8fx1MkdK2nbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=A0bqeoZl; arc=fail smtp.client-ip=40.107.113.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsqq65J7DfL9UXxZSyHFQuCPd8aTGAxsO8aOSuhAZezpBEFwV1UWu5RBpOyR/1WkgjxJQoO88IXAdykbU/LcagsXYvuq08Slf899QQ/gmiX9FCglr4LgFbnExj5j2FIRtsTxlE80Zq+tKZunaAUDzv+RZjdDqTIQ4+vQtNJ1Izkx0VpOjewaB5QeoftbZJwiBG2U+0K5b0Xbs/5WfXajPi1wzSm5rDJirbj9d0aXf2mCzJnG24YsY9R5Ix3ANb5XoPo/RbuO4E81JA2cmggEd4Y+mn/hb4a8qyycTYE9LbxmOIuGzR99kxAEDDP4PHNJwtVZvzvytNWjtBiCg6a9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgzce56w6w/LW3dhksydwCVzU3bIOhpmE/ESINnt8JA=;
 b=iLC8y1RQb85cwsMidbO8IbxKnHDLE/bxi1BbzHK5IXsYKqLioHTrSTiKrEGaMxgUrfOv62OvOEIk+19K7z8iGgAShy45/5oQbQPhd44N+P+fDiz6ZG05k6ye5aYUh3+GxOPRqC6FiPXxWvaOnIxsv6TCFAkA3UT5yyC/RaYGTuWhBokabTOrgorgcMSs8xwNwK/CPsOICK4ByYy1Y7q5GvQ9cijL2SHCwGqSXtSnR+koizCFyld5SkklGtr1dg7TSuKllwCXdK/lTGfpTJb0PqxnPv3U2p3BnvW984C9/xRQFmhCrw/i/1/IWdSpEW/ZGLUEFvJgDqrMxPDRP2HSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgzce56w6w/LW3dhksydwCVzU3bIOhpmE/ESINnt8JA=;
 b=A0bqeoZlsXA3IZJZashENO5qGMpHrvGHN9be//Y+0ABDgORMdWuTMUOWQ9lDUSfZXe6ccELR1yoI+Ak7DlC5J474laYMQ3EITpSjl+J1Fga5RY3zlIl5X7C+f8uzsPqnv09Q8Ja83QmlM0PxVzSywDQ3JUeHCZm8VYBhEgvKYCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB4323.jpnprd01.prod.outlook.com (2603:1096:604:37::10)
 by OSZPR01MB8372.jpnprd01.prod.outlook.com (2603:1096:604:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 13:14:25 +0000
Received: from OSAPR01MB4323.jpnprd01.prod.outlook.com
 ([fe80::46db:654a:ea70:d399]) by OSAPR01MB4323.jpnprd01.prod.outlook.com
 ([fe80::46db:654a:ea70:d399%6]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 13:14:25 +0000
From: Steven Niu <steven.niu.uj@renesas.com>
To: alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: zbigniew.lukwinski@linux.intel.com,
	Steven Niu <steven.niu.uj@renesas.com>
Subject: [PATCH 1/2] dt-bindings: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB
Date: Sat, 17 Feb 2024 21:14:11 +0800
Message-Id: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::18) To OSAPR01MB4323.jpnprd01.prod.outlook.com
 (2603:1096:604:37::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB4323:EE_|OSZPR01MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef73c4d-7ad3-4ae8-1e01-08dc2fba5d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n9T77FBpiPkAiTLvvRs487Kn6kvpzkzMD4PeZxfsZKCJewEy+6ZPobIO887T2VtLobJAtX/4WyuBHxbdkc6fH/QeNIovOykDfyelm+3ZtMXV0F1wypgHTEJ9DmyVaCxzDwhm7sPxthBPSQqzvMPhhnMMJIqzcn7Xqpw1U8O6rnooVUnYqPCX1MWXbXqV+eGRj8dEbD7rAZ+7YhCGWF5mnheifPIrP1pemFwQOp/TrSP+2AN+JDxcSJl0HubVgYgYUff//0yW6Bu9QitTUez7LGQauB3FaH/flSJ8W5N8R0gLPx9azglTAXnbnVmeFnn/ZBd2k8Ux2LHLNfeQbkpw0tFj7JOhGIbl3QIOcRsdagGSCs0ZXCKZYW7G2awX9b6Fr2+FpGEc++/dNPtuZLzRTxoaVipu1A8gQ36no3rDv1lZhQRsyf+OYaoWk3o3xZQ1+93Fsy0p7CFWbRDH9Gd2HaZkSvMQDTzw0ZMvBx8zHX0ji8DQfGxk29hgXnaYzBUcx3QH3j7MLqP4Ksy9t9JMmAOs/B6x5IOrD5+zCmvQAbFjuBCW7qQ2PPLaK2zwIj7w9niHqaGRQOcKb4egBx6ftdkHFJjGCTEsCSc56livrQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4323.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(103116003)(36756003)(86362001)(38100700002)(38350700005)(6666004)(83380400001)(2906002)(8936002)(4326008)(66946007)(66556008)(8676002)(66476007)(30864003)(5660300002)(966005)(6506007)(6512007)(6486002)(316002)(478600001)(52116002)(41300700001)(26005)(107886003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCfD7WNvTMKzny5qmSoj6mk2+IZdyY842A+c8/K/YQVrQCNHyJaht0QElq9C?=
 =?us-ascii?Q?wUkDI3aTcYfL1c8alVNiESMXnKKpiSsfeeWJ3ij2cOXFMyh72SRWF4KFOAwK?=
 =?us-ascii?Q?aZRusXAxVZFlcCwxGdeoOkhx1AGvC3qdtejE82v2TwyuliadWPTHoicQ17d8?=
 =?us-ascii?Q?Lz4Ea6r6Ch8WuPT/o9YFBY9v+Ps4oxChByIk0KyywJNjEkVVGQA1iZBkDIr2?=
 =?us-ascii?Q?+CKIC452iNuULgCqNrmVzCTKE7hVoLWkZDzgsA1GyTlw77qDD91GXybjGpra?=
 =?us-ascii?Q?v8m2tShz5I4WKl1hRHrrb/TvrJ4CBE5Rc3fOWb7Rx3vrYL4XoyzninR0M3xg?=
 =?us-ascii?Q?6rdoc+a1t5lPTASoUjIrD5fuvDcCQ2iyA/mCqy/G4YB8VeCQbPBvQieC4zeX?=
 =?us-ascii?Q?hg8W6NOGffe3o0Ty+As8OdZE8AKjpGTJ/x7mkwzNM7ye57ZlzBtDe8lCSZ60?=
 =?us-ascii?Q?tWVVkjA5ES4MXQdvffpjwA+SuNR62+v8byELDkpo6x0eBiSMZ9/FaZTyFrPx?=
 =?us-ascii?Q?ZMIQR4UzQWe+PiNVpkui5p5ARqaxQusOauwpiQYQdQgGKSp6rETQaCMyB8OS?=
 =?us-ascii?Q?DG+JnuOhGHDfyRjc8b5vUNOx6OEgWk5g4xTDD0xnICcvm5TAw6tqjHNtjfcr?=
 =?us-ascii?Q?XXdNvsIUYn0kUZ2HbpxlpssSLXp474fJHZ14xLsPEV6lNTkUDxRzkiB4/1qb?=
 =?us-ascii?Q?Jap1sF5Cx9wjBWlnsDxFjfv+yZUCNtXjDM+vmpVNHnikOAdG+5vU9Or/RBlu?=
 =?us-ascii?Q?tudCH0BJxuRe+Ute5BzlHFal7F9uFywOcImrdWKn8UHxd4b8sukyFkezZd8A?=
 =?us-ascii?Q?wbsXInnCxUnt8EKWmS/bASYJ3Bo3dCmmHGOaEOcdZ848LOg0NMirB4RAytVP?=
 =?us-ascii?Q?ZZ8oh1U/40rH3r7qik7G2K0K4N/sVnzGP0NaunpRUYKoxWwu3QV0eeQUke4O?=
 =?us-ascii?Q?cc6NbGPMwfMqmiDySzhkAyu8godSRcxH8LTeccAVnHR74vkBLxo64OHR3Ce4?=
 =?us-ascii?Q?5VV0Qh6P+kJjHm3ivTb2YUKiNLrY0/MwR6zKcsGAsjer9GWuMsl0Jm+67k2Q?=
 =?us-ascii?Q?tmlkBM9d3Gk8s0fSiHdADxQR/nzSsg3ej9S4p+kJteddKS0bhdYKATzrpEHV?=
 =?us-ascii?Q?1nVDSfQ/vo7eopVU8KgoI0nfJ+EvG8TidzCtJALvhMUAXrdp0YYeYk2axWUN?=
 =?us-ascii?Q?UuWbk6Zawma6+tjnkSef59jHMtOurikdSL+yV+lfCVMuB7Y1W2FSVWJSsIBb?=
 =?us-ascii?Q?r9ToHCd7PcAfo8TDJi0jnqnF47XGVLWhhf1bGRJw8diw6yG8sNO57AdUGPpM?=
 =?us-ascii?Q?xY2SSiwkdEDbWBzoqkJG9F8nNZ0KNAD+r06Hl9ZUufFUcvsqS7qI7bdy04+q?=
 =?us-ascii?Q?cS0ytu46ClkO1E5PG50EZdL6jlOw+8tboAW7tWxVTEb0R8nnWR2asHajZ023?=
 =?us-ascii?Q?RNCZirvnEfWqqVifUSUrJdRp9nGlJVAmee7p0KtaW0FPaHqs42JM+Wjy3Hxx?=
 =?us-ascii?Q?vDoRs9g+0eWqxG5uXXc6j32uJV/z9kV8sZWItQm9/FigfsGRtjqFfWFaTOVu?=
 =?us-ascii?Q?8oewsCZ6v5k9MbQ64hHGQhvxMgZNS/0TvqEUBfzYjfaFcw9/D4uIVjzZyOTH?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef73c4d-7ad3-4ae8-1e01-08dc2fba5d3a
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4323.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 13:14:25.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSDAvyAVNcSNgCzB5BbNhtIyvXJNBSAFN3pBkLRiQFtoJ/LTS/FYmo9uxTZ040Znmsrc2lmyT9FLELR9VApSJ8YT5O5oISWSGi03gRMHQF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8372

Document the Renesas RG3MxxB12A1 I3C HUB.

Signed-off-by: Steven Niu <steven.niu.uj@renesas.com>
---
 .../devicetree/bindings/i3c/i3c-hub.yaml      | 400 ++++++++++++++++++
 1 file changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c-hub.yaml

diff --git a/Documentation/devicetree/bindings/i3c/i3c-hub.yaml b/Documentation/devicetree/bindings/i3c/i3c-hub.yaml
new file mode 100644
index 000000000000..8ff6ca172975
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/i3c-hub.yaml
@@ -0,0 +1,400 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/i3c-hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I3C HUB
+
+maintainers:
+  - Zbigniew Lukwinski <zbigniew.lukwinski@linux.intel.com>
+  - Steven Niu <steven.niu.uj@renesas.com>
+
+description: |
+  I3C HUB is smart device which provides multiple functionality:
+  * enabling voltage compatibility across I3C Controller and Target devices,
+  * bus capacitance isolation
+  * address conflict isolation
+  * I3C port expansion
+  * two controllers in a single I3C bus
+  * I3C and SMBus device compatibility
+  * GPIO expansion
+
+  Having such big number of features, there is a need to have some DT knobs to tell the I3C HUB
+  driver which features shall be enabled and how they shall be configured. I3C HUB driver read,
+  validate DT knobs and set corresponding registers with the right way to satisfy user requests from
+  DT.
+
+  All the DT properties for I3C HUB are located under dedicated (for I3C HUB) DT entry. I3C HUB DT
+  entry structure is aligned with regular I3C device DT entry described in i3c.yaml.
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  $nodename:
+    pattern: "^hub@0,0$"
+
+  cp0-ldo-en:
+    enum:
+      - disabled
+      - enabled
+    description: |
+      I3C HUB Controller Port 0 LDO disabling/enabling setting. If enabled, voltage produced by
+      on-die LDO will be available externally on dedicated pin. This option could be used to supply
+      external pull-up resistors or for any other purpose which does not cross LDO capabilities.
+
+      This property is optional. If not provided, LDO will be disabled.
+
+  cp1-ldo-en:
+    enum:
+      - disabled
+      - enabled
+    description: |
+      I3C HUB Controller Port 1 LDO disabling/enabling setting. If enabled, voltage produced by
+      on-die LDO will be available externally on dedicated pin. This option could be used to supply
+      external pull-up resistors or for any other purpose which does not cross LDO capabilities.
+
+      This property is optional. If not provided, LDO will be disabled.
+
+  tp0145-ldo-en:
+    enum:
+      - disabled
+      - enabled
+    description: |
+      I3C HUB Target Ports 0/1/4/5 LDO disabling/enabling setting. If enabled, voltage produced by
+      on-die LDO will be available externally on dedicated pin. This option could be used to supply
+      external pull-up resistors or for any other purpose which does not cross LDO capabilities.
+
+      This property is optional. If not provided, LDO will be disabled.
+
+  tp2367-ldo-en:
+    enum:
+      - disabled
+      - enabled
+    description: |
+      I3C HUB Target Ports 2/3/6/7 LDO disabling/enabling setting. If enabled, voltage produced by
+      on-die LDO will be available externally on dedicated pin. This option could be used to supply
+      external pull-up resistors or for any other purpose which does not cross LDO capabilities.
+
+      This property is optional. If not provided, LDO will be disabled.
+
+  cp0-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+    description: |
+      I3C HUB Controller Port 0 LDO setting to control the Controller Port 1 voltage level. This
+      property is optional.
+
+      If not provided, LDO configuration is not modified in I3C HUB.
+
+  cp1-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+    description: |
+      I3C HUB Controller Port 1 LDO setting to control the Controller Port 1 voltage level. This
+      property is optional.
+
+      If not provided, LDO configuration is not modified in I3C HUB.
+
+  tp0145-ldo-volt:
+    enum:
+      - disabled
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+    description: |
+      I3C HUB Target Ports 0/1/4/5 LDO setting to control the Target Ports 0/1/4/5 voltage level.
+
+      If not provided, LDO configuration is not modified in I3C HUB.
+
+  tp2367-ldo-volt:
+    enum:
+      - disabled
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+    description: |
+      I3C HUB Target Ports 2/3/6/7 LDO setting to control the Target Ports 2/3/6/7 voltage level.
+
+      If not provided, LDO configuration is not modified in I3C HUB.
+
+  tp0145-pullup:
+    enum:
+      - disabled
+      - 250R
+      - 500R
+      - 1k
+      - 2k
+    description: |
+      I3C HUB Target Ports 0/1/4/5 pull-up setting to control the Target Ports 0/1/4/5 pull-up
+      resistance level.
+
+      This property is optional. If not provided, pull-up configuration is not modified in I3C HUB.
+
+  tp2367-pullup:
+    enum:
+      - disabled
+      - 250R
+      - 500R
+      - 1k
+      - 2k
+    description: |
+      I3C HUB Target Ports 2/3/6/7 pull-up setting to control the Target Ports 2/3/6/7 pull-up
+      resistance level.
+
+      This property is optional. If not provided, pull-up configuration is not modified in I3C HUB.
+
+  cp0-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+    description: |
+      I3C HUB Controller Port 0 IO strength setting to control the Controller Port 0 output driver
+      strength.
+
+      This property is optional. If not provided, IO strength configuration is not modified in I3C
+      HUB.
+
+  cp1-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+    description: |
+      I3C HUB Controller Port 1 IO strength setting to control the Controller Port 1 output driver
+      strength.
+
+      This property is optional. If not provided, IO strength configuration is not modified in I3C
+      HUB.
+
+  tp0145-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+    description: |
+      I3C HUB Target Ports 0/1/4/5 IO strength setting to control the Target Ports 0/1/4/5 output
+      driver strength.
+
+      This property is optional. If not provided, IO strength configuration is not modified in I3C
+      HUB.
+
+  tp2367-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+    description: |
+      I3C HUB Target Ports 2/3/6/7 IO strength setting to control the Target Ports 2/3/6/7 output
+      driver strength.
+
+      This property is optional. If not provided, IO strength configuration is not modified in I3C
+      HUB.
+
+  id:
+    enum:
+      - 0
+      - 1
+      - 3
+    description: |
+      I3C HUB ID based on CSEL pin. There are three possible values:
+      0 - CP0 is selected as primary Controller Port
+      1 - Primary Controller Port is selected by software by writing the REG#56
+      3 - CP1 is selected as primary Controller Port
+
+      I3C HUB driver reads CSEL pin status (REG#121[5:4]) and tries to find DT node with matching
+      value in 'id' property.
+
+      This property is optional. If not provided, DT node can only be used by the I3C HUB driver if
+      there is no others with matching 'id' or 'id-cp1'. If there is a multiple DT nodes with no
+      'id' property - the first one will be chosen by I3C HUB driver. If there is a multiple DT
+      nodes with matching 'id' property - the first one will be chosen by I3C HUB driver.
+
+      If both 'id' and 'id-cp1' are available, DT node will chosen only when both values match those
+      read from I3C HUB.
+
+  id-cp1:
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+    description: |
+      I3C HUB ID based on CP1 SDA and SCL pins state probed during power on.
+
+      I3C HUB driver reads CP1 SDA and SCL pin status and tries to find DT node with matching value
+      in 'id-cp1' property.
+
+      This property is optional. If not provided, DT node can only be used by the I3C HUB
+      driver if there is no others with matching 'id' or 'id-cp1'. If there is a multiple DT nodes
+      with no 'id-cp1' property - the first one will be chosen by I3C HUB driver. If there is a
+      multiple DT nodes with matching 'id-cp1' property - the first one will be chosen by I3C HUB
+      driver.
+
+      If both 'id' and 'id-cp1' are available, DT node will chosen only when both values match those
+      read from I3C HUB.
+
+patternProperties:
+  "@[0-9]$":
+    type: object
+    description: |
+      I3C HUB Target Port child, should be named: target-port@<target-port-id>
+
+    properties:
+      mode:
+        enum:
+          - disabled
+          - i3c
+          - smbus
+          - gpio
+        description: |
+          I3C HUB Target Port mode setting to control Target Port functionality.
+
+          This property is optional. If not provided, Target Port mode configuration is not modified
+          in I3C HUB.
+
+      pullup:
+        enum:
+          - disabled
+          - enabled
+        description: |
+          I3C HUB Target Port pull-up setting to disable/enable Target Port pull-up.
+
+          This property is optional. If not provided, Target Port pull-up configuration is not
+          modified in I3C HUB.
+
+      always-enable:
+        type: boolean
+        description: |
+          I3C HUB Target Port settings to control the port enable/disable policy.
+
+          This property is optional. If not provided, Target Port is enabled only on accessing to
+          the devices connected to it and the port is disabled automatically after the accessing
+          is done. If provided, the Target Port is always enabled.
+
+    patternProperties:
+      "@0,0$":
+        type: object
+        description: |
+          Backend for handling SMBus mode, should be named: backend@0,0
+          Adding this node installs the backed for handling SMBus Target mode communication.
+
+        properties:
+          compatible:
+            description:
+              Compatible of the I2C/SMBus backend.
+
+          target-reg:
+            description:
+              Target address used for Target Port in the I3C HUB configured as SMBus Target mode.
+
+additionalProperties: true
+
+examples:
+  - |
+    i3c-master@d040000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hub@0,0 {
+        cp0-ldo-en = "disabled";
+        cp1-ldo-en = "enabled";
+        cp0-ldo-volt = "1.0V";
+        cp1-ldo-volt = "1.1V";
+        tp0145-ldo-en = "enabled";
+        tp2367-ldo-en = "disabled";
+        tp0145-ldo-volt = "1.2V";
+        tp2367-ldo-volt = "1.8V";
+        tp0145-pullup = "2k";
+        tp2367-pullup = "500R";
+        tp0145-io-strength = "50Ohms";
+        tp2367-io-strength = "30Ohms";
+        cp0-io-strength = "20Ohms";
+        cp1-io-strength = "40Ohms";
+
+        target-port@0 {
+          mode = "i3c";
+          pullup = "enabled";
+          always_enable;
+        };
+        target-port@1 {
+          mode = "smbus";
+          pullup = "enabled";
+          backend@0,0{
+              compatible = "slave-mqueue";
+              target-reg = <0x10>;
+          };
+        };
+        target-port@2 {
+          mode = "gpio";
+          pullup = "disabled";
+        };
+        target-port@3 {
+          mode = "disabled";
+          pullup = "disabled";
+        };
+      };
+    };
+
+  - |
+    i3c-master@d040000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hub@70,3C000000100 {
+        reg = <0x70 0x3C0 0x00000100>;
+        assigned-address = <0x70>;
+        dcr = <0xC2>;
+
+        cp0-ldo-en = "disabled";
+        cp1-ldo-en = "enabled";
+        cp0-ldo-volt = "1.0V";
+        cp1-ldo-volt = "1.1V";
+        tp0145-ldo-en = "enabled";
+        tp2367-ldo-en = "disabled";
+        tp0145-ldo-volt = "1.2V";
+        tp2367-ldo-volt = "1.8V";
+        tp0145-pullup = "2k";
+        tp2367-pullup = "500R";
+        tp0145-io-strength = "50Ohms";
+        tp2367-io-strength = "30Ohms";
+        cp0-io-strength = "20Ohms";
+        cp1-io-strength = "40Ohms";
+
+        target-port@0 {
+          mode = "i3c";
+          pullup = "enabled";
+          always-enable;
+        };
+        target-port@1 {
+          mode = "smbus";
+          pullup = "enabled";
+          backend@0,0{
+              compatible = "slave-mqueue";
+              target-reg = <0x12>;
+          };
+        };
+        target-port@2 {
+          mode = "gpio";
+          pullup = "disabled";
+        };
+        target-port@3 {
+          mode = "disabled";
+          pullup = "disabled";
+        };
+      };
+    };
-- 
2.25.1


