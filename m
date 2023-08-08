Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E07774124
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHHRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjHHROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:14:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34392718
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so865713566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510762; x=1692115562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCx8RlEOFx8UDQtGNW/6cgXaxJHTs4rAU1l6hTQLDFk=;
        b=FTmSYdVA9TWOG/QXugmuOOGtZshAt+cwiRPNjpjpBhtNUE2YH7DLctBwkCU9N42G5I
         zOFNGlSkADItptIisJsOSWOXBLnNwfdnjGSxuU07U+nM8pFgImUr+QKcsIzRUZn9XIj2
         RhyOYdtqcA5iTL8vtirwGcIU99VsOTMTLL5b70009C3WzuUCQb11cE5Ax30nxFT8XYZx
         bQ6lkCCYgzeFkaWt4haSJxoaJ3XV8RkYarQ3qlgPAs9ElZoQcj8WGsvknFSwysbxzdWe
         V9qV1viKZg1gvylvvLmbdjz6eMok841QTefo9DDxXfsNcdMnwfnBP07DrfmcVJsbAEtY
         oOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510762; x=1692115562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCx8RlEOFx8UDQtGNW/6cgXaxJHTs4rAU1l6hTQLDFk=;
        b=juSSSvuMZcx3iUUz8yGBpRUOZubiaLXsVdP1JHvbp2y3rEBhEoPnDVWjxuDzDp/kAU
         jmXFM6wtTz6RFNgYKRo2VxXT4X55vceLH1WZvz2JF0HzYGgFb9QHSxhBRmmKgr2PQypV
         bsgUqvzBJmULVw36UErs7hctlzEBA1zBLX6BipHGM/ylQAn5tnJ3Ywj/59Fn9Zp5Jn8x
         aWX9tlUAG13dDcQLsBypIIGQzs44h0tNnLs5ObrBIfSDTBG8D0YbLWRtQv7P3M1gpbAQ
         JPzH/zOWa0w8ErhWKB/F1ozl76BWiH1h0IDYLA6B+X6CGeItCImnxSjK33A9dwFN9Xb7
         Bz1Q==
X-Gm-Message-State: AOJu0Yx3/gpGieeVBRCaZe9gD/dIobish1a8Y+hE0b4RjXj/NdGzxEJK
        J77FGKAd24R86d3uFee24PxxnWSpaV/4npkdAN4=
X-Google-Smtp-Source: AGHT+IH+sPe9RaM9v5SJiPH9mGRNklcFtnmQjV71N3tInoFanoFMD5xKQLAj+RolMkFNtpIptv/IlA==
X-Received: by 2002:a05:6512:2e4:b0:4fe:cca:c6f7 with SMTP id m4-20020a05651202e400b004fe0ccac6f7mr7807040lfq.48.1691495022052;
        Tue, 08 Aug 2023 04:43:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:36 +0200
Subject: [PATCH v3 05/10] interconnect: qcom: qcm2290: Hook up
 MAS_APPS_PROC's bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-5-dee684d6cdd2@linaro.org>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=2342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=baltAV4RoHwcQRz0/eW44USFJNd7n+E9JFHsU6Sjt+4=;
 b=MAN7N0prQn1s1uUMDQ6ZtSNXTmx17gJ/z3RFDO/h4V4WTWklSZf/hJxh+ULsHiD442q2RovQ8
 KHxzAyUUWgKBUDESPgVueFeDu76mSu4J0AXSNzBnfLgjMfDWMV8ZgAD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This single node has its own clock which seems to be responsible for
transactions between CPUSS (CPU + some stuff) and the GNOC. See [1]
for reference.

Define it and hook it up.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm-clocks.c | 6 ++++++
 drivers/interconnect/qcom/icc-rpm.h        | 1 +
 drivers/interconnect/qcom/qcm2290.c        | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
index 63c82a91bbc7..ac1677de7dfd 100644
--- a/drivers/interconnect/qcom/icc-rpm-clocks.c
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -25,6 +25,12 @@ const struct rpm_clk_resource bimc_clk = {
 };
 EXPORT_SYMBOL_GPL(bimc_clk);
 
+const struct rpm_clk_resource mem_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(mem_1_clk);
+
 const struct rpm_clk_resource bus_0_clk = {
 	.resource_type = QCOM_SMD_RPM_BUS_CLK,
 	.clock_id = 0,
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 4abf99ce2690..a13768cfd231 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -152,6 +152,7 @@ extern const struct rpm_clk_resource bimc_clk;
 extern const struct rpm_clk_resource bus_0_clk;
 extern const struct rpm_clk_resource bus_1_clk;
 extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mem_1_clk;
 extern const struct rpm_clk_resource mmaxi_0_clk;
 extern const struct rpm_clk_resource mmaxi_1_clk;
 extern const struct rpm_clk_resource qup_clk;
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 3c3b24264a5b..52a6eb32e832 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -112,6 +112,9 @@ static struct qcom_icc_node mas_appss_proc = {
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.prio_level = 0,
 	.qos.areq_prio = 0,
+	.bus_clk_desc = &mem_1_clk,
+	.ab_coeff = 159,
+	.ib_coeff = 96,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_appss_proc_links),

-- 
2.41.0

