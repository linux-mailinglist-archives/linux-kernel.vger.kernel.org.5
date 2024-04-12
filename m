Return-Path: <linux-kernel+bounces-142503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA48A2C86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CCC1F2423F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3A43AC0;
	Fri, 12 Apr 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="f/y3/o+O"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798D1CAA3;
	Fri, 12 Apr 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918168; cv=fail; b=QRU/NGY4XCwQlX7F3X+FzyZifum0T8Mq5rfc2nHZz6EF8kjLXhkhTx7UKnkSK0FtnkwPSzALj4Ql3jAU9EJjRiTVxb1Tzm94Yrm+PxwC/AxuJ2TLGkVwm4UxmBTqYZS7neiVXbIy7CgCVaBAi4cPx6k7xx5T3/qxy7qxxXr1lOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918168; c=relaxed/simple;
	bh=6S416KwxLfCtEeZ6OyMeopnp0v2WlooLPqk1tgImJgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcfSkBVdynOENq5e9B3bFsLc42dlJsyjOQimYJtSBJdS6BSK1126p7Nrz/ej3wtk2ykY/R6j6Bkfa2hu6eaSshM9ki4iTDd9Ue2TFIeMuXNT2c9x28jQnGLDeuAphpkZdQMY0R+bEc0OV5Wss4TKTIRRwKMCUD10dBerRKZTw6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=f/y3/o+O; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKImd7XeZh/fBOwxLz5MHI6E1T97lGnWmPvl+OZl6xbBoNKK3qqq2fzr+de7zoKbwR1zWI/cFsSd0OIQjsoN8yXBbWlS6IimD7bQo7bt7cOeWG5rmJVrPBgp1wP14rctqYGEiIVPbQOQ2twoAKzf80SpwyCd8LLCuwkvtTyEgxi0J9Iy9V/KUxSM/t0smu1oOO15olkT5Th2WixnwwY4oSppGkTw0+L9chrwWE7zJ+yKOWHnTNB1Lxzc3MmGiKjvJjdN//zt2OsXHVRNTB+g0OmV4WkO0p9Y6u46MnvGGcDtJtmPvjHSm0gfEfeWeGDF2KvqySpPfzkzJMcGbHL01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUvrX9jrmtMjpHmz6D8VLu5LDN7o/EHtoES/dsqqc4o=;
 b=d+CkUYipw1S/5dmrLsw868rGaWs8yjSMLwR1A6GF/XY9qv5uHM6+ujoHeHtLCExuQDRM/37YJM2woGte3bUNbq5tE0ehnTUuC7N5g20zoHaavNAMaW2UrcdhHJn/8GmJVZVUINkqh4AVprWpHwmEX9Aiw43U83RTEpgjcYePGmIHOTCuw2bUatNDzBBO6UuGOgns2o5IDwxd4mB2XfS5TgxIR4dChrrqeo624pCPoBS2sd0si3J1VONgeLzXQNHkCJrpU9SzDR1pSUUi2zpo2+ziAeTIvs3dkS/sC5hnYfswNh3+AhwOQoiHvGiYFEti2g90S4mNdsBOag8nuqZ9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUvrX9jrmtMjpHmz6D8VLu5LDN7o/EHtoES/dsqqc4o=;
 b=f/y3/o+O6NZqBha72xpiztySIv0B/HIl5kTTMi6Mu7IZUyZc8I9HlQXTf61IPJ1GMCV+ER4OdRWBjeM0h5MMABdfjdXHpajIWF1tLxCR/TiVnSI5yUazVZgwPQt44jY+lZkaqX/eeAoqhOzWDZJxGfCKopF1qnT2EMCfdK3TwmM=
Received: from SG2PR02CA0035.apcprd02.prod.outlook.com (2603:1096:3:18::23) by
 TY0PR03MB6536.apcprd03.prod.outlook.com (2603:1096:400:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:36:00 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::57) by SG2PR02CA0035.outlook.office365.com
 (2603:1096:3:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 10:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 10:36:00 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 Apr
 2024 18:35:55 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 12 Apr
 2024 18:35:55 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 12 Apr 2024 18:35:55 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>,
	<CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>,
	<scott6986@gmail.com>, <supercraig0719@gmail.com>, <dardar923@gmail.com>,
	<edson.drosdeck@gmail.com>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] ASoC: dt-bindings: nau8821: Add delay control for ADC
Date: Fri, 12 Apr 2024 18:35:52 +0800
Message-ID: <20240412103554.3487290-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|TY0PR03MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: a69cfc3b-137e-494e-0841-08dc5adc586a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p6jPcI/C54wRH3dO005Ca9wMFQ91G1IjHTLgq1B1oIKZtUqaPrMLnhJAC/dJuWKYCXCbS25yARR0M6tvbQKzTMrFVzAxXIFLE3mTHgmp2wdAbAQlDtMIYSUf155hRGXpucvTZaVkfJZnwTon5DpuWQjaV5GnrjDdEUtuCKzvm1NQs7RrVoulMKfzCZ7ODcq4Y8Qd7MH0fNEzt574J9ihJ7S+Fd/w2pgRSvayHDaag9TX05NFTm9m2Je1O424YCvZmtr9YwXxU871AKepabRxFw9sbx2dFQ90hN887a2bse0EA3gYYwvOjSTz9HjE5qvnk0Up6tjp8WmbumCfKB8uTXli2j+D/QW5LwSS/0nP7ts44der6lH7HPkpxhr4DW0lpMoTsNjFxGtXsfiYEEBUGPiDhzinZS+vbhRWnNLXvUjpxHDfJWksspXy7kTcFIiv0cAjoOn/T5Mt4qORQDzFTQSjiNEiEcTJLlYc/1DhAHorV5PtCMv8+a90hUprERgwHWFJcJFIHlg47HIMeZMR7VH/GTa6cDzm5chfGsL5jYs3S/1MLFdc3TGn++9wt0Gki5sK4460bpne22AEhK+GMwYrBP83JWFxpJ14NZJ0Bueck67otWBUVJrlqY+A8EwG6nEHOFT/kzghrPneq3QGJzEAqXnp4frTL1G2bBiFQBuG7yVIJf1rC8vmj0q3VdifCYRqb0cIhW/tXSS+Zs4k1ZA/VPGTuYcFUEMFgvaThHjRFtk8A7h5sLr/AvAb5krI
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:36:00.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69cfc3b-137e-494e-0841-08dc5adc586a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6536

Change the original fixed delay to the assignment from the property. It
will make it more flexible to different platforms to avoid pop noise at
the beginning of recording.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index 054b53954ac3..a726c5a9b067 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -103,6 +103,13 @@ properties:
         just limited to the left adc for design demand.
     type: boolean
 
+  nuvoton,adc-delay-ms:
+    description: Delay (in ms) to make input path stable and avoid pop noise.
+        The default value is 125 and range between 125 to 500 ms.
+    minimum: 125
+    maximum: 500
+    default: 125
+
   '#sound-dai-cells':
     const: 0
 
@@ -136,6 +143,7 @@ examples:
             nuvoton,jack-eject-debounce = <0>;
             nuvoton,dmic-clk-threshold = <3072000>;
             nuvoton,dmic-slew-rate = <0>;
+            nuvoton,nuvoton,adc-delay-ms = <125>;
             #sound-dai-cells = <0>;
         };
     };
-- 
2.25.1


