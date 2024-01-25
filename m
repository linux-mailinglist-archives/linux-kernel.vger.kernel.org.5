Return-Path: <linux-kernel+bounces-38696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60083C43B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B3285757
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CE605B2;
	Thu, 25 Jan 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdOI+uXN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E357604CC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191307; cv=none; b=rUG2SsF6G4iHVKgd9K+gVTApBKMpk84XYgRjB8eujgFxd2hfi4AlQ2wkzNqkKyG4A2Au7VUKUm0mrJgxnRY/CmfahvHxMjb6qc25Ufk6bSZlW8n8NA+u+wfG/tc9yoh+O8qkOTDAYGhV0puhKf4M4BKyifcSVpWPOFwqbT+CiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191307; c=relaxed/simple;
	bh=lfXymCih8K4E3VCnUTnLCvDgmUDS6aPwTshK7FgaqVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMWyg5f7D71bCvulEpB12UwXs3dYsyOoJSrIQ25vGeGB86aESa4SBwlo9zCVuPsoDxrQVqY8HHzyCD1Ezuo3KyTN08l64gM+54a91Ud1/NSRTJZpjR3LaWqGDINRBXjGBofyC1IkH/J/zJNzWvw76lyEijZaLEsgFTGXu3I/CbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AdOI+uXN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51005675963so4839929e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706191302; x=1706796102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KvKCRCBN449rio/DKI464Fncv3o1DnaiUByEc969UA=;
        b=AdOI+uXNDQzJmfGTNRyUm1GtkUx/EyKhwcoQI1G1bOA8mNRIT98F/1IdAmE462hrBk
         0KwTAez614+dlJaAwNrimmsnQLYIkzyWQBTGO652Ayhd1Ca3B2ykxw8Qy7pUjsxfCe/m
         Guq7rdlEEap5Q9DXiHiuh/xmWdVXJPibikkJjNDSDbb30HU9rT0+SMmE5bL6yWuoK9Fi
         uH9KTRAsqFOzl5/7i4Sg+aTkWDC7WnrTeV/PHqXapNERjlmCKaQY0ZfD+cXECSbGcEcP
         HUrQdfw/oYB5eekHkw3jYShtzrtIv6+iL9KwShIfvsC6R2fZc9bc+Djz0bkWREPE7TyC
         Djgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191302; x=1706796102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KvKCRCBN449rio/DKI464Fncv3o1DnaiUByEc969UA=;
        b=jxrBWrUjIpqUHsBOQClx8/tIrnizaOJyNbvnnYcjn0ekK8rdirU/VWY2UcsbuLi5M6
         vqcfcEXErOmSmzne+EuugbpbZjiQu5C6lhHVK1QL/6DHWoFVGP1ODHFH8S5UpH8hdmCW
         qeSetljxn7E34a4A2pD9WFYhdxX8OBJyy3AFjKHu9nf7Cr/GOTCdIENGxBVWuxM/nfQX
         TrgzBMszBaQm7VzlZn7+T47e8/1F7a56aXWXYNkUI7OmowrdwpO+fuXCUdbbhsANuyzw
         x02Ci6ecKbsMi4ZNcRYQ/dBgfXOFVYdVaven3Xg1ZXHB804uUSEpLuWgztWXV135+rGD
         gSsg==
X-Gm-Message-State: AOJu0YyKtCSUlbuTxGaVqUQDm9+8+Hpxp1BWpqYoGQSA6wd8eWHMxqRC
	fnAgdErI/qoGIMfBHHz6q6nhDlMBaE+acMA504bkPW6N9KTT7TRLMCIHKSVazdndx/2Th7XGBY5
	pReoJEQ==
X-Google-Smtp-Source: AGHT+IEUSuckZSbp7+7LJ/KMKFB8cmOCZlQnHH9oeU4dOPU6vGxMnuPXXl5wbqmBe4kz+uw5KVF/4g==
X-Received: by 2002:ac2:5e66:0:b0:510:bbd:6de1 with SMTP id a6-20020ac25e66000000b005100bbd6de1mr329846lfr.204.1706191302478;
        Thu, 25 Jan 2024 06:01:42 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709067fd100b00a2c7d34157asm1048170ejs.180.2024.01.25.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:01:41 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org
Cc: kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: samsung: exynos-sysreg: gs101-peric0 requires a clock
Date: Thu, 25 Jan 2024 14:01:38 +0000
Message-ID: <20240125140139.3616119-1-andre.draszik@linaro.org>
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


