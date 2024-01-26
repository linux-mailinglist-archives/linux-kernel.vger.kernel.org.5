Return-Path: <linux-kernel+bounces-40075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A126383D9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2289EB2DEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9891B275;
	Fri, 26 Jan 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxd04UQZ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852E1A726
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270123; cv=none; b=MQ6k1boFgikgMgdZCicqrje0uqOCW955YVvyzoq3W8vRvvhwHqxRSQHAeJY5Arz5tvbut8i1E5kgULYo0Ofh6d/tdL/X1uT4r6Skvdf1aznCEEziKOFHtvmikUpQq0+3F4kB047y5KXZduMp8oL0kuVyzi74O9GRge3R5uVZq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270123; c=relaxed/simple;
	bh=5gQbWGeiAGTlDLAa9LO74fg/WiV7ejSsxBG3mOJYxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9Mb76qUg500xdmHpJyhOLtFg4470043IoJzNLNAK6KF7xg3A8+oicsNWS4IETabXil595gVpxROFuWG9DtliyGZ4tdgfc6D4eEoebubvptbAOSmcxqkFsLTKJZfO8+pVTpCEAr4jLDfagLJGuBl7FAkWcL5DnlUWpZwxHYJ3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxd04UQZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26f73732c5so26128966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706270120; x=1706874920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LVcqUTXP/P2WsnP6Y5tfw0AY+HXGkieDjmGHyFGDKA=;
        b=sxd04UQZOL++DRDSLqE5sSLNSGqznkTncIPsu1hCkKzF5xQbuvy3Q8uq8WU7wr/vho
         EVUtYYR+Y2ONL9fm9ODT+OwwPyvnRUhEMgjrzKEZndNVIt0tBgft+yTxgeMn4n8ZfpRO
         Jq6ZbPjBuLtBx8iZgu1HApVTOMJpLJasHiYtoeM/x+gPFi0625Yi7fcCNEmFzi7pgMcr
         O+xGhmVpeZV3zivPNYTRJbsH7DmBPkRFQ7uCf37K7FjZtA2FMi9TumOPK21nwI5yLiLI
         o+EjT9QxrhJxh+XiUXpQgSeXH1yKY4+g4bJy33Gpq4HIucZo+/gRTmVqw0/nXm5ThYFo
         DOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706270120; x=1706874920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LVcqUTXP/P2WsnP6Y5tfw0AY+HXGkieDjmGHyFGDKA=;
        b=A9yuaaWqcFVaoZW3nyMmsa7+TDUnv4i0pJUmEguZPSaseRFdPll836pyG39RFw0W/B
         jaNcl3vu01bTJp0YtqeCIIo1oi/4IHciDhCQapoTzYGw7wl5i+UdSRushVAT7KOW+K2C
         GazaYt5IloTknnbNQQ39Ul6XH1g6h31l2zgmiR3uxnB2G5iSl28BKaaq3G37uWSIT7Rf
         ZctLTjHNOcYElIHqbxKn40bKKVkGDpkotGx5g8QkwQ1w5NYqUcfIdgk4kaHjWfum8Vu8
         EWjgKpTrJQ6JCwk60x2GJfmLeUtOSy6fJp6wonA+6cn+BgK42wmaky2RlH8VQeKLlomQ
         /cAA==
X-Gm-Message-State: AOJu0YxtOW2dscW+u0+Ov5TZXkAuYXNcVZcog8a0BNeOoSeai1Xwwfwo
	Y9rx5xpHJUqatd/0aGdyyw5O3H8YXO+KDFVMfDl+PMGsjDv/5bCa829nipaacmI=
X-Google-Smtp-Source: AGHT+IFRkMZKCLree9XUXLoFwO0IzzGB3sFNqGLLWGA4sB0l0tlaNsDMLiafgrhUecbTMmtb+SjOFQ==
X-Received: by 2002:a17:906:16cb:b0:a2f:b9bf:3955 with SMTP id t11-20020a17090616cb00b00a2fb9bf3955mr628553ejd.21.1706270119990;
        Fri, 26 Jan 2024 03:55:19 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a2d7f63dd71sm551280ejc.29.2024.01.26.03.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 03:55:19 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: samsung: exynos-sysreg: gs101-peric0 requires a clock
Date: Fri, 26 Jan 2024 11:55:16 +0000
Message-ID: <20240126115517.1751971-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

.. otherwise it won't be accessible.

Update the schema to make this obvious.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3: no changes, resend as a complete series
v2: no changes
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 1794e3799f21..33d837ae4f45 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -72,6 +72,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - google,gs101-peric0-sysreg
               - samsung,exynos850-cmgp-sysreg
               - samsung,exynos850-peri-sysreg
               - samsung,exynos850-sysreg
-- 
2.43.0.429.g432eaa2c6b-goog


