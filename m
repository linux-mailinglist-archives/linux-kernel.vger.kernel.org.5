Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F1788CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbjHYPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbjHYPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0762685
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso15842331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977911; x=1693582711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcjcwisDXlg84xv+ldq2FQJTTOumDjlAQbIhasmseG4=;
        b=wv+7VD7h2I9Bwxo458SiQOktW0QIFDltt4/vn/kw/WblRcP546HD1eUSnOPwYZvG32
         XOFrvCIt4w/j2VcN06RNHJc2lSHRw+U+OoVQHzTR959o9GywnADT+Nq/bc2SHeBGRPvA
         +mXTIbVYQ++57pQ3bPAcQKuGMXZU2PH8MN+R1xdBAS2kldiQcz73OYsEdblj35OUZB5K
         MJzsN9Jr/gAOKxGXcrJOfrDQCjHaB0mDdlcV5sK/p6zCXlLdODfFWv1Qvgw6xsQl9GTF
         si7s0CV1doVUnrnRwgGworZenrskPpG+fVnVfSm/53HCL6bu1TbUUg1vk5nu5DnBz2Ko
         /iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977911; x=1693582711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcjcwisDXlg84xv+ldq2FQJTTOumDjlAQbIhasmseG4=;
        b=KKFKROPzPkNHgVV5RA7oJN76oyRTEuBE/7QsZpbXgDRDFTHEihNR6VzjJKIIho6uLJ
         +euCtHyGVdSillqhpxk5vgdUXkomi2hKPF1Kx/86yet5YC7z+v2IGA6pAEXJtUoz3k8r
         t62O2x6+1xhUs8tNgI8ZaoDFzeX9U/6tjS9t4A0k8maHqeWI4xEATdNF9cgR9k1MSL9T
         6f+Ltf1DBzleBE1ciXHogDsN1a7fuvnSiqmfWBXfKEfl+39lwqokV+stHAT/5cYT+t0t
         offpHbBNn/aU+jLUxBsMHXbe1stDfWplHbKqY1XpZSzaXytww6ePC0kdtcm2GMzmVmCG
         /eRg==
X-Gm-Message-State: AOJu0YybT0SMwIu668YYf29+Y9SVCB47M4LY473EKEwoU9gKUso/X125
        AK4lzUA0YUoEkJ8uLzZArQi5Iw==
X-Google-Smtp-Source: AGHT+IE31/e3cnbPUm2oftzb5dIS9wX6shBNinidBB80qR9C1Lcug/NYghtA/1bMLAB+jx3HHMS9lA==
X-Received: by 2002:ac2:4985:0:b0:4f9:51ac:41eb with SMTP id f5-20020ac24985000000b004f951ac41ebmr11172410lfl.16.1692977911150;
        Fri, 25 Aug 2023 08:38:31 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:26 +0200
Subject: [PATCH v4 04/10] interconnect: qcom: icc-rpm: Check for
 node-specific rate coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-4-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=2693;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mAeJwUiLt8a3mVMD19ZVYHlnPNRhvBX56pfF4nnsqeU=;
 b=fQY47HFD8x4as0tMazw1XA/kjiE7LYBWkxxqbTw7bad6rox/70IKKEhXY4I8h7i9KKBqlEIZm
 WQBNFTKpD3WA/tcJFgcfRNiBF4xrw+r0MvevMIO/WIhYXbDowBGEGAp
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

Some nodes may have different coefficients than the general values for
bus they're attached to. Check for that and use them if present. See
[1], [2] for reference.

[1] https://github.com/sonyxperiadev/kernel/commit/7456d9779af9ad6bb9c7ee6f33d5c5a8d3648e24
[2] https://github.com/artem/android_kernel_sony_msm8996/commit/bf7a8985dcaf0eab5bc2562d2d6775e7e29c0f30
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 ++++++++++----
 drivers/interconnect/qcom/icc-rpm.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 1d3af4e9ead8..9c40314e03b5 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -300,14 +300,14 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
 	else
 		agg_avg_rate = qn->sum_avg[ctx];
 
-	if (qp->ab_coeff) {
-		agg_avg_rate = agg_avg_rate * qp->ab_coeff;
+	if (qn->ab_coeff) {
+		agg_avg_rate = agg_avg_rate * qn->ab_coeff;
 		agg_avg_rate = div_u64(agg_avg_rate, 100);
 	}
 
-	if (qp->ib_coeff) {
+	if (qn->ib_coeff) {
 		agg_peak_rate = qn->max_peak[ctx] * 100;
-		agg_peak_rate = div_u64(qn->max_peak[ctx], qp->ib_coeff);
+		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
 	} else {
 		agg_peak_rate = qn->max_peak[ctx];
 	}
@@ -563,6 +563,12 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
+		if (!qnodes[i]->ab_coeff)
+			qnodes[i]->ab_coeff = qp->ab_coeff;
+
+		if (!qnodes[i]->ib_coeff)
+			qnodes[i]->ib_coeff = qp->ib_coeff;
+
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 725e0d4840e4..4abf99ce2690 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -103,6 +103,8 @@ struct qcom_icc_qos {
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
  * @qos: NoC QoS setting parameters
+ * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
+ * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
  * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
  */
 struct qcom_icc_node {
@@ -118,6 +120,8 @@ struct qcom_icc_node {
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;
+	u16 ab_coeff;
+	u16 ib_coeff;
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 };
 

-- 
2.42.0

