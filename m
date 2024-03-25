Return-Path: <linux-kernel+bounces-116871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810E88A497
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7A1F3F07F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710991C230D;
	Mon, 25 Mar 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtYcQwPL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453118C9D2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363721; cv=none; b=eHJL2Iis/4U+r73Vep3Ibr5OuaWBTUxRXCUUiWwtIl134YO8obxDSgf6Qi1SAZ8nRMuWcjxRUeFoI8VupuCpoz2Xew99ee0AKUBCyu/ciud8iMp5xJh1q1asFxkUjWWabM6wu7ThYnaRQGYHoJi3wyhYNw+Ug81sSSiTIa5hvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363721; c=relaxed/simple;
	bh=tla5/GdjKrTPP+kJAYRZ8KGODm6wDmTDoyN5IPNwwlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqZ702+k8nFwOVfoPlGWmjP85mCBSz9jcxo+n2qKUa5M1p/1mCRYuLapf9on4M62wWN87GylWILuxaUbzyWDKSXnVhVU2uW0bzLf3ay2UHXcBxQ4g7r9BC+V3jpSceWd3qXEatUuN4wdtzixkdeBgIeZALUNUobshew5J7yMFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtYcQwPL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d212f818so4702449e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363717; x=1711968517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GdyAlHz63fHy0CpLlEnn3btu6ypzjd0jIMH561mJYbY=;
        b=JtYcQwPLu/QShMcY128A/xlyxrRh9nALSE1NocBrHjhQXOHkBpuOeqXqlnnLfVqs5/
         9gDogpn7E/z4YLfKgfBP2unYjELm4o/NZEh+/a469isJ7HNN4lD7pqhD2sD/iTC0k7bM
         GMFBhvgWAy0wNCFBz/pM4Z9UA5cnl8Fc0njyMnEpMkEDDJrbUDlz/eZO1+5V65kNlpsY
         wQlbOO6cKzmEM2hp1nJv+Wd7uYpKm6FzdRPT6D8CNysJj3NE9c0l/Cv915FB+9AS9F8p
         YMMJBaLGOH7gq6Rtsi5kX2Spmcun6z/LUNJawAs6KGmFzIUyjzn7gcC6yiRkVQ2SRQCq
         QseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363717; x=1711968517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdyAlHz63fHy0CpLlEnn3btu6ypzjd0jIMH561mJYbY=;
        b=XMZw8UAodW78+tGPCqPXA1SYCyNZotoUU0HPNdnf1eBnZwwRhEl7MQ4i+/Ae8HKogK
         qGknTN4umeAcpVOBAzEhpBXtaB7Xm3rJu2fZTHWbO5IdE44gyx+4AZdflG8PvANuOdu9
         WBTHews3mrgD1yI5sBwMahYyO8bM0y7PmLF86xa6H8vebiwwl82xWSbZBm59ef1lHt1A
         +zA8PXvghhlN8mx4pmLJgiZxxb3JUBjMg4Mu6IwTWQGFvmrHSI5nkvXig0642pnPkmft
         9PApavkX4Ci1QVaGVfg//J1SaL9G7shPXtIQzx7mSBcghEoxNe+khgKAgW6Tp1I1d6Cz
         0zvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEOWk6BukEYYku9b5azzmXuG7SLP9wkAk3MzXoyr6FM05JN4Z2Oiazyc961XzYsG3XyBWIE2mVfe1EeBlQ3qJhl0KRTrQHO22a6BZ+
X-Gm-Message-State: AOJu0Yz2RtTJWV17X+H38ohoodf31eaJk+vZCQYtM+DSHNyKmWVoBnqe
	q62ZUZSKCUgXmDbIzl7w5MB9Vr6teznB/NdFtHYKbUNsgssIAV/3gZTpLhMNMZ0=
X-Google-Smtp-Source: AGHT+IEtwhIbYV6Dwdb3Hs6WgP/TgyCYhQ1U7xeEJW156UNlPksk5MnUlGzwXG2IL7SeXUvQg/yLUQ==
X-Received: by 2002:a19:8c56:0:b0:513:c9ea:67 with SMTP id i22-20020a198c56000000b00513c9ea0067mr4160794lfj.24.1711363717293;
        Mon, 25 Mar 2024 03:48:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id df15-20020a05640230af00b00568d6a20717sm2859339edb.52.2024.03.25.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:48:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: soc: fsl: narrow regex for unit address to hex numbers
Date: Mon, 25 Mar 2024 11:48:32 +0100
Message-Id: <20240325104833.33372-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regular expression used to match the unit address part should not allow
non-hex numbers.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

v2: No changes
---
 .../devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml        | 2 +-
 .../devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index 397f75909b20..ce1a6505eb51 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -51,7 +51,7 @@ properties:
   ranges: true
 
 patternProperties:
-  "^clock-controller@[0-9a-z]+$":
+  "^clock-controller@[0-9a-f]+$":
     $ref: /schemas/clock/fsl,flexspi-clock.yaml#
 
 required:
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
index 8d088b5fe823..a6a511b00a12 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
@@ -41,7 +41,7 @@ properties:
   ranges: true
 
 patternProperties:
-  "^interrupt-controller@[a-z0-9]+$":
+  "^interrupt-controller@[a-f0-9]+$":
     $ref: /schemas/interrupt-controller/fsl,ls-extirq.yaml#
 
 required:
-- 
2.34.1


