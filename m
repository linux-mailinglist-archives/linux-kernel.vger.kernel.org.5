Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A307693B8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGaKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGaKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB21FC6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6932971e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800755; x=1691405555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvcdgSAVOaO6olnZ2J7zbPhjDUv8IMKoyG5dIGy7pps=;
        b=GvfLD9e6+fc2ShIbqGqZQ42tgyVrv/DAKmNMAbQfyPTnm7CaJCrR6tWPhZ7lJwJy4u
         GOQVGD9dt+nbRZhMmFrgmbp6JSpIrXzhWiT1XbVGlhqK8V3SmiL2w3BKZzFCCxJiMTIO
         srIXvs94lea6zukhWr4NV3q8gU93imlJ6eIafuZUO3Pkwwgsxqzq9Tu7zuhzIOkreRUy
         PSj3/cRkluM73TQ9h9sMn2ygSaXwYAcyUOlKnWWKomn6mpQaaT4/i1F1CwQXUtrbYu2L
         g9H+LtooiMJWJr4xtJ/WdEe1dMt8nfEJSYavYs5il7aC6U6IkpsQFaUJvdk5n76RqKoz
         e9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800755; x=1691405555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvcdgSAVOaO6olnZ2J7zbPhjDUv8IMKoyG5dIGy7pps=;
        b=OxkfOiZ3sYESbCUG/jcS32hYK0Iw1H3zoNdTDcJoOpQIS1fnbBi90DbBtfcwffBSzo
         PLpM+4MOe95Nr//OLiqXPQoMylm7N5cN+LdSyD7gCXkHQiS1O+FpGBLg6umsUSRIk6XT
         7obrmcXcveSPw5SGpc7foAcvhiOS9XcRqCEN/JAwdjG5dz0pKcDY1dWJl2BsNbnx4+cV
         LUUcElpsaWTWeljwj3oi/YCrb9chlYweXzLxsPYCY2FZrY+gMoUsoICOv/C7x+Vcu2HY
         rtRD+DShvqNZnDTGKQj1hwINnWohk0S39EmjigiWYDSXcfEaXaZiaO17LIvDFxulJezq
         CT2g==
X-Gm-Message-State: ABy/qLZx+k+Tni70z4RpbvvBoDP9Zul0itiMamCLW6V/mJ40H7y27b+t
        l2DESqgRJOhbt/b8SZXEEbZhDQ==
X-Google-Smtp-Source: APBJJlE7A/+g6cMD48kIZh3qptol9zZSpFMAkpJROi49Ka6Mw2U6bHRKuqRIIc2dTxZNBbj6gCmnKA==
X-Received: by 2002:a05:6512:3b87:b0:4fd:c84f:30d4 with SMTP id g7-20020a0565123b8700b004fdc84f30d4mr6894360lfv.36.1690800755127;
        Mon, 31 Jul 2023 03:52:35 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:20 +0200
Subject: [PATCH v2 04/10] interconnect: qcom: icc-rpm: Check for
 node-specific rate coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-4-8c91c6c76076@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=2228;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=S37fCoemtVls+bqCyB1WrEUAA8XbCS2lHy+GvBs398k=;
 b=0pE89gmxzA/dtumdl6wHpZPUVAjNHE5L/6tePRYe4ztfP5d7jhE8RxiAbTU+d2b3211sukzD1
 8L0VhxQg2qWAXJ83p/xZ+l9R1QMXH5bRg/GpXXF3wJQ04PEU2VqCQfs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nodes may have different coefficients than the general values for
bus they're attached to. Check for that and use them if present.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 10 +++++++---
 drivers/interconnect/qcom/icc-rpm.h |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index f0e575c95b49..91eb428385f6 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -300,11 +300,15 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
 	else
 		agg_avg_rate = qn->sum_avg[ctx];
 
-	/* Check if the node has a specific coefficient first*/
-	if (qp->ab_coeff)
+	/* Check if the node has a specific coefficient first */
+	if (qn->ab_coeff)
+		agg_avg_rate = mult_frac(qn->ab_coeff, agg_avg_rate, 100);
+	else if (qp->ab_coeff)
 		agg_avg_rate = mult_frac(qp->ab_coeff, agg_avg_rate, 100);
 
-	if (qp->ib_coeff)
+	if (qn->ab_coeff)
+		agg_peak_rate = mult_frac(100, qn->max_peak[ctx], qn->ib_coeff);
+	else if (qp->ib_coeff)
 		agg_peak_rate = mult_frac(100, qn->max_peak[ctx], qp->ib_coeff);
 	else
 		agg_peak_rate = qn->max_peak[ctx];
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 835b83cfb548..1a26a7b82166 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -103,6 +103,9 @@ struct qcom_icc_qos {
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
  * @qos: NoC QoS setting parameters
+ * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
+ * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
+ * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
  */
 struct qcom_icc_node {
 	unsigned char *name;
@@ -117,6 +120,9 @@ struct qcom_icc_node {
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;
+	u16 ab_coeff;
+	u16 ib_coeff;
+	u32 *bus_clk_rate;
 };
 
 struct qcom_icc_desc {

-- 
2.41.0

