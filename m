Return-Path: <linux-kernel+bounces-34917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA083892F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE41C250A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246C5C5F7;
	Tue, 23 Jan 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIAV5LS8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF755C5E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998923; cv=none; b=CigPIzFw2gT6lNGzQ0nHYqK/CCeNV2qvyv9hiV7tBSPu+8Sap/PH8wH6IrwYDfj3pltncKUtCc1zs/ALvZXMQh/RLd4hyfIH9e5cCZ+SCAQViOdg2YqOOavEvGNpvYzs4ZAI+1Bl5QNYVkhoLudcGXVvQSfke4EsjS5H9xzApec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998923; c=relaxed/simple;
	bh=XSWZdAOs6hAsxD5MITsh6XvhE0ZurohRXOoGiYT/7Ww=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tFgBV8xEAeN7hc3xTL0tbExIIV71yRsAxAZFQkNQsNfve6+/xBhSLjfi769d1AuYpz9WZW1sOTUcmah5Pzl3zbDFcXTrlqanKJh5ilMKzSIJKTU0OA4pnzIxHk9tiWKc+OieU5d5CsNg7lvuVdGJanBXTicJSI6Z5PYIk17agQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIAV5LS8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so44304325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705998920; x=1706603720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=skHURHUQR7i0GOIojP4/LIIN0dBVeJ7kB7JR1qs7z2M=;
        b=nIAV5LS8m0X6+9c15dz63Jdew/f3//RDSnamYG1YVoks95mmADFP53H3zUbbn3jxPH
         Q0wZwdaWuTkxI7LFaD9GyZ/VQg9JelHnZD8z3XHfcX3qcAkAtqvMIUjQoUnF0HxiwOSG
         4NTJBIHVcygPswb4ljXJmnug4Gt7WCGD4upW5anSqTE1ZW8AN+0eAnirLqJWCBHbzSlA
         vAvQAd1KgdsFnYw8+iGoPD1wfM1pwfv444wNJEnRHmQA+NfT9SAcxWgB+a6OnNzLMrET
         c9bs8Jt1uBWax9PnU8geWJiAvoPIuH2zEsvPN7BgT2BgTPH5nqU6kCnx2LLhci+1JQp/
         gSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998920; x=1706603720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skHURHUQR7i0GOIojP4/LIIN0dBVeJ7kB7JR1qs7z2M=;
        b=PLyDp+fckTx6Zk70kBDbMv6kIKMypgnPZe7PrHyER3Alp0SFEkHxPojeyVOjluO3iW
         m+58iOy4vUdqrNr/H9wVPpjlvd3F44S2gExypuxrQbM2mipLa6zC/lGmR3my+HyLD4gT
         X6DsVzBhV0pGs/bmEXSndiOnVSaM9vmOR4TNRuDiixEPMCQROX5V4ZUpMwCTi0zt6vz2
         jxJs0H6JZnAv1omVsAPaMWbzLEcCg7C9dEV/GhAO9JbfEVVMc4QK/mi/NZ+5NWxvLJOO
         oW7JIedPj1qZFxEubPaNyKCerX8IIvgiekiSWcuj+/yarSbU2x/tQLhukRy2k/W5bLxF
         jdZQ==
X-Gm-Message-State: AOJu0YxyaGkHSfomA45dcOc78vvtXsIprDchFz5ACFmKT/wnCR96zTvy
	4w+XXovl5sJJ4ouV+M7tj0yMejNSDnMi4smpPPcj6pEO4Xs7NzuSbD47Q8evNFI=
X-Google-Smtp-Source: AGHT+IEDMr/w8Trt1zB7Og/p3DQFm8Ri9WQH4rTw1DnY+3XH5GBq/BcUu+6w0HawCFf9l/HasGidLQ==
X-Received: by 2002:a05:600c:2249:b0:40e:4ca6:1017 with SMTP id a9-20020a05600c224900b0040e4ca61017mr347253wmm.57.1705998920390;
        Tue, 23 Jan 2024 00:35:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040e76b60235sm30590641wmq.8.2024.01.23.00.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:35:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: memory-controllers: narrow regex for unit address to hex numbers
Date: Tue, 23 Jan 2024 09:35:17 +0100
Message-Id: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
index f54e553e6c0e..71896cb10692 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
@@ -145,7 +145,7 @@ patternProperties:
   "^emc-table@[0-9]+$":
     $ref: "#/$defs/emc-table"
 
-  "^emc-tables@[a-z0-9-]+$":
+  "^emc-tables@[a-f0-9-]+$":
     type: object
     properties:
       reg:
-- 
2.34.1


