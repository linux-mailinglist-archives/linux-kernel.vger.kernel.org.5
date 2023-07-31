Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D947693B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGaKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGaKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:53:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569791BCC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso6976282e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800751; x=1691405551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVvWZuZykGB5bMQAupOuWvDvdMeiJLjxPsV4TGGQesg=;
        b=eDvFqWCzdd6OlEph6PTSxP7744I61Ot/s84FP2ZORdSHbReEGTypSqX+LEX5+Lo/wH
         2w385t/63vUv4SIIY+mmfSY6ZStvpnGiC7WAZ0hSv4C5CdcJHaVQPa704dehHQtqwVav
         rL5pgl+ZC3/yD5I1CWDW9BsYOk+g+otnOE6lvsgbuNRD+nTydjTQVOtg3aP5G2b6hKa4
         VqXy78xyWoajws1v6jl8Xkdw+NDSbgVvIopD47OGdv0akiGZU5vCy85MXVzc64T47aYe
         mdGNkJBEbBvBr2da3BrFU/isnNjTDr9p4pJ1DxmYyK9/YERsldWCoT3Y9CdZWILtCIA1
         S7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800751; x=1691405551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVvWZuZykGB5bMQAupOuWvDvdMeiJLjxPsV4TGGQesg=;
        b=Z6S17Dm6FDFHBn4nwUICJlqs0eTJXPTrwd5xaLxfOTMOGOo2hW5WTOh4epu9DmVBZz
         qM5A9ZcHHdNCYkyUvUIaL4PSrYiT3VmEfRkK7K3iMZdk5rrxUkgWUDAt3OXOXo0cFi9i
         +9dzlr8s6vpBzVvDHYxdZs/n+Uz+6rlEg5EgZqbt+Fby8cnAFV8rO1hTLZWHCGpVsEAy
         5q5VgDEjmO1ZcX8rcu9n/+WCP/W+nOiy4/ENcvc7IeYz1QWIDTFD2BP507oGeAA99cxa
         fdnjWv3LKe+8FA5slBNEBJCcaqCSDb8u6KyNO9C1tNtHoCafysNR3H47D4OeYexzcGSo
         EorA==
X-Gm-Message-State: ABy/qLYUtH7LEbQ3D/nQhpFGfRO1iEyCU/NrdFq67wQ+c0IOqiua44Tr
        +03ByGVQO8zSTZgXy5CR9rsItg==
X-Google-Smtp-Source: APBJJlFV7t4btE6CmOURCabRnHjP9HKiAcSfqFMdiFhrlKwJxpFX/ROUqVWivY2kbmwauP606A0EHg==
X-Received: by 2002:a19:6917:0:b0:4f8:4216:e91f with SMTP id e23-20020a196917000000b004f84216e91fmr4229253lfc.63.1690800751450;
        Mon, 31 Jul 2023 03:52:31 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:18 +0200
Subject: [PATCH v2 02/10] interconnect: qcom: icc-rpm: Separate out clock
 rate calulcations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-2-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=2807;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=l2ys7kUG65Xi3tEUxGk88Ev+nzyHo4Dj5sUaoIzZZZA=;
 b=VqPlFtmOHF3NLS2AmYOlrACcxBUYD72n5jfWXxo+SYpGi/YBmMubNIOA+JpVGSZtQvxS/Q7+S
 pWrJZbnz3vbAG2KkwA8NNsoFPd87W/fjKrbDx9lfaXyzYAYtFYzvwCL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for also setting per-node clock rates, separate out the
logic that computes it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 46 ++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index a837d20af79e..f1d8ed354718 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -291,6 +291,29 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	return 0;
 }
 
+static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node *qn, int ctx)
+{
+	u64 agg_avg_rate, agg_peak_rate, agg_rate;
+
+	if (qn->channels)
+		agg_avg_rate = div_u64(qn->sum_avg[ctx], qn->channels);
+	else
+		agg_avg_rate = qn->sum_avg[ctx];
+
+	/* Check if the node has a specific coefficient first*/
+	if (qp->ab_coeff)
+		agg_avg_rate = mult_frac(qp->ab_coeff, agg_avg_rate, 100);
+
+	if (qp->ib_coeff)
+		agg_peak_rate = mult_frac(100, qn->max_peak[ctx], qp->ib_coeff);
+	else
+		agg_peak_rate = qn->max_peak[ctx];
+
+	agg_rate = max_t(u64, agg_avg_rate, agg_peak_rate);
+
+	return div_u64(agg_rate, qn->buswidth);
+}
+
 /**
  * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
  * @provider: generic interconnect provider
@@ -299,10 +322,9 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
 {
 	struct qcom_icc_provider *qp = to_qcom_provider(provider);
-	u64 agg_avg_rate, agg_peak_rate, agg_rate;
 	struct qcom_icc_node *qn;
 	struct icc_node *node;
-	int i;
+	int ctx;
 
 	/*
 	 * Iterate nodes on the provider, aggregate bandwidth requests for
@@ -310,23 +332,9 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
-		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
-			if (qn->channels)
-				agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
-			else
-				agg_avg_rate = qn->sum_avg[i];
-
-			if (qp->ab_coeff)
-				agg_avg_rate = mult_frac(qp->ab_coeff, agg_avg_rate, 100);
-
-			if (qp->ib_coeff)
-				agg_peak_rate = mult_frac(100, qn->max_peak[i], qp->ib_coeff);
-			else
-				agg_peak_rate = qn->max_peak[i];
-
-			agg_rate = max_t(u64, agg_avg_rate, agg_peak_rate);
-
-			agg_clk_rate[i] = max_t(u64, agg_clk_rate[i], agg_rate);
+		for (ctx = 0; ctx < QCOM_SMD_RPM_STATE_NUM; ctx++) {
+			agg_clk_rate[ctx] = max_t(u64, agg_clk_rate[ctx],
+						  qcom_icc_calc_rate(qp, qn, ctx));
 		}
 	}
 }

-- 
2.41.0

