Return-Path: <linux-kernel+bounces-167179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A78BA546
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778D61C21F68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7C17547;
	Fri,  3 May 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hl6ub+Dy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2075.outbound.protection.outlook.com [40.92.40.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A34134AC;
	Fri,  3 May 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702781; cv=fail; b=PZA7GNjDkjGQh4R82mXOa/8+zeXkY2X7rPjUGEjb0X2AMufe+VGD+dqGv7UReGA0Z64AuNDAOYq+Z9VPaLFbqO94S86t7gahVZEcq3wh4BkudTIui/EjqUq+WOmwIJWbZb777EEYYLd0RcQ+PTngU5JjXlhnBfL9NwmIlE5Tl1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702781; c=relaxed/simple;
	bh=wMpSLe83UUAD35veRRcSUPwt96DTkc38lywOf/tN810=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GI4urDqR1Fc5uzoUZe1EmI8QzXC7T8odUW3EpXGbHQuZWsy6uTCH+x6oct1JbCl4Toq1QYFOhzf8AAJnSosei5o35a8oip8KFOMM1XLZ0lTY373wPFKhrgdru1d+Sl5a7EOULj1xsfYoB3TFdJTAmYjkHl/Uijv6TJwtSij5ojc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hl6ub+Dy; arc=fail smtp.client-ip=40.92.40.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmxGElw+kc8J/x8QgrFItH08tRPH9uwem0ZX8a+SJAm7lHzr8AI1UPPBmZFvlx9PqWysa4y5yK4M6B6S9DZR3hDlkEmkzqjFg16t9AgQkbNrfi0AX29SAJeVZQUu2YlqigwHzTPeHvdDv4F3CT38KCyEfHzKCIGknpqtm28vjRRfELq2ah2WYHHfSAgA88pHouWxukjvFGDLZr4BQFrfg7UCYv71IB0ojmUH/gtDc1l18AQ7jdFGwVg/Ck9jDkfpqi/SOZjKB58Ii91cOKhYFd19PbI3hJJGK+mbpx8C4cuPEXU2Li4WMNnxFzhfuGrhcEFVAYN7TxEJcfcXblVuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLPewNaxgAFCFu4+LQqxZ1Th7DVvlEFO105osJ1Etuk=;
 b=ZiUNGioOU+IIV82JfoKpFIMOdEVkH5TTrE6FmzUm4mLsxXZmOEmrujytbwVYEEQVPrK32lWLxxb0YEUesHH5mFOcphdgI78Cilyc7q9nmUAcFXtz0r/8JVYHQpNRpG5u+jk6h7Iq4XhwODVEWT4hSg/pWDcLfvUbunO1jQVzNIFK59o5JaZ0XTJ+ehoZWify3fsO934uGeo4U+j8ZmCICzBMYdLo31u/3MoenwJ1jcW8SYbwbAYLV7xjf6sBFTXWBT2IbPuakZzVv+FSYRAKKDsi3SAD5u0bviA+NgZ4MdXZaCuQaCTo+DZvC/1d6Rrh6RqcXEDr06jvokk69mkf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLPewNaxgAFCFu4+LQqxZ1Th7DVvlEFO105osJ1Etuk=;
 b=Hl6ub+DyfmyZXTCezpplVXJXvp522KlDuZd1sq96B1O65JC/HieYL0U4ndZnvDihpYBQ58G5UNr7P2ptufddf1jDeDscV0+amBcBlLdLYLelDFohi+KkWz1qm1eSPJqR28s3cY4cXHsTiPm/D8GZuJt4mKr7AU6FFNq2cAZ9AXgQ+1nY4RVUCn7AZx6BviWKVD3MUHz9g+JFDRFfxCXNrk9DLi4JXy+zeoEmPwCRRLlSeWfbcLzsD1LSvqcC+ur08E078JpBbAvoiUi1fIF5vlx8sI4SkCsyMm2BbY+I4MDVFs2+xpBHb0fETv7WDfAmmPUag0X7gGVD5M62x2VPrg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7419.namprd20.prod.outlook.com (2603:10b6:610:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Fri, 3 May
 2024 02:19:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 02:19:37 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Fri,  3 May 2024 10:20:07 +0800
Message-ID:
 <IA1PR20MB49538E47932808E80B2DC781BB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <IA1PR20MB49534B54403ECFB15D952A8BBB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B54403ECFB15D952A8BBB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kKB1eB3ZUAHaHUnyKuBAeipjOYMBLSdHHvzgspf+lcg=]
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240503022008.898271-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c01e83-1462-4ec0-839e-08dc6b177abe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|1602099003|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	+yCSnuSTogzdHjyhqD9IW1hUOIaeyc+7w+mVadJLw/p3Lucst20GmBui6vkZb8WS1/lPClHxnPTmPhz8HZJ3EDm3VUXEZXAHHW9PSo6IhNdhYlqVrPd/Z2bMyisGMgwRurr5Z7vt7naCePx4GJKPDk9OOLRWBX8xKJ1Ys/c0aujDl5hvwj4oiW57+peNTa84vSJ3jqrZrKea/OGbyGiXxpFNs9sdddVyU4gp4h7Ixo6TIJzV1qGucisbTWbIA72VjAtG+It3ma/u+G6VhQkHzKHrH0VwSqtXgN+eeH9MnM65Hh+ntkzwUeJlTStZJb3PWW9osjaWwmvAgTr/0KCY4bBdDoN6CDv6sHkxZJSbJpuecIJ9aKDCx97Gz04jHv/5QpvaIpUI/rqbQzgcPtbF5y+M+grWZHzES0dokVrHsSn4CPa5PMZevMhCbo2xAhW8p6OhV/DWHExELG8330d3Cbbmhm+nIlrcbtfL29TF7yXPjCVlShf3yNdgg3MaP9uscMqGHJepjoHXfpKSohLtrp21OyWg0NMrAD4u63Ba6ETe/nP9JqLUGNYKRoxADV+NtqWSTT4wJhRtfm0JFjYTPo8YdrGLrQJ0BorJJFFX/hzQGPsAxdzl008+DMgg7e0stRRtAS2fPU7NtLddtAPsmFkVUthdPD0NqRJOxJaQruL6t4re5Qa3MODMnR/g0qX1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mx3MMP/8Zdr0n1+DXywlbY0Xl8//bNjEdkfCXplLHn0/OeBdI03HMeUPlfu3?=
 =?us-ascii?Q?UiMoN7s62xaAje7zwXgrAw9jU0lXklDK4FxEoSqaffCDZfvW1nAXE5POLZxm?=
 =?us-ascii?Q?pwgBf6Ct3j6KUgTwE9h3YGJ0Beot9w+DSEUfq7QnopeMzLS8C5OAkj1NbrQj?=
 =?us-ascii?Q?NmBhGhO8DE4F3N2a5032xYJ48UI6HF9pKBBrQCE91u0JuhMLFk7wqWWamAZn?=
 =?us-ascii?Q?TWQ2fL2bHzh8hqSd7f6gVRazRpRU2CxeO6g9aJA4/+ePQNjwyl/EEAYwYNaX?=
 =?us-ascii?Q?zNGNA4x7Dw+C7xv7Q96HIgQj1ITo1DFVcd2e7v5h0TG71llf8nAE/IpJ44jA?=
 =?us-ascii?Q?cKJ5O04SoVa7VKErvZSiTKqzhMLJfqzQfww24QYk/gPxkQx2/QSCOfIH66A7?=
 =?us-ascii?Q?bvY+3kjIf0Eb72VfCFR0TzAvY/ZWag0xvdt9G5W9s79pztK4AgNoRHbVaKvW?=
 =?us-ascii?Q?HVi4ycs7T31BsFR4inDSj4Fnif1t/rpNDlUo2Od0IqbCdSTVLS2Q3NMNajUT?=
 =?us-ascii?Q?n5JGzCElNbJjxeL0ffcoBJMiRPi7PFurhKnJm8+iCXbidmfpaWm4zF4FrX7g?=
 =?us-ascii?Q?bvnbKP5Vnr0+DwQF/8hhYPwzaRkHWt5twLaVf9gZcoQTq/7amw+v0cz1dtM/?=
 =?us-ascii?Q?R3g5kKuN7hinZVk9SH0HllWA+Lg3fqeQaRHUbA+qrE1+FPdKMJ3RJCccpRfu?=
 =?us-ascii?Q?eATBezRiRkXiICOP0C5OeXSH/4+8nvCRpagyzTO5EfeYGAlU5VyJMGfhPUHG?=
 =?us-ascii?Q?shu/XTx1zUxlBksOfjDhkCUQo5lJr05oQCd67WycW64F3XdgkpOlRv6CMT79?=
 =?us-ascii?Q?vJOpthz/ZoRwzX1Bc91MOeX6G5FedymRvn6SDPkIYhp6uqODjKSRJ6TLcS3/?=
 =?us-ascii?Q?jwECLfwgDgVaP17l0G06Sa5eoq0Ej870eKK3QiFacdgxFwaPeaN9U7U8tAsQ?=
 =?us-ascii?Q?Rcb3+Mpweu7CYd9gn+U0rpFSeLm3dAJXRq9m3L1X9LzMkNpsN62/DNnUZK/x?=
 =?us-ascii?Q?/5VbSyTwaiL9RCgNHIvSJWybOnaWqb48GI4Yi3sDPZ2CugBbEJFRPXnaVDEY?=
 =?us-ascii?Q?N1RcrOsRoGw3QiIYBb3pLwjR3SixZox++f48F03It4O/Z2pRAoer3hwkDY0z?=
 =?us-ascii?Q?addFc2FnEjUjlLSiKfLVShWW6pwkf6V47EjDzzVWCHoXV6AQ7nUYgiOtWRlr?=
 =?us-ascii?Q?UmhFcfd7fOeZwlnLy+7/1XLHd1Ym26FGwuqjhhL5txCHdBboZoLdvYFFOjAu?=
 =?us-ascii?Q?UuLyIop6Qkl/27H4s3h5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c01e83-1462-4ec0-839e-08dc6b177abe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:19:36.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7419

Due to the design, Sophgo SG2042 use an external MCU to provide
hardware information, thermal information and reset control.

Add bindings for this monitor device.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
new file mode 100644
index 000000000000..6c114f42ef03
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 onboard MCU support
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-hwmon-mcu
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#thermal-sensor-cells"
+
+allOf:
+  - $ref: ../thermal/thermal-sensor.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@17 {
+            compatible = "sophgo,sg2042-hwmon-mcu";
+            reg = <0x17>;
+            #thermal-sensor-cells = <1>;
+        };
+    };
--
2.45.0


