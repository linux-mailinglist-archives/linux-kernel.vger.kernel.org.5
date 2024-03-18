Return-Path: <linux-kernel+bounces-105670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802887E261
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DBAB22C86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587B1E865;
	Mon, 18 Mar 2024 03:07:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D417BB5;
	Mon, 18 Mar 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731230; cv=fail; b=hKXTWbMzC6EmOhZdKUVXio2yLidug+xL71Lf/e5mHsRriWgJZGEorPk+kbUZDr9GDju9Lz8bkPoM8ESAxCh8uhczOl41LWtR7mZeA2YOeIRgCsREFAbs1e9ZF7Hys5VLFJIMa8VuQRy6jcW/JpwVV5d2Qzkbn5quJPv2KIWTPVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731230; c=relaxed/simple;
	bh=heDuOAEH4hH6Pvg6owmqRjKjqzmjyGj67G3STdt24M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+Is4f+Z1zBBbONV0L+Yd0wld/eZp+rr6iP3PBeFUwPb34Jpe0mAwjoT9NcmdVA0LZ4+6w++dKLwk2MRW6n9LxgFiO9vaW0rRvcGKehpgsRdA9xkPiAf2YcgjKX460OVbGcddD20bN+l0vbcMTNYgfS7dUdmLxyXyrJLNrlNdnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnXsTiOo2ezdA2PlGyu2X5NUkmNUUGcP1W7E6pwPydlOyLRHIRBDgMZLCCEIKVjVUQbPO7R3nRQ1ylRtjYfeqNyqVEdnhsQIp9ouS8FL9y327lKGBnmenMh272CcJvLgQ3/Zzts4y+Xgn/CGvH/CZCWOoRnDvwzCXkTPPJ6LNE64TpYRTMVvk1WX1Z5MZilOb8nLYjvCxrvHaLiwZE6fFLex8gIfKQ1rusU9xvgwPBHaQUZtM10052hX/cVSxyQu/3y1oz9yE3jKMEr8A84CP+PyOpbvw12Ah1IXlEQDHrp+WjkDRGwFn8TfgEfLx1HZ68MhsBlAykuuNRruU+fKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpqvJdZvPmycFfRZZCCSg4FFhQ3bjyafbiyaP+KjlYQ=;
 b=OsGxXzHRlRvpdiQpDu4FGgih6qQmG8dvQJlhu5SAkOQldOWpoSF7XW+Tb7s/gZ5H1FC8F1TmxadBzuMT3P2X2xTaWjCG5aCOneIAJt/eqlIpptSu979rbaS0JUxbYvlE0H2fSJ5kpKN3SOkbt//1NiQLhQBZx7P6hhhAkLb6G/Kvo41usJjISapjKN+IT+yYqZo4z02P4q9qqRBwGdIuNCZLNOIWa7qldkXvTfRm/ycnQRcHKf/zEmxf5KS8KOmeOkwKdIinPXyi4BMSjlTaKIwd336VlQ9GGMWHVZqPIz4cSU+09iAjDbCs8PV01iH3j+mgXpQR2RlqUcJSyexQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1083.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Mon, 18 Mar
 2024 03:06:56 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::6011:feb9:5761:3880]) by
 NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn ([fe80::6011:feb9:5761:3880%6])
 with mapi id 15.20.7386.016; Mon, 18 Mar 2024 03:06:56 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v9 1/3] dt-bindings: timer: Add timer for StarFive JH7110 SoC
Date: Mon, 18 Mar 2024 11:06:47 +0800
Message-Id: <20240318030649.10413-2-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240318030649.10413-1-ziv.xu@starfivetech.com>
References: <20240318030649.10413-1-ziv.xu@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::11) To NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1083:EE_
X-MS-Office365-Filtering-Correlation-Id: b79efe5e-768b-4888-dc36-08dc46f87858
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6NpkCzQP64e8bn+V+0f2cRAau8iNrk+rQv7zH7t2EnBhSiiAaGF92MhM6X+qc89MoxDVzwYdiOdINHj0DbrGC7Z8QwWr36kRQFQNgQ8Qc7UgsmONNYFQfftkFhYqAVdeNq4v46Pgs+kstMAq2HhQPxFhZeziFm8WlTlnHBZzJCXFuhaDWyQx+ttLbBbWbCz+7y0rZWJ1xT3cfcFD3LH6UidTalA3RWYoKjpQB3eZ14hy+kyjb1mJ0CL/CCoY2yIToxZQbX+f7KnlxJa1vXX4t1xDZpiM3RzXJuU/s+hD4/sgqzZnOiKHj31X9VXDMpwmrc844HQCyr2nLQcBefZd2vXQ+50bAkWofIg9RpAJpm0YC8z5wTvOZ0aIG1nWpsI1YSOrfGqyzqZNdGa0I9e5YQYQ4hguTaoSGGMPFXdTs5CqW/OfU+xhRxfdLr9mMhdg6DnOcsPIJSFJYe6RE2DH60b+RJhlUpAFJ5AL+cp9VNYZ9dvIvc4sx1TJ8LNdM7kGf41lV4eDncag7WOGudwVkmDOX1i0iFBTJLyDKHY5/a8JryePtbMBOXW5zrY43uaQVNBOa9P06upc0U20oeC+a8KfpNuWC3YC7j7JXDq1YmJqz58aN5r+YiBqXzyUD3S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?189M09UIMfzwgKICvBGDhGP3lb1gdfeyBijkQUauy5pCHJ7bu/39VsOGgbVE?=
 =?us-ascii?Q?F0RUnnQuxSkMi6QJ6doKY/iCZalQftTu+hy50YJh6zptGUQ4zDhiSXap/xE+?=
 =?us-ascii?Q?6Aj0IW9s73Ya5/RUos1H92FPmzjZeAYPhg7hQ2EuWTdj22AcscTbsyxgYZh7?=
 =?us-ascii?Q?4vOFTDNb/DIYxgQjskdlapbzb0vOE9KHyed6BXaqZdDtVJJTYm6sZYL26PcC?=
 =?us-ascii?Q?+gM5JZCZzPli0dad2QyHIFbCpcT+GumgTPFMvLEO+QrZINZ19MF6lFbPphzP?=
 =?us-ascii?Q?yJk2KJY+HOtOkFPACpcuHBBGtysHo52SXYn/yLdbddadqed9cKEZPtYDbJxH?=
 =?us-ascii?Q?YEWNHjlvnDoP9DO83PH8jy7Bvxy80OWJXDFpwu2wjBU4q0H3L/qq/zPK15ac?=
 =?us-ascii?Q?NWd8cxrUSttvN+e+dWiHL7vcqruJIZV7LkdcuvvZjkJ9pI4StWYIBFh6sh/4?=
 =?us-ascii?Q?576N4lgBuXa6LP1yIDbd9LZa5F7GfSrGPoYaRuC+7WkHP4AKD/OV+5He+Jj5?=
 =?us-ascii?Q?1y5rXXfQR/EUvQ4T+rrEnuNlQEXYQSWCNWgJ9oaWFbZzG5CrgjXBomD0hZGg?=
 =?us-ascii?Q?T2Wla9JfqI7141Up/DJAgkFMGymcZrEe7V0R4OgCC0L/LF0hzW1BKjmkMnNJ?=
 =?us-ascii?Q?Vkxc1JSpJzqpFPh+89Gr8kcmgH4EnfCJiwNFpDjrI1KgkbcQQWmf94zQ5lT1?=
 =?us-ascii?Q?EWyBKnZ0wWuttbceKl2cQKz62dClObfc6ksRBlP6Jca2stTyO9SWWqebAEJg?=
 =?us-ascii?Q?RBwYEXiGuJXs50+iU5q5gp2YihR2l667QsMMBZszUqMkMS2qAd99dUVfYPUu?=
 =?us-ascii?Q?VimX8S1AgDxJcB9d6/pXQdVV9pmoX4YaRCZSkiPwx592HYH2c7tiwEoQqiww?=
 =?us-ascii?Q?2Jw3mQqPKSHqr2tGzqicbZEsE+SnhebmAbZPzcOeS163IvzfHMNEwe6ZEkxs?=
 =?us-ascii?Q?5vKYZGziHbdHogtyuqoj9G2/WXA67f9KaZloSUwiugCNa+PuWd2t8NK/YlBm?=
 =?us-ascii?Q?KPxG6Hxbkoq7r3p0oEL7VYb6F8q95TUkmbpiJjMnmFJbenHBPBE5B3Z/mJMq?=
 =?us-ascii?Q?yWmMEALmNox/IXniaZAgP1gJT+/gRR6VPxk5+u5Dj1HXOBOSMPzeqJRHCcrM?=
 =?us-ascii?Q?6ezhFGYvCVADys+mxu6e8Y2SQNeUezkb8r5yO2I7h4s2fx+IO08jVQB1YGfw?=
 =?us-ascii?Q?diIZjRL1MLSrwVTeN9AJI2ywC07IsXcPyokfAJxlZILnwEo7jTlKp+6BCHNu?=
 =?us-ascii?Q?OVaRJfWrffPUe95A2p43o1HK1gigLfgPUO3FmeVqZKGDTwuNt8uEWJ8W/gep?=
 =?us-ascii?Q?E7SHhiyDHxxNSdj9shEmIzixck7Z39BLvTJyzNw1h+e1MY6zTQfR/vjp8BrI?=
 =?us-ascii?Q?TLTGa3IoNDS+K9X77xf1rtc7zSH1c6E2j6poaDOiXbMXWViZnwv+Wd+HSIn8?=
 =?us-ascii?Q?21Jkv/vY+jJS4uZU0y+fFh1VkgYxIWQTKGFCWBzFRUYvZhY2oL9vjF6EONk9?=
 =?us-ascii?Q?msoj1NrUVyOd4ijMiYJvsQcwQTT90DTJ5ZLxiBFO32BFXpj7h7jMuf8xKmky?=
 =?us-ascii?Q?gb7QhFPZ2/XzYtYv2i1RAIGqS/VKC4aREzHdtWvr?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79efe5e-768b-4888-dc36-08dc46f87858
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 03:06:56.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lylBdHP/PIh6QPruE3OTqk1MJEYpgZJ7Q1x0AH3t4mIo//PJXhl31gBbMWrpt2MJdIInp5O9bWSDPM5pYJVN+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1083

From: Xingyu Wu <xingyu.wu@starfivetech.com>

Add bindings for the timer on the JH7110 RISC-V SoC
by StarFive Technology Ltd.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/timer/starfive,jh7110-timer.yaml | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
new file mode 100644
index 000000000000..9a2dac11eb06
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/starfive,jh7110-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Timer
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+  - Samin Guo <samin.guo@starfivetech.com>
+
+description:
+  This timer has four free-running 32 bit counters in StarFive JH7110 SoC.
+  And each channel(counter) triggers an interrupt when timeout. They support
+  one-shot mode and continuous-run mode.
+
+properties:
+  compatible:
+    const: starfive,jh7110-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  clocks:
+    items:
+      - description: timer APB
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  clock-names:
+    items:
+      - const: apb
+      - const: ch0
+      - const: ch1
+      - const: ch2
+      - const: ch3
+
+  resets:
+    items:
+      - description: timer APB
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  reset-names:
+    items:
+      - const: apb
+      - const: ch0
+      - const: ch1
+      - const: ch2
+      - const: ch3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@13050000 {
+        compatible = "starfive,jh7110-timer";
+        reg = <0x13050000 0x10000>;
+        interrupts = <69>, <70>, <71> ,<72>;
+        clocks = <&clk 124>,
+                 <&clk 125>,
+                 <&clk 126>,
+                 <&clk 127>,
+                 <&clk 128>;
+        clock-names = "apb", "ch0", "ch1",
+                      "ch2", "ch3";
+        resets = <&rst 117>,
+                 <&rst 118>,
+                 <&rst 119>,
+                 <&rst 120>,
+                 <&rst 121>;
+        reset-names = "apb", "ch0", "ch1",
+                      "ch2", "ch3";
+    };
+
-- 
2.17.1


