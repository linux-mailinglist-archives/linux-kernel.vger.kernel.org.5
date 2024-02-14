Return-Path: <linux-kernel+bounces-64697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D5854197
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017E8B28A43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D647493;
	Wed, 14 Feb 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZGFnKN+m"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2077.outbound.protection.outlook.com [40.92.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B0BE4C;
	Wed, 14 Feb 2024 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878752; cv=fail; b=MaPIvxUd34muE7/5HHAFQcZPzIVJa/IIYShXmy6hxbMvLauSAPMdjtnYYr5etol1soFzMfy/d5n4sNwOZ6yiQ/MMgvNQWxsuTYQWLNeIhznYEMzC+GxTcKt94cERS3TpH7KuNhXtD7IhhCTEoZrz772v4o37wLtoE9FrKPpPGNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878752; c=relaxed/simple;
	bh=bawxOijEcHnMT3Obq3Z/hIZUV8e+rloP1T/vL3l7yp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFbCcDobp0jTAz51B3TPR0wMQEloX5EpfWoMyOeM2q5KsrwWNnJd3GGS6MZZpM33Ix0BEW95q5TZo8qGQaw4j0EK7hntBvOKdzHyHNDt11EnqTFidQhLcPsxFhbarZLrTHFFtuQwS5Tdy4QpY77JP3UgwKARIdADA7YcH0fsFKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZGFnKN+m; arc=fail smtp.client-ip=40.92.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCrHF4ykECPtbngUz21cRWjGt8zK68DIRVVYuZKBQE6UWrZx+YCnuuz6+N2VHoLgNyBuqrX912iyo41X3KXN4rhag5J5Yld8eXW4TANeq10GV41hRUpX8309RyGQhwdVJT2d+2tbeAyoD3d0g7ZH50mg4DaJzHttw2GZ8b/Rm7u9awOu4Ncoh6dY7kuigtY9SfVCOlYaBQOD3+ibrqNQF9ZZsnKbonxwv+Hpgvt33Q2ByUniRCNGM9tWIMjaSs12KDlDRm8glFVpZsTF82Pq9uvczYtDQF7pcmnMQH5ev2L2pjOticF2s+zlNEYgNrZtTVUcQ7Fom77B7eURTpPmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60NKp3UCzdPXkXtUhU+cgJy0XBC2Ez/PysKkRmAtMBU=;
 b=cCenzLTN8uzXH9Gf10058LiTs1139cPe9l15LioamUC1VEom3ZV22VyU/2QimNl8qw5tpfVKqJagGWU4Ns5hKZLcqWGd/8o70wLE9SSmfmfccpYF4IhlMcZKZonnpKnk/4WIh2T8t62uIO1cx+NOzxTX8/nx+ke5HbESuOG/OQHAmcUrv5ENkntyNflp7rJmtYxue1rwrYp+JD2oY4I7LEPHXN9PuBDMEo7QJBx1suUVWxMD+T/ij2ptkDuHhIxVMh4FKJACF/sMR9+m3O1DrnvBrrjNKxf/ZoUQ7Y8gn14JA6Po7rs/l0edkshTX99Ws8893Jj3Yr5aMfnduf/oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60NKp3UCzdPXkXtUhU+cgJy0XBC2Ez/PysKkRmAtMBU=;
 b=ZGFnKN+m6Tcn9GEW9bE9coebccAU/rgNrmTtz5iTTVszAwuWBovZm0udVZn9B3xvZBTEIEy8ZmOLNbHCwIZEowkbBOLyUJjXp++K+BR1swDG7vn4wQuLKmsEYKOBGSvbIyoZ8Nfo27x1KnyRDPLyr2bXAtnfhO06v6crFtwkPR9XuTdb8e1OUzLD45xdmAmg5m0ldY9ZiP4lvIIgqzFyRk2OcgOdzMBkLf6+Q9xH5jgs6U8qWvTqv5yIcqpb5jMIe1GMf0W+f9zBTQk9P+sioUJqfqp0tJMbW2IXlQYl3NnqHlRGvrQcVMKLcI4nYW/OGQmeKdOlnqq9D49eyvExoQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3788.namprd20.prod.outlook.com (2603:10b6:610:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 02:45:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 02:45:48 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Wed, 14 Feb 2024 10:45:49 +0800
Message-ID:
 <IA1PR20MB495375047C24D9398A82E43BBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953C0B48F84A3F3A500253CBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C0B48F84A3F3A500253CBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GCnDntMKZ5seAFvkNrKolpPeRuHnR+hHYyWI2RgsATCMWHIANGGx0w+ffB9CRfrt]
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240214024551.292853-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 26afa5b6-2b50-4963-8d3c-08dc2d070cc7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sL5yrl3LpP4sYGLPy1f25N0unbErOA9OyFWz7p7D/YgFRDK87QGSO3eG9bCbY9bqU4gD4Y/d6K18kyIHDXEe0x/tmvWH9RC0ea7ZsHPrhhud9GsJdTH28ZvajSjBGLvp52I6vyLlmnqwPftBIBwhGx6vHzkdWA3FlMFdfpwlGpUvnOrcBZI8ulfVmdbSk9bCdqVpwmunvfoX7CONfclSrCNlGunxz5GPgP5g773XFBy3V7fBGK6AZMzY9FzrMorA3V1K8lma3DZyll38w55dBnoAoOc+ZKJkSbBswsU08644sygHrAdbSZ5PVqPbMMHatbbXBjmzREevo4MqNmXpq7yu2OuBGsYjAkhKfiHZOMMQpV2jJ8mGTo00YjprpwnpTaElxg1IeS5gxOOue+pHxweHFeH1AHJDgF/GXL1SuCxiyFq31XFjnwjCV93lGlUF055aPz2ooVBtKUAkV4qXBeLrVqKfyvzamiNMj6AC/ac297ojG6lIDOCskaYeocrvGIbYTRwi1IHcOtbg2e+1lQzcXKcT/SO3JI/6TCu/Nn76duX+9kkE7sxFahio6ut4hYHQxN5V0bJ7X/f8sPXAJC3YtDsksdCphcb5xZSHQ1RqZrzL0uQUxknsEPBdmJbuSzPWa/xLJG/9I+afHTevobKflgG5Pp0mI6LErrMarpw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVSMgrfoada+ZQDFIk5TwUlkEDv1lgH5geGiyeh3VleHg/JXABiwnrQsT1X0?=
 =?us-ascii?Q?4HfHtiMWrY1PEGn5x7+vAX3bbjJ4qtRz3J8aENhTDFMum1SD1+YJnqLEY7EH?=
 =?us-ascii?Q?Hicgwjcwv4I5VIH9yrLW4RfmcQcz6X97q5QknpwLUUcnC03j6vxbUF/h/2tR?=
 =?us-ascii?Q?roFlaNccmTQ/wnEndlx3JfTV260aT3FtX1kAi9DmKSWR3X07lZJr18sZTjv2?=
 =?us-ascii?Q?p3PUdkq9nSe7IQTsbW1Tph2JFwcUWFAumiKBq8dsA56MwavIW/McVzwdwH+S?=
 =?us-ascii?Q?2nCEfvOEnxFYuXvRoaNKPI5jw4j3iYZ18BJXZWTruvQ75JRbCYxnYKwiWSBk?=
 =?us-ascii?Q?vpDE4bl+KnV+zK8A9APfRmRxlusDRSPHCM2oULcqNk7JxQFqORTNjqNCizBA?=
 =?us-ascii?Q?z+US1F6tbMueonMgzWlfL1o9Da2hdgoaAqcAwewiZLlJz8ttpEufPwmQffZv?=
 =?us-ascii?Q?HYTAUtkvjAalxf7/uYs57wJnUHjZf9U5kpEoDDqT2dPhuZHEbTVk4FChHlDr?=
 =?us-ascii?Q?bTngahggj2uQQPssggHjvEUAvuF6Eb66fx1zaUu2UOfLtW8+qY5B4aXzdVFy?=
 =?us-ascii?Q?JLANd8N0DxPly04c6m66dtMG2RDaSOsHETAb7VKr/DY+93K+RidqNAEgzbou?=
 =?us-ascii?Q?0PKWvOD6wZkK00BqA7ZhVKbeEk0jjyqfaDdHGBEfK3hhlJRyiFVkzCLnpDrZ?=
 =?us-ascii?Q?HhVTU1XjA7D4JQagnG9czNpqwxCPJVGyOPMSgz8Xgt+1KSFon7QgLQxBvRXr?=
 =?us-ascii?Q?+ITBdjogyJq/0OhcOIE/XRTFqctPDn3IV1VeU78AvbtYp5WcLDJnZsBqkpqJ?=
 =?us-ascii?Q?DyKC+Jnq5qRJ3XklMnkg/4eaQhRLf9ZQIgAF0/nDLq9mIUanqFsAhAoTBhWc?=
 =?us-ascii?Q?jIP86xcLF50+liGv3MnlqvQroToIiFezpJ85j82kRfhOUJK2zh6t0Je8RAub?=
 =?us-ascii?Q?3FZaZ9VGpzUO4QsNEVoR5q6dB+mWnh0XNwrsRwuo2+KbxBaqkiUuTAJZScm1?=
 =?us-ascii?Q?C9Wsm2XsiaTnGIfyxh5ev/LC2659vn13gDmbvxdWBY6D86/oF7spJ+D28Oq2?=
 =?us-ascii?Q?vrDbZ/sxnU+J4U99NqtnS1QXdBtmTUJZuqqKRAqbYjUJa7ghMA5GGMTQ+26f?=
 =?us-ascii?Q?BLHNtUubmJdrvOxTpBUvqA03BaESuZ8dzttZMgeFrFtXzSEbGLWgzDBWRpV0?=
 =?us-ascii?Q?IeEjSCdulspiAqBZAv4VJMZptTeb9gaVsCsbtR5fjY6TLJJ86Qy1+mGRKUsK?=
 =?us-ascii?Q?W6CifTIEhdhCj10WqSraadchEP1qQiBC6dF1Ys8Yj89xzNmv/vVY6v6awKa8?=
 =?us-ascii?Q?4qo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26afa5b6-2b50-4963-8d3c-08dc2d070cc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 02:45:48.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3788

CV18XX/SG200X series SoCs have a special top misc system controller,
which provides register access for several devices. In addition to
register access, this system controller also contains some subdevices
(such as dmamux).

Add bindings for top misc controller of CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
new file mode 100644
index 000000000000..630257083cf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG2000 SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV1800/SG2000 SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,cv1800-top-syscon
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@3000000 {
+      compatible = "sophgo,cv1800-top-syscon",
+             "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+    };
+
+...
--
2.43.1


