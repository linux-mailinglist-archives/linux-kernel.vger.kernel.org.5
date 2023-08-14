Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4C77BCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHNPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHNPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:13:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACAE0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso41283815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025981; x=1692630781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=fFr7IcU9zLzY9T98mm/BX6HDp6EPfkSf0pa6+HInbwRrBiiNuwg7mKic2vgtpYiu7F
         AHF6wbKvVCjLnPHFn82VKtOr0mZPq3H4dkk8TzWnEzKLVGP8J+sFqjFPdiiMAXTzMDk7
         IWrIfTrw0Q3Pg0aAbBXf7JMRrrsIbCiTdnIisxgPdBwqHZgTrppmfdQPp//z+q+SMPf+
         aqUpo6mu52HGqJ7wqqF6o68HQH1wQoC7E2y11b5p33ocUH6Lg2k+MQPOmri3TzLu4EUM
         f5tUWteos/mXBsjL5Akns2qdyoUKPANSCrhjUe0fqxttcrKb3O/DOO442lkkuHI7QDuE
         L2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025981; x=1692630781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHxvfmBq2wQcZEqJeTw0BxrGFmAlBN3kn0Ir0lpbaw4=;
        b=eWEL+vmfQFRhNtQB5mXYFYjUXnivIhXojSSZJLOf3vPTaGjBeZ0KKtrjY+z8WWMh5g
         Lpd5H5+6IbniuXKh+evv1OSCpyz46Sm+/C7zy0KCavseexcqoXOEDNUTI+buwMsyC1OT
         fJZDkxsgdD+ifk4N8lBlz+5JZmv9wbgOvVzvg8nacsz+gwYXCZcqgoCm4i55vZOwwZ5P
         F2VWCtoprwdkIvBetycc0GmE1aL06bm1WLIgA/0T+9HhdaK13EQW5Vorhlg+PY2VLWu2
         7xZXDs5Eg/LZxEhfZ2kH3MPZp7jN4lyVuQURfg7faOS2NtygngJ6bf1KzMJPEf0cdn3h
         72xg==
X-Gm-Message-State: AOJu0YyIsN7HuBzf6UVNpoNWKmytfkgcKWYNzcx9SxPjnr8oaorngpLW
        BrQPj5Z7r8Yjnz7zwjJD13IuMw==
X-Google-Smtp-Source: AGHT+IEjFG0DujsHM87qHijilhHZRGP0bl7W5DcJIBGkrJ8/GOZB/NfMGN2iEl0sAhH7Fd/jEeNlQw==
X-Received: by 2002:a05:600c:3789:b0:3fe:1c11:7788 with SMTP id o9-20020a05600c378900b003fe1c117788mr8121542wmr.33.1692025980951;
        Mon, 14 Aug 2023 08:13:00 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:13:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 11/13] media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
Date:   Mon, 14 Aug 2023 16:12:41 +0100
Message-ID: <20230814151243.3801456-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
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

