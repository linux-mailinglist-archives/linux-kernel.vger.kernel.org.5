Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA3763C61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjGZQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjGZQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:25:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A626BB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1525856e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388751; x=1690993551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB32geWf90RWSJ/puuP7HGjsb5OtEdaqcLUmO5MUEyk=;
        b=CCJ6KftoE2u7NiLWNuwWPDtVpifdvKo4xe6UOJjFtbKyRdjqMqg5uX361BptvP8Cg9
         FWV3zw0cIIRpFxp6iX+KF+3ueBF91mj4Ypgu9SEBrYP/wIy9XN4K9LE1Hieq7A+CjaHO
         aTvPBDCr+N3hpRXKc9imDzEsu4nItNEN7vALNAaMP/e5csYLitM7vA2POmf4Z3aizzjh
         lWlAqAbe9pXl2lFcCIq2d298Rv1txdpsifqMEJt+zr9WnUp6yCiBwEUgYshQmoGen0tR
         75y0Le2D4+1vgR4ncrmyPa++gZ6/iOnXZZLLXRSYmQifjRO9uHJd1Gj1vuobWAcuaIIR
         TQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388751; x=1690993551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB32geWf90RWSJ/puuP7HGjsb5OtEdaqcLUmO5MUEyk=;
        b=FmqoEWIwqqKPczN71IXpVPTl/y8HEa4b3q51AkJHSevv6HRx3/fTlT920IbC9nqE3l
         Ddvf2QRnw1cIgdhycs+WR7aJk/ngcp20aqyZxkcY/FE5hfQafc0az8ZAYCsBZK6ujnHY
         5ABAzicEWAljIklYux2s1om3RdXGs1I63ZZmP6kjrp2xr70/nvYAOHYfW2TAnFuSzP2F
         GfECKJatC8yt0PYHFNjiD5zQXNuhoD2QcpsM+hyRaAeZdXf7r++AaBez2rBLXxeasfT1
         ju4JPK1Pngt/GlBOdftPZPfzIU4kkOelszXZLqs1/uM9mqHyto9DVwpMwK4l4PWUbqWI
         Rx9A==
X-Gm-Message-State: ABy/qLa0py7/fHoGv0nAf+p0Ai74fk3U51sFKOId0DhsjNOOPmbHb2uK
        srQa00VyfmguRhcy1kuLM3Z7kQ==
X-Google-Smtp-Source: APBJJlEdOcmZclfe9gWsFsy1sN/jV40TAjFJPePzOIDt9QT9Ud4/xJJNWXL6iRvxQSNwXgAeymBhDw==
X-Received: by 2002:a05:6512:3da0:b0:4fb:7624:85a5 with SMTP id k32-20020a0565123da000b004fb762485a5mr13400lfv.0.1690388751480;
        Wed, 26 Jul 2023 09:25:51 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b004fba5c20ab1sm3336299lfs.167.2023.07.26.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:25:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 26 Jul 2023 18:25:43 +0200
Subject: [PATCH 1/4] interconnect: qcom: icc-rpm: Add AB/IB calculations
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690388749; l=3935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YJ7lGPV4JFwVTnFj0BAnHPjZR4mTBTkkPOZe7rsv1UU=;
 b=6U868dTCqZyKJLcr1HM/SdeFBmXzlfUz+WrxsSSA5SDQz+llT58/0LOfX9VDQdTM5kEWynFht
 rZKRjp/ZeLgA6fFa39ShDDD3audsrXnKbt8WtzY0Snd56OK4o4oS4rA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

One thing to note is that downstream does (X%)*AB and IB/(Y%) which
feels a bit backwards, especially given that the divisors for IB turn
out to always be 25, 50, 200 making this a convenient conversion to 4x,
2x, 0.5x.. This commit uses the more sane, non-inverse approach.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 10 +++++++++-
 drivers/interconnect/qcom/icc-rpm.h |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 2c16917ba1fd..2de0e1dfe225 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -298,9 +298,11 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
  */
 static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
 {
-	u64 agg_avg_rate, agg_rate;
+	struct qcom_icc_provider *qp = to_qcom_provider(provider);
+	u64 agg_avg_rate, agg_peak_rate, agg_rate;
 	struct qcom_icc_node *qn;
 	struct icc_node *node;
+	u16 percent;
 	int i;
 
 	/*
@@ -315,6 +317,12 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
 			else
 				agg_avg_rate = qn->sum_avg[i];
 
+			percent = qp->ab_percent ? qp->ab_percent : 100;
+			agg_avg_rate = mult_frac(percent, agg_avg_rate, 100);
+
+			percent = qn->ib_percent ? qn->ib_percent : 100;
+			agg_peak_rate = mult_frac(percent, qn->max_peak[i], 100);
+
 			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
 			do_div(agg_rate, qn->buswidth);
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index eed3451af3e6..dbb3146a81c4 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -45,6 +45,7 @@ struct rpm_clk_resource {
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @ab_percent: a percentage-based coefficient for compensating the AB calculations
  * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @bus_clk: a pointer to a HLOS-owned bus clock
  * @intf_clks: a clk_bulk_data array of interface clocks
@@ -58,6 +59,7 @@ struct qcom_icc_provider {
 	struct regmap *regmap;
 	unsigned int qos_offset;
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
+	u16 ab_percent;
 	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk *bus_clk;
 	struct clk_bulk_data *intf_clks;
@@ -93,6 +95,7 @@ struct qcom_icc_qos {
  * @num_links: the total number of @links
  * @channels: number of channels at this node (e.g. DDR channels)
  * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @ib_percent: a percentage-based coefficient for compensating the IB calculations
  * @sum_avg: current sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
  * @mas_rpm_id:	RPM id for devices that are bus masters
@@ -106,6 +109,7 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
+	u16 ib_percent;
 	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;
@@ -123,6 +127,7 @@ struct qcom_icc_desc {
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
+	u16 ab_percent;
 };
 
 /* Valid for all bus types */

-- 
2.41.0

