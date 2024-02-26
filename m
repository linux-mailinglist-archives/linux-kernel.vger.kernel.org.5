Return-Path: <linux-kernel+bounces-81370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9128674F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB933B274D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A660889;
	Mon, 26 Feb 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvxlmbc1"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0972605AF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950581; cv=none; b=cNi2MZnrKR7jTh5WymiHeEZIEMLVuWzZfH0SguuS65fk2BA2vMZcFvTFeIQeo2Wno70gzX4iJrBi/a60OqEBIJufmml4m17e5OAIC2PJ9xW6pTh1Mw7g8sTnxgjd9Xc8tc06DLFYGLL02T8oTpT5n2gVJH2ZrpBZVHcvq0zh5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950581; c=relaxed/simple;
	bh=/yIz5oyLBfSA++ON1dY6EPVob2yea5MQlWsNhAmfIVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YEUVwHUzKqfYKN/JXd3RGgZlegsez+MYsB3g262FhR3dAEvuj3Or78CehhPhoyFKsYbmFSzOvJI0sbMXfUFxVhMWCKtveB0lDLwSixX2+yvmzRXwtDfGKa60w+WnL9jJpPqp79WyRCSpg+at6L7PDf8+59H1CmX28bI2VKuSJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvxlmbc1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso4144749a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950578; x=1709555378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUO6wmBtkv4ffo/uxOeQsK49ucl/5uSltaqOCTDJPag=;
        b=zvxlmbc1hoLmUsYE3vC2ANVf9Ser6/fe32yCoRTtB1xN43g9yN8TNVacuv4No4SzO9
         qcT+aZaV4ZiKvw6kqI1jPhynrkMDjfuUwwySb2bglXUU2hZT3km4K/rTG7ovaKuU2y/H
         mZDgRhX2rW82Gf0z8NUQeUv0vO+v688WX5I2tI1hxLsD6McTeApY4+5jbrHbKcJoVAcB
         LiOS6Kd40bzld+sf5sjtDIuTrQ2e02JRmsBbNLiJZEHkH75vPcju8Kv2kPJFzT/eU02R
         HHPhGXG+McoYDTsEwuUOz6uVlqWhmjmSAkwwbKXfqI8/DMUKmaT+lwSPqdmpnsYQPTSf
         SyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950578; x=1709555378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUO6wmBtkv4ffo/uxOeQsK49ucl/5uSltaqOCTDJPag=;
        b=jl11ffVrfIKErjZd0jHM3IvNkrwe4jRi+FsT5ZZCAJUylTslmbBOsYR5amg4UYQtgl
         5ZaxfjWU5gcbGA86Tj9OSpeUY4VSliCXfSBtIq7jhCFKSBlrGDIjVn2O+oIOF4WO4cNP
         JEUQx/sHqsOs1LKt48KPRYio4h0ZjxPc9B2P8iRHNTRAIReHD6RqkPwUxo1Jh9MFePVH
         tLfX2W7aD4pwl4PH4nXPosvRkxmCPTqtkhzGsm+eAIZr3/aieJ7jXvR81G6uaOZf5S3Q
         H9+Vj4kGTt3h721AsLaos4liYLZLsv9vJqL2CfOA5GVBcn9AmSuJk6l2lmKKwhYYDKMV
         xSXw==
X-Forwarded-Encrypted: i=1; AJvYcCW9sFQZDSFtaQovBmKIc4ALkUx+Ir3JYBnqvxb6e8cLNhNtMgVAOHEI/KIVsVhreWqwOgjDBynkluf2T9UgIyKdpbQpKQPUggsZs0Kn
X-Gm-Message-State: AOJu0YyHeWlhBscr0t19ERXjNPctVOAv+4RGarG28vuHn6RhdN2m0zQM
	fn5sgABSGAMZKRDQlKTAo/SwQEllTHRRnzcCYbM1hlG+gF2mBQlt059o49W65YA=
X-Google-Smtp-Source: AGHT+IEG45l2x++PIZXi1hnUpUUkA/1s8de6YMCGRZc2XdUxmEusGFOlqs4MacdMEgFnjeNKBj1UZQ==
X-Received: by 2002:a50:ef08:0:b0:566:ee8:8b1d with SMTP id m8-20020a50ef08000000b005660ee88b1dmr869351eds.24.1708950577837;
        Mon, 26 Feb 2024 04:29:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s17-20020a50ab11000000b0055f0b3ec5d8sm2422683edc.36.2024.02.26.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:29:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop redundant type from label
Date: Mon, 26 Feb 2024 13:29:34 +0100
Message-Id: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/input/allwinner,sun4i-a10-lradc-keys.yaml           | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
index 5efceb313879..c384bf0bb25d 100644
--- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
+++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -49,7 +49,6 @@ patternProperties:
     $ref: input.yaml#
     properties:
       label:
-        $ref: /schemas/types.yaml#/definitions/string
         description: Descriptive name of the key
 
       linux,code: true
-- 
2.34.1


