Return-Path: <linux-kernel+bounces-120488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D488D841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F65F1F2AED3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4224BA88;
	Wed, 27 Mar 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="XajhCg87"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96116482FC;
	Wed, 27 Mar 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526286; cv=fail; b=n6+HTN/f0GWgSuKWEp/ElTtK7NerDeQ9nIcJsWrdc+pU2MPHXURg8qP8tFIFJg5QhMfqyQQn60fGPvii+lbVZWExNUNz5A14d6R9hDGNE5DzNZxcPEzobJ2NONk0lJfM3BhhAZSLj/xTHWM9pRJi2P2OS+y58gNkSfxslDxh4hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526286; c=relaxed/simple;
	bh=YznkdrzJNBztvQ19tSWo4G0cjF01out7JwU3C2Bg+bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK3CuXSzixsvvTLy6b+/HLYR1OsHU5HpMPnKMSkYpR472dL1cyVabQAG7T5ydAHk2w86xkqQvopbxkKhZYPOe1c461PTMd2zgjPDM8JSuy0QZJzBkpt4lXwuqEVxM+IEOM/4Cl+kA9en//Ifqf0PPvjf77+HQU6cmVwWs6u9n08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=XajhCg87; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSlN56ZUcN9hJva0og3T+alnAlG02LIH0xcCDWOgu2O3fciS9ulugZK3OQOic/bxVTQ7BzfVfnrZO5C9p6OwA3Thus6lFNsh/M7Ct84Q5V2GBhny80x24kpYLUIajMR8tewErwn7exc7eYJBr4FcslqwC95fjFd+gDUetmLoYrRBMNn8oHaRqtHOFLtb7uuYhEV0XSBQ5aUQC9HY9MAZE6qbExouImuDNG29xzhS766Ui80wWguqMTWFI41muMjuntFnHw9Xj7J04ok1TpAn0UZ1LMuOCHRn/u0nHx/wUix3LJqlsDxc75WOAkGZjYGLdI2VfOhyKQ1oOivMwCRG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZd9sb/j3Cb8rNFsmXWT5+1usPmgsP11NlpIVnOcYLM=;
 b=UIV6D9/CTD0nUfYqunxrcvaMawoUT2STiYEOpsdM7pMRtfuKogg2LrqODDbW9HqFlz8I6IK/RhvUYjxag2NOaPwUMF8xM7XjfusCff8wZZmXuIxU5vX4CIw39i1tftKBjbTlFJnnM2AbB9wNrnt6nprFAA37QugQDdBDNluqGdHQCkwqxIa874N+P3+YtS4IhIMbMM+4osGm0g/fw0bkH/BW4DyDDclC0/jtzrpaKQCxV+/BxF7FFntQnZomzgnLcSPVW6fLrSpHE7qkGX+mg98U6jm603SuiFHoss6asuqdsracHVswKSaRz+hu1u1raPFyPuxU19w/QGKNSV1fCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZd9sb/j3Cb8rNFsmXWT5+1usPmgsP11NlpIVnOcYLM=;
 b=XajhCg87+BZA4k6oxQreNDhXVyOw3WL8bm9RBoKsEGSYRHyX9pAQ+/dwZkyjgKWEsrOfFBma+ExEp+xvh8/r80JmXVlrAylDQO28fTIbn3lDFTWnaWcKSj1/4qorJQoROEHeBiirGhFcewWS99rBf0Gr2CRropBcrId6o7gw/vA=
Received: from SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) by
 JH0PR03MB7855.apcprd03.prod.outlook.com (2603:1096:990:2d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Wed, 27 Mar 2024 07:58:00 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:0:cafe::82) by SG2PR04CA0158.outlook.office365.com
 (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 07:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 07:58:00 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Mar
 2024 15:57:58 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 27 Mar
 2024 15:57:58 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Mar 2024 15:57:58 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>,
	<CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>,
	<scott6986@gmail.com>, <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v5 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Date: Wed, 27 Mar 2024 15:57:54 +0800
Message-ID: <20240327075755.3410381-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327075755.3410381-1-wtli@nuvoton.com>
References: <20240327075755.3410381-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|JH0PR03MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 75314a56-1713-43ce-774f-08dc4e339f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mDUH+0jFBaqPLAuMAv7TwqHBzKJ0MDzLwTya0DqFU1crVGyH7te+x8SJMrCIs0JUuvvYNPPLVW88zbg47c0AOEaT6mJPs05s1wtgPlZgB+MszdcwRg/Jxu61wDBjQ1pltubOcsLT68e/sF0dK+bnFYjftUZT2/5/YQWpBkMlr+bzVH4rNIRM/3HjHZr1NR9uolQ8uBG6mcqnOjNCq/qxwhKfgj0ZGJ2vablWaGzIri1K5F6XbeEqPZ9/y0jLR1ixs6r0E5Dfrrej6IF3iqen8ZM7SrsLRis0NI/98SL+7rqyseNeECFvEzJkv55mIRcKbuC2ba4vkOQVtjDGo8XFYCoK/3HPg9iS5ITO1ife9v9ZgkuRl43EInUsm3d94mhfXtl6VeBrJKrfctFH27wLv89Ao8EExZ3jscufc470hXTn/wqr3GQFqptGkXnflWLp9oeqpHco4aWa3pkSzidPjmCVxDPHaaobnUsuOH6cfSwQBQ/oPrTwp/U6adBz1RuMRlveXvWRGWqzK6fruRGcBdvSHaE7H6KgcVE70C3j7NLj83BeqV+vXsbaRCfhNWqbHwwnnVeaN9N7bNTpf0x4+WQdWeAETYn0VFI05uxCfL9w7XhbZuiOUNlmHvg1kmzOX9s/+7ReRTuhllgm2hxHZ0ZQ+sr2+9ickHSWfd6e2044B3vskFfqEk5Q8RPdaVsN3QxjLx/pgdi1EtqAxSUVgQ==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:58:00.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75314a56-1713-43ce-774f-08dc4e339f8e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7855

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


