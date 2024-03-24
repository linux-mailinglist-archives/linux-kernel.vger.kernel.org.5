Return-Path: <linux-kernel+bounces-112786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C8887E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2941F20FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655819BBA;
	Sun, 24 Mar 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnwcBzs1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E691A28C;
	Sun, 24 Mar 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300712; cv=none; b=I0CCrSbnqzZOSSzX2RiNrXo7B4GiKrXa84f8bY3ascluhe/EssTPqYrvWn/0DMJfm9u1YQaY/nDeAdVZnjCsNkvMPEdBmkTg67YIgAVQtb5r2Cx66JM+jNYH1nZDburQ7rWv3+Nh/kom+QuiNJdVVOeo0vaB0tphK+m6Hng75JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300712; c=relaxed/simple;
	bh=q9gIEP+47uECqeW/Ab6DCR5xwIIg85b7ex64vT8DUD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J1bHiPl1Ec7NAcVHjD/uFqTacsUZV126DbVPMhhybtJOzQbej3RhKyHldB21b9IZ1hIDaSdrv01RY9ED8MPgLtX0t5uIJM4IX0FAhCmK4QPoE07nVVvGk1xj6MandYxrDAuEGB+p97V+dfgOt7A/3Aj28F66WNGMM+1VhBCjiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnwcBzs1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso421492766b.1;
        Sun, 24 Mar 2024 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711300708; x=1711905508; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qv3QzY1Obj1+AIxrGHQYaon8YRfBj3KRvINfCBirAII=;
        b=hnwcBzs1wzVl1zRyGgyaFK4t2QiNSSgQQRsS0a2e4TgOJs98YNT5/ynGhwHt6bqSbJ
         a/xckbLnmQvaTQsKw9HSVud0OFTOZWEYEIeIhjpifXwEbFr1WA8hYu5vHZK43IC6HuHc
         wYUwTPQcwMmoJsqinQhmuWoEMbuaaKx+QKoi7MujHlmHmxiy7CR4MARjkGOANjK5FL6w
         eqbX3nx4WTxaHGguKvRaSiOeVIJzheiSD3F3smLgmelPO13dsmwdPKCyYUNfRXvR4aS6
         LzxYvmRZmNlDDKBioJDVIqAOUHDT4vFduf9yYLlirwZIhmj+2XEE9KPuZ9BcNVuyLh2q
         1PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711300708; x=1711905508;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv3QzY1Obj1+AIxrGHQYaon8YRfBj3KRvINfCBirAII=;
        b=mnBfsdY8Xuy8jrHAGE4JkVAVcpRfkPHZOr7Q4ZtOCb2IIGEbq5o+ETDugT7F+BuOLJ
         3T52+b7HjlgI34A24WeiVvLJzB2y0T+FAv2N8hRrosnFCtQikd31VPD5pXIeb41wnVfD
         xMG4jcP8vHqoSWwT5/A7cFlmlGA463xglhI1WpQ0AU8iTqZSqjYbVjCc3BwSg6nOQ8yP
         SnEeWvrg8s50vFK97jc+VAXIBUpzzshsfj4S2GQ2A4biOsW8uUU3C7tQm3xLDFsH5zYe
         5nV9Vk4RAdITrYuAns2u97wim2jRbzb5CfMVmpvwzHR9bnSoppeO1CUZs66CCRtHgvSa
         VASQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBCoOGo4SAski2e7ZGMrUevoeiGeUPq0xEIgt64ZpChvLsm719P9Z70Jr1fyyQJIg9cPRI/FP+s/f+J6amHdeB6u4tFUbAVUQ+JsobUC4pDxaqVlsyrNWl3Ph8LPjhWUtLF5tfXsq2zzTLEjpjiRre6qtkIFXJBu0TiWlPrUf
X-Gm-Message-State: AOJu0YxHY5uc+en+xrvJG+1Zqrg24PyAHUHVZI/UgRHwsn5HhlYaedif
	jBi9xAk9iP63MBPbGdQCg+gpCu83xc37HYRh6shlwxEPr51EF7Rd
X-Google-Smtp-Source: AGHT+IEZDmcoUwJAEqLTuNLP8RgK7by8mJvF0fIe2Y7XdL4rV57O3xXwgjqODfJ8McDaAFjb8J6LyQ==
X-Received: by 2002:a17:907:2683:b0:a47:5231:754f with SMTP id bn3-20020a170907268300b00a475231754fmr1710790ejc.7.1711300708391;
        Sun, 24 Mar 2024 10:18:28 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2132983ejc.209.2024.03.24.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 10:18:27 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 24 Mar 2024 18:18:22 +0100
Subject: [PATCH] qcom: clk: clk-alpha-pll: fix rate setting for Stromer
 PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-alpha-pll-fix-stromer-set-rate-v1-1-335b0b157219@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF1gAGYC/x2NwQqDMBAFf0X23IV0DQr9ldJDqM+6kGrYDUUQ/
 73B48Awc5DDFE6P7iDDT123tcH91tF7SesHrFNjkiAx9BI55bIkLjnzrDt7te0LY0dlSxUcR+n
 HAYPEOVCLFEPzrsHzdZ5/7KR2+XAAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The clk_alpha_pll_stromer_set_rate() function writes inproper
values into the ALPHA_VAL{,_U} registers which results in wrong
clock rates when the alpha value is used.

The broken behaviour can be seen on IPQ5018 for example, when
dynamic scaling sets the CPU frequency to 800000 KHz. In this
case the CPU cores are running only at 792031 KHz:

  # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
  800000
  # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
  792031

This happens because the function ignores the fact that the alpha
value calculated by the alpha_pll_round_rate() function is only
32 bits wide which must be extended to 40 bits if it is used on
a hardware which supports 40 bits wide values.

Extend the clk_alpha_pll_stromer_set_rate() function to convert
the alpha value to 40 bits before wrinting that into the registers
in order to ensure that the hardware really uses the requested rate.

After the change the CPU frequency is correct:

  # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
  800000
  # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
  800000

Cc: stable@vger.kernel.org
Fixes: e47a4f55f240 ("clk: qcom: clk-alpha-pll: Add support for Stromer PLLs")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.8.
---
Based on v6.8.

Depends on the following patch:
  https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
---
 drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 05898d2a8b22c..4f5dba44411f6 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2474,6 +2474,10 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
 	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
 
 	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	if (ALPHA_REG_BITWIDTH > ALPHA_BITWIDTH)
+		a <<= ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH;
+
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
 		     a >> ALPHA_BITWIDTH);

---
base-commit: 97483adf4c6181df2f3d8fe7c2aa057443298080
change-id: 20240324-alpha-pll-fix-stromer-set-rate-472376e624f0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


