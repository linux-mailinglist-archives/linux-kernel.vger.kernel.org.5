Return-Path: <linux-kernel+bounces-155876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F358AF850
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A482B27DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B032143C6E;
	Tue, 23 Apr 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lj/CgTBX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA1143889
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905418; cv=none; b=cMX0PLeNMfRd15IaPhlRGoTtH/+qsraMd21gKAdgkpPBLE3DXQuO8xybBBwKcFok7O09jU1COQzuO7X4TcMtZsDIoPLVZGexD2sPS1SQorZePhxH/oPO5L8u1COsZL+x7mTot2SyfiHGY5XIzyh8GQ+QmsO5kISpmG4O37NJMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905418; c=relaxed/simple;
	bh=WARBLKc8IIwkOZR1KT6Pc8Nf7x5S3Qw6DwX2PgELUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW3zBpREseUs/8kWrPMm3x0u+VQevnr5g10DUFw+D9+kqKgQR5+hBQVaOFi1I0grUW23N+LrqEpVKldE8hsy7TMEYq3e7irw3BQQOFrA5Ccvx3ssiVX9NoX3s0FVW8e1ndXfKyxIzZx/xIjPcyRIu7myL7VsHIEViU5HcPoqHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lj/CgTBX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a5b68ed4fso21754375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905415; x=1714510215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=lj/CgTBXWD5CQMfW4dzCG4gJ6scB6ECUYUscs8fay/vFE0fR3JZRJ5l07Ai4gxO5/q
         wyzHUTJ1lpwBRc5niZ7M/66a1t+GE73GuSp+DCLRSNRSF4ykHIdYqUq6Y0E/S7wMDM8b
         LUxXhfF5+YlO7zQzsc/Sjihh70NDrq079eS3WYyR22lMfAKJ8TDMbw6qg8oRvuUc7h0k
         HIeZWcoUYnTyGOQ0pCFSjTBEJqnGH2w63T8V153+dNTFuGgF4bO6QEVn6/ARlkcZ2ch7
         ZI99JVXs5akUTQPO2jiiILFm7qV1Zpeyj5O0eglSfZTRZZzFV/tKA0bqtOgHfj0fSLRI
         7qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905415; x=1714510215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=AOZfo4ipwK9fgL0EP8jlZ1qFN+LAXs+Bfj5hNPCDoL0ccAA/ZfnWaShBZ77LGfuHCE
         xT+lRR0m0aYcXUH2opZfHC3fe4eQmMWTN7Xfpha4jT6+bBK5BZ5uWdUz+csLstm9/zrZ
         okiqWQBlZwTK8ALrertEPGHy2fQmdUBf7jBoKa5c0bmsW0j9yOXaK1S0EG+D1/lNF8I3
         LNH6ZrvLCwcsA0BYAo+wSCKu2knJPCtncsDdAK0QXDk1amGB037fplziWwBphVkfd4Xn
         Qs6JtfbccsHIae1tQElmYrsF6mBeqVeP/SVOi/sr6M5oWMeO7hMSqvVXe6Fz5uHrBQvz
         hPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssxqB0HwqVx/agebVa5QFZ72eSp1/AIOgR7hejkwkXIPeClSNDCaq889dBye8W+j1Fyi0oC4vjqq0/u8DUpiJrPFn3Q4+WwAamCqD
X-Gm-Message-State: AOJu0YyIbzlbMXtheLXGl5u5BKJqzD9zk+D8vWfgCtc8wrVu9m2obPCz
	i8Yh4ex7F1Xb/VAEzpatmWtpAK6/NrFqWd3xHd6Hp9HuYTXxQ3HrEDfHF5n3ez4=
X-Google-Smtp-Source: AGHT+IH9p7rRQpyh3qjFY22JgIFm5zaFqK/Hn2YUUXTMJfPhSR4r4a+glqPpxsEltfaY8s2J4KBqIg==
X-Received: by 2002:a05:600c:3ba7:b0:416:9f45:e639 with SMTP id n39-20020a05600c3ba700b004169f45e639mr225716wms.20.1713905415398;
        Tue, 23 Apr 2024 13:50:15 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:15 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 02/14] dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
Date: Tue, 23 Apr 2024 21:49:54 +0100
Message-ID: <20240423205006.1785138-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423205006.1785138-1-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update dt schema to include the gs101 hsi2 sysreg compatible.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index c0c6ce8fc786..3ca220582897 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - google,gs101-apm-sysreg
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos3-sysreg
@@ -72,6 +73,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos850-cmgp-sysreg
-- 
2.44.0.769.g3c40516874-goog


