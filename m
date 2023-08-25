Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35E788CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjHYPjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbjHYPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC802702
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so1630795e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977910; x=1693582710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qs7DkXQesvmGRUTl+7tMvgVhMmlkAzzcuf9jrhvd4Y=;
        b=DIXvKrqhsgANPbvldoFMXQUyWVAzNJe3J2ltUM5E5JmFoFoMkLIh12L+QyuxxMmrgh
         gUJ4QjajuvpMmC3VxGb1Ne+DE1JT9kCNg4mpjd5ZyVcfmv+RKp4YBelTALsDrf88KoOy
         hUoaN8PAfRh3liybsj69YBwuvB2mixpZzJz/pJChfXp/lG0RjW/DuYiSFZLb1Ipr1oTV
         neMk/mlKxPOMzvpWzjHF/1boxVoWHiMF/PnFws5Tj4/njFyyxINr+pXDsPG0H9lmijI2
         1AqqVp6MWOXBVAwEU4ut/l2xYd4VeD9Y2LM/qkEVrB6SI1Ga7JkklwNIdCs3H4obQb2H
         QyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977910; x=1693582710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qs7DkXQesvmGRUTl+7tMvgVhMmlkAzzcuf9jrhvd4Y=;
        b=d23fgEwOvBHEySVbTO5rAEVeJp2eNOTfAB00CRbpFR40ZL75ZgIrKB+d0SHvCy8n66
         HIRjX7PLqCN6zmDb6+/6VFf6kLhsZUbmJbnHH5yqpKVR6exOuRhJLxBYO0Nc7/MBH2Uo
         97pXswD3UShh5GnXuSDDsWtd+snK9qN16FF6yyAKBDEwhCIcoHlIDL5ANLIpvCH1+nEK
         UvLF0q0y4kKyUIShx0erHBobZYtpGY/Fw1EK5uDWcLiZ5MhsWZiBHjSBAgyVyg0xacjg
         gg0ZVho+DUlakQiRxVIwRFU8uKn5W7ymo7qmKnZ+r/BlduXEZeIcAOK6KkKou5VbWs3Y
         nwlQ==
X-Gm-Message-State: AOJu0YzAnF3rb+O+czQ+d86Xtvb7J92czCLSII2AY38mB3T516BdLeVq
        b6rAGemDkPuUCZFivIk08tXbZg==
X-Google-Smtp-Source: AGHT+IG6CPeQKtNazpQeSnupGElm9heSeqRw3O+1Sbk7nDLDVg4dFBT94G9Z+AKuoCvIuGjCitRLHg==
X-Received: by 2002:a05:6512:3ca9:b0:4fd:fadc:f1e with SMTP id h41-20020a0565123ca900b004fdfadc0f1emr17413695lfv.44.1692977909940;
        Fri, 25 Aug 2023 08:38:29 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:25 +0200
Subject: [PATCH v4 03/10] interconnect: qcom: icc-rpm: Let nodes drive
 their own bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-3-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=3339;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4w553Q1VyjmZbXhLcbPL02QrXrtQUKMzjob+n5kf8OI=;
 b=X30m0M4CuX9fVT307N4gHheamTK9uxJOwTbdsUU/aQx6NMV/7J4tTA+NGSFueEagqw7l7tP7B
 UcZGiZMAngCAwR43lQrTJZhuhVIejoHDN2tO5jC+FzUTSr4CMJWHXzP
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

If this hardware couldn't get messier, some nodes are supposed to drive
their own bus clock.. Presumably to connect to some intermediate
interface between the node itself and the bus it's (supposed to be)
connected to.

Expand the node struct with the necessary data and hook up the
allocations & calculations.

Note that the node-specific AB/IB coefficients contribute (by design)
to both the node-level and the bus-level aggregation.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 27 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 8c1bfd65d774..1d3af4e9ead8 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -414,6 +414,33 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
 	}
 
+	/* Handle the node-specific clock */
+	if (!src_qn->bus_clk_desc)
+		return 0;
+
+	active_rate = qcom_icc_calc_rate(qp, src_qn, QCOM_SMD_RPM_ACTIVE_STATE);
+	sleep_rate = qcom_icc_calc_rate(qp, src_qn, QCOM_SMD_RPM_SLEEP_STATE);
+
+	if (active_rate != src_qn->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(src_qn->bus_clk_desc, QCOM_SMD_RPM_ACTIVE_STATE,
+						active_rate);
+		if (ret)
+			return ret;
+
+		/* Cache the rate after we've successfully committed it to RPM */
+		src_qn->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
+	}
+
+	if (sleep_rate != src_qn->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(src_qn->bus_clk_desc, QCOM_SMD_RPM_SLEEP_STATE,
+						sleep_rate);
+		if (ret)
+			return ret;
+
+		/* Cache the rate after we've successfully committed it to RPM */
+		src_qn->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 5e7d6a4fd2f3..725e0d4840e4 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -97,11 +97,13 @@ struct qcom_icc_qos {
  * @num_links: the total number of @links
  * @channels: number of channels at this node (e.g. DDR channels)
  * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @sum_avg: current sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
  * @qos: NoC QoS setting parameters
+ * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
  */
 struct qcom_icc_node {
 	unsigned char *name;
@@ -110,11 +112,13 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
+	const struct rpm_clk_resource *bus_clk_desc;
 	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;
+	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 };
 
 struct qcom_icc_desc {

-- 
2.42.0

