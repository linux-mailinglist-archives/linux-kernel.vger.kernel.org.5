Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0457AC177
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjIWLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjIWLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:50:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C641A6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b11cc499c2so182077566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469820; x=1696074620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z22Rfgd7UjpYt4TAoqngtq5qLN6/k4A45SAesnG+QTI=;
        b=JLBeSQiCAXlpMl4ybd17rbwgJeipNxL4Xo+SnWlEwAmABKLVqMjqxkkr4ceB5c3RnR
         cpi+25uwJq7kUlyaZdiHTvvdV9+XDaMuqs9Tgmg7j6J2sO+sV4HCqlMyppyVZ21R8M2M
         VzHHWPbJHb9THQBWcdXIUj3cGfFqK2tE/+IazsTuBOhxfERebBmuoMpJ+XwUNSpWzpcp
         /p0gINNfScBa0naH80YEgjiD2arIXQivf/ydWV1yctIa3qpDoUEa0OnanhTh+9ut++WH
         u20We6AN1Ws0vgf1n69T5eRG1WdJVUCy6IPZfQgXac1o0AzVnAQhzbgX4d6NmuZA9FQO
         cZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469820; x=1696074620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z22Rfgd7UjpYt4TAoqngtq5qLN6/k4A45SAesnG+QTI=;
        b=WSEwtXih779byWnojn19/zwikT4GcPl7xhUiaEdy1tLyzSEjUcgz6cGTPcANjqn+bZ
         GezFnX70/Z5phcFYUVsHFy9GFgQ4LWe/GiF5cS3Jl6bi+L+hBKOxY1Rdld64dDDEPgK8
         /tAvbBu5ITTHjT1YmIx1o+DTUQNLCc+mEo2o9QQ+8JP2uHTjsh2u53Q9aK9mH3whYadW
         O6RfuAp7OQUG9syja/YG5lbAgJLD7dk9os6htJ+nY65KhOeq89EKaTcgthMKpXKoLJLh
         Hu0O9c2l/iiJxsYtH1eyh73e2CBf4u4b7OJDok7j5YowVKzcb1qyhLYtRNGRU1elAlEg
         uorA==
X-Gm-Message-State: AOJu0Yyff94/pSvTpPOWLgie4Sv/teo8L5NnNejSZagpKYgHQdvxTCmM
        Ano8mAfRY+mu1jDkFogzPIJUPA==
X-Google-Smtp-Source: AGHT+IHOKPV7tYEYJr657kkH+IPPQoUNAztuS8mSEUiRMTXXngg1z06D5l/pJFMhWEUG1uokl2U5lg==
X-Received: by 2002:a17:907:3d86:b0:9ae:729c:f651 with SMTP id he6-20020a1709073d8600b009ae729cf651mr1743569ejc.17.1695469820447;
        Sat, 23 Sep 2023 04:50:20 -0700 (PDT)
Received: from hackbox.lan ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709062a4f00b009ad8084e08asm3853310eje.0.2023.09.23.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:50:19 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [RESEND v3 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
Date:   Sat, 23 Sep 2023 14:50:06 +0300
Message-Id: <20230923115008.1698384-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923115008.1698384-1-abel.vesa@linaro.org>
References: <20230923115008.1698384-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

