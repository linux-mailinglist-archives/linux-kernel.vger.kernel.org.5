Return-Path: <linux-kernel+bounces-116870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F288B1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8446ABE1BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7518C9D3;
	Mon, 25 Mar 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hbh/xgSn"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283D18C9D1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363722; cv=none; b=SwxqhK29mxnh1+ZW+ZCWA10b7AYQHd4IZZSW0x5x9uNxJeD8WdkIFDa67zk5NHsU97oNXyZD+o8dL0Y05o/VBj7Y4H/xLxqxuXYBvFnpbF6mGyg4Mg9fnclMPjtOD18KKzKlcstX3dAl9Y/CPwoZT762JjSsMIcWyby31B+h39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363722; c=relaxed/simple;
	bh=2ymQHq92dFt5ftZpOQDXAFXnvGbioEFB3yZ5dxZ8PX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHu1d75TRAnPFYFvpSr6OPJyDN0hqU4LG55DDS5MvZSyw0VekEUpKwhy10onpkx8+H7pGyFjqTRIkLB7YIvXMBPID7FCO7rAxQAVX6Htp+P7e1bXZdZ13o5CV7ShEcfF8itd3HLBhUf/RNzl964Vwtp+OhZDpIss1fIaqSiY9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hbh/xgSn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d3746950so5133683e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363719; x=1711968519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipt8Nni/JGxfVH6xjAHK3ADWRzeEAUH7NmYP0XN00dA=;
        b=Hbh/xgSnldbXoXCPSuyqkZ9srFfEFplg9HpwNkajsfrCkjMljhP79sc/Nsw6mnQP//
         K7fmbMuROB3AUuc/cIgIX7XpCimLVxcYvCpmQQQHqqpAtK6cx746hX7OAXcXlzcEUF8i
         JO/7M6qZBkYyvz2VQ9LTPfKNzEgY/Z1RV1PvcDvdZk2wC1dM/iFIxK8V8q7QVlbC7Umj
         Mg5HircVmTP8JAmftqAdg4llSex0FByyBRlPQ3SzPU05dXPpdZh7v7VvX5P3nnt+8Nux
         EBvEerIO1lj0VHWe/jsMcQc4YSEqvTev3jT530H9y9bMpGHV01gE9areVnAp7Nc0ZJN2
         3a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363719; x=1711968519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipt8Nni/JGxfVH6xjAHK3ADWRzeEAUH7NmYP0XN00dA=;
        b=aOXzq6w6RhBzwkUTLxbKEi2sjYQe5r5AFbTs1HCmhcL+8S4nR/5Q9pPLj502cT/Ixo
         dMwWwEHLaTrsduwINThZ7rNhvQejDqZ+CL6AkkyKcu9fPNv8I+sCuJU6iE5pDLXKyxWt
         TERMUb0LWamGqJ6HR/OFhq+L8gUXD0NI7z6NBwL+QSldP1GlhvjXkdMa6jhWXF4C/YA0
         4spftp3v8KoxSsHMYpez9ShSItS3+V0CKeuKxaFDSJb5/r1ANYv9QkZpC96Q/qT0p/km
         8d1DNwD3i16jaLPuFeM1XVuTuXoYeZFj6xHMa46MV7gvCRoamXFH6JZgdfzm7wGBbrTn
         /X3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNgOpK+GaXPEvDsoZ65y0w6tLFbLYREqlZabma8i5cBB1hKDzvObVVwwVhp6NRdqBogELetihuoIzcAJmmOmzcqSmQzv+mKO9l6pY6
X-Gm-Message-State: AOJu0Yw2SjHoRWdMVvCBFs/WrVDDm5uUpXUnusJlzeWkcULpygj8ocUB
	7hTeT2nu0EgHWlSuq1gDjMA7uZOM15eAs4JkZbhbWS6iXBlJpHGCmu+8MclmLzo=
X-Google-Smtp-Source: AGHT+IHQzqJeE/IoQzxHE7jCIJWL1TTDdd8bA1fBeZ5XLg80Uh92cwV9vAQl/+qFaFpTQrZejIynHw==
X-Received: by 2002:ac2:5dfc:0:b0:515:ab85:34c2 with SMTP id z28-20020ac25dfc000000b00515ab8534c2mr1795658lfq.29.1711363718839;
        Mon, 25 Mar 2024 03:48:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id df15-20020a05640230af00b00568d6a20717sm2859339edb.52.2024.03.25.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:48:38 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dt-bindings: timer: narrow regex for unit address to hex numbers
Date: Mon, 25 Mar 2024 11:48:33 +0100
Message-Id: <20240325104833.33372-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325104833.33372-1-krzysztof.kozlowski@linaro.org>
References: <20240325104833.33372-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regular expression used to match the unit address part should not allow
non-hex numbers.  Expect at least one hex digit as well.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v2: Change '*' into '+' in the regex.
---
 .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index 7a4a6ab85970..ab8f28993139 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -60,7 +60,7 @@ properties:
       be implemented in an always-on power domain."
 
 patternProperties:
-  '^frame@[0-9a-z]*$':
+  '^frame@[0-9a-f]+$':
     type: object
     additionalProperties: false
     description: A timer node has up to 8 frame sub-nodes, each with the following properties.
-- 
2.34.1


