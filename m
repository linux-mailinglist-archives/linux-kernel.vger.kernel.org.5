Return-Path: <linux-kernel+bounces-90409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E0086FEC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A7128326A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578939AEE;
	Mon,  4 Mar 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="SiHu9E3T"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7E39AC2;
	Mon,  4 Mar 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547340; cv=fail; b=ryeMN76MywlWiz0TpHkJoNQPgp6BzVs/5r5vJKvMa3UHaUp6mAxwlhHTwjT9wNcu2BiOfgMGbFaN9i6adVaGylIROo+opdQVoJTaLcePW3+QhNfLOAmpza7zz6aPJiB5vul139yYw6nrnnhl2pdMFGxQq55t1/OD6cZRh6DC+kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547340; c=relaxed/simple;
	bh=pk3v59F+H3w8QuXmIM9KfP1hNnfp0jn5wFPfLzDkKXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JN+TfqTSY7JIHgDRdZv48ZsV211jnXdsYXqEHNdvF322esmhV7kVd+nUSEUaYFYjfKY5E96JT+w50O8NdXo962bHz9UWg5c9wk7WxYiqsSQ3mggdzEGIjMlE49fUWy/Frpmc0Mbp+6OrSTzJ8ZyTf40Bb9aywIy+G38m2zm1P+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=SiHu9E3T; arc=fail smtp.client-ip=40.107.117.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKIZGbo5iPGSY0UZIWvXco1tKaQG8GXgNGvkqED5SiVoAdA/cJjBvMio8luHPYknxpOHLdgsYj5Aid1XS8TCVoIg2ZF/kTDw0anT8C55WbC+LSA2aFJull2rbYmSuu3XoEyYysdwAG3AFp3Eqq20wCgCc0EKJEnHLg9OP/K5NOZ0Csbfy5yb6I6G67HUYojnbQ6sk2Ysp1xBSFvPasDfx6jIblHnQyFnKSOSKQ1Mj52a6JFraxPEQe5076PiFfgp6cXZTO5RJ5feLs12Lqj6rOlXw1pfrACD1pl1lQCJHys3xEZ4bL41jZsuQIeO59gUfHtrfMuMq3sDYXpMj/wjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWtXSI869hAyHi+DjzMNrNkIHZkoy5Fu0AmHyARowNY=;
 b=ZW4UNhu6UERcBDEHJghVVYnr5rMT/ObmucSc0q1PtPpRUJfaDGNMVFxMUcRe0Kzdre3zoQXkgG1MjrRc41kOy5A4B5KsXCqfF55UDu0/A2+ys9zPf6nZEgL4T+ILSxnKgjs/zG+uNv4Q2HNVuquU+MAc/ATApIgAD/nIwFF4KGRdkBI1HaSabgRaD1dnqWURmOkx6/5WqEqVVcZgJboijjGc5FXaqz/zJcIocIx1oD4tT6DOBXSIiXWQizCueUtKZLoM6pZZLrzOYV0uTUSjwOVLGUampETsEF4IlYV+f0N+S/gMxTJFgD4E4KSPgJnGrY5dbL5s+akNU8KBdsvIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWtXSI869hAyHi+DjzMNrNkIHZkoy5Fu0AmHyARowNY=;
 b=SiHu9E3TC2KylIBW+p1d4cCXKp4JNiE/wTHeI4A0p7m5UnK72PNPKMTEqQ8pzoqtFIEbRovmVzkOJKFulrJ8rllaetgJocyoGmw0L4GRcOOjGeIUOa22jPyQfwxJKs+rC31ZPREEBdJXaoPX0w3ChlTyegRSFyUqOqHJsAVCmTQ=
Received: from PS2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::29) by TYZPR03MB7867.apcprd03.prod.outlook.com
 (2603:1096:400:465::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:15:34 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::bf) by PS2PR01CA0041.outlook.office365.com
 (2603:1096:300:58::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 10:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 10:15:33 +0000
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.34; Mon, 4 Mar
 2024 18:15:30 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Mar 2024 18:15:30 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <YHCHuang@nuvoton.com>,
	<KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>,
	<wtli@nuvoton.com>, <scott6986@gmail.com>, <supercraig0719@gmail.com>,
	<dardar923@gmail.com>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Date: Mon, 4 Mar 2024 18:15:22 +0800
Message-ID: <20240304101523.538989-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304101523.538989-1-wtli@nuvoton.com>
References: <20240304101523.538989-1-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYZPR03MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0be985-4159-4da3-4f46-08dc3c34073b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bw42YUA9LzUQwyz8GN7t7MP5TbHrTutDWi6zZyuCBKV5mNX2nY+cGl4eg8GnFetdvyKo1gYXg9KISIWZc4IKvBBsko+y7jBSi4oXY5KD8Us6zaoWpy2mieiH9DvF/nJEa4zK1LnWPN/ALTqkpCNxEFy3IzfNTnoWyAmucgShtvs/VVNP2cidWwlqFS+rsBno7PY7pwVDtt2AKBhtbT0mYg8od3JN9q8me7H8kthOaKLWzw4jAysXROAwmpDjE06+lhwrusNlrEG5OVxo6pN7KtxmseWmgi/mOFCoMLSTUoEgiKMRP8azZ0qR0BkyUUagYyLmdjurlzUp1OP3xjrWAyaZ3EzXb6dJ1H/Pw6+Xh3N6J23fgQYSUMODnui17OJLWGr4cK9wa/vKB9olhujlbrfGfCWwMK+Sx+4Zwh3m6DFDPbOWYb6rbznZmbWxIhWpD7zfmu26kRwAFPu8sGcYq+EpGNs2zsiZr8vGPmfQwGLgvY5hUgeACUE+0FkOoxlumIIvQ6cUjnLMMZfDexT3j1OmsovhN4z43pkr19I27oAMr3sdAmSH+o1IsW8skiCv2ZojXQn2h3V2zupahoZFCrBYXPIMx0gvUYl5yjUF7dgWMNFkHlNRLww6DrydMCWPjX2eIEuqDGCrwzgACHcrFDcHHXPsuu7cJd83J9/y7zEnf/z+Qf823JxFUoat45umd3htwbnbmFzSA1ae6p9jHA==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:15:33.6592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0be985-4159-4da3-4f46-08dc3c34073b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7867

Added a DT schema for describing nau8325 audio amplifiers.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../bindings/sound/nuvoton,nau8325.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
new file mode 100755
index 000000000000..297d29462812
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NAU8325 audio Amplifier
+
+maintainers:
+  - Seven Lee <WTLI@nuvoton.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,nau8325
+
+  reg:
+    maxItems: 1
+
+  nuvoton,vref-impedance:
+    description:
+      VREF impedance selection.
+    enum: ["Open", "25kOhm", "125kOhm", "2.5kOhm"]
+
+
+  nuvoton,dac-vref:
+    description: DAC Reference Voltage Setting.
+    enum: ["External VDDA", "1.5V", "1.6V", "1.7V"]
+
+
+  nuvoton,alc-enable:
+    description:
+      Enable digital automatic level control (ALC) function.
+    type: boolean
+
+  nuvoton,clock-detection-disable:
+    description:
+      When clock detection is enabled, it will detect whether MCLK
+      and FS are within the range. MCLK range is from 2.048MHz to 24.576MHz.
+      FS range is from 8kHz to 96kHz. And also needs to detect the ratio
+      MCLK_SRC/LRCK of 256, 400 or 500, and needs to detect the BCLK
+      to make sure data is present. There needs to be at least 8 BCLK
+      cycles per Frame Sync.
+    type: boolean
+
+  nuvoton,clock-det-data:
+    description:
+      Request clock detection to require 2048 non-zero samples before enabling
+      the audio paths. If set then non-zero samples is required, otherwise it
+      doesn't matter.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@21 {
+            compatible = "nuvoton,nau8325";
+            reg = <0x21>;
+            nuvoton,vref-impedance = "125kOhm";
+            nuvoton,dac-vref = "1.6V";
+            nuvoton,alc-enable;
+            nuvoton,clock-det-data;
+        };
+    };
-- 
2.25.1


