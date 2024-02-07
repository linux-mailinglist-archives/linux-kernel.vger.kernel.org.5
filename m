Return-Path: <linux-kernel+bounces-55990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4984C490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF5C1C24AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90551CD1F;
	Wed,  7 Feb 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0ZNC2ZV"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB451CD25;
	Wed,  7 Feb 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285546; cv=none; b=rGb/fsvexlOi4LXkl0zv9zll6AHgX5uv8Gmf/qK2S0J17u59fFRC4/QqAOfxPF7NyywB4upJXY7zxi9FzmUy3UffWoBOvnDBi2sHg148L+2WlonemLuMYTol4ibzD1crjtqWbBWHoc+TbpnvoALdpCF9lG2eb89IG+Ub8ALg+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285546; c=relaxed/simple;
	bh=xFXi2UIRe00nhT4n+S7N5s7JJ4U/nwtzBClHlrzvqgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAAUQJfgUDOcCJa8HlX6UDhnLzdJafQXwZIp4HFQxB2YnIArjHnLmTf49OEfpsdp5ymL6ezkpv4JbT/VqlethR6Wkw+fHq0nR3ONEwYebjjDeBW3MyygSsc69SE2wPsudjpa1q3rbgsv1N6rTBMBVoIckKYxYFz/TD6GxLt/o9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0ZNC2ZV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bfcf606936so147410b6e.0;
        Tue, 06 Feb 2024 21:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285544; x=1707890344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGq4nXKDwtVR5j58DrEt76XQbCTlsrAlFhIvJM2+AAY=;
        b=P0ZNC2ZVDZS30udHbbeh+w5SsFoyqKHsWOy4uPlFFE/ejMURDwgQdeD16I09aNgEvQ
         zVDANOtfiplF0gsBQhsaTuFF0PApksRg/+XH2S2CBrbgaQymhRbRe7e3hSYk8Z6SIAnG
         2UUz33KhKDNmdu/mH52XVS8Fv9ywFO11JL7GvaTU4NmsZni9RT6C5ZZNLess0COZH0PS
         mm4H0YXicyL6ODFjgAXQ047gGLsOC1Eav/cXs95Ng8goxxVPr73rKnIjPfIny1Baq58U
         Ygwv46srfRwNr9DwlcUPa4VxDWoWQG+LkSIKPyxdbcf2UMhNj8Ia6DLuq1cz5s/Bpav+
         SIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285544; x=1707890344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGq4nXKDwtVR5j58DrEt76XQbCTlsrAlFhIvJM2+AAY=;
        b=bW51WxXkIH+xSJgGQ/M7K5eVfuHLYOtssyKQk1aOzZqJcbfRJbxYFu7voBxo1Ug8Kx
         INqoKrRDy+4OEZS2kGdc0zu6YqrINiBXyu1G2oGzY1S/7GrxA8xQ5ynMutg63Mcze/6A
         5lrvVyUKXE5+HZ4Ta342e2HDDN9uDAvAfX31CpIM0+5cNCV9mbs8FKyqHZPfUyU1GHym
         zTM5O0ASFf+q449V1rwzez0ygtERcGp5nSJcbPQ+gbz1+ABVicG/cRzSPxbKgASgIQnD
         l5WZxg4Zz0zkicXei06a53UQ3cHsZ5n+pI+ytGSBbpabHwgTC+vnarhE1d51aOSTfazZ
         7A/A==
X-Forwarded-Encrypted: i=1; AJvYcCX6V3qte9rUYg7pgsOnVTYo0k+UvpI13+Qn8UGVdm95Q9v2xuCZv4Yd9bcAH1oN2C1PjGgtLkq1Mrp8cqRwXAWToSEFLwyrL0qa/vxdSxaPbNrOa2PpKZCWroGYKCwdb7mVhI7nmBsswA==
X-Gm-Message-State: AOJu0YyB9EWx3q4yVqd7+rDAxdMqVfWugBTiMo7wAWSJj0j2uNfFlCQT
	uqVAHS6DOZnxz5I5Kx1sQh/tb2QEWpPVS0B4CnnDgmLgW4+A5h2i
X-Google-Smtp-Source: AGHT+IFJ1uSNZr2F74eetYgjKoROr9ghfF/UDk/owV7CNEBeRmt4UUrcwE0whoI8WvBXETOUI3mG5g==
X-Received: by 2002:a05:6808:285:b0:3bf:e3b3:c463 with SMTP id z5-20020a056808028500b003bfe3b3c463mr4350773oic.16.1707285543070;
        Tue, 06 Feb 2024 21:59:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0duPcRBbTWYM8jn+7PE7RP6z2dBYtvebosoE//mZ5l6hwKI+mLHx5/yl1UR6G0GrNkgdhwJHDsTGisgpvcXzRLzv21KzIid2gVyodDP17JA9YwsKlSMQXj0dYTNrgCsOPfW4dYVvQmTLCbwStWNydW3RJNfxrsUjb5hg1z7cLxtX/j69e76jnu51gBxe9Ok7tsn0NdNaxKf4zwAwizSYVxoc478AZIW9ljOm5n7Qxb94gzD2F2dHG5oXUEySdwo6vB/9qc9qUy2llvNJohS01XFvTM2Cw8CJ2mou2wo4Jq+emZC34mweT7rAaiZjiJ/GrWp3UE4BnEQycWs8L4v9gmeMJDjjAwPR5ZK7493t7Qz/0mVJsKEbORBEt1aclerfmovp53FCqcBkNLeoj9fAo+EChf+LXLcdiscs6g2LyVb2U8B/FrrK2uetIXJOrjjNnoPF7CANgIBDPG+T6
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006d638fd230bsm567312pfq.93.2024.02.06.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:59:02 -0800 (PST)
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
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC.
Date: Wed,  7 Feb 2024 13:58:55 +0800
Message-Id: <20240207055856.672184-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
References: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/pwm/sophgo,cv1800-pwm.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
new file mode 100644
index 000000000000..7fcdf98b27fd
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
+description:
+  The chip provides a set of four independent PWM channel outputs.
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
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


