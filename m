Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AC7C68DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjJLJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjJLJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:01:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC685B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:01:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-325e9cd483eso682747f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697101298; x=1697706098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp9e51zMSM1A4LjQRlP8e6Z2OMJhjsVvUn5sJ7CbDOY=;
        b=cQC5k8ZngLTfsatdz7IT1kym+FMju4krUsfpIVQB5s4MXnG+IueR8tegS7CjgipLHS
         C/WIY3atJusBnPvsI73dY97eqrKF1zwc3c4M2FazqnkKZuor8KJ43B8zzWjfj0gaWrSQ
         k2W4OucZ19d9rwHygys412+ql4xv8q+iJN07eHd1Gr//9DJhvcHYt5A3U49Ll797Ffzf
         IQeN765qKjkDBb6nDhUdWAd9dgDPipotlH1TLecH/aiqNSTucRyfutnHopMd/MW/qEm9
         g6UTWCU0bVSYQMj3MDVPHzaKirj2W1i51ifoZofi47lbicfnHPQygqOdeYZl+mnSF+x8
         Lilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101298; x=1697706098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp9e51zMSM1A4LjQRlP8e6Z2OMJhjsVvUn5sJ7CbDOY=;
        b=m+AjC0+8Z3oX2zsgykOrwbcRlRRqrWFNaPakSLs5lMNSwlMu+tReO9wZ7ka+mDKJZ7
         5+S53kfpyK8LISa+rAXOcvn3UN87R0ZS8LlwbTPUXoZ3dLVlxEOTAJqdNdC8Cv3pwOu1
         MuAMeBeRiTiYTAh3SHhpr+11Ptwjynh8/eEsbXSoQI63h4CbejcgsvCM4vKyQjW0Xw2C
         Ql58vGaVtWfJystpbLTxqtx3Kg6sp7lrpQWcLOG30FiYDSt4Rah6PWIRkccUlpoNqo+y
         Ko6azvEZeO7HP+1w8cAzJwFwYDXjLFpq4KbgFAR8mXK0tu52bUKnEDn4UTatNWUxohmU
         Og/A==
X-Gm-Message-State: AOJu0Ywo4iYU56yiEDx8Itvv5LQ+viOsADrcs+0RlUeGgEgikKtphe4y
        XP8YPatE8jrw2ZXHzlRW3ABbNg==
X-Google-Smtp-Source: AGHT+IGicf280BeC13aU4D8azDk2sM0JZfJD4dJzon56oGdvxPEpCe7im5WssqaYhxwsggfRMUTu8A==
X-Received: by 2002:adf:f4ce:0:b0:32d:857c:d51d with SMTP id h14-20020adff4ce000000b0032d857cd51dmr3181321wrp.60.1697101298393;
        Thu, 12 Oct 2023 02:01:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b00324ae863ac1sm17811176wru.35.2023.10.12.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:01:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 12 Oct 2023 11:01:31 +0200
Subject: [PATCH v3 5/5] drm/msm/dpu: enable writeback on SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231012-topic-sm8550-graphics-sspp-split-clk-v3-5-4bcad69812d3@linaro.org>
References: <20231012-topic-sm8550-graphics-sspp-split-clk-v3-0-4bcad69812d3@linaro.org>
In-Reply-To: <20231012-topic-sm8550-graphics-sspp-split-clk-v3-0-4bcad69812d3@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vyJ6HrSHxd1BhoDm2ZS2X6iLQcaDh5cmR3iYl608YDI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJ7XsHlKh4HhsSvaOGbNW/+YAM5zOZ+oyFbVDIPNX
 qECnY0mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSe17AAKCRB33NvayMhJ0XuLD/
 9lXK5dl1D1HkFMJGVu5YuPjA4p8gZXfq5eJ3dA2POtdjOeM6w+j88Hc1pKNsNXLn5Dh4OU/snjwb/W
 lTsQSbdyIyIN06a/9+9yvBubXtwwlRNh2djXIJS21Czx2PgGlxJUe0z+zs2pGpN6XhBirR+INY/z+J
 V3JvH4wy7TExA/EyF6KaWouKA1Kh+CR4jkNUbdf01y04BbBKu5QejN0/3NsgB1yWj3k9zvvfDBkiMk
 d5RXeiHnztdkPPYF8gmf1fu9ZCIUvbw8+QTYA939MxKDm9NuitajrK2f/snpKCSuboZvPNAXuvV/ab
 V3PTL60IofWMYEfZO/hU+AbGVzNYZcuPZz1cut35EVCKk8byK7nbhJHaapWlg7OQKY9Cpm3TDU212z
 JZVwo64huhx8PN7bFHuBalcNzx9Fro5QFmvF7QEpLApd9AB1dYlBIyX4XQWmGmJGHcnP7vZEcvLkXN
 itwjKvwJRnfHn+D11jg7GbNNiokbYVCTfjeKqdbGwnZLYyGLnScGCariBY9lFURWQYtWopu++gXEdZ
 tHuP779D0+J3g2g/Qar0n75t8n6mOTWOdNUhEsLZRUC6jN9zklWPC3J4QrxROLfdPHn6neokzZk2us
 FIiT6LEw6I/iAjj7hkkhY8zHzbfXWKeczVmjuwqxPS3rlDIHHvjpuqMD7sjQ==
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

Enable WB2 hardware block, enabling writeback support on this platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 4590a01c1252..d83a68a2cc0a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -321,6 +321,20 @@ static const struct dpu_dsc_cfg sm8550_dsc[] = {
 	},
 };
 
+static const struct dpu_wb_cfg sm8550_wb[] = {
+	{
+		.name = "wb_2", .id = WB_2,
+		.base = 0x65000, .len = 0x2c8,
+		.features = WB_SM8250_MASK,
+		.format_list = wb2_formats,
+		.num_formats = ARRAY_SIZE(wb2_formats),
+		.xin_id = 6,
+		.vbif_idx = VBIF_RT,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
+	},
+};
+
 static const struct dpu_intf_cfg sm8550_intf[] = {
 	{
 		.name = "intf_0", .id = INTF_0,
@@ -418,6 +432,8 @@ const struct dpu_mdss_cfg dpu_sm8550_cfg = {
 	.dsc = sm8550_dsc,
 	.merge_3d_count = ARRAY_SIZE(sm8550_merge_3d),
 	.merge_3d = sm8550_merge_3d,
+	.wb_count = ARRAY_SIZE(sm8550_wb),
+	.wb = sm8550_wb,
 	.intf_count = ARRAY_SIZE(sm8550_intf),
 	.intf = sm8550_intf,
 	.vbif_count = ARRAY_SIZE(sm8550_vbif),

-- 
2.34.1

