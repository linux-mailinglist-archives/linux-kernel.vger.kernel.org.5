Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A077BB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjHNOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjHNOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38ED7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fea0640d88so5112175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022223; x=1692627023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L+XNvliqOsl1iPZj9oRnADFCbVYElBi7HCIjhmc9Ws=;
        b=SKB/iQalUvWVCrqR3StDWPdWygoNH8mhPMsC8sF8haLNWDzUNPfLv/wau93s5DJN+/
         Bwxq36fDFfxkYOxTBsC1/HmdKbz9WJVaImBK0lh0J8aXBs9WB9KeleWYRaJUqspgDZDP
         xnEAw4RQxtAbm0Y+aTuwM0iXDTrFIt3ndZissBJXPfP2SBDdWldRd4o4/hsZ1q/9NKS5
         5t1SzzDmVeu2CDUCYN9l63qSygmSdX8EIDm+kU+n5hTzXwIuevkvKk0ctQR+I7ckiuL2
         Xj0s66HkGTyAXKNjxf9wi6IhcfgRCco6Qk1Akbwb/nJmmROVyYV7bMT0vxxmzJHsjwYQ
         Dwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022223; x=1692627023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4L+XNvliqOsl1iPZj9oRnADFCbVYElBi7HCIjhmc9Ws=;
        b=RULkiR6fyD+DrHYT+NKNuq/i/L0c/ts7Ylxy4exeqlMNjJvlQTR3tUkpgb3qMYahzc
         F0Ajy0Iv7rbY2p5aCehjLYfMH1GtKx4NxHwlBZzo3uc99E6adpfHMHJqWh2P9cDSZj8f
         J0LPqWr8hGPqtEGWtmcPTkpl6IP9SBybPI+o9YB34+1uusS4/a0ESytmXghlMPkGvCPi
         DWVsPQBUoSeg4lOHDTaH5FijfCeIZGYTcT2RFwignQkKFh4GK4clajvWnkoXYGPQlmlc
         XHguchM5Xxx9Rcq5MJIMVzWv18MmTyie0SN+XOnjErSrR8WBtmH5i9GxuKwWftB0Cxct
         mECw==
X-Gm-Message-State: AOJu0Yz2GaogbcxmR0nh3bPrZE/K9nGXquqYBwoZ9nDVNnJa96c17nI3
        CWmziqd9XKrO7VpbvTvmSbHwUg==
X-Google-Smtp-Source: AGHT+IEW3aP7zQFQMYPvIkUXb/PIi58OEAu99alQbeoYvIOnvqOIYxhNBaFZwxk7Be37ehpraF+X5w==
X-Received: by 2002:a05:6000:90a:b0:30f:b7b4:3e55 with SMTP id cw10-20020a056000090a00b0030fb7b43e55mr7009029wrb.19.1692022223586;
        Mon, 14 Aug 2023 07:10:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm17232749wmc.24.2023.08.14.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:10:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v0 9/9] media: qcom: camss: Fix csid-gen2 for test pattern generator
Date:   Mon, 14 Aug 2023 15:10:07 +0100
Message-ID: <20230814141007.3721197-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andrey.konovalov@linaro.org>

In the current driver csid Test Pattern Generator (TPG) doesn't work.
This change:
- fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
- fixes the shift by one between test_pattern control value and the
  actual pattern.
So that TPG starts working, but with the below limitations:
- only test_pattern=9 works as it should
- test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
- the rest of test_pattern's don't work (yavta doesn't get the data)
- regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
  order is always the same (RGGB for any RAW8 or RAW10P format in
  4608x2592 resolution).

Tested with:

RAW10P format, VC0:
 media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0

RAW10P format, VC1:
 media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1

RAW8 format, VC0:
 media-ctl --reset
 media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 9ac253111e572..b0890259af4ee 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -355,9 +355,6 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		u8 dt_id = vc * 4;
 
 		if (tg->enabled) {
-			/* Config Test Generator */
-			vc = 0xa;
-
 			/* configure one DT, infinite frames */
 			val = vc << TPG_VC_CFG0_VC_NUM;
 			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
@@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 
 			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
 
-			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
-			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
+			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
+			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
 
 			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
 
-			val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
+			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
 			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
 			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
-- 
2.41.0

