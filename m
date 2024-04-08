Return-Path: <linux-kernel+bounces-135130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDD89BB76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443A4282B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE943FBBE;
	Mon,  8 Apr 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bs496o1m"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E818E0E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567891; cv=none; b=nKRv8DwQepwIG83sBkBOHwGjfPHnh0v7JzSi2kwFjfyHlVpBUT2n4aKL73AUhs4tnbuAI4i4QFYhcqrR4mIx3pcTw3Xw2EWsloxapeMIlQozoffVAwxhC3TgiSoreT/TDVWcrogRE0ZIzom3TyaokeJJ5gefujFOIK0htRBoYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567891; c=relaxed/simple;
	bh=xjwUdN10CjsJZjh973zo5V8Q/lDBawSFqqbnjtrDn/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUTPtyZRMJRsZMfaqPDoeHOZxlinZr8/Z3MYKTzLoJPlbF2E9mzBXjkkNVc2M/CTN/POxKy/MLjifvZeSZs2MgYSkRNhxBbftmwMQ/xn2uzpeOJ41FRu8ge65g15GorRm3HeCvHTTFI+zQO8oWhfHfvcKZIY2mzNef48cBHtsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bs496o1m; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2c9903ef0so2918997a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712567889; x=1713172689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ+a9b/yyBQoRrz5uKGPZjuLE6NdFjAqEAuWnxBbk4U=;
        b=bs496o1maxW/vGcXb+bDnBJSk7qplM/8+fs6YFpm4ZWIGrebt5mbN5/CdNdbO6chHU
         4XKQw1MyaGBtZFn2XhFgjcYmH2R+1fEWvVlLeWMJdbKe5gam4BeJcUAIOXCNRfNv5X15
         MITS6wqQVzStvcuTq+4ciivE2JUVBwkY4wx4OcK0B3BpSOsh7HCn8sQtluN71/FXTUHj
         G3IoI1iiFBPSHbxes+amTXcTBmaQAHF13iCIbfixXgosSBqf00v8jSgxT4t5CYqx6rF/
         bAqv9VOCThjlmiHNPv91fP5wQUB5f9uFbuW8rRh1DVa1LhkKEa6B+7gGfauq/GPxVvDo
         NDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567889; x=1713172689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ+a9b/yyBQoRrz5uKGPZjuLE6NdFjAqEAuWnxBbk4U=;
        b=BobZ2gsOmEDn+7JXQ1R+w1/l4ORdqfFVHWQKoo1teBx3CzLG9P6Cp64zfbeYxeW78e
         46If0+RLceI45NFh8DZdS9gc6e6auO6eW7OQsVRjJEiuldt13XINvWZNTUOlQepBmKrV
         H/arGQrMDZEOfiyI8siHcIQAly6QOSJceW25qjeTSTN+14G6lWC7p+Oz150RDW8edLnB
         gDlb29kCQ2WNKoKWvuae/fGxnK2EiuMRBI6fIpFYC7Jh6afBBHXqvT67km6siZUTwAcV
         navr0MT6QMPu+UMCNkyr9/5LIvZsiJdFgJr7j/Qx8YQ+GlmaCRn7gLXy67rPU80cKZzF
         ErGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW55jrJbFXevdLkazkiD4yQzfuV/Xk94ynFy2QcO2BGMRNRrGbD6H9U9YOjptn9KZcSLLr/hM0ljBk67sVXs9nufzFM2AnoHAPMNztr
X-Gm-Message-State: AOJu0YzTA9huwSOSAYhPiSQ+FxJ6LTf5TRTKwpplkPQKhAREjnoOrWpP
	NtpOoFHx14diV24s0YGZJ1ZkCdBDnx0KgorPujsvqVsaev7vBh6NDiOhfnRUqoriObaen+bX6st
	qadBTzw==
X-Google-Smtp-Source: AGHT+IHi5RZwxXKnBfFno8pVX7cRaumvMEbsem9ikm46d/ihvdHjbtsYEjDdWwYOzCXi8rR5QOMJsg==
X-Received: by 2002:a17:90a:130b:b0:29b:22d2:9dd5 with SMTP id h11-20020a17090a130b00b0029b22d29dd5mr6894064pja.38.1712567888845;
        Mon, 08 Apr 2024 02:18:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s63-20020a17090a69c500b002a51dcecc49sm1532017pjj.38.2024.04.08.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:18:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Apr 2024 11:17:58 +0200
Subject: [PATCH] clk: meson: fix module license to GPL only
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-amlogic-v6-9-upstream-fix-clk-module-license-v1-1-366ddc0f3db9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEW2E2YC/x2NywrCMBAAf6Xs2YVtjMX4K+Ihptu6mEfJ2iKU/
 rvB48Aws4NyFVa4dTtU3kSl5Ab9qYPw8nlmlLExGDKWLF3Rp1hmCbgN6HBd9FPZJ5zkiyG+MZV
 xjYxRAmdlPFsaaHLPS+8MtORSuZn/3f1xHD8k59VpfgAAAA==
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8776;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xjwUdN10CjsJZjh973zo5V8Q/lDBawSFqqbnjtrDn/A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmE7ZL89go/quwtMveKQ6nLbQtpLAjWpfkce1ffITE
 Kb1cAmWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZhO2SwAKCRB33NvayMhJ0caqEA
 CJvHwSkpsNtoe7ac44udmtD52Bs0aAFUXoFBboJ9b7TjPI246X2F1Cy0ZG4C6hJgnGx4iyjrutSI9t
 i8L21DHmOqEoREm+OV6gA3pccirC2oLS4ZWTx15k8E4elEHIaOeorHL4M94lQiLm0n1nWpcH3340uU
 8ElF58DKxfNXHDLrfr7VP4POZoK6eX7xburq1cvt+7DP6Y9tq0s3/h8+XbqiGciQaOGyoxbCJos3Xu
 KgaBNtWwbvwdYs/hv7j1NXK9X7xBHxGvF2Cw4bkEWmRg+0a7xmItJ1pHFcINp7SFi/vUC2kygkJORW
 jOtBaLSisl1xmCtn5RhZ/zkPpi+LwAx978Eb21DNRHmjSTzR7MtquKIGaK6Hu9Kvv57FYMRYPEYRPE
 AGQgavwTVahD6H8dNCS5wSCF/nqepejy0NXdfgsnjwT9fwLL7oh6M7K33hTfTWyRTtvurY+cFbsBsA
 6Xz0/O7wVFyye81o6pBAmdih3kuS/5aKxZ2O7Is46QIA02zLBOD+MwkxnyIVkVdROjM8OX5PY/vRLJ
 x0xrfhLKRKgcnty0Rzz2TBBGuLBZKx8L32OB29OZOCEuv8IT64USgLYqCtuq19Sb/MkKFfNGiAlrOQ
 R+oD52dnZ8lkMoaM2vkdW1KDLPb7a1Xc6/j0ZWdM5bPQdA3K0KRy+aV+/V9w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Fix the checkpatch warning:
WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org/
---
 drivers/clk/meson/axg-aoclk.c      | 2 +-
 drivers/clk/meson/axg-audio.c      | 2 +-
 drivers/clk/meson/axg.c            | 2 +-
 drivers/clk/meson/clk-cpu-dyndiv.c | 2 +-
 drivers/clk/meson/clk-dualdiv.c    | 2 +-
 drivers/clk/meson/clk-mpll.c       | 2 +-
 drivers/clk/meson/clk-phase.c      | 2 +-
 drivers/clk/meson/clk-pll.c        | 2 +-
 drivers/clk/meson/clk-regmap.c     | 2 +-
 drivers/clk/meson/g12a-aoclk.c     | 2 +-
 drivers/clk/meson/g12a.c           | 2 +-
 drivers/clk/meson/gxbb-aoclk.c     | 2 +-
 drivers/clk/meson/gxbb.c           | 2 +-
 drivers/clk/meson/meson-aoclk.c    | 2 +-
 drivers/clk/meson/meson-eeclk.c    | 2 +-
 drivers/clk/meson/sclk-div.c       | 2 +-
 drivers/clk/meson/vclk.c           | 2 +-
 drivers/clk/meson/vid-pll-div.c    | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index d80ab4728f7a..e4d0f46f47f5 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -340,4 +340,4 @@ static struct platform_driver axg_aoclkc_driver = {
 };
 
 module_platform_driver(axg_aoclkc_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index ac3482960903..e03a5bf899c0 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1877,4 +1877,4 @@ module_platform_driver(axg_audio_driver);
 
 MODULE_DESCRIPTION("Amlogic AXG/G12A/SM1 Audio Clock driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 5f60f2bcca59..52d610110e44 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2185,4 +2185,4 @@ static struct platform_driver axg_driver = {
 };
 
 module_platform_driver(axg_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-cpu-dyndiv.c b/drivers/clk/meson/clk-cpu-dyndiv.c
index 8778c149d26a..aa824b030cb8 100644
--- a/drivers/clk/meson/clk-cpu-dyndiv.c
+++ b/drivers/clk/meson/clk-cpu-dyndiv.c
@@ -69,4 +69,4 @@ EXPORT_SYMBOL_GPL(meson_clk_cpu_dyndiv_ops);
 
 MODULE_DESCRIPTION("Amlogic CPU Dynamic Clock divider");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
index feae49a8f6dc..d46c02b51be5 100644
--- a/drivers/clk/meson/clk-dualdiv.c
+++ b/drivers/clk/meson/clk-dualdiv.c
@@ -140,4 +140,4 @@ EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ro_ops);
 MODULE_DESCRIPTION("Amlogic dual divider driver");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 20255e129b37..eae9b7dc5a6c 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -177,4 +177,4 @@ EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
 
 MODULE_DESCRIPTION("Amlogic MPLL driver");
 MODULE_AUTHOR("Michael Turquette <mturquette@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index a6763439f7d2..ff3f0b1a3ed1 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -183,4 +183,4 @@ EXPORT_SYMBOL_GPL(meson_sclk_ws_inv_ops);
 
 MODULE_DESCRIPTION("Amlogic phase driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 6fa7639a3050..7f96ede7fdbe 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -486,4 +486,4 @@ EXPORT_SYMBOL_GPL(meson_clk_pll_ro_ops);
 MODULE_DESCRIPTION("Amlogic PLL driver");
 MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 8ad8977cf1c2..ad116d24f700 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -183,4 +183,4 @@ EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
 
 MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index c6b1d55cd7c8..58976ed8b92a 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -475,4 +475,4 @@ static struct platform_driver g12a_aoclkc_driver = {
 };
 
 module_platform_driver(g12a_aoclkc_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 083882e53b65..c7c3a9259427 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -5610,4 +5610,4 @@ static struct platform_driver g12a_driver = {
 };
 
 module_platform_driver(g12a_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 4aec1740ac34..dbda563729db 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -300,4 +300,4 @@ static struct platform_driver gxbb_aoclkc_driver = {
 	},
 };
 module_platform_driver(gxbb_aoclkc_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 1b1279d94781..29507b8c4304 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -3569,4 +3569,4 @@ static struct platform_driver gxbb_driver = {
 };
 
 module_platform_driver(gxbb_driver);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index bf466fef263c..b8a9d59e6726 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -89,4 +89,4 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
 EXPORT_SYMBOL_GPL(meson_aoclkc_probe);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 845ca8bfa346..3cbc7f233bba 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -58,4 +58,4 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
 EXPORT_SYMBOL_GPL(meson_eeclkc_probe);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index d12c45c4c261..987f5b06587c 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -251,4 +251,4 @@ EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
 
 MODULE_DESCRIPTION("Amlogic Sample divider driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
index 3ea813a0a995..c0a1d24844bb 100644
--- a/drivers/clk/meson/vclk.c
+++ b/drivers/clk/meson/vclk.c
@@ -138,4 +138,4 @@ EXPORT_SYMBOL_GPL(meson_vclk_div_ops);
 
 MODULE_DESCRIPTION("Amlogic vclk clock driver");
 MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index daff235bc763..ee129f86794d 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -96,4 +96,4 @@ EXPORT_SYMBOL_GPL(meson_vid_pll_div_ro_ops);
 
 MODULE_DESCRIPTION("Amlogic video pll divider driver");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");

---
base-commit: a3c4ce7a4b9c1fe78f66afeea6eb89c68ef45f9c
change-id: 20240408-amlogic-v6-9-upstream-fix-clk-module-license-34060f9b5192

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


