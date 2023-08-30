Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75778DB96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjH3SkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245470AbjH3PQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4691A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso53691645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693408591; x=1694013391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IkRunNGFvIUJfzmN6ZAOdQYKxHXQcRYO09oUxFh850=;
        b=c3PT7U7Lj/4oiPhQ21wVDQxLw+K5NmnFvzFWXxuVoicCp/kIimH1f54x7DPy3qq64Y
         oTJF5m56wLrVPrM6PWqesduc+aSrFEgWRaARLjbxxi3EAR1kl2fUkPf48Qmwvb4uepQo
         y5axITUR+o2zP6RYewb/0Ge8JjEEpAoloBGpM8/S4OGvTIgCgUJNdFGMLjlGnqYFRcpI
         CuPYeO2Uy++VYwXNqFwrYs8M9ZO+VsYzOleJ2tq/vnGWs72Vg4M4oIPMGbpHqDIGsB1b
         GkerDeYyCqIzIiiHHPmfCRdmoO9LbkXYEVyZ50FHWFieWggPzUt99B9ye66W0Wt9O9p2
         dszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408591; x=1694013391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IkRunNGFvIUJfzmN6ZAOdQYKxHXQcRYO09oUxFh850=;
        b=Z6Y2Zbn7Ki4PndXIZ6gTHyWqvFHaEVsHTjOJVctfb0oRzjEpVakVgCLm0jl8DEtnIV
         OKbpTtLkbO/3aWUkih6mVRw9GbFO8zrsYg3he0LXmFoUv7z3axl/0252P9tDnjrOpc5R
         A3FCv/LkRXi9V2CGQT4dlm/iHjXvtHYWiMLIny+zkDM+G544r47nuaBLmIOpJaACqxhu
         PQX2p2OFCHlM+yW+S0Do+k5u3/Ukr+0GfOvk6oFq6U2m1w+Kws7IFhCBcXQ231cHEBRE
         reHbfH4yCukmaMYgesdXaHcB+f3AsrhxIv8CTls+Gp6o8DL5dkk6c3JO/maOB6OVYKKN
         yqDQ==
X-Gm-Message-State: AOJu0Yw4F6Q0mljpVvkTcrRzxkSynE4RP3lZyn25zrnRbdZVvGb/ehht
        Jc8FHoLhxEPOHIGch0l6G1nchQ==
X-Google-Smtp-Source: AGHT+IHFl1yrh0ovBa90KE0kq0+ttmyMeRKswrgsfajAr7QL3hpxWJxBE3YovtaB1CnKt0Tfj4M63Q==
X-Received: by 2002:a7b:c7c7:0:b0:401:bf62:9456 with SMTP id z7-20020a7bc7c7000000b00401bf629456mr2507971wmk.8.1693408590646;
        Wed, 30 Aug 2023 08:16:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0030fd03e3d25sm16989961wru.75.2023.08.30.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 10/10] media: qcom: camss: Fix csid-gen2 for test pattern generator
Date:   Wed, 30 Aug 2023 16:16:15 +0100
Message-ID: <20230830151615.3012325-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
References: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
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
- drops fixed VC of 0x0a which testing showed prohibited some test
  patterns in the CSID to produce output.
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 140c584bfb8b1..6ba2b10326444 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -355,9 +355,6 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		u8 dt_id = vc;
 
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

