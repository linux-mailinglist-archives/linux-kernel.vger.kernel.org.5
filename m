Return-Path: <linux-kernel+bounces-120582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAA88D9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1981C276C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77880376F5;
	Wed, 27 Mar 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lz4iTux/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D93418B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529709; cv=none; b=rKgwnSovSGDdbzfT/rXvpZTnP+njaYcoAVE8awjVu9+SkRPKOwhIwr1t7+6xdkl27jZtakikr+tNv7bmM77vTAKojZoWmurJIfrcjY/bTNCwyQKUwn9M+eQQ34/AtfoWIfI/pyICV4NN+aWYZfWYMND3ygR7jWbyEzPyoSvllPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529709; c=relaxed/simple;
	bh=eD2FnmLx+X21p+zCd5l4yY/sDK9AVd2VRkFA39qHz8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZOL6VNZa36xRqdKlJQjouZ7NUAmpa1EyyGwh8+DtF92bu4CQZU2adGR1+OBg5TFiowAM1J3T9su96O+8JTa1edcAhHfbO9yr2y15K/ZsUQaK3f35gTrglUP3k/ZB+0VSqYEHcFJY6UO4jiWmDgtKRxiTZgPkDLUAbat22tKr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lz4iTux/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so4588028b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711529707; x=1712134507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dKcZjC/OoDiaM+OdJQAME/VGMT+Uf23GJ2KQctLAZo=;
        b=Lz4iTux/eSh0rfnIqiyh71E62M29pcVk9fdBjaA+/7Jw4YStG2UZQzlF+ZJ1Ozzo/h
         M8Xai5gBewu4FvG+4+AA7Zg28o5V9YXW4kpVvwNipiNZFn7WDeTGSHylbQC46q57mDBb
         ff9e307/mtR2sH2baKOsVXBguVQK4yE2s2Bes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529707; x=1712134507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dKcZjC/OoDiaM+OdJQAME/VGMT+Uf23GJ2KQctLAZo=;
        b=URkL951Qygf408AsFBZQV1JKw26Cr1iKykhkt4IxUDwMNRgS/A1eITfgut2iupbPxV
         wG3Iz+YObbRB+06fKxoLp7JG28N3dXOz5y34k36qu5bPqEHt9yH8N3PQ593HX7N1m9h/
         MytF1wfkE56KHGATlDXdws3WkVJk7018t7LZqtk8QX0dp5ZUrkUX3EUf0LjWa5BBXt+I
         tmqd2NFJQuu5+4m0IQag+Mx57zrNzs3gwh0K34GcpGaeS8LWIqEM5xZODNBQSiJ2R6G7
         MYkwXxZNAEbp7py63zsomhn13gbLvMbE1e0WbmjbDfr/gqwrLm2SceZvRPZkyjPbhH6X
         j6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUuMxvZftdCYmaj4Zo2QrYFk6+nFyNSir2Ddr6BBVC//QCrh/oQb5ATGh2SFzewdn/iCNU6TUAsqPpPlQUuxbITL3eliPUWiQ2nD2pA
X-Gm-Message-State: AOJu0Yxx6IGNIDjVm3cjr9vMzPbkYR7EZwqwKbRhmgm+uKxCaNvw/79s
	3pnUIjrQG8ECJ/xFje9Po8tqzq+aUf0gx3Pio2StrEglzzoBE1haCjRWhakO0A==
X-Google-Smtp-Source: AGHT+IFUfIVQvdLysyZn334SAY0D7Vx2KrUYwFkbjwbnUAsEt/qwEP0DXbUtpROi/ojeOIlZdyTbcw==
X-Received: by 2002:a05:6a00:b48:b0:6e6:946b:a983 with SMTP id p8-20020a056a000b4800b006e6946ba983mr4563684pfo.10.1711529706853;
        Wed, 27 Mar 2024 01:55:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74c2:3606:170b:52f3])
        by smtp.gmail.com with ESMTPSA id h7-20020aa79f47000000b006e724ccdc3esm7329514pfr.55.2024.03.27.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:55:06 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: bridge: it6505: Add #sound-dai-cells
Date: Wed, 27 Mar 2024 16:52:48 +0800
Message-ID: <20240327085250.3427496-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE IT6505 display bridge can take one I2S input and transmit it
over the DisplayPort link.

Add #sound-dai-cells (= 0) to the binding for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1 [1]:
- Reference /schemas/sound/dai-common.yaml
- Change "additionalProperties: false" to "unevaluatedProperties: false"

The driver side changes [2] are still being worked on.

[1] https://lore.kernel.org/dri-devel/20240126073511.2708574-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-arm-kernel/20230730180803.22570-4-jiaxin.yu@mediatek.com/
---
 .../devicetree/bindings/display/bridge/ite,it6505.yaml    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
index c9a882ee6d98..c4469f463978 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
@@ -9,6 +9,9 @@ title: ITE it6505
 maintainers:
   - Allen Chen <allen.chen@ite.com.tw>
 
+allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
+
 description: |
   The IT6505 is a high-performance DisplayPort 1.1a transmitter,
   fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications.
@@ -52,6 +55,9 @@ properties:
     maxItems: 1
     description: extcon specifier for the Power Delivery
 
+  "#sound-dai-cells":
+    const: 0
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -105,7 +111,7 @@ required:
   - extcon
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
-- 
2.44.0.396.g6e790dbe36-goog


