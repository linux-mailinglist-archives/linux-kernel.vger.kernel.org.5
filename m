Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49A760DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjGYJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjGYJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EE1BEC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so43576035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690275637; x=1690880437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zU/cjwRMTTz2495il9q5eV7STYjp78SNHViO7CJZv4=;
        b=lpxJA1OEBqmxCVZwM7/k5ol2T7tS4AJJFs3Xmwi3+Q3qO1iQeyMQwLyyR9O+gdOaty
         j+2zL3ad+2KVxyIhtRuPeoKqnxJFdXWGFRtzsZpqzkvMRj+PKQCuvEljaUto5TSDfa3v
         ocDOQ4fzIF/HdWWfxiTLEJXeU9EG007kQKt7NPkHe5FQal+bMrO2WcLSV2WDZFWZWjla
         ArBCMr71ny2p9suFlOb//mccdxu9SMtqES5JYD2OQgHOpD+SKfmmwL3SgnhpzIG+sxQf
         J2/8sgDN99c3yFVDkc9ujfY2//1nxhpPe2y+0ql1/pNhAhXEFFhWoTxFSOACnz2kYOiA
         MrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275637; x=1690880437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zU/cjwRMTTz2495il9q5eV7STYjp78SNHViO7CJZv4=;
        b=OpAdEC81U/S20xTxZQW04iI3bnFoUnTl4EYcg4LYpk2AnY/qb9fyHLMWwqr4MmI8Vg
         PdjadlLbEUNRhdla9MBnKzVK2Th3wqLGtfNKBJ4eA2nvMfBAT10x46FJh4oQteQ+KMvu
         M5DRs9zYWxtHV/qqxpRQdi+V3RpnMppvSFDEJ37T6LjOA8LEvvD3HgDAvZsuEwBaKOEY
         hHe29RYYE3Nhvw64afvJwQNqz4M3UelQLn8d29tS8M4sMrCKMtVlQLhNsAqVNiKYnqGi
         BzI5TxJXR26DETRHckQHrv2EIxdekQS5NSUEPdzHPv8n4kpVms9PYt0ztDyiadz9dB4F
         2/wA==
X-Gm-Message-State: ABy/qLYIzV3hS2vFmnPDRMS32/1jncoACD4yNCtmd12RbRcmdClxHzka
        eLrfQkfTVoO9s3KIG9jlp+PVWA==
X-Google-Smtp-Source: APBJJlFE+E8WPxVy6Mm8c0BDyptcXh01hA22eGb23odV8R7mbPbrWatWfCk6xeye3M/DA0IfLXgaIw==
X-Received: by 2002:a1c:7217:0:b0:3fc:1f0:a66e with SMTP id n23-20020a1c7217000000b003fc01f0a66emr8996587wmc.1.1690275636818;
        Tue, 25 Jul 2023 02:00:36 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003fc015ae1e1sm12648420wmc.3.2023.07.25.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:00:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 25 Jul 2023 11:00:29 +0200
Subject: [PATCH v4 2/3] remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-topic-6375_rproc-v4-2-d55e8a6d0f5f@linaro.org>
References: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
In-Reply-To: <20230725-topic-6375_rproc-v4-0-d55e8a6d0f5f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690275632; l=1093;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dhLWSUNPf4MHw81JBZTsRJ2sX68bGcNHGXn7nRcPQs0=;
 b=P+oi8UCkLPTSksv3BuliO13fIMgjcU4aLpTLAj8O7oMwSD1PGF41N5zMvfWhaWA42zhS/U/38
 uzW78XXOn1DBJX/Ugq3RvcbS913XCbXKR94K0kbjwkPgtJtQQQQC9vd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the ADSP&CDSP present on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b5447dd2dd35..0d58b5be9a77 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1180,6 +1180,8 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm6350-adsp-pas", .data = &sm6350_adsp_resource},
 	{ .compatible = "qcom,sm6350-cdsp-pas", .data = &sm6350_cdsp_resource},
 	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sm6375-adsp-pas", .data = &sm6350_adsp_resource},
+	{ .compatible = "qcom,sm6375-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},

-- 
2.41.0

