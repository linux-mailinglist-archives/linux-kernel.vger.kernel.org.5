Return-Path: <linux-kernel+bounces-85995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9F86BE41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31AF1F268D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD32D61B;
	Thu, 29 Feb 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XHx697qe"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533E2D046
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170112; cv=none; b=oRhEY0053KNMAHionSeNzGAV790LhgFLFsm4CspBoD+WFmNMXQVGPXHpGCGDLQD5XsbIBWMMLVgNZBZVIMFz6LcnymsqC85gNi5++MVgHNC+/STrsDrvEXb6U32iW1qtL/KyYdXKnInmZAzrs/tXWWzcJrXKgdoBBmTX8Zt7eSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170112; c=relaxed/simple;
	bh=jh68udILcKxaKugT7b2cDM3HVtsQku3plCWj0K+LaSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzXdxOhxw/Gwnl3X4dg9wEUriZuaR/lR5gU3ePiptzHGzjzEuy6gXKvnHE58TfE4NnqPTRgnkEQt0UC7oYAc+ALHoK+750NTq4/jbBf7AhTu926NSXNvzpkxFhWV6Nga9QjoNYHD3poj0z0NEA5FyRsG5gDEtxtu4fI+JN92o8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XHx697qe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299b92948a6so217447a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709170110; x=1709774910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jq4TUlWX3GIYiIoQ+zpQ3OQeTgAG70ET6DGeOsDe4E=;
        b=XHx697qe9z3HwXLUSsTt9Mhd/6bxPVTuBe6U6tUDm8aJNDxWkjG8i5/pfiDd76AR0k
         G3JRD8k0+iJXMWKuem9K5kSiLtHqGtv2RK9dexnZgh6EOtrW663izFVwaxJfgMCbfDFP
         W+ThHSZT+ChgizjkpXFavXMssKO0KxM66eYb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170110; x=1709774910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jq4TUlWX3GIYiIoQ+zpQ3OQeTgAG70ET6DGeOsDe4E=;
        b=sDiXBTbR05WiRjRoeuHCiQ28tXjz9G9cGqbs0ip8rgbwj2+4H2Svo5wrEEHk5vroik
         5IKa6Zq1RASK1jnHTKvc1eRk5nFRBa0MM+RqhAswv6JL7wbQwR8h17tGrFGNFwTTEvAQ
         516SUEdLHs+xYhZDwa/yGNY9h5gSjUaLWLn0bT3T2m7fFFID2PtXzZm+Xmpouxt+3jej
         xkIo7NMcTtKiXWyBWaemG8LLTO7b8Z7+zAyX51kwjn4bJ5lEyGBGrshvDtH+OA8qqxFS
         4Y0OSKjKDtVwK6GmWm6pE/LOgKLJhJcWGYYYPALaZjLKMZ9ubgvFGp7AWxF+cKg/WVS+
         x8wg==
X-Gm-Message-State: AOJu0YzcYxIFNkg7R5prMM7ryjm9Lq4OtEWe4RWH3g/U2JUl8s4+Al4Z
	U0EH92QJvbtbkpiDnQirKE9HwwTiLCGzJex5MVYqT4nRGjb8cDAhPq4qOgjjDA==
X-Google-Smtp-Source: AGHT+IEYN2In2MRJucUTR7e0wGoAIi/LK1pWKTCPgEITDs7weQjpJtIRVTB+q8iM3JfA2fuLcWiVug==
X-Received: by 2002:a17:90a:734a:b0:29a:6cf0:57a3 with SMTP id j10-20020a17090a734a00b0029a6cf057a3mr864753pjs.8.1709170110507;
        Wed, 28 Feb 2024 17:28:30 -0800 (PST)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with UTF8SMTPSA id mf12-20020a17090b184c00b002904cba0ffbsm2187303pjb.32.2024.02.28.17.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:28:30 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Disable pmic pinctrl node on Trogdor
Date: Wed, 28 Feb 2024 17:28:26 -0800
Message-ID: <20240229012828.438020-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't use this pmic pinctrl node on any Trogdor devices. The
AP_SUSPEND pin is here, but this pinctrl device isn't a supplier to
anything in the devicetrees that include this file. Disable this device
node in the DTS so that we don't waste time or memory on this device.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba28604..774c0647ea19 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1164,6 +1164,7 @@ &pm6150_gpios {
 };
 
 &pm6150l_gpios {
+	status = "disabled"; /* No GPIOs are consumed or configured */
 	gpio-line-names = "AP_SUSPEND",
 			  "",
 			  "",

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
https://chromeos.dev


