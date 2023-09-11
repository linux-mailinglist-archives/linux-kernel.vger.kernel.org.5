Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF479B2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358441AbjIKWKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbjIKPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EFFA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso5768539a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445042; x=1695049842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+Ee+p0MgR8f6mi4LN6zTW+Ly80MKvHlH7hIzIx/iCU=;
        b=Aqshvo2VtW5e0tfNPzDCC6ikf6iuO9yq9RI2WZlC7DF2r1jRGFiAWydnaYYYit5/Tu
         hH+yqAnblkvW03+OFHPD2kFzugN0OHusgDSGt9tl+2mSKn9FeH6AIIQGj5bUyieCy8aK
         GAA6gbbklHl0k99/Bdar3ERNdGacgMLfcNK/qnoWDnEOMvc13bYlSct0ovzXBbbT4CWT
         x5P1jUgW3z4Ife2h8ghgctbioosFDCIb5KAb0eP/OlmkfZWhjcKmL99a2myPZk/KirmM
         8EobZMqOrvchPNdteVmJ8SuQKymx05+BdK4MyRfl+lPbW9BUFvPXSMFIAMJ80+WeFxVi
         C54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445042; x=1695049842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Ee+p0MgR8f6mi4LN6zTW+Ly80MKvHlH7hIzIx/iCU=;
        b=H//eDNa0Ua9PtZIv8qz/WTnCKh7qCDXLxJsWj0sYlo2Ci8UgYe4ZTycpgarG54uArO
         pxcP3lzJzzFwR3a/P4iEIv9ElmzA7tTcW0tpQGT5kVFB37VyCMDRlF+Nn7w55btady3k
         HUWA+EiqxY8EhAYnlNDP/ustbbhiLYel2NXXDcMctzdYjHoukywNpGUtVlG0qo85Biqu
         TbeFx5MncibFoB8wX+VxErQ65C8aiMHhpetJd0Lrs0vOlRyidQTsX3d9XdvlgfKYXsz9
         uGz+jsTrHPesiYGzh6/ny/ICEFsDVR865aAA10V1rdBW0Gs5zYR/WGKd6flNGt2Rqt3o
         K79w==
X-Gm-Message-State: AOJu0Yxe4maug/l2AE46y+LyBv5pO3vvVKv6oyqmABbH0BQroJ1N+GqM
        5N5a/o7y1lNm7k6S3fbTgxjFnA==
X-Google-Smtp-Source: AGHT+IHX+V1ZfRnb2p4Ait7p0NyTMhK+xnoPHBwMKdGlpVFN5o5gm33rn7JA6oNx0OyzZg92Pk+OTA==
X-Received: by 2002:aa7:d9c8:0:b0:525:6666:3551 with SMTP id v8-20020aa7d9c8000000b0052566663551mr7753512eds.27.1694445042122;
        Mon, 11 Sep 2023 08:10:42 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:22 +0200
Subject: [PATCH RFT 08/20] media: venus: core: Constify all members of the
 resource struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-8-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2695;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=W0g0byTl6c4puFfQRs30LwSqiMEXDbtkmuwi72umncI=;
 b=h+Lq+Zn8i1er1pX71A5d9g50NTac8o2WQ32FO2tyoRiMIEanxulG/HCnQs9kEGCslGEsXACs1
 S5RLewuAk2JDxlr5PAQwqtuJGb+EIBjLWo3Vlc/hYGQBhvKN7+QaJ7r
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

Nothing inside the resource struct needs to be mutable. Sprinkle
'const' all over it. A lot of 'const'.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h | 56 ++++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 515e7d78b7ab..9a38d568117a 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -57,39 +57,39 @@ enum vpu_version {
 };
 
 struct venus_resources {
-	u64 dma_mask;
-	const struct freq_tbl *freq_tbl;
-	unsigned int freq_tbl_size;
-	const struct bw_tbl *bw_tbl_enc;
-	unsigned int bw_tbl_enc_size;
-	const struct bw_tbl *bw_tbl_dec;
-	unsigned int bw_tbl_dec_size;
-	const struct reg_val *reg_tbl;
-	unsigned int reg_tbl_size;
-	const struct hfi_ubwc_config *ubwc_conf;
+	const u64 dma_mask;
+	const struct freq_tbl * const freq_tbl;
+	const unsigned int freq_tbl_size;
+	const struct bw_tbl * const bw_tbl_enc;
+	const unsigned int bw_tbl_enc_size;
+	const struct bw_tbl * const bw_tbl_dec;
+	const unsigned int bw_tbl_dec_size;
+	const struct reg_val * const reg_tbl;
+	const unsigned int reg_tbl_size;
+	const struct hfi_ubwc_config * const ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
-	unsigned int clks_num;
+	const unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	unsigned int vcodec_clks_num;
+	const unsigned int vcodec_clks_num;
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
-	unsigned int vcodec_pmdomains_num;
-	const char **opp_pmdomain;
-	unsigned int vcodec_num;
+	const unsigned int vcodec_pmdomains_num;
+	const char * const * const opp_pmdomain;
+	const unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
-	unsigned int resets_num;
-	enum hfi_version hfi_version;
-	enum vpu_version vpu_version;
-	u8 num_vpp_pipes;
-	u32 max_load;
-	unsigned int vmem_id;
-	u32 vmem_size;
-	u32 vmem_addr;
-	u32 cp_start;
-	u32 cp_size;
-	u32 cp_nonpixel_start;
-	u32 cp_nonpixel_size;
-	const char *fwname;
+	const unsigned int resets_num;
+	const enum hfi_version hfi_version;
+	const enum vpu_version vpu_version;
+	const u8 num_vpp_pipes;
+	const u32 max_load;
+	const unsigned int vmem_id;
+	const u32 vmem_size;
+	const u32 vmem_addr;
+	const u32 cp_start;
+	const u32 cp_size;
+	const u32 cp_nonpixel_start;
+	const u32 cp_nonpixel_size;
+	const char * const fwname;
 };
 
 enum venus_fmt {

-- 
2.42.0

