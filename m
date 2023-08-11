Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A6779B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHKXQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHKXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:16:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983510E4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:16:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso4027852e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691795780; x=1692400580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrEa7BnRXqlxSfaLWUoZT+UIgmwKchO/B/AYrIhfcQw=;
        b=rOrwY5e7PCKvYy7gp1p09YmQ/t6ViOupbDgqW/MRFSypqkrrf4MRP+zMghQh7c6iNI
         vu3ezvNwuWZPr6G98njW+GxZmD48wOlPvagCctULeQmECjUeLQ+1bK9BqS6MLTl/X5YX
         urb1CHb2iFLY3aXknZOnUAUS87B8RG2H9ZoBln/YfF0StG1SjbgikVD9GGQJcVZByaGG
         p2VGufLz3yWLnnPfmrztbEgVuHHuiJD7lS5VNT8epSRYuF0SmgALucTZ98A3Hnf7O3rH
         FuYHwuWuJNJDHHRwW5LWiz7I6N2wCwVF1/Lw/1JbtUrPOxH1IX+QIWafBFZCujwoyu9d
         bhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795780; x=1692400580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrEa7BnRXqlxSfaLWUoZT+UIgmwKchO/B/AYrIhfcQw=;
        b=fn5lFIjjVRAwL7oRfGpKhxs5IYQ8fDBiGVHdiLRT5rdW1H0GrAXoFmlzS7W3byhtAO
         x+olV8K/j4/J5tg35uyqIl5nIMMah+Sz4NkUB4EvAl89fHJf1x3D/hZ8wpst4xUKrN42
         S3nibW3VxPki5T85dIReySicuGU11+tflHQruNU+IQcAT/yjZ/26M/b6WPBwUJ+v07SS
         GQaGqwI2SlmDezviU9Bwvw363QlKwfjgp0uwRjY8LYKQlYrnQSAPibO+tK+qNEY7MhEn
         dgJsI0jjlBhZgnJIORFcv7Hup7gHl6gtdZiL9FGuafCPWOy22Kx0Qa3p9u/oIn7KUt+p
         cPMw==
X-Gm-Message-State: AOJu0Yzcl8ixXmDcvQD6Rw5xwg6hqy19IBZ+/0fgpHvhOkrGNeqDcVQ4
        R8xO4v3Ol0cb2sHu6I2CwKUwKw==
X-Google-Smtp-Source: AGHT+IG7ZoaVk9HKiAJFHqFOnhqYz9z9kh++5WoMap5AsFluRuAOLr4Gyxrj8gNLAvPl2P0umjGjSg==
X-Received: by 2002:a05:6512:3d03:b0:4fd:c844:6a43 with SMTP id d3-20020a0565123d0300b004fdc8446a43mr2855752lfv.43.1691795780209;
        Fri, 11 Aug 2023 16:16:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m16-20020a195210000000b004fe48332852sm884773lfb.136.2023.08.11.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:16:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:16:15 +0200
Subject: [PATCH v2 1/2] interconnect: qcom: bcm-voter: Improve enable_mask
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_fix_1he-v2-1-0620af8ac133@linaro.org>
References: <20230811-topic-icc_fix_1he-v2-0-0620af8ac133@linaro.org>
In-Reply-To: <20230811-topic-icc_fix_1he-v2-0-0620af8ac133@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691795777; l=2645;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/nUZR/0rc3yqrbbrAEz7dJ1RQ7GveO6vo5M4t98V7rI=;
 b=yopVK/ZtfM2RmTl6QHD084IAaGO1rxaQJR19IYJTnKafbeqsyktjQSPYOLzSrCbn91x+tG8EF
 YWSZ2ucOpQnA+f8Y/xdRXBIjNbFIN81JMy0eRcY7hbDA8Bg+cyWwlPI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need all the complex arithmetic for BCMs utilizing enable_mask,
as all we need to do is to determine whether there's any user (or
keepalive) asking for it to be on.

Separate the logic for such BCMs for a small speed boost.

Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 43 +++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d5f2a6b5376b..d857eb8838b9 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -58,6 +58,36 @@ static u64 bcm_div(u64 num, u32 base)
 	return num;
 }
 
+/* BCMs with enable_mask use one-hot-encoding for on/off signaling */
+static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
+{
+	struct qcom_icc_node *node;
+	int bucket, i;
+
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		bcm->vote_x[bucket] = 0;
+		bcm->vote_y[bucket] = 0;
+
+		for (i = 0; i < bcm->num_nodes; i++) {
+			node = bcm->nodes[i];
+
+			/* If any vote in this bucket exists, keep the BCM enabled */
+			if (node->sum_avg[bucket] || node->max_peak[bucket]) {
+				bcm->vote_x[bucket] = 0;
+				bcm->vote_y[bucket] = bcm->enable_mask;
+				break;
+			}
+		}
+	}
+
+	if (bcm->keepalive) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+	}
+}
+
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
 	struct qcom_icc_node *node;
@@ -83,11 +113,6 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
 		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
-
-		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
-			bcm->vote_x[bucket] = 0;
-			bcm->vote_y[bucket] = bcm->enable_mask;
-		}
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
@@ -260,8 +285,12 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 		return 0;
 
 	mutex_lock(&voter->lock);
-	list_for_each_entry(bcm, &voter->commit_list, list)
-		bcm_aggregate(bcm);
+	list_for_each_entry(bcm, &voter->commit_list, list) {
+		if (bcm->enable_mask)
+			bcm_aggregate_mask(bcm);
+		else
+			bcm_aggregate(bcm);
+	}
 
 	/*
 	 * Pre sort the BCMs based on VCD for ease of generating a command list

-- 
2.41.0

