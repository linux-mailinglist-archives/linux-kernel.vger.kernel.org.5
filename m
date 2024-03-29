Return-Path: <linux-kernel+bounces-124298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA7891542
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B5F1C22223
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03B38F91;
	Fri, 29 Mar 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="QxLv67bo"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3428DA7;
	Fri, 29 Mar 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702458; cv=fail; b=PF1jxoSEMv9wW5QHcOb0CTHguZLeu9fTG3WqCCaWxdWPXdJmcQKCJT9sC78aXBykJsqrruaw7vTF7hsT5cPcGuGDv1Se9K0IWq3t0o0Vjy7LPHyuhBs3w8rlRVdi3fVy2nFeNcS+XJMA8IueFBK8pHS07t4T804GkMO4awFezNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702458; c=relaxed/simple;
	bh=YznkdrzJNBztvQ19tSWo4G0cjF01out7JwU3C2Bg+bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jaa8VPF0fvjQBCrAnxX/JFGiq4qKx2beIw4wVHv36XG4q5xabJSSKOfzXVXOluP1o0svMM1wIXRZhsau9pDXjllwJTNtAThA5Zet/NY9UEXx1RQhMz4oq/CjNdGy+7TuNTifD2a/Q/kisC1uG/fZg7gUnQB2vwTCdjzUdPQBtN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=QxLv67bo; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY6Q9iDHMrLN+lF1zjiZR23eWq1YMijuNqBl9cSNOp4pYUrJdNNr0FAyO2Xf4c9OoLcLNEWkfaqjDmWIH115mQB47iPsaIt9J67cUKv0V/7SgQ9SZ+rxhTqocNDDuCxoFGhtlNymQA8nPU9Gqh2NBUFXaT01ZqMHdtlofggxgS0unv7And9uK0ATAitA5nnm7n5VUHWVpkxxbMpJ/Xoa5NkJeNQYE24/TAVLqqAk2rE+h1gqBPJQJljY+fL2Q8BAWnOJz8d9d76uvat+x9ACvXMIZNzxkGTzbovBwPo7BG3237qvgq2yq04Nrv6vHhwXMiByziU2AxIDrB9iP7BKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZd9sb/j3Cb8rNFsmXWT5+1usPmgsP11NlpIVnOcYLM=;
 b=PthOBTSVxsmC/GbA6KnWTWhdz8it7Yr7xVsWKoWYft6proKSII1KUIK3XtG+hRjKjEbeTxnNUUVIw2WT8NBanZ/LWIRqFLTePJSGxTi+zPExPldmY4cDqmBNDU1iX6T/Q9Llp8hTueyKCzBN/gjWWCgF8HiNk9+bHc9LUjva5J1hRravAml9O2N6IxOGyqwSEVFLgZSPHLNx39Z/dn3aR5HvyIkU7FQzFzj0oqGV+Wf3kuGE6Le9EHXbx8tJ5QVhkwu1sm2qVu0WM04TqsreN/mLSKedwBQnrjttoDlgCFlRB1H4CGZkDx12lbjeBKtA/EdVy79T4zHJjOSgos/vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZd9sb/j3Cb8rNFsmXWT5+1usPmgsP11NlpIVnOcYLM=;
 b=QxLv67bo7PEYJ2IlpFElV6SKj5cEknhPIhumbmM2g1z2qSVJZI0dQJRiP0YbZs9ANWTNoEvWpC2ecu/JnqZAXkdRvs3dVOj3ps/WmBjbUGQEWc10A1PdpfY+NisPe8qo2ukWonPS9laxN/Iq8ruzltwfQFbIWceMyalIOjegXmk=
Received: from PS1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::30) by TY0PR03MB6999.apcprd03.prod.outlook.com
 (2603:1096:400:266::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 08:54:12 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:75:cafe::fb) by PS1PR01CA0018.outlook.office365.com
 (2603:1096:300:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 08:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 08:54:11 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Mar
 2024 16:54:09 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 29 Mar 2024 16:54:09 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>,
	<CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>,
	<scott6986@gmail.com>, <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v6 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Date: Fri, 29 Mar 2024 16:54:01 +0800
Message-ID: <20240329085402.3424749-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329085402.3424749-1-wtli@nuvoton.com>
References: <20240329085402.3424749-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TY0PR03MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 963b2874-95b7-404b-d978-08dc4fcdcd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1KlVbBWceuWhfZh5tpxgJEs+Hdgnyffv9tIdAv+NvJ5mVzt/ItmiJPFZz5cq6ZmYNxel4Vt0ndOZJZDgmtslasBBp3W65Wjw9NTTD3mS6pNDLIN+3C6tGxPzNU8HzPslNlG/t5tz3LNiDECieeIWb1lJXLgzk8li966TtkrywHVS8tAPOJP/eWnFMrakPHFaWB2tiGdXhRId9DNexFwFdOPGJ/wqb5NYssX9DjSZovv685hkTzYwHs9h9/2hWAspmXHRFuRTW7aWK0jEloTk7VpFnL4zpSg835TMOFXFld2eSf8ezXjtpAaxAzjwCmkdn8QvxldWktQzNcFDW1VYTeNUSaURQZkY6pYWDaczg+eG+dXY7nRcdFdbE1RQ1aMoYQ5db/lj0BboE5iBcao+vgnkUDIsVk4qh6dHOhuDa+Gxf7sVpIadfEYyyTRqyCtYbwfMGxnxn4B6YQJ51c4DcC3qDEd/W0q/YGVkWnNi1+ySYqRwltbht4EBGO0hAb+OZS8UNlLtrny0t5zvMs7BAGFz5WSCiRcldu76ANDFARpOYSQHplGaPvlB5KgMctCB/O/3nIRmqUX6zsZRJIXostwAPUMAjUmkP9shRtHSyaihIv2KIIhMQoL3GrH0cBZabwwx30LR+kIXrNCTaMeJiIaLcaeU0cBAJepbP/SL5KaWEdpIj9R24yzptCez/nI+e0B2/NG3dJue6ExIK64XgQ==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 08:54:11.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963b2874-95b7-404b-d978-08dc4fcdcd69
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6999

Add a DT schema for describing nau8325 audio amplifiers. The key features
are as follows:
  - Low SPK_VDD Quiescent Current
  - Gain Setting with 2-wire interface
  - Powerful Stereo Class-D Amplifier
  - Low Output Noise
  - Low Current Shutdown Mode
  - Click-and Pop Suppression

More resources :
https://www.nuvoton.com/products/smart-home-audio/audio-amplifiers/class-d-series/nau8325yg/

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../bindings/sound/nuvoton,nau8325.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
new file mode 100644
index 000000000000..979be0d336da
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
@@ -0,0 +1,80 @@
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
+  nuvoton,vref-impedance-ohms:
+    description:
+      The vref impedance to be used in ohms. Middle of voltage enables
+      Tie-Off selection options. Due to the high impedance of the VREF
+      pin, it is important to use a low-leakage capacitor.
+
+    enum: [0, 25000, 125000, 2500]
+
+  nuvoton,dac-vref-microvolt:
+    description:
+      The DAC vref to be used in voltage. DAC reference voltage setting. Can
+      be used for minor tuning of the output level. Since the VDDA is range
+      between 1.62 to 1.98 voltage, the typical value for design is 1.8V. After
+      the minor tuning, the final microvolt are as the below.
+
+    enum: [1800000, 2700000, 2880000, 3060000]
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
+            nuvoton,vref-impedance-ohms = <125000>;
+            nuvoton,dac-vref-microvolt = <2880000>;
+            nuvoton,alc-enable;
+            nuvoton,clock-det-data;
+        };
+    };
-- 
2.25.1


