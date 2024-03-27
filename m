Return-Path: <linux-kernel+bounces-121974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DD88F011
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AFC1C2A7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC91534F2;
	Wed, 27 Mar 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FO9RNtOh"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DE15219F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571267; cv=none; b=o0Xf4gNlIoq7jGcOj/QbCpAlI9InCb1FHXnBDILT1jnQ9AbOdkjmw+GabZVaaQ0qPJn1XjU5RxTW4IcgJHlAHsDkRQWEffUsAG8fTnyc7emhlA102alEP5kQtoD6+97I0/5BxlOlKsWiNaDLG5RsIHh+zmiTp15tmSYhl7fxn6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571267; c=relaxed/simple;
	bh=5oad9tk6xdefUEpfxlO0qYtx6N8maziQMfOniCqwJyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm3RZwDkV/hnlF27bGS5ggCOYYqpIxoD8FjviKI1PeCS3bMxPnsdluxjA88I7gZ3JXwUnFSLhI8Vq6f1n+NNKQMnVePj+PgRDDAc99FtN5INf/lXPLU25UPeKFsOBZCGW5ML9NTBP44dyTTtcNVpEiM+e+wNojUSuTNwLklKlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FO9RNtOh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29f6f8614c8so226814a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711571265; x=1712176065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOsAStJoLrdj/BC0nTULl44A6A/+Mu8syVTsqrg00QY=;
        b=FO9RNtOh9nmWPrsc0Wbt4Qb0e9boRouaPAalzw174s+6dQUxuDYtdJz+M2ynUZ9KgE
         wEANRs/JjRMK7KkmPKYBRK7PGnOdBbd8C3iODKCuOdEC/Ndetd4G0HSPdTD9ROUafBYa
         pzCSAXP4pHonrrdhTkuBQ8cGF38U0g6OvKQPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571265; x=1712176065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOsAStJoLrdj/BC0nTULl44A6A/+Mu8syVTsqrg00QY=;
        b=q3/8I9lJt6WPvSzlCy7aCvTHIf2SApoZV5urPusw07GEF60jl4bqLZ7mzSpMgbOUd3
         5AT6z0auj7jJO9W2JjOBwjz9PhnoIj9M2wdK9LTYXgJlCYbC+r4oEeOKzxb2T4QCVitj
         F9faM7tnunaKf3JkO0DNJZDRHtilfu3WuoatC4fx/TgfHVKaXFwiY1dqlW/J0GDjGzHN
         3mMYQzytY0iRorTsPitIJlZQ3qL+HQhpvFAq47kheGN4Kl2g70pdb1WFCSig4oOKX+jh
         EUoP50KTt7GjDSRbL8zaetLG/2PLwrlNlJVBRODsen4g9wC20AwuMm963PFEC+WRBvnw
         gAFA==
X-Gm-Message-State: AOJu0YyEc67bP9pI9ogHLN5Zj7rvc2Ohc03S98jMTOSazR4aXOhp9l1c
	npvJIn2NBeRrJ0mUwzkLc+atCrEdHhv8tWEfn7iM5CEj8MkeAWX0pY3qUirUgA==
X-Google-Smtp-Source: AGHT+IEsci/FRTRW4pt6BJLZbr1PpuxpETOrv0oWRHOV5f+8PsFRccHqiRauOWrEOQ+yKC5ucYNhyg==
X-Received: by 2002:a17:90a:8402:b0:299:72d7:5b9a with SMTP id j2-20020a17090a840200b0029972d75b9amr706179pjn.24.1711571265285;
        Wed, 27 Mar 2024 13:27:45 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id si13-20020a17090b528d00b0029fe0b8859fsm3602158pjb.1.2024.03.27.13.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:27:44 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH 1/2] clk: qcom: dispcc-sc7180: Force off rotator clk at probe
Date: Wed, 27 Mar 2024 13:27:37 -0700
Message-ID: <20240327202740.3075378-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240327202740.3075378-1-swboyd@chromium.org>
References: <20240327202740.3075378-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'disp_cc_mdss_rot_clk' is parented to 'disp_cc_pll0' and enabled out
of boot on sc7180 Trogdor devices. This is a problem because the mdss
driver (the driver for compatible node "qcom,sc7180-mdss") turns off
'disp_cc_mdss_mdp_clk' and that clk is also parented to 'disp_cc_pll0'.
When the display pll turns off, the rotator clk gets stuck on.

We don't really care about this clk being on through boot, so simply
disable the clk during driver probe to avoid this issue.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/dispcc-sc7180.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 9536bfc72a43..a3356a7758b3 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -705,6 +705,20 @@ static int disp_cc_sc7180_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/*
+	 * Force off 'disp_cc_mdss_rot_clk' so that the driver for the
+	 * "qcom,sc7180-mdss" compatible node can disable
+	 * 'disp_cc_mdss_mdp_clk', which in turn disables 'disp_cc_pll0',
+	 * without making this clk stuck on. When the mdss driver runtime
+	 * suspends, the mdss_gdsc will turn off. If 'disp_cc_mdss_rot_clk'
+	 * isn't off or parked on XO at this time it will wedge the GDSC and
+	 * then 'disp_cc_mdss_mdp_clk' will fail to turn on because the GDSC is
+	 * wedged.
+	 */
+	regmap_update_bits(regmap,
+			   disp_cc_mdss_rot_clk.clkr.enable_reg,
+			   disp_cc_mdss_rot_clk.clkr.enable_mask, 0);
+
 	/* 1380MHz configuration */
 	disp_cc_pll_config.l = 0x47;
 	disp_cc_pll_config.alpha = 0xe000;
-- 
https://chromeos.dev


