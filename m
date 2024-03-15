Return-Path: <linux-kernel+bounces-104321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3F87CC27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67E11C2227D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7871C695;
	Fri, 15 Mar 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CggN73De"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BE1C298
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501397; cv=none; b=lE7KultRL/QqXUiCpd5MpCL75AJTLayZLUN0QDe6NkUT70WXinzQfJcmygitRlsyd2NO6n4z6IhnnLNN+BiWGxq+9iaq8XDTvgcI1qBLtKEmCvbcN7iv5oxutvlKEkLB0IucuxuMrpCo/ZBep0Ry0p+/9bsDIirXW1Ap/sdHFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501397; c=relaxed/simple;
	bh=YpK9B0f8PSiwV/jMDxO+BOeqJp7bjd7POHW41IxWz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/P91arn1mgEgsr3n3RtJIJmu4WNGWWbyBc2vm+hbw/iXxl2+RRWhf7Q/TeLtonAiLCmrhzHaECX6uCSVQ6PldKou675qAUDPZY1uOZhA8pX2JQ99+6aGpWIItuj+4QIVM4WjOpVc6QJFkqxUxQiuV4NX21RRg9SBBJh/B3to44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CggN73De; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6c8823519so1935258b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710501395; x=1711106195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al0RWiU4gJElSS4Z7Unyt/qe+1B4tsgOmYSta+HjBpc=;
        b=CggN73Dedi/tTO0cb+sRDWGvs/nn6XwNSddLkfZ0CAs1R3wVIzNnETtPloUmmB+ORD
         UlXdPYvBSm2k64Uj7QqbVNZoJK83255JwytNOmDrJvSXNGgfnqB8KzeaT4CrGx27SVa2
         Ul/IjisPuzWlJrAOiTMtRCNfv+46vDCBhga4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501395; x=1711106195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al0RWiU4gJElSS4Z7Unyt/qe+1B4tsgOmYSta+HjBpc=;
        b=Aaw4uR+QXwaVzxH2GBPKgmGNvPuNq9HCgD72j0rDY/GF16tHbrHiRMcK1+MRgRHowg
         RkVI9DIPKLp58Flh8W9FUzVyHcE0S8xUtCXmyqqx7idaUdm5HtumzjzdqsCMjNMedE2Y
         0jMcaeUG7fieh06v4jw1EhtnSA1gEElWquZWvfS/S1pGMOzAS26PqmneluB9Wi2n3V/M
         TdUNwDYS+ZZ4ZjHq8Jk1A2Bfu3z0+DzfenE97zvjY7vUalIJ+LpQJR73wHewrGQMo9om
         yjww6MV09r4ghVjGOBmrkfkSCaIH6d4Fzicr7v8VXIKwUlRwr4QaWLgn9ERd+nfzLJha
         T5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWTV3kwuc5hglRA0pLLFTT47j8B83wazBqX9p0cxCxUfAHDLhzUFbdf11b7wRzm7udOotDTYyg8X4CWumphxeahuHfDuQ2F8Sn002CD
X-Gm-Message-State: AOJu0YypO4fZOfTMcjHTHP7jUI3XurSVf4bbNu1dmylhc7sIzYqi1DzC
	vcbcKVfK/eRmy7MEVt5vtgnf0R9C2AhG82OrXSqpRGcaJjn96/DCE7Tcmjs48LppkL9XxgZzFhc
	=
X-Google-Smtp-Source: AGHT+IEAdPZ814mOPF422g9xOunYnTCRZxGPQITS45msqmivfaAABFu1iB7POKJ4pYGf6WbFacC8iQ==
X-Received: by 2002:a05:6a00:2389:b0:6e6:5374:411a with SMTP id f9-20020a056a00238900b006e65374411amr4806672pfc.18.1710501395445;
        Fri, 15 Mar 2024 04:16:35 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2f9c:c00a:bf1f:e53c])
        by smtp.gmail.com with ESMTPSA id c11-20020a62e80b000000b006e6aee6807dsm3122683pfi.22.2024.03.15.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:16:35 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8186-corsola: Update min voltage constraint for Vgpu
Date: Fri, 15 Mar 2024 19:16:05 +0800
Message-ID: <20240315111621.2263159-5-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240315111621.2263159-1-treapking@chromium.org>
References: <20240315111621.2263159-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The requested voltage could be lower than the minimum voltage on the
GPU OPP table when the MTK Smart Voltage Scaling (SVS) driver is
enabled, so update the minimum voltage constraint from 600000 uV to
500000 uV as listed on the mt6366 datasheet.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- New in v2

 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 3dea28f1d806..1807e9d6cb0e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1296,7 +1296,7 @@ mt6366_vgpu_reg: vgpu {
 				 * regulator coupling requirements.
 				 */
 				regulator-name = "ppvar_dvdd_vgpu";
-				regulator-min-microvolt = <600000>;
+				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <6250>;
 				regulator-enable-ramp-delay = <200>;
-- 
2.44.0.291.gc1ea87d7ee-goog


