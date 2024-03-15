Return-Path: <linux-kernel+bounces-104081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840787C8B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA5D1F22C33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376314267;
	Fri, 15 Mar 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXcTFc6K"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AF14012
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482846; cv=none; b=Zqyqa0I9TsMA+lkrz/GzRqJviJp3nO/ycSi6E/VpO45JgPT9WqHuyM3JPSbNhkCEx3HVxMurVxf5oGjSACCl/MGNzDUqshaKMW7gM3hyYpppblwm3YfD6hPizbjC+pLZ/8MPVZEqDK6P9vjp5URoIlOd3ragRAjeuByOe8LBBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482846; c=relaxed/simple;
	bh=rPfFrJBnAulSY0rHFnC89I3kUqU3f8YhptHrQUiyOjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGTvwNlWS0reasGBY5np4gJAkCs6zgNN7WjPejhBZ3aXi4ToHDFDLqChVlEDuKqFoAZuv846jLnK+fSvZTwQOsfysuL1niFsvQZb9jL0fRtjzRvmLdHU4FKqFibwjGjvqLPDmNpAuRpJYaSnrHeR01mS0M8TlVUafvpZ5MQ5zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXcTFc6K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1016349a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710482845; x=1711087645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=OXcTFc6KRmvzJXSLqQ1wK5hWCgZ2kig1rFqI0KU224jnvEFBAFfxC5ePzx1qUnV8dF
         dAjk9entEtMnFE/K4Pq7IfpmjTkkbEPMZSq5x8ijmxkGpLarw62VAmNiHczIvLmCoOwf
         Wr7x2fIOFG0ScAaEJhIgiRJkY7X/58RL6ZncnqnkHNhoTZ+Gikq7R0CksadzqGi+cHuq
         yKlUAvEvXUOJ9aRHDduliAU/lCUXP7AHzsMjsS6PKMGDzhl+ZiJGjbxpatdT9zmZFhbD
         dxKhJNgvUrWQ7ishdToNJqv6zM1ym+oVuaY0FssxQQDMUdbZ5NvuQpNZ8/HCPEsw4R3o
         mmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710482845; x=1711087645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=rwEqx/rdoxjqMlvcm5JhKyfmb/+YJpuvG66jR5kTVj8vFhSJHi3mhoKchzY0DvESUd
         jhRrrMiu8pJXh2UIXMcRuNbEqJwbwBmlcmTCgvh7Co0/Bs3Z15KNcPlh3oSDF4OkbAhQ
         DEPPTckBPbZPPWkQ+OkGYEu/anKd4MUqleQdLIcfHcQ9RN87MEUL63Fk50nqRDW17ZmF
         xjRjElMJAIPVmRBuBhgY0X123oJbsHaWdmy35yG6qreQLQndN5TdDOBRmV4UrhNN73c1
         LF5zF07bvkizXcpCtBO+z+yL3Xmy3ZebUJuzXjOWE7XZ9tlF8FxTCdcPNwtR+BGEKu1Y
         z/9g==
X-Forwarded-Encrypted: i=1; AJvYcCUAReiO8QtovtPaXJ+ZaflbX0vXc+YXFMsA4/nBnVNokn+PdarpkJHqE+yUqvZAHTHjeDwYkOUr0gGuBHJV5Gq5UIw3AkuDvw7Ib3UT
X-Gm-Message-State: AOJu0Yw/eFB3GyhELXXp3xeKBLDLbzPb8lgX/Kc82xHJk37GgoDWrUTz
	uxOnN3AVahXgJryrBHBNsnJOOVTKGAe1NpwF73GMdTHmUVTA7ryE40OjhOIiHCg=
X-Google-Smtp-Source: AGHT+IHFm4sFG8tL4mqeCjyXADUMibOeJ8dbQh7BVj68FUdxiCyg9F3bKknXFUQ7hjlVtpy4pVq/Rw==
X-Received: by 2002:a05:6a20:6a0e:b0:1a3:4c69:6030 with SMTP id p14-20020a056a206a0e00b001a34c696030mr1493226pzk.54.1710482844746;
        Thu, 14 Mar 2024 23:07:24 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.73])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170902fb4b00b001dccaafe249sm2852024plb.220.2024.03.14.23.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:07:24 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Schneider Electric
Date: Fri, 15 Mar 2024 11:37:05 +0530
Message-Id: <20240315060707.471248-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315060707.471248-1-sumit.garg@linaro.org>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Schneider Electric (https://www.se.com/).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..4ef38573e411 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1211,6 +1211,8 @@ patternProperties:
     description: Smart Battery System
   "^schindler,.*":
     description: Schindler
+  "^schneider,.*":
+    description: Schneider Electric
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":
-- 
2.34.1


