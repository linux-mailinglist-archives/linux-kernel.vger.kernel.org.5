Return-Path: <linux-kernel+bounces-77917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF29860C22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07FC1C245C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408D1B5B2;
	Fri, 23 Feb 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igzC3AMW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA54414;
	Fri, 23 Feb 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676425; cv=none; b=JY3nIFBpscrqZpW+nH7oLaXNhNgcZorQJGkowcKK47VzEOxHrGXCqcDLnGkv2CPZUEdIQSrkRgq1/a56S9WUGmChlATPo3IpdnH2EjwykJGx6PUaqTtUqiDf+gKB/HXfEixLvaFrfS4PMLz3NhMe4XBSrMSRH7wQlNgX8qW/whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676425; c=relaxed/simple;
	bh=5n7Ca93sgt2C4nvaRXiYy2nhqL3iHW3hsRzfzicQJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgk6PrL1DZBxGfBWYgl4Tl4DZqZb+KTnyAQ5OAIF1323Xz/ylULd/yWGvkkOfq7G1TRKmehu2a4d8aWVNS+9nKkX8XHuH5VH5b+nI+tJFFVlMPrZSS2P9WTV9kUTgsbvvUVLGlDOYnwNoFH3XV89Jilee+3Avxh7NKlVJRFm5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igzC3AMW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so68132b3a.1;
        Fri, 23 Feb 2024 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676422; x=1709281222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=igzC3AMWY/D77ji9c9voFd2EoFBTHFS2c/Cf0MvmXxkmiC0naIph42oNxNUIPkNGeK
         9xEzgfPcj+tIBm3L6Im8vjXkSsOqEK1OWgBrvCmLIlhE1fn/Sb6eWcO/5+WodkVhxEAt
         wso0ByJ3VTzgF7v8qNaw31UcIlpcCYQU/NTG7FYw02cbdD7CcZVOr7IK4WQkGx7yz9Gy
         NcLoFML9FxKXi7hEU4OptBG4LL6+2AMKsrcIplBf5A3JRzb1K1OiJYzUcPJPViYzWaG9
         gE2vY475c9kb4ubGKEJdM+2kTRi2qFMa81Nz6AAcgr18ha8jHzDZS0aj4pV7lDGZ8lTk
         8W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676422; x=1709281222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RfbJF1AHvLx68TbsWfPK5aQiL25UBSnWB8Job9Vv4g=;
        b=K1FXu/Gc55iXcg3Qq2d+IQp6XcYfuRgC9m/AaUJwuEP7oW4wMWje0NKRCgVm9u9chj
         hyKcXfB1nSGP/9hZF9GcnK0v/IwCroaKK2CxRh5T5cwLEOhZZf/2MiLpPbCBrFSI1R5d
         UR1zDKHRGnepR8aLvPYzSsDmKrdctf9NctQqzc7PTdK+Gb6N6NV6jvT4FYDOU9Y0dU4z
         oqMyCXAPEWvk+1ar2lm6Gmejdlkgih7L2ZuYEijvCaNYdc/bQRYre8Vml6c5eCqbB3aW
         8nNAgTmaqsoPde3LytQQEFbcc4hCnyX1xjrzSF1/HBuHPrfVKY1I9mx+LSpAdKJnVCb/
         lchQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnpoRTbAPAhQdLXRMqSBYGB6b+/6QRomSlAJhMCUmQirNzBMsJ0W5EST43hMpjCQ8tkJVwubM98ZzL4pnkRwBirQSxHZh95DM2T+9QNMWZ0AgASpfjl0VKa5NVxDuzVfLk4QZTEmboYg==
X-Gm-Message-State: AOJu0YwCIo7HWS8j+Wcun6a30POE5E9qEW9JhqOS4XCtcyJm1N1Tmdll
	aj0iY6V0ZeXAkuNjrMrzxf3Wf1/oJKtjlJp/gRn3eyj41zmkta9Y
X-Google-Smtp-Source: AGHT+IESlTxR62kcKEjRyPd2MRipWcHKSB7X8sQnfOsHDmD+ru1s8Eaj7GCPdSZiEdY7xGi0rgweRw==
X-Received: by 2002:a05:6a20:7a9e:b0:19e:5517:c345 with SMTP id u30-20020a056a207a9e00b0019e5517c345mr924733pzh.44.1708676421551;
        Fri, 23 Feb 2024 00:20:21 -0800 (PST)
Received: from localhost ([46.3.240.102])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001dc6f7e794dsm411534plb.16.2024.02.23.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:20:21 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
Date: Fri, 23 Feb 2024 16:20:13 +0800
Message-Id: <20240223082014.109385-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223082014.109385-1-qiujingbao.dlmu@gmail.com>
References: <20240223082014.109385-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/pwm/sophgo,cv1800-pwm.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
new file mode 100644
index 000000000000..b5b819d780f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,cv1800-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 PWM controller
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  The chip provides a set of four independent PWM channel outputs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm0: pwm@3060000 {
+        compatible = "sophgo,cv1800-pwm";
+        reg = <0x3060000 0x1000>;
+        clocks = <&clk 60>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1


