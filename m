Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E9770974
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHDUJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHDUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:09:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70AE6E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:09:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b974031aeaso38803211fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691179759; x=1691784559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/25QmPqgzCURSZCpBLYalibQ5PKj59W8hnxCgXKHqU=;
        b=IZQcQaIxwS3mQrViQ+C+mgUtxnitR+JeapgfL37vqJgP2Z+bkKPLclFcVYzG9JKUc0
         71NsGiqoUTeukJkh1M+u9+A2X7nZlJyqLygYbA3Ln/0MNPFUHD8Ayp9Ivukt/T2UiXm1
         V9mJ5ki8VuxJYEGdJtc4uwIUSjR3e0C8otrWIgqYQKOT9FNzMQA1cZ/J4BZBETEJztaB
         11ruqs8H1+je0ZmqeUFPS6zV8/JH6Z/zoArDPV9u4X2k/e2+89AsMRwgFVT/2kCkIOTU
         k8ONEjCEG39A050cetbaUz8IcLtp8QpU2EkbX12FUDK32T3V36Ys62bYHP2KuASU02PX
         NxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179759; x=1691784559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/25QmPqgzCURSZCpBLYalibQ5PKj59W8hnxCgXKHqU=;
        b=dY6DVewm/zKcRYGawZNI4FJqSAkHQdisHTlVIx9/xDbq+B9HiNKOh2wEJPmraVuV9O
         JuWfqiumSSlKVh/YAp6mKggeDyltZbd7d0uBngl+kAqIpK1/eEw7jGHo32rd5U5XSExp
         kJ2EGhuh5xaS9lIXdxcyeDQOlTv1mlQRqfIyngRN+VXFLnBtX9n1VtQPLKuNP18fiOjv
         cLVaRWStFBvJcdQDvpU0khpK+NHcLF4wkwg0sT1UEhRtN2/29gas++b9n5q51dvbpvKV
         ugXZQnIm0PnYcxPHjQ1WXMjgudkk7VcaU4NhSYe0y1A02fpPJJJG4oZylH1ahA1osMmP
         +8fw==
X-Gm-Message-State: AOJu0YzzwcztRrbJBO6wpJDaYzYWOFXhrvF3eStPmhmj6/NnX32xdWSj
        03M+GitMvxgdzKwpyg9/R3nYpA==
X-Google-Smtp-Source: AGHT+IEnPBNzlIjAKa7TnjJ6ZTlM/Ay+j1u8193txL13DJHFOITyooEipnrrtmKAjwnWzK0Fins8zA==
X-Received: by 2002:a2e:8512:0:b0:2ba:18e5:1063 with SMTP id j18-20020a2e8512000000b002ba18e51063mr2335757lji.50.1691179758733;
        Fri, 04 Aug 2023 13:09:18 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e97c8000000b002b6fed37b18sm580048ljj.101.2023.08.04.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:09:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 04 Aug 2023 22:09:10 +0200
Subject: [PATCH 3/6] media: venus: hfi_venus: Support only updating certain
 bits with presets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-topic-8280_venus-v1-3-8c8bbe1983a5@linaro.org>
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691179750; l=1766;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rfPsf8y53fs4Evjoavn1JhvaL4tSt9nvOlejrwjRPcs=;
 b=U/fipOBf+0qivdKHsXRSvN7IhCjwjrfmB7mycj+31aGgBfUSrWLGMzJyNLijmanSnHRoOwQzv
 bIS5lH6TZ1HDp1/nBGo8nrfgDQpSpjhDtDr4hGnOtsTyrUXwx23AYvz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms (like SM8350) we're expected to only touch certain bits
(such as 0 and 4 corresponding to mask 0x11). Add support for doing so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/hfi_venus.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index d996abd339e1..2999c24392f5 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -38,6 +38,7 @@ struct freq_tbl {
 struct reg_val {
 	u32 reg;
 	u32 value;
+	u32 mask;
 };
 
 struct bw_tbl {
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 19fc6575a489..d4bad66f7293 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -349,10 +349,19 @@ static void venus_set_registers(struct venus_hfi_device *hdev)
 	const struct venus_resources *res = hdev->core->res;
 	const struct reg_val *tbl = res->reg_tbl;
 	unsigned int count = res->reg_tbl_size;
-	unsigned int i;
+	unsigned int i, val;
+
+	for (i = 0; i < count; i++) {
+		val = tbl[i].value;
 
-	for (i = 0; i < count; i++)
-		writel(tbl[i].value, hdev->core->base + tbl[i].reg);
+		/* In some cases, we only want to update certain bits */
+		if (tbl[i].mask) {
+			val = readl(hdev->core->base + tbl[i].reg);
+			val = (val & ~tbl[i].mask) | (tbl[i].value & tbl[i].mask);
+		}
+
+		writel(val, hdev->core->base + tbl[i].reg);
+	}
 }
 
 static void venus_soft_int(struct venus_hfi_device *hdev)

-- 
2.41.0

