Return-Path: <linux-kernel+bounces-102404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5287B1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A748D1F27833
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570060276;
	Wed, 13 Mar 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwS524bA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833613FFB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357122; cv=none; b=cu0IL+bTR4tO/NgqwHjQ7ewLuI8we1yeYxMnLM+hwbfVCZeSGxb8kiWEulM/ftU+9gra3cGcd6ha3GrRaxTyJUSF5IZzDD7AWk3dV0Pw9NNGm+RaA7+LIH5yvP3K1pukkRPCyGO+eFBucpEkwGV1Gj3zv47KUsZ4jsWkDdRBPgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357122; c=relaxed/simple;
	bh=xlZAvT3oSRLffXzzTPVHTuzaeuzyCQhhip1y6+yT3T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENQcXSN1qdSfhELtaePR2vzqgDSvFJdOdRktIpcrvmr14bZeRVdRlatIMNTxt9EB/2p+vUw7uujOP6c5AFL4cHnlIlVcf36KyBVLnumrWIOAwfsm669j+ELKYUN5ZLNuWbdHHdOhMSPhXzgszNCYjXdjaBe8SupnoBOSTHy13+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwS524bA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e796cc90dso66702f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710357117; x=1710961917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gq8f56qQF7inQ6M+LC43N65QB908sIMe3u6SShL4CU=;
        b=QwS524bAn+gLdfDpPAMUZBiMgEipEfEj33+DRrLWRBjtL/iFB3DagMVCJ4gQvdpm/w
         OERhE8PiujjpQfs6StypXpUR7lAddiLuSarfy5MEaf3fM0cJ4T+ZalBUVZ8eadfbyJ3S
         e5tzZn/V6kYRBXzw0vULsT/wd8hvwbd2XuX+HyDYAGtR898TqJYYYDOH6tkFqrtsOzqG
         sLliPel/Z0D7WzRwfPVLUEiJOQA+uj76rVMQLYF2tZA/uPkfr6Ji+EsWDrLwVscuyJUx
         0+1JBPGK+vwBsKuLPXG0EWSvK+IfwGeTy51S7crYcyCyhf3YJjqIcBUgFkJ5kcDR037m
         ppFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357117; x=1710961917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gq8f56qQF7inQ6M+LC43N65QB908sIMe3u6SShL4CU=;
        b=FJgAG9AgCXIZlssP7paNVgfFoFvin8aMrbC9eVUFwKDGFDKdDX7H5x7IzkD91Zx9sF
         m9ZeB4JCc9BwSHs9KZalRFZI1wm6J8QOy6m6OZyNGM+lzEDpIuWYdU/mmoGK50WnYsnQ
         7xgU9QW3Ya6q4UJjwu6Kqkmbi40g9iJlIaMfrl9mePT8CZmhg5FBc0YWKcGLz5ahmlaT
         4P/CrAjSvRQfh4HoiQBGDwImXmrkxD3fDJvU12gqZJn08SRL/0l92ROTQeQQ3kTlyTsf
         PvjUCC3bxcu9/ggDDqz/fMDJ8ipx3z2WJ5CdieW9j+KT5nHPO3zHtUO0wOKsLHppCCai
         P7yA==
X-Forwarded-Encrypted: i=1; AJvYcCXTk6WCsW80vO3pBBMeofYwR/tLDLEQBLqLDY77L1Hs4uyl/VbQye8SZO9nwNB2NEBBlRGD56n4vA6pvNc0QevoYXiTOBGI5ISdkQ6b
X-Gm-Message-State: AOJu0YyRigzpPLej2EY0HHDZXn5nHaiFhh5HB/ZxSrgaeqEb33AkK3mc
	35gplCcprJd8XYPU5HtUkpzWRsjUMLezHo3fT4RLedRBF6a8Wk3AuTEuDB/5fXE=
X-Google-Smtp-Source: AGHT+IHMllLxdRaZBf/lrlOMSjorl7Hp1BMgsl5yp7HaJo8pP+fvHbPMD7UndN35jKTHjIPr1a+Egw==
X-Received: by 2002:adf:f305:0:b0:33e:7f5c:7a9c with SMTP id i5-20020adff305000000b0033e7f5c7a9cmr2456370wro.35.1710357117486;
        Wed, 13 Mar 2024 12:11:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c348200b00413ee7993f3sm990512wmq.40.2024.03.13.12.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:11:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: samsung: s5pv210: correct onenand size-cells
Date: Wed, 13 Mar 2024 20:11:48 +0100
Message-Id: <20240313191148.21792-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313191148.21792-1-krzysztof.kozlowski@linaro.org>
References: <20240313191148.21792-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Children of NAND controllers have only chip select, so address without
the size.  Correct size-cells as reported by dtbs_check:

  s5pv210-galaxys.dtb: onenand@b0600000: #size-cells:0:0: 0 was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/s5pv210.dtsi b/arch/arm/boot/dts/samsung/s5pv210.dtsi
index 23459430410f..9720573d84dc 100644
--- a/arch/arm/boot/dts/samsung/s5pv210.dtsi
+++ b/arch/arm/boot/dts/samsung/s5pv210.dtsi
@@ -82,7 +82,7 @@ onenand: nand-controller@b0600000 {
 			clocks = <&clocks CLK_NANDXL>, <&clocks DOUT_FLASH>;
 			clock-names = "bus", "onenand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.34.1


