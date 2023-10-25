Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A47D62E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjJYHck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjJYHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:32:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623E10FB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so6302515a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219131; x=1698823931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEl6CeVofgkSmlxhJVVUPe8R9z1EBoEri4+KtLhRxgw=;
        b=DImA6h1AF6io1ZOH4AVndCw3fdjKP/lURon640gvhNdF7HezOTQiIiZaNUjPcBo6H/
         ISFeIz5BUkuyMyk5nU8aUvA75N6bnY4kVnr+boPOOhQ34aggXVmWB165GYx8Ih8AJWF3
         14y0XFO7JaMRjSqP7dIO/fnTaYa8Wq7aXgWfWsWU4c8/wROj1VqzvTaJg9VDkVF3726J
         N0gYZOI8YaFkXYpyieErF25/n72P8JFaxgZg88BTtG5WSrQE9ITZnBQxc6gYIeajfQDG
         fjvzd8gXi19imiXKpzf0uaVMRwj3zpd6LlCY5r+QqrCXmteJZyaGjwbydCCAkdCejpyD
         k33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219131; x=1698823931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEl6CeVofgkSmlxhJVVUPe8R9z1EBoEri4+KtLhRxgw=;
        b=M8BricTBIq2JsexH0tpxDc2116LSo/5eO7WMIzT831HwxN9ToxTJJiHe8weehbrRPh
         v6vVrxFebAsZN6WAomFrbKn3wkojRe4LiBtEqkHccoK9JAKVt7sC0HDOdt869ztqLW1V
         oJ3huuAj6NSUH9+b6K+bJNEJcPL2RT5nALWLXX+AVaTvv3hQFsX+C6rN3+q+0+qcMrZl
         OnCnBKN0pjo67pSTiQtnKBClHThen7KR1I0WSvH2I3gBFlkejHviaWynVb4tGj7wdmp7
         i/S3QW+9DL7/U0xJ7VxbwGTRIA7NKPy1vWvic5XJLhLzooPG5MmCehAp3JDw24irquP3
         z6Kw==
X-Gm-Message-State: AOJu0YxrhdfDuP8HahpP/23T+rxc80zVw/KmH9nZyAgHr7ktXa0eGnNz
        Sc4j+FLtExjI4Htip5Shkzh81Q==
X-Google-Smtp-Source: AGHT+IElI56qjtNbDfhubW0NsRm+A8KF20hs9WE+8zIIXTxBtKHRPgg8lCt/G61OsoBsfC6wkcJecg==
X-Received: by 2002:a17:907:2d08:b0:9bf:d65d:dc0f with SMTP id gs8-20020a1709072d0800b009bfd65ddc0fmr10692726ejc.4.1698219131278;
        Wed, 25 Oct 2023 00:32:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040841e79715sm14036237wmq.27.2023.10.25.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:32:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:32:03 +0200
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add SM8650 RPMh Power Domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-rpmpd-v1-2-f25d313104c6@linaro.org>
References: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hAT6chxV+deZaIvy8RroY/kbSzlU1xIefmMxtRfKR3o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMR3RL+P9o31avF2mPaUE2cMVo/LbJq7wbh5e6FX
 VMGIf76JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEdwAKCRB33NvayMhJ0ZjrD/
 4+eDSbc2bLZplcv3gQehQWjyhBHBFVkYF0zwyKTKVGKC0hyCouIuGxHrMETElQRdemQyB3jBApsHoT
 HxxL8zSa2NuXADp7KuqCX5HTqQIc7J52grprYWaq3Wo91ZEQYRbYbaljxeudK7oYuUXAoj6PT+LmWa
 7jkj20LCorT0g5xHyZFe8IJeUcjtGoxy5Zj1YqY4TTaNvIZStAfgcsNi3lgIQXRRz/qYl42FcRlRjd
 A1fiRxJsCEQ2VXwjeNTcFx+sMStc/ibpwMQWg3xBcLx7FiMAeX9zD4h2H/gOFVmi+/TS/75cN6lq1U
 HONnbqnPGWEFYH0yZnL86d/lZbQ3hbWvAP1XOMHlwsLkErzguIPAtr/3OOSUFqe3ZGCC1E88MSxMEI
 MB1lZtvbRCaSw5KF5SlIqwh45FvUfuhq0Cz+NKEynsv5n87jC0lt3eWAH7Nj9s9MVv7rg6JeM46oaN
 lc0p/J3kBxczbAn3y9Ax2Bxc3c58u5GRodCLq14pPpaodoCFt/DjNWgMm4PG08FZaiO1bMt5LEjaJw
 d2ZJeLdsYd2Kj9D5GGesV02qmcNhXmSFY5WTBzcVwJOyskLdI8OwZ1JxppTvpRrtS9XS6JQ5pMg9kv
 m+9JrF46X0jxeIjWKTsbdB3YuZMccu9csx5KW73tRHHy/K9pdPxivsqorVFg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMh Power Domains support for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index a631fe1f9a06..cf25ba1cac66 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -197,6 +197,11 @@ static struct rpmhpd nsp1 = {
 	.res_name = "nsp1.lvl",
 };
 
+static struct rpmhpd nsp2 = {
+	.pd = { .name = "nsp2", },
+	.res_name = "nsp2.lvl",
+};
+
 static struct rpmhpd qphy = {
 	.pd = { .name = "qphy", },
 	.res_name = "qphy.lvl",
@@ -475,6 +480,30 @@ static const struct rpmhpd_desc sm8550_desc = {
 	.num_pds = ARRAY_SIZE(sm8550_rpmhpds),
 };
 
+/* SM8650 RPMH powerdomains */
+static struct rpmhpd *sm8650_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+};
+
+static const struct rpmhpd_desc sm8650_desc = {
+	.rpmhpds = sm8650_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm8650_rpmhpds),
+};
+
 /* QDU1000/QRU1000 RPMH powerdomains */
 static struct rpmhpd *qdu1000_rpmhpds[] = {
 	[QDU1000_CX] = &cx,
@@ -585,6 +614,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
 	{ .compatible = "qcom,sm8450-rpmhpd", .data = &sm8450_desc },
 	{ .compatible = "qcom,sm8550-rpmhpd", .data = &sm8550_desc },
+	{ .compatible = "qcom,sm8650-rpmhpd", .data = &sm8650_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmhpd_match_table);

-- 
2.34.1

