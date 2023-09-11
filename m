Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F879C084
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355668AbjIKWBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbjIKPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE5E4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso5971451a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445039; x=1695049839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgZree7XzpnUt+LTvm3ELxdMecDcHuNrPgAPFwwrlDc=;
        b=HfLJPspUIOYNlxqjTf6haE4L3OKKIt45rqYpRPXihauSxAXaOMlMLYBLONtGQXj0/X
         5s7H+iegg3zpdHZufOaxrsLh3XhluTpnijUHUkbmsND9jvBGC/iAk5RpAGvOaA7zqVTg
         JWld6t3dAZq+J5h3jI4fyNkisU6WkdUJr37ksp2LoLRYalYQr6GeNY68S/6wPb7FWsWV
         p+3pRypVJDsD7jPHDm2gE2ya66l/oMJsEuhwSA62E8RVNorsULsfxbXyC38oL2KzvYwp
         QQv9IU1UG1eoMYHhLvSrc1TOOGog4Bbz6XbCErSoEEFVKT6uA05X61G9XKFy+JupHCf8
         iExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445039; x=1695049839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgZree7XzpnUt+LTvm3ELxdMecDcHuNrPgAPFwwrlDc=;
        b=aR8xNyN3MBVTUBIhGnUAgY26dA4Mw9kKVpHTqOMAIi/1e4YvLxn8huxBaW5NQ7igU5
         xMy7Lm0igQhgz0j2dp0I4R6AJEWj258x2NMJ+6voDcluDBaI6GTHu7aZH/D0jPYAWMGL
         /b4RfaRMJLEFK7FyxgWnwwHvqwgkJZJK2Osq2zasb8AJp/a29v0qvggUe/SrLKnW2ies
         K5EC30CwMrvrkNmseCRXAwvquDNzRwJ39FrPCPogKC2CK/+zDgzs9DublYcdejvsFN5n
         5jwqXLBQKk8oDcWYmtf5JaY0yKCIBR5Z/U6n4aGtIdDlgmlayDTmGdL1zCh9F3BcwX2l
         OpVQ==
X-Gm-Message-State: AOJu0YwuMaVcp9qSOuAHxIAgHmLCES1PM/HuIQMQDN1bsZnH6/4G1N1E
        GlytTUYfIYys+7FycqY15KVzIQ==
X-Google-Smtp-Source: AGHT+IF6Autm6BEvISkfscmZhEQqCMFFMuaMCAzipStVpgAhuvU5zXf4w1yK4J40FXA+U9ObrHJAsg==
X-Received: by 2002:a05:6402:2027:b0:529:4457:92ea with SMTP id ay7-20020a056402202700b00529445792eamr7948487edb.8.1694445039213;
        Mon, 11 Sep 2023 08:10:39 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:20 +0200
Subject: [PATCH RFT 06/20] media: venus: pm_helpers: Move reset acquisition
 to common code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-6-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2552;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PPoQc4dWxK9IfdAY7guj4bitRzCDNn4oxWqLDhFKXac=;
 b=FZ9N6btphy5IyNxFeo26cRZ7A+FoWhLl00Ms967tW3PwzNaN2mpOeDvWI4FHkyMzPdVQ1I8m7
 FvaHtLL+VZeDOyU38CHcpwhkyuFVIZxuTq5o9sYz4ulCmz0tCN6Ly9k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep reset_get code local to HFIv4/v6.

Move it to the common part.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  9 ++++++++-
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 -----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index f32b20c3a565..2445a814b39f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
@@ -284,7 +285,7 @@ static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct venus_core *core;
-	int ret;
+	int i, ret;
 
 	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
 	if (!core)
@@ -322,6 +323,12 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < core->res->resets_num; i++) {
+		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
+		if (IS_ERR(core->resets[i]))
+			return PTR_ERR(core->resets[i]);
+	}
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index f5130aa3ddfc..0e04da8d7eb5 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -952,25 +952,6 @@ static int core_resets_reset(struct venus_core *core)
 	return ret;
 }
 
-static int core_resets_get(struct venus_core *core)
-{
-	struct device *dev = core->dev;
-	const struct venus_resources *res = core->res;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < res->resets_num; i++) {
-		core->resets[i] =
-			devm_reset_control_get_exclusive(dev, res->resets[i]);
-		if (IS_ERR(core->resets[i])) {
-			ret = PTR_ERR(core->resets[i]);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int core_get_v4(struct venus_core *core)
 {
 	struct device *dev = core->dev;
@@ -994,10 +975,6 @@ static int core_get_v4(struct venus_core *core)
 	if (ret)
 		return ret;
 
-	ret = core_resets_get(core);
-	if (ret)
-		return ret;
-
 	if (legacy_binding)
 		return 0;
 

-- 
2.42.0

