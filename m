Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582C788CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbjHYPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbjHYPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D22697
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500760b296aso1348539e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977908; x=1693582708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFgErp58KfdfypCOT3vFx0dQzamUJWU6QtZ8tkYYvkM=;
        b=u5cpDQmXs6XpHGgASadsyLq5blZls/H8Qkkkdmw41/WtbDxHFFAsCPcwEuWLteML9B
         r1oIuKJZvqsqsRPUKiG8pzaB52ijvMM9Nh/9YlU6+2DtQvH1HYryJbV6IKguyw2NmtQV
         j6KOBCA1FHLmegxyllTc5f9Z0o3iXfXC4gVRFOnQk4DUgt0Mr/X+p2+zlHKsZKf+vQkF
         sEaswXdNdy9CLgUYu/Pvaizh8qqyyc9g1Qyw8n2XPWp1dzstbjvElbfGOBcEc4JRUHvN
         DWGhDkngRlbFcCrqQxtnrRvf+PaK1nMScgeHddYqLCHk2IAQvgo+6zJQeN5Teo2xju7M
         /T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977908; x=1693582708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFgErp58KfdfypCOT3vFx0dQzamUJWU6QtZ8tkYYvkM=;
        b=l+EvgHRNmBXp2ZvX7fXsHTVuWAg9Y6gv2B7b3yLBwm/ymgsw/jRxGHI9y/xME4o8lb
         WYYhfBT6BNkKTuSW3+FoMcEJYArCY4LPy4NJu+Es1uE7Lw3nXvXg9UrtmVTqDmXNmjL9
         WT92hMAw/6mIdfHqIkfv8DRal5oH7bi0kTubRO1vTq7ej6MsfC/DV/5+EzhxqRLu7zxd
         +GAsfkz+01kZ/mFDY+d/iYfR0lEKIvONNjcY93jSN1mes6DE3YYBl24FrWWNCAtEwEHf
         sDI+prKKufR0u4aEnZVEi/kQs0nXeDje1TZPvVagE8CiS8ku0Zbrx87UuuBK77fbhmfz
         3k+A==
X-Gm-Message-State: AOJu0YzCKAMr0jABQQXEVEFNrQmfvTm3AL4gCtUvN/ZDiltp8dXrkozV
        wiLOkbuqULbT6XR+NR5L7dj+Lg==
X-Google-Smtp-Source: AGHT+IFXxsO0inhPEywRrkMW3OYRkGh+GPhn9IzpDF0AeHHchYr9Zt524WleaK1kVijGAxg3TAvhgg==
X-Received: by 2002:a05:6512:4026:b0:4fb:8938:48ab with SMTP id br38-20020a056512402600b004fb893848abmr7440673lfb.16.1692977907351;
        Fri, 25 Aug 2023 08:38:27 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:23 +0200
Subject: [PATCH v4 01/10] interconnect: qcom: icc-rpm: Add AB/IB
 calculations coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-1-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977904; l=3362;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VmCQkFG9XlEBLCy/UyzTZ9FZJie6xQcQFu/3Vn+/5S8=;
 b=z9JwFAn/1a+E13A31tID/phnvyfJsO+q7UKKiJGX9GEhcBpGwnLYXBsfoDCTjbTeyjo4U3TkP
 pPP2CARVWdkBuAbcAYGfYMwNKcCii28WqH4F41JYjuJ+HqVpszo+PQX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presumably due to the hardware being so complex, some nodes (or busses)
have different (usually higher) requirements for bandwidth than what
the usual calculations would suggest.

Looking at the available downstream files, it seems like AB values are
adjusted per-bus and IB values are adjusted per-node.
With that in mind, introduce percentage-based coefficient struct members
and use them in the calculations.

One thing to note is that the IB coefficient is inverse (100/ib_percent)
which feels a bit backwards, but it's necessary for precision..

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 18 +++++++++++++++---
 drivers/interconnect/qcom/icc-rpm.h |  6 ++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 2c16917ba1fd..8b02aa8aa96a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -298,7 +298,8 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
  */
 static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
 {
-	u64 agg_avg_rate, agg_rate;
+	struct qcom_icc_provider *qp = to_qcom_provider(provider);
+	u64 agg_avg_rate, agg_peak_rate, agg_rate;
 	struct qcom_icc_node *qn;
 	struct icc_node *node;
 	int i;
@@ -315,8 +316,19 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
 			else
 				agg_avg_rate = qn->sum_avg[i];
 
-			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
-			do_div(agg_rate, qn->buswidth);
+			if (qp->ab_coeff) {
+				agg_avg_rate = agg_avg_rate * qp->ab_coeff;
+				agg_avg_rate = div_u64(agg_avg_rate, 100);
+			}
+
+			if (qp->ib_coeff) {
+				agg_peak_rate = qn->max_peak[i] * 100;
+				agg_peak_rate = div_u64(qn->max_peak[i], qp->ib_coeff);
+			} else {
+				agg_peak_rate = qn->max_peak[i];
+			}
+
+			agg_rate = max_t(u64, agg_avg_rate, agg_peak_rate);
 
 			agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
 		}
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index eed3451af3e6..5e7d6a4fd2f3 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -44,6 +44,8 @@ struct rpm_clk_resource {
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
+ * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
+ * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @bus_clk: a pointer to a HLOS-owned bus clock
@@ -57,6 +59,8 @@ struct qcom_icc_provider {
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
+	u16 ab_coeff;
+	u16 ib_coeff;
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk *bus_clk;
@@ -123,6 +127,8 @@ struct qcom_icc_desc {
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
+	u16 ab_coeff;
+	u16 ib_coeff;
 };
 
 /* Valid for all bus types */

-- 
2.42.0

