Return-Path: <linux-kernel+bounces-135279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128789BE58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900DA1C21B21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B396B6BFC8;
	Mon,  8 Apr 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+izmYXK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2C6A026
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576836; cv=none; b=DMn63ZShpU4OHUTzn7SE6dlRhCD2o63pyoyurz81j0uKRhdfm8vNc30Syo5HF8dQFYOWGoIzgY8INoGoUAzCQ/i9E5On7RSNialZS2JSfkSU6+/vEX7hGNeSFExqoh7sQ+jX/VuS8Tv9CSHWKHPJOmKwa95npyaw21lTKi+ptkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576836; c=relaxed/simple;
	bh=FhQoTr0AvrLk6QoJyJABfGJzAUBSTtD195jvIOJBmlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDnrmsqVK3l84rgQur/iM59iBjAFoj4SijTJhzE6CDPjfxox7ULgIXky6EB6dNdRuqXIJLKhezLIhaRgA2fIL+tk2zzlqUuL8tExm6cPEHN8FUnK5udSo73ApOSeApUwP09uSP7KOp6JDbrL3+FV8OZqDfaa5vciUnev45/QAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+izmYXK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so5349442e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712576833; x=1713181633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfh+IFGGFO50cagmdMAMy2wvELw0DUI2fSJUlsAEF90=;
        b=d+izmYXKe/iZeQ21Aka/4JDA1Qpa3H2PBuWSQjgyouCe4U7pfi7Izu9O4jwHnu95hW
         a03i1m6voL83pQiqJElPztguUGxnxuPhqov3O9U94wDIeO5nAtNQLpnhSYjs93RTBLiV
         COd6P6R1BFN81GIKo9+5b2EJ8/wcf8O4KwD+vBe+/udvu/+CwT49PTZsc+Ncy8NCn1iJ
         4XNzXX/UQuzCZtZFbZ0acWmByZg/zkAtr8r3Y2EPSCOpF8W1bu4L7P8c/45nPMmj8DY7
         7dM6rGCjVgb9mz2DhRZ91SkEy9waiG/RI1f9TVOt8jrFn42a3FL5f7zoYUpEMs+8dasy
         9nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576833; x=1713181633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfh+IFGGFO50cagmdMAMy2wvELw0DUI2fSJUlsAEF90=;
        b=DXrAdHy5W+u67604EdKmq1GbxWcLxOYYH/PIxqfklrvcZOvb8WyukMd9ocwAnceCeC
         hd5u2gLsfbcoNgVMuvsx0YZgz0MD9Ki2LIKVmfxuUP7W5ZJKgufSaXYngpV9oZMkCiBh
         ptKFOirGAqnKJxyNbnjOH6F8k5KYPVjP9PBGfwXYBIhH+MiR1UvJsI6QB/FULTspdA86
         aJLAwfV937waMXlrbton72K7fobnHlbpeg9izhTnZ2yaJUS/YIV066hxCmU40XfT3rHl
         loe0GPUu/mdTV5F9ChIT5AJg4DzDaWo/dCbEzce28nFQFQqmfvuEXueJ7+QXWUzpz89t
         A98w==
X-Forwarded-Encrypted: i=1; AJvYcCVRnTQJJVUqTdPt7iJ3G6DOcAFh18oUrtdvA9mRwZg0cWaYzT7AT+U1CwKXDe3+o6ojfIitEhIgwqlhK9mfCaq1k17WMgBPkErxG8lN
X-Gm-Message-State: AOJu0YxBaQ8H4FvGf0nGT38S1kjQT/mHS1ct60hwS4QJyfSHvN0tVCaa
	TiBAw5tPy0U55J1JwCBJ8+LVZ5C6MW+Pd0UECPvpX48Q5rfkTnl+KJaBCT+21g1VHgeAuYrBmzT
	l
X-Google-Smtp-Source: AGHT+IFXUVN/VS8k+F/6ACOo9SxvRvCzqxWsfE59GivhPlSyoOrlRRZN5re/crSCy843/biTKnYZnA==
X-Received: by 2002:a05:6512:3134:b0:516:b148:6d8 with SMTP id p20-20020a056512313400b00516b14806d8mr6215011lfd.50.1712576833060;
        Mon, 08 Apr 2024 04:47:13 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g17-20020a19e051000000b005158ddab172sm1175549lfj.19.2024.04.08.04.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:47:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 14:47:06 +0300
Subject: [PATCH 3/4] clk: qcom: dispcc-sm8550: fix DisplayPort clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-dispcc-dp-clocks-v1-3-f9e44902c28d@linaro.org>
References: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
In-Reply-To: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FhQoTr0AvrLk6QoJyJABfGJzAUBSTtD195jvIOJBmlk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE9k9wFt9eN1/J0kZNA4RledruJ4qqlYwBoldH
 66kpS1s4B6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhPZPQAKCRCLPIo+Aiko
 1cMUB/9weyhr1QSQlO12vN8YefYoycnkjThsV7v5ONcRuOBjr37FeLtdRjyjeTs9CNkV3NaQpeE
 eL6rptscrOy1xgpmiAnKt9B7w38fZaHx/psoM0nwED/Jx0ROTlFOG89j6b4ZbrjtG4ChKOOn7oj
 K1sdjYuB739rdQSF8wmVxMoNQ333uc3naBRssgQmK3TFdzNp3pR9/6qGiZMNfSqN03Ko23sEdXZ
 es8k/pjATXBRp11MKz0pSxY2JekxtWzqjsHiYEOk3AXHbaOSDNZvF04UREovmZvfZbYQCH8/npJ
 LbueZm+lI3gkBqPqEFwI2gx4MB8Kc4PKZX8TR35LBb4OdDp7
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SM8550 DisplayPort link clocks use frequency tables inherited from
the vendor kernel, it is not applicable in the upstream kernel. Drop
frequency tables and use clk_byte2_ops for those clocks.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 3672c73ac11c..38ecea805503 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -345,26 +345,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x8170,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -418,13 +409,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -478,13 +468,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -538,13 +527,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 

-- 
2.39.2


