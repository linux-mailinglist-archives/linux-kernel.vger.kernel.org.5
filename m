Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDBE778D38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjHKLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjHKLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:12:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE059E68
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:12:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe4762173bso2991240e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691752361; x=1692357161;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZU6zi2nPFzYLNoD/G2lzwzZB0LUCeWtjqe+ZzV6G1g=;
        b=vOIfIHBPyS0NU/kYqHQxLPGm6HTJRG4Oj4vnVzUkG1zOivm8As+n26T8YZ2Lyy8rin
         al5t+SM3jqP57I3vERvtQgB6x5uE9npApfqYDag9BpV/Qr5E6aEdXfdylt7TP9aRvRoO
         BF23I/8JyFL7TNQJp3E396X2ofleNygIRxNUQD8zc24CCXXIoguUZ1XjsPkQBcKo1Wpa
         WMWUdbaKYHxMIf0GY+UmUCN9IyS99wPbKY0NVGfh9FDZDxg5s8fUnBb6HmvnwqDPO/8+
         Ohl0RFzkgfGaNH1jtr0YGUf+X8M244uZ5R7r5ATUqKGxcEJ0Cqf2+T6e4vIASFiN7MUw
         zisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691752361; x=1692357161;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZU6zi2nPFzYLNoD/G2lzwzZB0LUCeWtjqe+ZzV6G1g=;
        b=VnFPKHrdqb4+IhokwbLCIlxlgMJAk7ocrtxb/Kk0U2t4LufAUSd+Xy72qsHoATj2tc
         xr1ZAk1nLLuHwXvKzyJ2tFqEBUnya5NbwWddfQtKx015bAtmYWfIGWrtP2FpYWlDid3j
         ZsUGoHdNQ65lsZFay13DmxmDUZE2eYZ2VEsIx9W/h726z7VgLQSYHjSbxzLCEuyF/Auf
         ZYrUqiMRFgCHqpWKV2XcWo6UnsJItGQHXOdUp1F1roVjBUn8bARklKMlwdkxMdS+S4Ug
         g6z4Ul0jWV+jFOmYBK8Vj7oOKj5udBBlhx9zf909G+SKdb5IWXZIKda0c8N+HCEdl1YB
         CWPQ==
X-Gm-Message-State: AOJu0YwEKxuUC/LLqTKOs1zqn7qYVlMgPLt6ywsEfMnKeB36+1tEN5Qa
        zHjIWmQrAmhA8TIAKObDdyZqnw==
X-Google-Smtp-Source: AGHT+IEZHbUb7GrSaO9dtbl5/CH1M6CKJ/V1RryGx0Mm+BnmseSTLxKoHhdZBXWWV4cYC+HLlTywhQ==
X-Received: by 2002:a05:6512:3994:b0:4fe:958:88ad with SMTP id j20-20020a056512399400b004fe095888admr1530951lfu.10.1691752361092;
        Fri, 11 Aug 2023 04:12:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m8-20020ac24288000000b004fcddf3671dsm687780lfh.177.2023.08.11.04.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:12:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 13:12:38 +0200
Subject: [PATCH] media: venus: pm_helpers: Unify v3 and v4 venc/vdec_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-venus_dedup-v1-1-c4b4af499ef2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKYX1mQC/x2N0QqDMAwAf0XyvEBjYZT9yhijtnEGpJZmFUH89
 4U93sFxJyg3YYXHcELjXVS2YkC3AdISy4dRsjGMbvQuEOF3q5Jw59L1nTn3ii7MFHz28U4E1k1
 RGacWS1qsLH1dTdbGsxz/0fN1XT+YbcsYeAAAAA==
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691752359; l=2860;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uyxymekY3d16mvMpRx8+gp/jIwxJUIC361Pq17TAh/M=;
 b=jcrrvya02orIr1hZgvW49M7Pw4iD9SyGsN8Giott5VDaCFr3j6WZh6tT1rNX+GKqmREo/LN6H
 FSdt3fc8RjJD6IYdB3nHhdOuW4O1PvhQ2NsRmvukXeVnHKpxvTpi6kl
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

They do the same thing, except v3 and earlier are expected to have the
old style of bindings (i.e. core clock per core under video-enc/decoder
subnode).

Unify them to stop duplicating needlessly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 34 ++++++++------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4db..83d1e68bb9ca 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -295,6 +295,8 @@ static int core_get_v1(struct venus_core *core)
 {
 	int ret;
 
+	legacy_binding = true;
+
 	ret = core_clks_get(core);
 	if (ret)
 		return ret;
@@ -349,6 +351,9 @@ static int vdec_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
+	if (!legacy_binding)
+		return 0;
+
 	return vcodec_clks_get(core, dev, core->vcodec0_clks,
 			       core->res->vcodec0_clks);
 }
@@ -374,6 +379,9 @@ static int venc_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
+	if (!legacy_binding)
+		return 0;
+
 	return vcodec_clks_get(core, dev, core->vcodec1_clks,
 			       core->res->vcodec1_clks);
 }
@@ -764,17 +772,6 @@ static int coreid_power_v4(struct venus_inst *inst, int on)
 	return ret;
 }
 
-static int vdec_get_v4(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	if (!legacy_binding)
-		return 0;
-
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
-}
-
 static void vdec_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -809,17 +806,6 @@ static int vdec_power_v4(struct device *dev, int on)
 	return ret;
 }
 
-static int venc_get_v4(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	if (!legacy_binding)
-		return 0;
-
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
-}
-
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -1180,10 +1166,10 @@ static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
 	.core_put = core_put_v4,
 	.core_power = core_power_v4,
-	.vdec_get = vdec_get_v4,
+	.vdec_get = vdec_get_v3,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
-	.venc_get = venc_get_v4,
+	.venc_get = venc_get_v3,
 	.venc_put = venc_put_v4,
 	.venc_power = venc_power_v4,
 	.coreid_power = coreid_power_v4,

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230811-topic-venus_dedup-08f183d3a611

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

