Return-Path: <linux-kernel+bounces-105496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01187DF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303D2B20C44
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88801EA8F;
	Sun, 17 Mar 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJV7TbEc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDA1D54D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700901; cv=none; b=kgkANfgWZdtaZB4mI75CBPgVdKLGv+yR3rSX7gAvlQHNPFDVDeR08jaTCPMq/JK7JQJeiukAGWGsFwnUr+vCPTxqXiTnVbYHZl1mUnAt2FLKT4N+Wn8JDwjtpsG1yPdwrYG8VAxeIrP8FKlfLGfRtS9UTG3M9qkeaTcZC8lKfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700901; c=relaxed/simple;
	bh=Wu9Nd161FfGYTW3cdgUBizaowguROAhMQjD+83XddZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHu94UwcY/5e9pS6JUU/0BdNixZQmu4lQlepf5I+DMJdmciUp8FWryYMcNhjHMCN/pbNTAdK+36HMbz2QjuDBe2iP/gPL/XACsgeZtf80BqhFVslQuFRg/Sb6fCAO37x0YDOsZ98oTq/NKYNH74EfFRqy4Sj765EvzYmrgVcSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJV7TbEc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568a53d2ce0so4054998a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710700898; x=1711305698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e14jYuFbqzpNdPgZtffp0K2rsnlvD+gHqPk0zI2q0lU=;
        b=XJV7TbEciERgKG3vqdKhZ3rwlAP8+nB0l8ixxVGeYZUZ/4Q9LPEjcRsT6tdHzpDEud
         ZSRBo38lo/kcKyYb06huyrgOyeNc6rEMjmL2wIaUc6QIfnWoBzO2erD30DODbho1QtWd
         fr+N/npOyoQsfmu7Ht5FMKrracA9UvFA+sQuRn/PtFvgdv/DnU+QSPsalPy2E+UHYkPG
         CpXJ55R4rXZOj9ejwtQco06n/9J5qdiLf87vPi5mUmYu6yRM8KqRMfbK3GJOniYdhzx/
         v3WoQVditbWrcT7uGKOOKVKWF1xzT8qQmXSNfqFhPEURhZayXZOvVuCygfha4DV1DiIf
         boPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700898; x=1711305698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e14jYuFbqzpNdPgZtffp0K2rsnlvD+gHqPk0zI2q0lU=;
        b=Jy7kRWqgz+Ax4ukAE3xfPAXlQk1HIznOSdXfIOE4RegGSqZ1MSvoFJ2SuIB3HoXjd4
         So31mKmrvdSVruFmL+T7aXSnn3itrwCHTs5bZ0mI1ioZHHWk9CHef9pke2lcHlauE6PL
         d84HqK1AGLyOj7tr5h/o+NT9LlSI9UFhSAh4Sb+ozcbXvM8uT1CuVUyi71rs4Qf3YMk/
         smDx4gU5DMobcInGl0OSBtFEdZGe7G0E+nMy6bWYaxCzPyhjkDG8Usv0U5e/seYHusDA
         xJFB1v+17T7ePWaOsoSKxu8oOqKeNAJel5J57MNkbh0oYhRy2WuS+X5qKhPwSqomHYr3
         7OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk9v4Bv4Nkbiu+Ew+2MjQQWOOaKmpdtxyOzFQQNv348c2DbwAPE3vz1/SlAqgHRlCz0PNXTY3vTBwYTqhfMHlhp4YjLpcHcBX12TAE
X-Gm-Message-State: AOJu0Yzz0R2Q7LLbVjYZ0WoxJGFGFjUSqcxpqQdYwVhlOG2S4DOq9xJq
	IjFkO9xVeg5LAO3Tiiah8OfxpyNstvwreuzi3PE7Tj7I8FsLIK3/cVvhcSCFb1s=
X-Google-Smtp-Source: AGHT+IE+WEYLkK2Xr6I7GOUWRruUBNYvrXmePST78xe3ptjzIPZvGVaFGeYhPe/DfSzq69N+wowqiQ==
X-Received: by 2002:a05:6402:e9f:b0:566:44ca:9f5c with SMTP id h31-20020a0564020e9f00b0056644ca9f5cmr7622436eda.8.1710700897803;
        Sun, 17 Mar 2024 11:41:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0056a2b87787dsm242877edq.37.2024.03.17.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:41:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: allwinner: Orange Pi: delete node by phandle
Date: Sun, 17 Mar 2024 19:41:29 +0100
Message-Id: <20240317184130.157695-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete node via phandle, not via full node path, to avoid easy mistakes
- if original node name changes, such deletion would be ineffective and
not reported by the dtc as error.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
index 3356f4210d45..067a2ecbc0a4 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts
@@ -43,11 +43,12 @@
 /* Orange Pi R1 is based on Orange Pi Zero design */
 #include "sun8i-h2-plus-orangepi-zero.dts"
 
+/delete-node/ &reg_vcc_wifi;
+
 / {
 	model = "Xunlong Orange Pi R1";
 	compatible = "xunlong,orangepi-r1", "allwinner,sun8i-h2-plus";
 
-	/delete-node/ reg_vcc_wifi;
 
 	/*
 	 * Ths pin of this regulator is the same with the Wi-Fi extra
-- 
2.34.1


