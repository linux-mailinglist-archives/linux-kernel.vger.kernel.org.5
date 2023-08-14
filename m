Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188477BE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHNQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjHNQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E401E6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so40969245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692030563; x=1692635363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=MVDUyLNo9O6sKi/JQRUyfv3hbSM3DpAfbwkGmXCuB9+MFbnW8JPBHUHQ+u/AvSSFRf
         nitMHru2LgEDjO3BcmDYMLPOCePhwIu08gs9S7cjjvWG+IKB3S7kwrLK7r04tvCaroIV
         y0s8ruLwq1w0hdMQF5e0xi9rHJwvL3wXtFxNPl53Yd32l7H9cd0FIMYeOIM30BpPFHo9
         wmnWvgIuQs0R3I0X3zQOVlNWI+sin3RfngrsfrEUQ6xpJidsQyMPVr2yNrVwozV795Yc
         c3tTdJx4BEh05MBbarGmW/sJf6Pwxrn0dIk+CsH2EBefaH97Mzv4Aex3Zr+AYkv7pmeM
         ZRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030563; x=1692635363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=g7MrIDKu8O5FpxaH7a+U1XZ5UrQj+APyqrpS8ZLjMtWuUaektgQaU0LEyy4TDF15Wn
         ub51wyDdVABnphpMo2NB96QicGa66qzZ8JQIb4BpWMgi7pUpyhN7aELfrK8cgx5Bh3d3
         qlDj/V5BP/Lislw3yvqA8pnnGjPorF4ququxBZI2fjxyAc205qV3bqHcC6GsLYJp0MIG
         qK0hMUbwfDvd5npC6R4t3Qso9ruj3DW0UTajDLWnbiNn4uKTDjZQ7+m9GfWAQ/Rw8yui
         3TBkzRb7mjaRdpjyDYyqZUjZnf8DSuGX55oXKiD17WYinjc5J9xaIlhgskP5EVecazIR
         kJhQ==
X-Gm-Message-State: AOJu0YyRTqxpyVzrsdVolbYitO9bhR+iIZhbdX6VdwKBX0Li7WjBo0NI
        vFxR1pNAGueCidqS87p1ZWaucA==
X-Google-Smtp-Source: AGHT+IGSwzHnuII53JUnS2cqb2gI4Us3pnCdsRZ7zkLFwYBDRrpbqqROTZjHYH8r5Cgn/MQgBUePbA==
X-Received: by 2002:a05:600c:218:b0:3fb:b5dc:dab1 with SMTP id 24-20020a05600c021800b003fbb5dcdab1mr7879728wmi.39.1692030563632;
        Mon, 14 Aug 2023 09:29:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc16ee2864sm14743475wme.48.2023.08.14.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:29:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/14] media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
Date:   Mon, 14 Aug 2023 17:29:04 +0100
Message-ID: <20230814162907.3878421-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
References: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

