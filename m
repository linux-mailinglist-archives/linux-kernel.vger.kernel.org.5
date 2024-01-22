Return-Path: <linux-kernel+bounces-32678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A049835EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6B31C22D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD139FD5;
	Mon, 22 Jan 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="CoG45rmC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C439AF6;
	Mon, 22 Jan 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917423; cv=fail; b=eNeTxgYbmg49Ub2MiEGiFvEz2qu2F9Oh1OVHSB+qpjw8DrosEiSsMn9CUpJwLvq2JNeY9mhCxQ2sFb3sTgQnWZErjTYHr/tCxHcF8P3QL6LmoKoYxJXCdPrIIpT/dp82kEwgAQicLC8gIijjQrT4otW+uINBhQTKkB6VmbHU1xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917423; c=relaxed/simple;
	bh=Cw9LUkWqLf+p1uKjSB6kqijldO/4Y5vSJRZpg7KwLXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sla+1Y6rd99LX25SJ1CIM7exLmODWzLZtn58lXwrakE1JOrYsHg8gbi8ptcAbJuc7X62RVNBqPzzPIVrThSN2Tl5beVve+CgWkAHgpKqNU/XPkEjis7h1l7c03wxZR+i5Rs18zVS/UpBpqP70VaTdT4DMN+aZu/QkMSkTp/MKLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=CoG45rmC; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyoArDNsQRO4a2W2AydXCQ3ddJHod+VyiFI1EObjJ/QTaTGQPDSeBGxn5TWEFh1zKRQypZgKj+7Q8KP99PrekZyN9VvMfZMzPEeGUvpGyRULgIFQBtsTtic3z+DB721O8RscBhxrCQu0mBUF6SM8/+dWWc0v3kzD6DJ7E0mOD7uRLVeikPsGsrxHqj3OtyVhW3tBuV41CXNT4v7X/mFeJPt1P8+HZczoJhXJkuphLi2k6pK1sGs3Yf657rlTswk7yiEw5F6AbgPvpeFuCOwt4srs4E0qfqbp3NXCixD84r7vQot7xESeptzKXyffdN70AhHrDaDp+VTw3t/pxA5yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7VRYe0I3IM6rlKllm7eKeJGfoggF+J4EvaHVLxshLg=;
 b=lOcacH9nx6+0+7QFjv9aBcJPf6E7D9GTZTDrvgZHSnBpcBbrjCp85HZLehKYNhX96ud9cKpVmoFj0t3d8lMZijxTvuJk3cRsuFkRQWQTBaiOXU+/bvlFPOYAdINLhabpxosNIIyKD23TI8Jrt+cY4XYZNGmllUUzLEE7LExWyLwrDVqGAx2TgDRddOWShD6hb3Y8bBYyRSxSw7SKKHZxrsIyP4v/17XhUGvJLhB3djMVbb3xXIKoYRavJbK/0nidCKOnRYCRu00n82ywi5jX+ALP/8cBxrFFySOVkwIqRqiwD3b3/NpcaDfiNWtVtpb/uqBrmN5d1cZNkrr1XZwNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7VRYe0I3IM6rlKllm7eKeJGfoggF+J4EvaHVLxshLg=;
 b=CoG45rmCSSoPRn3cprBdZ4eQYRatuNt6P8UwQjJThabBs4XSslemOMnbnFxIu5ODSVFz7pMWwKm/ftW7GeFmWrMxUH1iy8z1TUnrZfuoF11h1P/qBF3N1F9VkWaAmjacGgkp566qjdh0c7iWT8DHamD6ZVV412HhOK/paZRz5R0=
Received: from SI1PR02CA0044.apcprd02.prod.outlook.com (2603:1096:4:1f6::6) by
 SI2PR03MB7261.apcprd03.prod.outlook.com (2603:1096:4:1bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 09:56:56 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::71) by SI1PR02CA0044.outlook.office365.com
 (2603:1096:4:1f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 09:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 09:56:55 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 Jan
 2024 17:56:53 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 22 Jan
 2024 17:56:53 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 22 Jan 2024 17:56:53 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <YHCHuang@nuvoton.com>,
	<KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>,
	<wtli@nuvoton.com>, <scott6986@gmail.com>, <supercraig0719@gmail.com>,
	<dardar923@gmail.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Date: Mon, 22 Jan 2024 17:56:49 +0800
Message-ID: <20240122095650.60523-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI2PR03MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f51fdcc-5198-4e59-059d-08dc1b3077b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAG2AztBZ4c6e56rfSAm0FQ1F4C2VE6UokutDdp1xqUYjp61I34JWU0hMVHV0KdijCqCS70p8LmFZJgXNKcuoHD6KIbIrqZXT3hTGBm5Bm/cJBZMhklFdACr2AEI/VEArpJoT9hQtmi0/14CyEi9FY2ix4OR0yunY0tcUVtnKzNCfRd1kqb7YX3wOW7d42yo8wwXyDNnPBbC5QwNdldKBA83wMOn7teJ4pB91kcuKijnFevEtpwF9mLQmj7iPWXIvnFoz97PvkmepjGUnKAOKlE5nD1gmFR4NpA6o1gEVIoPBhkvPEkrS+4sfcLBQvj/U9XRpXbGas0sl5FfOZ/ZKZdyZ0VhJcs6rTtbRyWd8Ab4117911qs/L2j5ChI9LWVWDfSeFBRHX+pp5shyCqPD879FY5QVTpACJATjprPOtos95Hk8VoO3qlwvaA9FX6LPxLIekSQBPVJXwebOLc8i14uk24OWDRb8U5uGjkWEQJcG/O6sP+Xf2derFJzJRvLp7Db33fc64CcF4M9DyYF3a7hkLIFpxULNpklY2ur8g8LDCgjhY1KD/ISGDYqC3kE7wcfn2eCns4M5NYxCY/wQrjKt7zk4+YqjlvEQVPtkqEqaLaAerWv73dPvvQyY+dfoEVxdcs7OxefU4oHko1IPgtS7Ct1gld9Vf/deIzYeOBhiUFXdesxkjX39t7YHQG7+ngT6WW5H7kfwUWRsfRF0as5z6WAE8Sw53zfc7DxZhU=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(6666004)(426003)(2616005)(1076003)(26005)(356005)(82740400003)(86362001)(81166007)(36756003)(41300700001)(83380400001)(36860700001)(47076005)(5660300002)(7416002)(2906002)(478600001)(966005)(70206006)(4326008)(8936002)(8676002)(70586007)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:56:55.9471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f51fdcc-5198-4e59-059d-08dc1b3077b6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB7261

Added a DT schema for describing nau8325 audio amplifiers.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../bindings/sound/nuvoton,nau8325.yaml       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
new file mode 100644
index 000000000000..9105985357aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
@@ -0,0 +1,82 @@
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VREF impedance selection.
+    enum:
+      - 0 # Open
+      - 1 # 25kOhm
+      - 2 # 125kOhm
+      - 3 # 2.5kOhm
+    default: 2
+
+  nuvoton,dac-vref:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DAC Reference Voltage Setting.
+    enum:
+      - 0 # VDDA
+      - 1 # VDDA*1.5/1.8V
+      - 2 # VDDA*1.6/1.8V
+      - 3 # VDDA*1.7/1.8V
+    default: 2
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
+      FS range is from 8kHz to 96kHz.
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
+            nuvoton,vref-impedance = <2>;
+            nuvoton,dac-vref = <2>;
+            nuvoton,alc-enable;
+            nuvoton,clock-det-data;
+        };
+    };
-- 
2.25.1


