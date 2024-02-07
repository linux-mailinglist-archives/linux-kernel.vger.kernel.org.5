Return-Path: <linux-kernel+bounces-56372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331984C960
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1911C25905
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50721B275;
	Wed,  7 Feb 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/ghoCeQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0D24A06
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304523; cv=none; b=kyBypn+C+ELI7e+j8XYghDnqHp9sz51SDmuCmDpljNc155zCg5w4R0OxuVK9t7XYq3VXwS87dJU3MvX4HUcjpJLg62ft6LT5D3WqNP8rrTzSjMl0Bj3E8cTpWqQVQiQ76ES11Ni0UK7sigYC1diIJe8PdNDVnccZ/h9en9JpvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304523; c=relaxed/simple;
	bh=Qvk/qTyq5uRD//DHihb1tNABWl9BPAyY+f5kfI6tqpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A053MNctjG3lxAYhMTwEPsB6qdntfOi6Mnip6c3Nj2gwLUHKKc71Vk+OzxX4cimkRj6BYRVfjXsX0bawBgxatcHiuaAK8NzwWNBBeMdoR9+pbmbGl3zcizN+fLXiLs4lKxxvMrWlFZ562yHC9wWZiRQ3MnZCqhx0sk1NNBsC5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/ghoCeQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fff96d5d7so4089705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707304520; x=1707909320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIGHHabF8PutdD6yHlIxUOJsVrtxrMmEB9CphUfibrg=;
        b=j/ghoCeQU1jY2DHpMha9RYgyMk2tURTXXirdaQveGpVIXi5Otesc77R0cy6yqr6N56
         H/jApG4A1j4iD3IwGM1XS+AiN+l0Z1pCsNoA8ZUZuvEZY1MUAcYb5Db5pUhBOmi3rqyI
         cDdMw7NTLobaH3axAbWxUrOR+b/xnSL0/D3ivyOecDYf5VJ/6/02/a9mdLsG0KG3vL5J
         S3QywqBJRwI9avh7Zh0I5QsvAiuiFB4bpVFg0A6TWst25mEcZYnvo/TbTPOAsfMaqNDX
         naoYFqv+B74tCYKYF8izlO8slumeiLQrBbQmglXLBdEvy+wa6084E6VJ7imGBlDHLiOx
         C3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304520; x=1707909320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIGHHabF8PutdD6yHlIxUOJsVrtxrMmEB9CphUfibrg=;
        b=KClo8E++6V0zLrDIz9wsevYM/crefRJq0EAiP8cdVbafklCElQCJm9+e56iGomWhzr
         yQaXqrgj+jdgegu035cYFLwtznc5kgB+OXwhOYv70Og7+g+fn//pOiG6NQBojkpr3uXr
         0qfZQB/VOAb0lBYV0of/TDaTC2VpOLkO4UiBPxJ3k1amUZUttkaP1d4D/LGHo0WIkvhm
         n+LWeDC8D8itsTCzNKeHHjpLibqM4sa+7piYbvX7vTl/yPLFvD1Is9bshCReDgpULWN3
         3JpPO/b4HLzzms7UnXxElLeIZ6S1sca76Ttb8SuBmp9OcC5nU/O4+g9iyONi2RQBG1zO
         mo0g==
X-Forwarded-Encrypted: i=1; AJvYcCXlR7z1GJ0pbrUpNSO39apC7PSCwhJnVfyF06UbF4b452A6q9gL/D5LYzG4MRDaovw8rcD7ubXhSN40f99F/TRbmemR6uIc/W4bws91
X-Gm-Message-State: AOJu0YzlSV/QNzVg8ks+lR9h0Qz2u/fQivo5lrV312Le58abDmR7LoOk
	o3dB+VoYyn53yW09AVX2eHtgSdboOzeiAcWclUTH2W7hjPRcPvfgqCKWe2z7cgk=
X-Google-Smtp-Source: AGHT+IE9CGBhTz6IqEIMtmUKLJ8oUd2+VeP6Ht9LCZTiTW5XXNTBFYXLGHVKO8yWCmvHPaOXuEgh4w==
X-Received: by 2002:a05:600c:1d12:b0:40e:a36e:f0b4 with SMTP id l18-20020a05600c1d1200b0040ea36ef0b4mr4229319wms.6.1707304520059;
        Wed, 07 Feb 2024 03:15:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgB1rzra9UqBA3upMaaf5o59Vjg2uhZZ8QKt1pA8SFTdfGKjOlgklZAeIzM5PJPHxgDhmyOdkeIAQe9gdFL4qD8EGlM3rl5RwTXpl/eQ0j8jnQ3xHDZ1/hjGGTlJ3Gt953iLaRTDcLHGPmMa0GmntS0U6cEpFTOYH65WuJnajGLLUPkCjvu3mLwSpQDOpEpoEUckWW1wktATCMdWnSAfUH2PIPyd/u2HECj9BXrBzSzNvhEBCZqpDePpeE5i8Kg6XOWJEplB6YAHKqfzxIpTGyLpW5LzItd1Hjex4LxL2OpcY9HSYephbaMNn/gurSobKJRQ6S0fjOWaxpx/wkOofPqIcS0PpalUVO3QYo7eYaZiIOBlDUjmI6dwEjc459lLfHHS8glqCC08SCBID5fiUxpPqfvQcQrpVBetrZQd0m+t7NCgFHnP4zcLjSjfy4jBR7sU/xVxQSr1pJAkWL+iIh/GVdpPPeXFx5bSNVluBaw9kEgGt9UkY85DiZ7lz1U1IZ7pXK9P3I/ev1sMjRIxSQl36U5kDzUGxKQypmZ8Os5XYfrAsOHfwjnFi70YRQkQqxs0qo7RewI8Tdo0+akEjieA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040ec8330c8asm4983260wmq.39.2024.02.07.03.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:15:19 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 1/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
Date: Wed,  7 Feb 2024 11:15:13 +0000
Message-ID: <20240207111516.2563218-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
References: <20240207111516.2563218-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "google,gs101-spi" dedicated compatible for representing SPI of
Google GS101 SoC.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index f71099852653..2f0a0835ecfb 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-spi
           - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
-- 
2.43.0.687.g38aa6559b0-goog


