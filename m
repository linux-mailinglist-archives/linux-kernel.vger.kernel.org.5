Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C21A79BE69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbjIKWYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbjIKPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E0FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso5768397a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445035; x=1695049835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a74mAUWyNjQUrLkNN32VnDJFxKb6KoEOU6sRKzb9I4w=;
        b=AK/WtdjbYakEDa9RXDC6KeojelzjuSwH9+PJkfJ9gTPiSESTd/s7rEoGUDR2Y8O2RZ
         Grcord7fKnsDBx/YiG8vDnZIYF95ZSEfjRHX5Dh6uD69T59OE88qSSN284K6XL4padO4
         vGKP0fefE4gE3MgRO0NSfsn0LI2Wp7Ruzasgd45wrkQWvMVbuyTQahMD/004pUw5/mab
         Mm+YaHh57lO6eG7Km+218fpEdTR8lD7qC+mBi3OSkWlaILYMqWyLpC+SUYqYuRLgcEkN
         /tuhA1ZAJt6QFydtSNbJfl6qWXgDDvkbhU9ogiZWFWz0S/3/ywdjgmKc67xuIM2Tu0ZE
         oyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445035; x=1695049835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a74mAUWyNjQUrLkNN32VnDJFxKb6KoEOU6sRKzb9I4w=;
        b=dTEgnPL42SZ651YI+N2pm5fYwjWtQNq3O6t9x+B64357UdYS6c5hMfsb/LahF8dr+Q
         ScLre3cDP4fMIjTpmmAt5NK2Q3+te0sUUafrmBrfi6y+GrWoOWgSvdIlm8ENjBDMz7dA
         dzT5olaGbRJQo+NOlgxvNym0+R762jkZRCa/30DXpUzw1bWrsizBUvkl96RRIlAMWAl9
         LVdQgF/oUuxOZ30+dpcwD96KB9zgnetlJTPAs5BJhqe3tEd8aqNiUyeuthPIo2ZIs2jQ
         ja7ftNBqDQOfLnL/EWkqfvukEJLL86BvvcgY8AQ8/rVacYnQ1q7v+Dy33QpwnyIP4iLu
         s2jw==
X-Gm-Message-State: AOJu0YzXO5Vrcosw+7bvtb8tdeObxLsOWnmsLsjTsMU/0k2mNPnuI4RY
        W91KeHSFpcYSZxXrmfb2jCKqZojK2xTQdjiw0K67EA==
X-Google-Smtp-Source: AGHT+IFgjmU2G+Cish/os/XJgU5/mjj81gMqFgSuu1O6gF75c7LT4BNdQoX7X5W2JPKjCrV6VKqnjQ==
X-Received: by 2002:a05:6402:510:b0:522:ca6b:ad7d with SMTP id m16-20020a056402051000b00522ca6bad7dmr8349316edv.9.1694445035554;
        Mon, 11 Sep 2023 08:10:35 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:18 +0200
Subject: [PATCH RFT 04/20] media: venus: core: Set OPP clkname in a common
 code path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-4-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2651;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yWKtspCHH6VembG1lbkjXWBw413nk6iKNGzpyELOez8=;
 b=n21L3hKCSxuzjuglNuE7A8iIdmVtwk6Vqfkoet7bRWuHYWBjVCo76Z2Ah8Ynj6I31FRrZEjgs
 SWe8DcyMYZcB/X1vw5cGVJjEuMOhJR3OkbLOJve02C3YZ4/PS4MvkjG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling devm_pm_opp_set_clkname() is repeated for all HFI versions in
pm_ops->core_power.

Move it to the common codepath.

This also lets us get rid of core_get_v1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  5 +++++
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 ++---------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 054b8e74ba4f..f32b20c3a565 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
@@ -317,6 +318,10 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->pm_ops)
 		return -ENODEV;
 
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 59e3eaad97ed..9bedb3bc7223 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,21 +318,6 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static int core_get_v1(struct venus_core *core)
-{
-	int ret;
-
-	ret = venus_clks_get(core);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_clkname(core->dev, "core");
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static void core_put_v1(struct venus_core *core)
 {
 }
@@ -350,7 +335,7 @@ static int core_power_v1(struct venus_core *core, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v1 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.load_scale = load_scale_v1,
@@ -423,7 +408,7 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.vdec_get = vdec_get_v3,
@@ -1030,10 +1015,6 @@ static int core_get_v4(struct venus_core *core)
 	if (legacy_binding)
 		return 0;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
 	ret = vcodec_domains_get(core);
 	if (ret)
 		return ret;

-- 
2.42.0

