Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A19778E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjHKLzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjHKLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:55:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCB2D43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:55:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe82ac3ab4so2902586e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691754921; x=1692359721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=votk4MaYH9iEJdjenquLal2dl89uf7f2OrMOIxamFPM=;
        b=Fx2JVGT8ntOGcFTc1NrbXwlE82Z97ETjK7AOLvqACVJXdposPwTyYI/GQE+Rzwpw6V
         XtDvP2fOSUDYZyvFS2VHTB55D4Z4v805bQGod21ruBQbX+/7oAjnZ3Lomj0wnaxVPIR5
         0lM56TsSY1SbkZ/gTQNPo6WRt4Na04NLUv6cqgeOCwZJEkTij2egzVx5fCRNhNkbNFKJ
         NVbV74yebKRRiHwjPJCOSpQdaIy49v8zqhTy1kNps0xzIVXesNXnSUobo8aJVrlZj0dl
         LJPOwvFr+yiPpQkKfdCUDdqlNlj0L6rhjW2XFXi9fYhMjTUlCJQu/6loQFEBdGPE9Mpb
         Pyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754921; x=1692359721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=votk4MaYH9iEJdjenquLal2dl89uf7f2OrMOIxamFPM=;
        b=b5hxLHuW1aZQOKxhgtZeCRoZNRCneHOng2D5z1f0nXUJpxwDTjcZTHvaySkET6DFoQ
         PfCD9xDvPE+zM0OCry2MOXGfoYB0vRXi+Y4/AtJro4V/s0qUDWxxZzSmtFeL+Ce687PI
         fUtp0QGZYEdAQbOJf3rlVbypdB3GPB4EJIEu++VAwUKGLzL8ZaFxgEqBqXwmqH1xPt4+
         3zXy6SsKULEZR2CWiekGKLPbL+WuxbmPMq/gcVtQIXX6RItMSrdn35Oq0L8iCk0c0aqk
         jB/oVkexkBePJzakhUccVnYE+J5Lb7hPA3B3T/xlGhQoKFneXdmjjFNcLVrO1Hb0JBGr
         6ASw==
X-Gm-Message-State: AOJu0YyLS9NLF0Pq7Q8Jkd3rSThv6qaFaAIBFuRLTd7dpaDBmwHAQ18A
        HMGW6VK3TCmISwDwM3SeIjISrA==
X-Google-Smtp-Source: AGHT+IGoeWd+hmADTR5N0V3Dawi8YFFRfybqAmq8VhBXbgFzMyW2f0ZhttypuvVV9uQmVirmyin4jQ==
X-Received: by 2002:ac2:53ad:0:b0:4fd:c923:db5e with SMTP id j13-20020ac253ad000000b004fdc923db5emr1229203lfh.21.1691754921738;
        Fri, 11 Aug 2023 04:55:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b004fe4a4c61f0sm691729lff.191.2023.08.11.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:55:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 13:55:07 +0200
Subject: [PATCH 1/2] interconnect: qcom: bcm-voter: Improve enable_mask
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_fix_1he-v1-1-5c96ccef3399@linaro.org>
References: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
In-Reply-To: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691754919; l=2465;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QCAAvsp604ImmQ7hP5JbjgwsUhs0zxDvdhVnwg2+edc=;
 b=M5wMD0hgtAW/Zv45Zl64U4GK45BkeSAY0Cn6Wbo3+OxP9/KYzsAQinIwfaRbmeew7rqB2adMY
 kXPFZxtMwBBBlKH1LjRG8ob52RA0uqlbO83L+r32KXneAAneQZSvNpJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need all the complex arithmetic for BCMs utilizing enable_mask,
as all we need to do is to determine whether there's any user (or
keepalive) asking for it to be on.

Separate the logic for such BCMs for a small speed boost.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 40 +++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d5f2a6b5376b..82433f35717f 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -58,6 +58,33 @@ static u64 bcm_div(u64 num, u32 base)
 	return num;
 }
 
+/* BCMs with enable_mask use one-hot-encoding for on/off signaling */
+static void bcm_aggregate_1he(struct qcom_icc_bcm *bcm)
+{
+	struct qcom_icc_node *node;
+	int bucket, i;
+
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
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
@@ -83,11 +110,6 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
 		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
-
-		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
-			bcm->vote_x[bucket] = 0;
-			bcm->vote_y[bucket] = bcm->enable_mask;
-		}
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
@@ -260,8 +282,12 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 		return 0;
 
 	mutex_lock(&voter->lock);
-	list_for_each_entry(bcm, &voter->commit_list, list)
-		bcm_aggregate(bcm);
+	list_for_each_entry(bcm, &voter->commit_list, list) {
+		if (bcm->enable_mask)
+			bcm_aggregate_1he(bcm);
+		else
+			bcm_aggregate(bcm);
+	}
 
 	/*
 	 * Pre sort the BCMs based on VCD for ease of generating a command list

-- 
2.41.0

