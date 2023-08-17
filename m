Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E502E77F964
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352109AbjHQOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352057AbjHQOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB1F30E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3198d2745feso1965579f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283108; x=1692887908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=kvZxyxAjvY8qC8TUWpoVdXkGMVk79cjTvF/ox5zefhTYVoXgH90ozj4iOLmZTs10/E
         jJ+T+QN26hulLOlLYJ+eMHWWbW6iWD2GCICY15MTQ/IGYoN0Qc0KUfLWNl9lfG4HkBsF
         LqHTRQVqFxY4eknv+WPXba2atfOkToXvNyCMn+R1FetlCI90QnWtuL1aTFOFicDh0TVD
         egYMZ6CyA4FAqXu1fWMueAR3F89YOAKDgCGf0WyHvXXgOkzrQYlhdOviu17szsqUZLgJ
         iDqPxGFLv3MeWa3n35DNdkHqeu+Uz1HW0Ft5cBH2XZjm1VdP/Uuw2VgqiHaiuB2JCJA2
         lC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283108; x=1692887908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=C2BpI/ScJCfRFElxfEhOY41aZY9GO7qZONMk0p+0sgyP/b+q6Wm5ywl8RFVvw4Oh6A
         NjA+PhK7HKomOwZCuLpvB5pj+0fDv+LUWHUA8tdYVbTz/u8ky1fI9hdS3Nd68Hu7hhsN
         4nJN0E2U0Et9Sei2EftimmoIPD3UPHN0fPMejiCwvADId6Pp1dXPcZTdcdsck3FPSUHY
         zCEZZmzFRN6Q5VWuSNrs26CrrZqfOf0h19gqGxsvpq2UgF7X7M2ANqtyWjfJb3WPFUNK
         TPNUwJmlmGruKtRgmRpF4dVbaEJmqiMzDUf6jsp9FpowSoxvVzG/DrTj4oUplmiW4QMi
         6zXQ==
X-Gm-Message-State: AOJu0YzSdVntdwMtuurifCGWUC6V98tSKyVjvhiMOAMxpyMO6ud2/hgS
        a1WJlGRmaTCBy9Saj4KCzlvpBg==
X-Google-Smtp-Source: AGHT+IEyxDVIBwY0oT/rdz3mmCL7rTHgETgqxNd5B7Q8xsURiW7RqlHt4CgFLCTSP0P3oTvZfLUxeQ==
X-Received: by 2002:adf:ed0c:0:b0:319:8444:939f with SMTP id a12-20020adfed0c000000b003198444939fmr4103623wro.32.1692283108266;
        Thu, 17 Aug 2023 07:38:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
Date:   Thu, 17 Aug 2023 15:38:09 +0100
Message-ID: <20230817143812.677554-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of Video Front End - VFE or Image Front End - IFE supported
with new SoCs can vary both for the full and lite cases.

For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
vfe and four vfe lite blocks.

We need to support the following clock name formats

- vfeN
- vfe_liteN
- vfe_lite

with N being any reasonably sized integer.

There are two sites in this code which need to do the same thing,
constructing and matching strings with the pattern above, so encapsulate
the logic in one function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 8f48401e31cd3..73380e75dbb22 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -437,6 +437,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
 	complete(&vfe->reset_complete);
 }
 
+static int vfe_match_clock_names(struct vfe_device *vfe,
+				 struct camss_clock *clock)
+{
+	char vfe_name[CAMSS_RES_MAX];
+	char vfe_lite_name[CAMSS_RES_MAX];
+
+	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
+	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
+
+	return (!strcmp(clock->name, vfe_name) ||
+		!strcmp(clock->name, vfe_lite_name) ||
+		!strcmp(clock->name, "vfe_lite"));
+}
+
 /*
  * vfe_set_clock_rates - Calculate and set clock rates on VFE module
  * @vfe: VFE device
@@ -460,9 +474,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			long rate;
 
@@ -543,9 +555,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
-- 
2.41.0

