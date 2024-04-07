Return-Path: <linux-kernel+bounces-134332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E32789B06C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CEB212A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040718AE4;
	Sun,  7 Apr 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJZCW/S8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826E14294
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485727; cv=none; b=MBE56h4zZdZBvJS6iNNJnRAMuX1gti64Mmuy1A2GVK1mab+3Z+yMxaOTX+xQEhMgR14PucJpSF+hLKvA59HRYphHf/VaD0ONii6XrDehfN2l8ggn5uJc9qg1lXxSxwjraGX2KOl1pax97vf7Zj5l3woKOn3YPNkEjvDJZHU28yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485727; c=relaxed/simple;
	bh=zrafKbkh4s7cjDZTL+DArSyH4tS3eCcTAoC9DhpXz44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7je5Haxrnirgkf+9pCOAdbFWKlOLefXgOM0AdXIL3UyYcqF93IGxKe7q/MgyShGCWXLv4PoVNhADmglT+dZi5IokmeXs6d39wYOPCBf0lrlUxPL61W3i8TPw+HIXe95LJdHBfK5Zjqc81KJMfgK5mA68aukvGXZ1ONN7GrkUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJZCW/S8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4166d58a71eso65455e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712485724; x=1713090524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Cl7h9jU7ChQNHuc95qoMqQpHtUsnk01qC1Q0FakwM=;
        b=vJZCW/S8H44LIaWAgDPqluycE4xdQfqRMM8kY+IR3UZoninWFGjWEkuu2fHrgQn1HY
         rXFiXAwCrIGYa18FOyXHmP88g4Vhu87w9ARiOAQMrx473pUQGBVoLrViuvE8aDNtvLt6
         wf+uq7n0u1jtE7tbI0zWGpmmoQj+JHrCRwWgGc9/67mDuCr7ePntncMl+ob1Bgj25mWl
         GuQhIjzLkGKccQAMVEhl3HqHWinc1Qs70e6XExI3vCW3bXIf/fY7GdxxMHgg/or6Dh0+
         280YUL2LEN3aIFhN5KLjjtODaGqoA8k8Ptiz/fXzB4LQ3mTQqgkUnP6Ywe2N6I8IUS01
         NNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712485724; x=1713090524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3Cl7h9jU7ChQNHuc95qoMqQpHtUsnk01qC1Q0FakwM=;
        b=gjCun9mZ8sSaDfCtgvcQAeH4KXj2qnCPL/OBcJbnL4ZBXo3p3IgvzWK2Ys1uyCb3vm
         OsP7oo7zNzA9iLD3WiYeYJAQ58svdoOvuZHEpsfjzy224PNglJCr2sNfvgQ05qUe2dX5
         KBtroHRGeINDF1nEvpPwRpept5vf5JwiVzlRU19CUAsTcMyeEJEv9zLDjrLDulEn/7kN
         4ZbsnEjOGzIyOIHxTR1a68qSOB75Ti40/KQCRl5CPUEsBpPQ0ThoAhU0YqcCjPBRThEQ
         6sGW/He0HxQTK3pvAwAEOMLSV60ceSILDz/cnizE560Ra47MCS7I+bWpQQ/AYhEvGXmo
         p3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV2muKVna5v2HQ1+iPOu/FtRseWDx69Xsrpaz+OatEc0uZO0JuduIc4YalWYVfcJfUSlJ+TxW8LVysJHWCj+YxeunwpeR++dy0Kkc4e
X-Gm-Message-State: AOJu0YwDmeFvNm5krmksFyJO9p6d+xfPtH5E2G4KnxsKwXtA2zLQFolG
	VEl60muCb00fW5ZbSGga5fOJl4C+OVCJ6lE5i+t5/CGV+8YIkKK/R0fVWymdR7Q=
X-Google-Smtp-Source: AGHT+IGyr6WK4/XKIk3R6H/gfyVg/+5WfEv6sJHc2P9Nl5aDbnzIrVYpRGVPWmpM5DaRkh/h36MGIQ==
X-Received: by 2002:a05:600c:154b:b0:415:6b6d:da6f with SMTP id f11-20020a05600c154b00b004156b6dda6fmr5397004wmg.39.1712485724165;
        Sun, 07 Apr 2024 03:28:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b004148d7b889asm13241002wmq.8.2024.04.07.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:28:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Robert Richter <rric@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: cavium: thunder2-99xx:: drop redundant reg-names
Date: Sun,  7 Apr 2024 12:28:41 +0200
Message-Id: <20240407102841.38617-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no "reg-names" property in the PCI bindings and the value does
not conform to Devicetree coding style (upper-case letters, space), so
assume this was copied from downstream.

This fixes dtbs_check warning:

  thunder2-99xx.dtb: pcie@30000000: Unevaluated properties are not allowed ('reg-names' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
index 3419bd252696..874d4d3a4e4f 100644
--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
@@ -103,7 +103,6 @@ pcie@30000000 {
 
 		/* ECAM at 0x3000_0000 - 0x4000_0000 */
 		reg = <0x0 0x30000000  0x0 0x10000000>;
-		reg-names = "PCI ECAM";
 
 		/*
 		 * PCI ranges:
-- 
2.34.1


