Return-Path: <linux-kernel+bounces-81368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1068674EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40B41F26AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076696086A;
	Mon, 26 Feb 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiG2qLMz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4883433C2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950559; cv=none; b=aQPXXStBFp0hahprQsTBDgqXGITxd+TgHzl1a7X6nUSBnoiRnauBmeR9hms6Y3mk84ZjlOEwGPSn+7slaMpwXPvRT3H2qjRLm1qSAlH6Bo6PfHaU5+En+jrgjr9BDo3wYK1q251PdlZO/qvcAUCiHVeORbsToJp5+MxoNz6t0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950559; c=relaxed/simple;
	bh=GXBeYP8/NZGB5qf7XT5SAdvVmTap9xNVMLCGmPvvpCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PN1Q1yXEwr6wrVpJX+ukuTURQ7dUW+hCVbgJgUHKoZX4HpoEBVAS7eR9aE8ELZKE4+q3fT4K9vTL5SxWJsaTBg7hc2RkQcQF24sn6dlMB4zb1d+OpHdunrlun4gxwh9nultniGgIC9bKCrEUcNq7zXtV1X0HRLdM8XpIx9Zz/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TiG2qLMz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso383179766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950556; x=1709555356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HdH6UtXyV/jkzcX4bUHV7TOheGh3mZ5gM3aVou29Dg=;
        b=TiG2qLMz5qJUgsGBdPzBPRSIIHYodgqkh/gNB/BM6T1KlnLmfDxFxyhgvVDg1GIxUf
         HrOqaW1zdWMvApiLo+aQRhiYuMeUT7kCbEAvGZed8tk1VR9EyG7Oj/l7tCx6GTOuO7TJ
         9RzvX/dczCo3hda3Yi7fQeK1+Om5723GU5XSbKUENrXe8qKRhVjeu7lwryvo8UaNkAqh
         v38/TiSXL+pascDs4rUj+b0SxDxWwOthDdje3OjGdFT5//y6UD92cGshiYfnv5hsigbE
         UU9D8+TUy9Fi+DR9uEwhzIuUetSNKSRX0qwjjOzgLddYLIN2A7oZZ/uX9C+MpLkTOE8t
         SVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950556; x=1709555356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HdH6UtXyV/jkzcX4bUHV7TOheGh3mZ5gM3aVou29Dg=;
        b=sQ/G4WwJvZ8RmVRG9Nj1KT8RrwMrRzFrMWU9WVfIEgwaF9B65UW6CzzESSoxRNgFEe
         3zvpZ5ZpA2hCEonPga8rjhdzt6nHutDLW0Lz1/rdRaYE+6FQPaENfk2dxJBHD52dDkIx
         gE4+wB5RILxHPag5mJL2jntOYOLAQQOZuprueGHo9p/zC6+/3ttONPlmjrbipPqTw3IR
         /ABr1btV6XkjxrF9ouyqLkHF6crYIw0Ipv8Fm1BPql970tmNIXAvKuJPhm7KJPER07zD
         vkGX/TFa399GLKv8j2XnPLfN/ccTbF6INBRfPaQfwJPQH1JYppGZiFKe5Hj44b7F9S3/
         d2dw==
X-Forwarded-Encrypted: i=1; AJvYcCUZqaQevOld20vwPMwLsayC2+pY1ChYbbjpvYF3bYnPnIqiw9RniojnQ01KbbsGRg5O9PSwwHsgD9pN9dLGHNk9WgJ+MaJQIe6TiwfQ
X-Gm-Message-State: AOJu0YwE1RJZeYuNmKbfHtPH8lm9Nikrp824MC+WO43umrNluAON/Hsa
	c70B+naWgGCduhM1PowTc9nsHLLYeCPvJsODUuctE2CSr7R7dFsbGOC8x+kSfx4=
X-Google-Smtp-Source: AGHT+IHqozMTz0LD5vswK7bz7pL+WRBEhCMhfrrlLmOZUkgEm9k8MLdczRTNH55JCrx0Mk5cSvGapQ==
X-Received: by 2002:a17:906:6bcb:b0:a43:3c7a:39f8 with SMTP id t11-20020a1709066bcb00b00a433c7a39f8mr2340993ejs.71.1708950556073;
        Mon, 26 Feb 2024 04:29:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id fj10-20020a1709069c8a00b00a42ffa6b85asm2048272ejc.114.2024.02.26.04.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:29:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: ethernet-controller: drop redundant type from label
Date: Mon, 26 Feb 2024 13:29:13 +0100
Message-Id: <20240226122913.87669-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema defines label as string, so $ref in other bindings is
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index d14d123ad7a0..b2785b03139f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -14,7 +14,6 @@ properties:
     pattern: "^ethernet(@.*)?$"
 
   label:
-    $ref: /schemas/types.yaml#/definitions/string
     description: Human readable label on a port of a box.
 
   local-mac-address:
-- 
2.34.1


