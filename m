Return-Path: <linux-kernel+bounces-159316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE89F8B2CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960152866F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820715574E;
	Thu, 25 Apr 2024 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="EqeJgbq3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FA14A0A7;
	Thu, 25 Apr 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083586; cv=fail; b=YDs0/QYV/LgYFDrqAh+l8kJZ+gflxHtCy+leqcTnW2P6n7IPyAX/Y5mwebs2po8fmHK4aKIgvHTexfTztCs+9M+WlCKXjSUJgeRlMZL1TMDPtY2cMtm2pDdmZsJ51p6p8AygUb/yZ+rXIWxIPBDqYg3MoscwJTuC7eJ6htNHaeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083586; c=relaxed/simple;
	bh=KMn8aJhYHLgbzMmWnoPMgOObRAQAZg6z8nChg4MtXOo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N29+ck4h6sYtdwLK2KYyvnzwpPfdql5ZXvcUh1sQlP30tMf00uFIbnwAjnHIiXNqhXH9kkUnaSTtE0FrLfoIisCZMyy8/CileCMK6+rhFVtxYdp++A1gG4UfpBzY+yWqosYYbXDba9710b9jmCV46TAWCQA2ODwbqaPxNSOWrmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=EqeJgbq3; arc=fail smtp.client-ip=40.107.244.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/mPAU7XM9f8V9F/HfN8lnhT5CrE9Gp0+25YU7+ZfKu/RJRHfZeOWIAeTRqFipvVGl+eE3K0qSeK4kJKh3SXdPsJCZqw8LTVGUjOyiy6JC4KHlnDHt8RRapoosTfiPIR7MGlfpMVdDBiuq7ImYksGWuwRInp8x3H8CALG4drzKi24artk2+y/32EihH5LvEyPUqHvNhMM+tyoU1sc3and0tddJD4/l+JfhLen5m0O1SzWv+mwMdpXc3LrcLNfyJw0K2B+8RiWWOI+dSFTmyJfzHYCXN4JNJgAzX2vQQgUVbma67Nxe7LuY72/G5L1OGTbVASGva3b0lzcUlTITpZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxBKqmei/HDOeVuE4OSifdei5QFeAwvtF0/M26I+N/U=;
 b=kGrd4ynRpq9ftCB/kq0s9ujYShEwjYsE/Fn8eswEKfTe9hJtjuqUJPwC1uhXUFwnARUoHqXRE9S2O1xH1fA3KuFK3ntU0D9U/JyfDQjgeJKcOgPYhLK9HwigqS2rf/BzxZCBNWw5ME7fffnQu+PAdAJH/nDIac+BApVdqxs2ADy4IfYt1I6jSs7u2SywNZUdI5JlNPRiL1l0VvlB12NG8HrYiZe6mi5XKU7Wz935jt5eQteRQBkfVG2Pw4yjdWJ8o1q+tTw/EiF/ZgxQeiKVPD9fs+qxevHvZWxAFzCsPbNcUctf2GlblQXF8HURLau4kMJElN4hEC55IzswkoRyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxBKqmei/HDOeVuE4OSifdei5QFeAwvtF0/M26I+N/U=;
 b=EqeJgbq3GQdgpAuclgkX0mPMjsl6PoL1Y+RuLs9wF5CmATRyAOWJVW7MeaA8bpW4U+Vm8tV+LfMBmdj6HvfPxfnpF9TkvVt0QSRhfbcb5V6gXMdQ5vyjR1Xe2X7dga4QkNEihb8oUfqJSLMj2cwOG2JGNgTXWkJ9mE6DKDdLNpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV8PR22MB5889.namprd22.prod.outlook.com (2603:10b6:408:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 22:19:41 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 22:19:41 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu frequency to 1.4 GHz
Date: Thu, 25 Apr 2024 15:19:25 -0700
Message-Id: <20240425221925.1781226-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV8PR22MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: e1acca03-90a0-4b81-f435-08dc6575cdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GK5B4jSp5HcivChgw9Yv3ApCE6+CBIfEy77lIHH4fMFiOoGYu7xGoll92bqn?=
 =?us-ascii?Q?TB848ePqEUy7iDg9ajm0h5b0ARAN5EsuLLnnyp7b0HTpB4QMWLP8x0YpYrZH?=
 =?us-ascii?Q?jz+JlusvxCJCtZ9Nbao4XQcIin5Iw1pOG5ZG7ohv5tsdSOV7pmCdhxLcPfJp?=
 =?us-ascii?Q?cMgspcqtwyhj0F4/733FMbPD7wZNMCTfSzyDmmOVWxEJ9mDkpKGZehgzI4t5?=
 =?us-ascii?Q?ktySayiMAwkxR0ZD0vspfYCdLn9b2gatF9rIJ+Ymz+mobtOTCPmLNOUwYU4e?=
 =?us-ascii?Q?knMfRss/7IdlzojKHKSudWvP5gEzEBoYVlRCITAWntwcsjl19DaMLF8WZqmY?=
 =?us-ascii?Q?UVpp5UMSI2MWd5+nctgfIurpnzwMoxxrn0JEZN7RIuJvprVaQSHY2wXVcHVU?=
 =?us-ascii?Q?HhoMZBfBWbJd1zfmhi9mWkPifdux6fZcQS1DL5nCG3/BTyoV12p1g9pqbVht?=
 =?us-ascii?Q?Paz9nB6CnRNRrkOh/y7V7WJOTCyryDSyB9R7Hv7JOtjtK32x+IAGGyhLK7pf?=
 =?us-ascii?Q?BsJOi7a4OiNGDIhg6z1/MzX0phR4Xt7l85NOOsRbS8/HRGM5wQHMt0g68BT8?=
 =?us-ascii?Q?SF/pThZ9I6NPoY4lZZIFI7vLM1qrKQMpCEyiumwG9/F9S02lL4pqbhOzMWLQ?=
 =?us-ascii?Q?ahhs50v/pDpeC9iM0MFiMNCZ7CT7s9SInQetfVo01ydv1yIZAHYtJ060wz4D?=
 =?us-ascii?Q?xaKh8XeOjNlXqvlxbWn0q/enbFEG3kLPaD/EPpnnBR5h62N9LGrq3Eftvv2C?=
 =?us-ascii?Q?th3s9cLEk3KQVqRN5t18v6PMVp8XlJNH1nf9MYYnyrGcuVDKwGygNDDpFK2I?=
 =?us-ascii?Q?NFyAxm1pYe+JvndaHeNxi1Hv+p5ROWZCoA8GiCWaK53ePh5j3VdVnZqPvm01?=
 =?us-ascii?Q?Vh5WgOoo+8RBAlh0OTRfyxciGi75vFzzc4cqZEM70z6lZhbf5Sdrwe0Zl/mH?=
 =?us-ascii?Q?+P3MT9ip1TYlUP4FI2BA9jTUX6i3UT0DHTVb4ExJjNEHCkIcBPzk6ScUF270?=
 =?us-ascii?Q?P23pZB2DPAiNpk3Qn2MnHJq2PMnsg0BYdhg30IU5D/iTa+uCis0iARK9FvjF?=
 =?us-ascii?Q?q9oL3BG83/nQxbxhQS8nr7uJPBBpEUsPNCOsy4H6Y5iZY7xxya7CwXGppkHS?=
 =?us-ascii?Q?DcIt8alVRMGBEDlBNnKfSUc44sRoPGvXlhV5Ep2xNEb6cpcUjES1cfEDCXA5?=
 =?us-ascii?Q?guc4hffckv9fljtnCopFRQ0kkqZtTqYL7bo/dGqNMj6hJjvuf6N8dsZPesnO?=
 =?us-ascii?Q?46I2hgh1sfcS90SAKwPWNOkOybyCveRcQ66q76sRInjIP35nyfCoNkM8PJhc?=
 =?us-ascii?Q?2S/W414sdqqYFwa8aXx9raBYkYQRF1R6mEhbuPR8/9UfUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKpPyhwNZqPHnndBFn72PavyIpbGBKus3VgX5qYL7nYtU+HtuwsaHLcvmmKJ?=
 =?us-ascii?Q?DjZ5pIwMVKWV2FWGAMTnhkedBM9S197LUr4F9x+4bH9N2h3FTZZUGCEbHrBf?=
 =?us-ascii?Q?MF+jrvBdfYNvndiHD5iMXcBv2888RIf7ISoW5tKPFORP5JpU8P/8OF+39cEk?=
 =?us-ascii?Q?Sx2VC2wdt9v+Il/CHdyTV+xS7zQEQobv46V9A1AJoMwx/ykp03LTRqJecRMm?=
 =?us-ascii?Q?Uw7a46POsC4mJ6COAvPx15QulCcNKJe2WDuMQh7Z8nPLql69qH4zHIGlCfrq?=
 =?us-ascii?Q?TJqJRC6/vg7ikhVJ89xbXWo4FWwSrQASgFWvX4qvNN8VyqPEoMIdQ0WQcqz9?=
 =?us-ascii?Q?yR6fkcyYUUlLjpYdqbscQWwnBSR33JxFwd4/w3XRyqZFeaz7GAFWupcC46zD?=
 =?us-ascii?Q?HHvXXdAfA5vB670rbl3zES/W8gcS+NVeKhOE7hj/NnmRmW7arZ8ZFtwQTRPl?=
 =?us-ascii?Q?7ilVp0Wc7EJknVQwa73L+WV9Qounj2Sj29L+pkRxP34G9e5ThkXb8vYB6eRX?=
 =?us-ascii?Q?PVebMrpGDGWZ+yrD7BiGlHzs3+O4oa8x49nt7omdSL/As3NFDGxqGrq7eUIp?=
 =?us-ascii?Q?WPLT76jkXhCLyE+y9teFYxMd7EcRKO+VdF6qHonluAO0N1mFosOrwUoRZgr+?=
 =?us-ascii?Q?iLCYErhMmjwtDNcf1jCyItG/c7MavoWWh/5Qft53C/CTGPYOntU/XWOMlf3F?=
 =?us-ascii?Q?E0qw7+57FLYYi0VhtVFv7PXgaO2OxmIDv2+B7tEaEQlG2xYFvCJN+ukwmMrW?=
 =?us-ascii?Q?oiboYs9xZ8opDxj+J2omooQyACWYSIinyDpYGJx9cwzqaqWypTyJa3pBr+Kl?=
 =?us-ascii?Q?0yIGGWG7eVzas5oBVHFgllrDYjMmNjeFr2DDqU5sKEoMUR3m8KU9TJ9cPPfJ?=
 =?us-ascii?Q?X2NAEhiEk2CvHwzl6OYQtMN4O+y+xoPovmLa5c1ehvR5T4ZY8/VM5TNLnVwd?=
 =?us-ascii?Q?QKjHa1hy7svZ5cxbNIFGyQeBFwDJXXja6gV7LvmyzjkNEUkmut+5tF99KhSS?=
 =?us-ascii?Q?iF1DxZq5SnNMC75X3F4U3cdMWSVrZQDbTE00O/gYO9Mos8S3VRqoSZY8vaao?=
 =?us-ascii?Q?frqNEnrKJD06bgZ/cxnfVfHDEdshB1zFXR64PBDPZEDE4RQb9343yw9D1DfQ?=
 =?us-ascii?Q?O9fIbI3LDY9GkPtNO3YA0HPsCw2vX5bvWEJoqqNZ+Ho1nGtq9aUiXr5sNIZ6?=
 =?us-ascii?Q?uFhtE2JQdNz1LwV09iEAWLqsKmqo2NXiVDbhYVVPBR1pbDMJflv/kfWT1rSJ?=
 =?us-ascii?Q?rBk0s1KdHrMlP/++L2H6W13DCP4hGFZxzDEkC+ZYJ3iTJxSgSKiWrnphDy2k?=
 =?us-ascii?Q?YISyZwOtrg40pmfVVDHTuqi2/uwyWGWWAmBPgAcOmeDWeqR0YzgAIy5fUm5/?=
 =?us-ascii?Q?Ld9y7yNCufpD3L8sq8tuiU4RV9TNMKAgN+lvMxqbTNIWW9jbJ+pSQc19Fh3o?=
 =?us-ascii?Q?6k12vtO7SA55kRM+Tz2D/9Wty1m270hzT8szn5pKO0JAFjtIZ9eSTsavKcAl?=
 =?us-ascii?Q?L39ImgQqGkZ9Qqw+fLNRndbHj2dT4adNRcZmJnCNKQwoIJ9pSU2uQ3PGeFCl?=
 =?us-ascii?Q?avFkpPNZ0Ajwj7xrQwvjS1xzv8fo1SITT41y5wH0?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1acca03-90a0-4b81-f435-08dc6575cdaa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 22:19:41.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwmDOXEkaRamHn50WCJO/PXNegjdrqBVyuH+q8e6Cm7llf6CN6VeOGHXhyvS2uLm32s0kY65hwl/k+IZwHDWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5889

The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
from 0.75V to 0.85V. Increasing the voltage while the AM625 is
running has not been validated by TI, so we provide an overlay so that
people may choose to run at 1.4 GHz if they need the additional
performance.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 +++
 .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..725f7e44f76d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
@@ -106,6 +107,8 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-phyboard-lyra-1-4-ghz-opp.dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
new file mode 100644
index 000000000000..6ec6d57ec49c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&vdd_core {
+	regulator-min-microvolt = <850000>;
+	regulator-max-microvolt = <850000>;
+};
+
+&a53_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-supported-hw = <0x01 0x0004>;
+	};
+};
-- 
2.25.1


