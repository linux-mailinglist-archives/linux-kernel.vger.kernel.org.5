Return-Path: <linux-kernel+bounces-57905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0E84DED7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48D91C25E58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC677F0A;
	Thu,  8 Feb 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxqdhEdE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AF76C82
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389588; cv=none; b=or1DozS7qbG7GWAfFSQdtmjcG+OqBtjJbgLOGX9mWrxrUkDww2eZcgLm+53NHbtqsNLQcED8/NaQfDVbQNZ0+c3K2PsgMD3lGCyhr/KaSe9RV2hZA+PQIDwu9KESwoHlXSCZyW3WPyDTW+JInReEdk9nc1eC95tkT5Jm/mp/AgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389588; c=relaxed/simple;
	bh=r7neQIZqlD7kZSvzFfitQ/605+hU2dKz4dgTmnCCuhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0ZkwGmh677uPiKTP+gKdKmpcNEPpBXZL5QVq6atb6ER0H6/BZLuoYXAxdWB55GN7brWQaLc9V0jdCGb+0wG0aJNI89dZ0w+LVFlZePqy/YF0qSlSxjs1lXtihb1V4I1ylOU6Mfpw+F7SGkV640eBVEI++kmW5VF74YZQtxicso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxqdhEdE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511234430a4so3401174e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389585; x=1707994385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsvFX7J4wC4rV1ETkXmUe+0x+lfVuedy1wld88CqNbA=;
        b=kxqdhEdEBtHjGxY+E/rgGCRqppMIBCREJrc8ZtNfIm950dwuQtl1sen7JtPni6G5W/
         NtbpjrBEUoJgrRZuAJM4gG6tdLyiRUrkWTOzJiq/1O0CG8Bokx8lBVqpSZlg4ZjU9b5N
         GXQ488jPVNoONjArSRlnXMz2GvMSq4DS4H23d0+7I4wu09oEEh1H1k8O84AAnJ+m05A2
         NyVsgOp2ylLCZ6qgO9nvpzZwo8hABb97JpCMgS9Rn6/L/xJbEaVFEVamPJBjyr1K+yvv
         6QnFFElBR+53HhzrOu93x0C1HPyekOmZLhgL3Zpp7XiwlQSGoMILz0jLw5hUh5LVs4TP
         dO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389585; x=1707994385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsvFX7J4wC4rV1ETkXmUe+0x+lfVuedy1wld88CqNbA=;
        b=fUs3OkJswRNlA9nTuBQekIS/zqZWMIZ/yVM6EG4ShI5NDdW1bpqcbasBxSkiywtLNs
         ZaBq3+9YD82HLpHp/CwdCEgRRy1YhDZ0L2MrxHj2PN3Fu7G0EPwz0aoA3B6/XQYymar/
         wjJ2Y3wRTBHh4tnhQj1GJGBrw7iVK36CuQgnWphwINqWIg+bhOdDFlnFRg2DpD3m13Oe
         z7UgukuyxBrnIcpKfeJDnexFpN8teRstCUcGBwG0Vo8Wq2lXFEZhStDSy67G1ua5ufHz
         ouwxYqaeyMBV2xVDGigas2dCARixagibuhfeQvesMAFql/Uq+ybYidiQeGx+9vwXVTcw
         QB7Q==
X-Gm-Message-State: AOJu0Yx1DmDqk6h8QwFbgpE75P0GtRU0SLykFW9Gz4T2H2bxhT86c75C
	vr5Y1MlKSdoLS88sk0NO2sL1BH2UDkgyR0iAhaRQSqFQwmQuJ3lJSqfrggT6NFI=
X-Google-Smtp-Source: AGHT+IFb04yQV9E6QtRgImmRiODLQcP1FPjgehHeg0frAo6CFt4eUX5ECX91r3IH+PwfKgKacayJeQ==
X-Received: by 2002:a05:6512:b84:b0:511:4889:e27d with SMTP id b4-20020a0565120b8400b005114889e27dmr6538440lfv.42.1707389584948;
        Thu, 08 Feb 2024 02:53:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXkCHAjeFyN0Fsa+RcAqpxHyvfgJcwgR3h6Oip0IPelywc74iufW2oz19V9yOP4c7WICHUtvAyg+UTEn9rxI7ZMXJ4U3uubUhblVEg4wVHNGqnAeq6cMjqCG2sCHAHvViXCNDsAv4vUAGT09JNaIDDhN8W3t96/RZVubx/Jo/tUERWEmkamXTHts/xZhdASDOdavb6YMtFAXkTN7fa1yR7MsFxoz1CTh39F/UeJicSkPrpsogXS7e7enIDYLgKsDBLwB9pPQen4X7YOXX2D/uM41364VTkFVuml7SeOjYlS/gEDDSlv2l2gwfNvrVgXoFrlRvDRh70XNz5Wv0p/g==
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d468a000000b0033b44b4da56sm3331975wrq.111.2024.02.08.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:53:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: allwinner: use capital "OR" for multiple licenses in SPDX
Date: Thu,  8 Feb 2024 11:53:00 +0100
Message-Id: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi  | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
index dbce61b355d6..4bfb52609c94 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
index 1fed2b46cfe8..b2988f500231 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
  */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
index 832f08b2b260..ff84a3794470 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
  */
-- 
2.34.1


