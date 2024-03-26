Return-Path: <linux-kernel+bounces-118954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75E88C1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E0C1F3C404
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017A71B42;
	Tue, 26 Mar 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N590jXAm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E56BFD4;
	Tue, 26 Mar 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455367; cv=none; b=adrSxmzd3lCYNnynkYg9Af3kiPKrXD5YoXZZx+9zozs/OdBtWGSbAjXyRYkkwvDvQxMQZ481GfS7RJP8DSdRKn8nxHyJ2NYuCXXTdg2IpRCWbPuoqOfYfCkJS3tQ+LGZY8SlpqtqYI0uSfkaQJmbRfBRgJExKqQIGg7pOZycsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455367; c=relaxed/simple;
	bh=XcYTGNUP0d/t/YLHu//d62nSyNh2driN4jDgcinv76U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PSEnMzAv0MfLWUG18j5TW44K8bWEhGfHnjeMNliqTnTjOrVzgbCkjZkNNZ1b01H2Jpvb7zszZrQIokp5t0EzsA1cTiXOKJD9gmxQ7OE/Pk37qAJDnhhndxQaBTSn2o4rXv9bjUXU/90KosM0usyUBl67fsYbxX+BX4L3Yjkmifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N590jXAm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d599dbabso7106272e87.1;
        Tue, 26 Mar 2024 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711455363; x=1712060163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDPy0oZRU/yyYmSQH7wJjbHAam1AVRGf91TfaaWf3iM=;
        b=N590jXAmZUzpHhWCgaawb5SA82m97+4hvJJ8aTQb0eNs1Mj2wP3i9vkDKNw4jQQ5u5
         mb3G8W77wt9Lu/V5O9sMP1yNMnrEdGOqKcTDW0jj7aaIMFFyy/ILlXYOsud8hOcQemfT
         5HyLCdAPUBUEyhwbXw3VjD1atWtvsGzbPka9GEWk+ISQ656GUQNXTR2d0nfA964Dl2yG
         3HM6+FGEONRInOJWoKZtzFPR+ZWupIzXCwtZvNxGjTrChicNuG8bJ6nl/ydhibZTVmI/
         9dvRy6Bnm+M+AmfzmFCxHOw+XwN31ows3KiQbBTY1GOePHX3TBdRFNHdlsJEjb0NCL8U
         KyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455363; x=1712060163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDPy0oZRU/yyYmSQH7wJjbHAam1AVRGf91TfaaWf3iM=;
        b=QRIjaaBvUjDQRitcUcEBtzS7HUsoWBVmRIjBBw6Vk2mx+zvOO8llwUos5lmSp5Kq7U
         u4wJJ8koOC9Vh4KyTmqVT29VTFYOlDwzBKvMJX50Ush0hWa2LeaVSMDBCsyHzQkrMtrn
         MLCNNkoWjbpWNGAmoBQf1IsP24d1VI0cVYiW7V4tzeXSXWXXbg7f/qG2OgTOj2upBahh
         oIpaGrlwlMHaAKKtndm2ydda70K94BgK+n0BDjzEXwvB53rpKyFVMGC+Wp6zWbzqXHiH
         US8Wralv+zl6jdPWONL5+H0g6/7twOhRKTwNmAztlpHJ+W41mzb6Kx4EXBSsd/sDpEiN
         eM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXwD4juMiwRGwS3iNhnk1c4Hmtv/WepoZrEnLkU7V2r5E/7KXFOIUtKjr7f/WIA05BMXGzqMaYxtSoALJmqkVCRLTul6J+JI75HuagdWtp4oeASWoxW709/BwSXaiaIhqb34pak2wsQesk8F0cl18P/4YjUf5eBKMLYK9ymcfSS
X-Gm-Message-State: AOJu0YzC7PaTNWQogtbxTguzeDLaZ8vZ0LyoL6o5355WOjCd0OUrJiin
	2CtENmJ63FC5wdJTIetcxfIPgzn3ciTqaRqjhp04J2+1OErUd5qK
X-Google-Smtp-Source: AGHT+IGm30vxu7t2G0cwSlNM3BcJUW4wMMIUuxjWdKbyljp5HFXxsVAW9BFsAWEaPWqZKYTzvO2nvQ==
X-Received: by 2002:a19:430c:0:b0:515:9ee7:ce45 with SMTP id q12-20020a19430c000000b005159ee7ce45mr6522025lfa.49.1711455362846;
        Tue, 26 Mar 2024 05:16:02 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id x18-20020adfffd2000000b0034181bea3b0sm12096616wrs.3.2024.03.26.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:16:02 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:15:51 +0100
Subject: [PATCH v2] clk: qcom: clk-alpha-pll: fix rate setting for Stromer
 PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-alpha-pll-fix-stromer-set-rate-v2-1-48ae83af71c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHa8AmYC/42NTQqDMBBGryKz7pT8qbSr3qO4iHbUQDRhEqRFv
 HtTT9Dl+/h4b4dE7CjBvdqBaXPJhbWAulQwzHadCN2rMCihjNDKoPVxthi9x9G9MWUOCzEmysg
 2E5pW6bahRplRQJFEpvI7A8+u8OxSDvw5e5v8rX+rN4kSta570cu6VfL2mBbr/HUIC3THcXwBD
 JLSg8wAAAA=
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
Changes in v2:
  - fix subject prefix
  - rebase on v6.9-rc1
  - Link to v1: https://lore.kernel.org/r/20240324-alpha-pll-fix-stromer-set-rate-v1-1-335b0b157219@gmail.com

Depends on the following patch:
  https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
---
 drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e163..8e98198d4b4b6 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2490,6 +2490,10 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
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
base-commit: 5eab983c5e31e5f0bf2d583731e320e21814d1b7
change-id: 20240324-alpha-pll-fix-stromer-set-rate-472376e624f0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


