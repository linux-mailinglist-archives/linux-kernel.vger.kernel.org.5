Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425C79B883
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbjIKVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbjIKPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EEDE5F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso6051562a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445043; x=1695049843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57SqA+LXlncdOSRG7NfyWVutfyFwNDJRXLwGDrFIQwc=;
        b=xhy7Kiwv+rxwl6x1ytMMjhpvq3xT1Hy3kKP5dD2BwrjZxLUmsBQhRfdHlowffElaqe
         QKLRMkLTy0VAbbRKyjeCcqMm4+odEshO1kRIkCRNv3RwwUwQPqhvt9NOPGqSRgVWCBUm
         rrjmmtKXZkU1vs3ngPyWXYsyJddCuPJrrvHC/rLVFEMzXIIC1X94SXkEdSvqA7nDgyMg
         uNTR/W9iQDq59PoLp1lN93Ae753XEllnZ5RLST2+IH/RONl0AY98+PDuFbziv3a+uR8V
         /S0eZpPYnikiUf5ZX9x6lNfOpLxX6i9swHz/b3hOGyZSqhWxd2IPtC292nV5TJloVUBw
         cT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445043; x=1695049843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57SqA+LXlncdOSRG7NfyWVutfyFwNDJRXLwGDrFIQwc=;
        b=k/II/32Y8a7qMEPPPpcm5yvIOd7r11BzHhcd7dHOqIuFawaJUQakW/Cz4SCTzvau19
         3Vlz/4w1aUGhu17983f3HifvvGWUdDXgTQYM8uieyIrWpMBEWWAlkEC9wro9eLScDLkc
         dw7PddlhUG7/bJG39jDCqLOdRymDjb0htLWq0s+C7rQwh+8BHO/V1EGZM1N6rqPJ1GrN
         MMhLusrUgB6KJL2S0baQYgJoMVXILbXZ+bPG3AIAXeTBxrboqMpDb1evX8/bGobfoci6
         JPXA3wFi5Q2H02T9wHGCCZJTx4BzUfHwCaLvycqGV6ehVRGqYPN54L1OvzVZcL9MAmyo
         qnAw==
X-Gm-Message-State: AOJu0YwPEqgd+QOH7fHNYoXUkuoomw2miPKG2kI0WrnGeuHmdOASI7jy
        9AoNx9mkc0r/LAME2UipORH6Tg==
X-Google-Smtp-Source: AGHT+IEM1XY9Q9mfMFjuXXxZ7I4BGgfXUz25Bc65y8IWsWS3kRv9n//07VTtiG7GlZMNexyHlYlgjA==
X-Received: by 2002:a05:6402:333:b0:522:3d36:ff27 with SMTP id q19-20020a056402033300b005223d36ff27mr8334041edw.31.1694445043745;
        Mon, 11 Sep 2023 08:10:43 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:23 +0200
Subject: [PATCH RFT 09/20] media: venus: core: Deduplicate OPP genpd names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-9-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2397;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kcD6HPiGF+k3gCBcQjb5aEtKWIEejr4RKDg3yYPZBxk=;
 b=cqHVKPHualNUKjgbmwbOyX8dv1M+FNYrsWDzSsXlebm35My/ZRPJeQY3KMnsVDeb10D3vEdzY
 evpaFxxtljGD0oaNimSg5uCYI/l4N6eRVMKen6RUkY3z7U1fXR4qXnI
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

Instead of redefining the same literals over and over again, define
them once and point the reference to that definition.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index be633e62263c..8aac7f60fc81 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -541,6 +541,9 @@ static const struct dev_pm_ops venus_pm_ops = {
 	SET_RUNTIME_PM_OPS(venus_runtime_suspend, venus_runtime_resume, NULL)
 };
 
+static const char * const pd_names_cx[] = { "cx", NULL };
+static const char * const pd_names_mx[] = { "mx", NULL };
+
 static const struct freq_tbl msm8916_freq_table[] = {
 	{ 352800, 228570000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
 	{ 244800, 160000000 },	/* 1920x1088 @ 30 */
@@ -724,7 +727,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -773,7 +776,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -830,7 +833,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = pd_names_mx,
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -889,7 +892,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,

-- 
2.42.0

