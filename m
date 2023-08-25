Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A9788CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbjHYPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbjHYPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7726B8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007c8308c3so1657020e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977909; x=1693582709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAra/D7JVrn+dMn4F76JoN+KI4BtnRIaq6Is5qXv98k=;
        b=CrBLRGndIExyI2+wK/Zo3clqzofvj6CRWaMTF71+IjcVAC4VJFIPXG5Q+U6V4Ee+M0
         nkElt57mLTYkb/eSB3KfuGQoTF8nZ395kQtYYeeUiGIdGSGJD2ODWgETG0DtoKG/K2ed
         uLMQr3hDDs4wxnPd1YbaF3VNkx+hDJZHr8MpSengX+oY0jm810pmzgCrwL6G8uuE5gDY
         s9TmOjW9tfDnYAbNHSSIAjGz1LGX1XmS1DSIoGd4u/N86Z00ITqoZRoGx9GYfO6SVHXT
         4L0wAu16vJTyR75HjtMvdWEIQx2MD12b4WcdzOIkSEDeAxyTVvCmq0MHAGKd4Q11hcw3
         QAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977909; x=1693582709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAra/D7JVrn+dMn4F76JoN+KI4BtnRIaq6Is5qXv98k=;
        b=WB+7XGBvxr+SCRa+95JUSlsq7PBBgJduM2FiE+MNXYcpBEsVUfy0vMMGKRco/rXj9M
         rhIGnhSOdpYcDpsOxxS1ZGEIgDUhVwqRB6EP57zoPbW0W8R4wSEk+LWbjGOh965wLRQ1
         bP7oaQ2TyiutNZnotNLYIf0qC2ebf9COfH2RRm2QpjaTWvXPGPy44emqbtUjpWh/hCpm
         Parm6dYBeu2WRWp0BZzzEbo9/H59ukj8UN77A7PmNwVW34xV4eBg6HUm+9/TFNvI5JSI
         nNK61kJIFUL2xeqfsxaCG30Fk8/IkBaY0/gW01KqT2Adl+d1zgjswcncHCbq29teQlIc
         un8g==
X-Gm-Message-State: AOJu0Ywsfb1qQ4vbYXMaGlDlPyECD1NpTnMqve791WStcC7EnOeAyNj7
        TsK15/0deYHP34qHyb7zriL/vA==
X-Google-Smtp-Source: AGHT+IHI+8gip5772vltoC3vkbr47KloqwpeJEkOxu5dqyBC3IP3sNEjQLQo3a9bTBbUgFRSsv9fhA==
X-Received: by 2002:a05:6512:36d2:b0:500:9524:f733 with SMTP id e18-20020a05651236d200b005009524f733mr5522146lfs.20.1692977908870;
        Fri, 25 Aug 2023 08:38:28 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:24 +0200
Subject: [PATCH v4 02/10] interconnect: qcom: icc-rpm: Separate out clock
 rate calulcations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-2-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977904; l=2930;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VC812LO/ioFmOY5nAI+h4fNdcBO7BBenA1HKz6GQWTI=;
 b=Cc+hIEBSENUCytOdBLVU4wH09thDLSow/mlFKzyEfu4N4vNyEsQNwwwSIZrhuZ6kH7Z4Nov4j
 I8DUNAoq/XACHguOMYRKKGs1zB30ZkqQlD6p0GiF5zUKt+RqiLNo4Ye
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

In preparation for also setting per-node clock rates, separate out the
logic that computes it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 53 +++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 8b02aa8aa96a..8c1bfd65d774 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -291,6 +291,32 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
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
+	if (qp->ab_coeff) {
+		agg_avg_rate = agg_avg_rate * qp->ab_coeff;
+		agg_avg_rate = div_u64(agg_avg_rate, 100);
+	}
+
+	if (qp->ib_coeff) {
+		agg_peak_rate = qn->max_peak[ctx] * 100;
+		agg_peak_rate = div_u64(qn->max_peak[ctx], qp->ib_coeff);
+	} else {
+		agg_peak_rate = qn->max_peak[ctx];
+	}
+
+	agg_rate = max_t(u64, agg_avg_rate, agg_peak_rate);
+
+	return div_u64(agg_rate, qn->buswidth);
+}
+
 /**
  * qcom_icc_bus_aggregate - calculate bus clock rates by traversing all nodes
  * @provider: generic interconnect provider
@@ -299,10 +325,9 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
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
@@ -310,27 +335,9 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
-		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
-			if (qn->channels)
-				agg_avg_rate = div_u64(qn->sum_avg[i], qn->channels);
-			else
-				agg_avg_rate = qn->sum_avg[i];
-
-			if (qp->ab_coeff) {
-				agg_avg_rate = agg_avg_rate * qp->ab_coeff;
-				agg_avg_rate = div_u64(agg_avg_rate, 100);
-			}
-
-			if (qp->ib_coeff) {
-				agg_peak_rate = qn->max_peak[i] * 100;
-				agg_peak_rate = div_u64(qn->max_peak[i], qp->ib_coeff);
-			} else {
-				agg_peak_rate = qn->max_peak[i];
-			}
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
2.42.0

