Return-Path: <linux-kernel+bounces-126897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D4894422
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D467E1F21903
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03314C602;
	Mon,  1 Apr 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvUwOOqr"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE08F5C;
	Mon,  1 Apr 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991838; cv=none; b=TtcTU822aySpSxZS/V73OdKLOJX1yWZ7gs3JBPAgtKIu72hRofnJJcHyj3tEk+lI11d+a9hdLlbt0lZNBI4vynH61RRN0mIZq8EwmHzuIV/yF6TW7CoOVkLKRazX5o72EMjPvkEPU/l8X6AFfxIgCUOxycNkmgFHHgrhhmPB+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991838; c=relaxed/simple;
	bh=Xs8Q6CDyDIOEE03oPZLb/he7FAlRg+HMWx+Axg6xlnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1Cu+EKCJruAr4u69LDSvLvEnIy9h8ES5MTBhemsItS9v7T+37KD+QgmNYkrt1HySAKQUuPOypVNGYY/8JX1w7TEYVLCC60SbCnYVfaZOOGD1CTIdhWMrgBTvqr4gEwPRQBHsLKpri5QOITl2sD9uiMjK+BYVoY6Q6a8QaTt+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvUwOOqr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516a97b3139so1109840e87.2;
        Mon, 01 Apr 2024 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711991834; x=1712596634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNGvPCSXiECHoP3UreuKKK40O4Mox4jdXXntNPnjoX4=;
        b=WvUwOOqrk/iHUMPp61B5LbXc1HoKyPkur0bFy93qvaCz46PmMajb4tiK4iVEzx7vpf
         LZiX55+3ur4e15Zcc1v6efwnSJDo3gbAPXk+lQRbruGwYiuKYqtfnbuoh0uBZ+tYaU4B
         eLfDY8N3Kfhcymdes4EZiuV8p8r3Iz+R9KYs1rZwvDaYMuJX2l+lmmXS/FDxERIaDRqm
         nKSmGmSWH1mOqMTXMr3OJWHmL2AbeBVAG95lFsLuNiDDmNFoEZafsJabKP2cnNEg2HX7
         XOC3g3bieecVF3+mqU4S+SkCk6j39NTPMYc9fEJJD755GnG45WflIX6h6VuFkwTiGfOv
         877A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711991834; x=1712596634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNGvPCSXiECHoP3UreuKKK40O4Mox4jdXXntNPnjoX4=;
        b=hEb8cSC96q3RJqbnzjw89KMbQSHMBnXvCo8UPgb5Bm7IsLAd5XCFMv9tVig5S8sHZ5
         OKXWdfL+aP463YXv9PAmoZ7s6ET/Tb+MNykekrLKp33arrh/LsWP+QNIfEGNGUFiI33z
         4gBG1GZXhigYOMrNtOn4JNgNCTJueoRYGKgnCoXSR9bEQWBe/zI/c1IFwhW4tPHK9eOp
         YvVwRaaLbsRgE96njYuihqg1XfzwCEOjHa64S8PYcv0KCdvLhQzHM20Inz0aVDRzIMPn
         uytnn58vdudhLzIopyNyB9s1E1qbvHFWMYL+P6O0wxuc5icEUwACnQ4RI1CpNwFZjocr
         RJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWggMF9Dgai4aaeQI8RC366hYqv74JOdlc3KUSFoFKkYz2Az6tIsB612zrHJyPTDa22PSmAIVGnJTrOQrvp3+JO65TXj+Po97fCGwMbOtnP6+hpYBjSzsHOfsrfSRqevb7MGxT/2JVml3yYN5l4m7vmO8PXnOiRh/UvjPNuDAByzsCPCesakw==
X-Gm-Message-State: AOJu0YzX9Ekvirk/cgTYrbHxoJ0JK/mCI3A3PszO/2IMJtJEeFazPmm4
	yQ/y27LMFfkZf702dbl/bqwATLG+Ns2Tgz8i0l8qjzENS465xkyYou2L7bLyG0Y=
X-Google-Smtp-Source: AGHT+IFE1cBOnyqgKEuUC+S8xM0ABqAsAE+UMb9sHziXV/4h3sU6jqH0t2nkLVVigWdzn188zOSSTQ==
X-Received: by 2002:a05:6512:3711:b0:513:172d:5b46 with SMTP id z17-20020a056512371100b00513172d5b46mr6264509lfr.39.1711991833982;
        Mon, 01 Apr 2024 10:17:13 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b00a4673706b4dsm5505600ejs.78.2024.04.01.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:17:13 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] clk: qcom: smd-rpm: Restore msm8976 num_clk
Date: Mon,  1 Apr 2024 19:16:39 +0200
Message-Id: <20240401171641.8979-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During rework somehow msm8976 num_clk got removed, restore it.

Fixes: d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out interconnect bus clocks")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/clk-smd-rpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 8602c02047d0..45c5255bcd11 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -768,6 +768,7 @@ static struct clk_smd_rpm *msm8976_clks[] = {
 
 static const struct rpm_smd_clk_desc rpm_clk_msm8976 = {
 	.clks = msm8976_clks,
+	.num_clks = ARRAY_SIZE(msm8976_clks),
 	.icc_clks = bimc_pcnoc_snoc_smmnoc_icc_clks,
 	.num_icc_clks = ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
 };
-- 
2.44.0


