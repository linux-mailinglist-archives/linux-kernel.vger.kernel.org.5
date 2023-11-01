Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDC7DDE12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjKAJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjKAJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:04:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9779F110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:04:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso922444166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829467; x=1699434267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAFvtLcQDFS/Q8L7M01rdBdkMHl28eyjzLsx2k43AE0=;
        b=cIN5wO3XLicD2PI2pVAy1olw/wCInoZUzH7Tv6GeYLYkKKkx/n+Ddr85Qp7YEhAeHO
         phuSIF1/X//JQ32DPhoyan7Id1p3JpLJbOJj+vw7YQ2+z9QHuXwbWSEAToiLCHOSgQUj
         NZY8EUBFPNgcYDMGUoUfLQnyy68drrw3E+UbN7Q9H0J9VrmXb3Cf4qaDYj1a9crZn+/x
         mc4L0Dur3WYlKrk3pnchLQn2ZKovA0XEUG36ObtKhiSZH+Qob8+C9YL+DCW5stXcyAmG
         kF7cariiu0LZemx7p7sVP19HEWU5aU0Pdl//We/anfhvvMWd+qxMzySwz6MRzOfv690s
         RQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829467; x=1699434267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAFvtLcQDFS/Q8L7M01rdBdkMHl28eyjzLsx2k43AE0=;
        b=LmVljLTzoOQ16hFynVyw5zRcWEf3Rx0gUO0WzwoHP3knprpHSZI1AWS1z2jvVUuQLi
         Mnf86Pp6uAKSBuxn2ZBZkWW9r1AE/hJZxW7WXvGlP7XE1cs2rrrYW+P6dGZSAhiB+9JO
         2oGDI2C/SJtMdi9AIjL7mMePY/4XA9QB0lD+Lvjg/lmOtQNc5psxKJCGNS4Osh+nXVdR
         Qq9rnvyAlD7pEVWNVpx/GqDWSOduVgQaARxz8e6MqXl52HLSZevYchvX1EKhHBYqUrgF
         Jou+uPeDnDu6r0hvqsN5Q+NmAJKG9oh2gwsnrJkKYSe0kEMBVfZpqYZ1nPhga6OSumcd
         arIA==
X-Gm-Message-State: AOJu0YxNW2uJY018jzavJRymHkhEK35WF2mHBUguM87g7BOiaP/Fy9S7
        2PgSU7K47Ai2fGsnnWpbbt55aQ==
X-Google-Smtp-Source: AGHT+IH6/UzCpc3F7hxSdFehBqOrOsXpQjueAuqVPvGjjAt3jyLxZ42E0wby2MHKxuJpbqOB294Frg==
X-Received: by 2002:a17:907:6ea9:b0:9c5:45f8:c529 with SMTP id sh41-20020a1709076ea900b009c545f8c529mr1663704ejc.20.1698829467054;
        Wed, 01 Nov 2023 02:04:27 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:26 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 01 Nov 2023 11:04:09 +0200
Subject: [PATCH RESEND v3 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-gdsc-hwctrl-v3-3-0740ae6b2b04@linaro.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dmM9Qksk+QeZ3gA1LIqXc2D7T/oP/OYmfjqi8kIlD9c=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSQGvrYdhdnKHK9C8Ljnoq6z1YGTD3WeM0a9
 Zk3qYpNlUyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUkAAKCRAbX0TJAJUV
 VtnmD/0UKZWZWFdfjBII/4cQuPdLRDcbr5BdbRtGanjzTq6dReA8MnnIBghStcaoCJ4u5AKfcHX
 WM7bz7LU+ccIMzYTNjWjLxMUJO1qmo+A4QtbbQY7IugpTbIaIgzgS7vfdwkQpnUuKHd9brv/udl
 TEX//HErRiDpdwD9NwVZXcthR8KxtCh5GTt71S+psbNSZ0kVp2i/Px2Uh2MbSA1YnrDHTSXR+ka
 bv4KaxWPgxObVscLZsC9Jk81n2uYoGv0LfdkgUWUCwIR2cZXNAME2fGJTdS75FBur+OaGf8yt1f
 CSrzFttgKvlt/2pvDTE06M5H0nHNworLkdElYli3DZqK0+pXpNjDMqriT+aOOinBzv/LUml8odH
 bGjWK4sspwzwuu4Oh8CrP85/GgrE9+LsAPPbU3frUhLgMAV8kqvXU4fLHw4flOV20CKSwxFvbcz
 4N6vti39r7/29yMVv7RONzaW1KkPidwW9MAAHxMnrR/nlgZ7cgNw7QA6VOaVoDcUcNtOeM1aFyi
 CAvr+oLnH0iugXwmS225z3lFyRyStZFZjgxQrpLkexQFRgnncMCpDCIRnB2P7TAmCfAvCUCoXCh
 bCNpeAr1s4f78U4gWlBP2f1u3807HWhKmXEi28b6U9Zs8jKGeQ8hn4prTFgN2XtyvU73WJ9jfUv
 bsFOsi0ykM7IyHw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Add support for set and get hwmode callbacks to switch the GDSC between
SW and HW modes. Currently, the GDSC is moved to HW control mode
using HW_CTRL flag and if this flag is present, GDSC is moved to HW
mode as part of GDSC enable itself. The intention is to keep the
HW_CTRL flag functionality as is, since many older chipsets still use
this flag.

Introduce a new HW_CTRL_TRIGGER flag to switch the GDSC back and forth
between HW/SW modes dynamically at runtime. If HW_CTRL_TRIGGER flag is
present, register set_hwmode_dev callback to switch the GDSC mode which
can be invoked from consumer drivers using dev_pm_genpd_set_hwmode
function. Unlike HW_CTRL flag, HW_CTRL_TRIGGER won't move the GDSC to HW
control mode as part of GDSC enable itself, GDSC will be moved to HW
control mode only when consumer driver explicity calls
dev_pm_genpd_set_hwmode to switch to HW mode. Also add the
dev_pm_genpd_get_hwmode to allow the consumers to read the actual
HW/SW mode from hardware.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 32 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..c763524cd5da 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -363,6 +363,34 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
+		pr_err("Cannot set mode while parent is disabled\n");
+		return -EIO;
+	}
+
+	return gdsc_hwctrl(sc, mode);
+}
+
+static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->gdscr, &val);
+	if (ret)
+		return ret;
+
+	if (val & HW_CONTROL_MASK)
+		return true;
+
+	return false;
+}
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -451,6 +479,10 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_off = gdsc_disable;
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
+		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
+	}
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..1e2779b823d1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -67,6 +67,7 @@ struct gdsc {
 #define ALWAYS_ON	BIT(6)
 #define RETAIN_FF_ENABLE	BIT(7)
 #define NO_RET_PERIPH	BIT(8)
+#define HW_CTRL_TRIGGER	BIT(9)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;

-- 
2.34.1

