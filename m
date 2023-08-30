Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95FA78DC59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbjH3Soz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbjH3PQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01541A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31adc5c899fso5162807f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693408580; x=1694013380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WUaXRaDRIjkZF5nHMeqQDMlSMpGdHODmzhwpaSYMnQ=;
        b=xD7ujoZWfkR4ewfMFZ5NROT3KC+gFCPYHjP7g4SRauAnn80T5MV0jyD1X4KFlRxAyF
         YEpvKrAvpmZHSPzN2616eQs/8dpmqaqCe+HTYCcGSuTvyt1k7y+gFXN5HR6wd/Fyk6iw
         C2+F2aS/cHNbXrbWOTPAvq0+yg0NuNO0i1gMao1eSgBPzQ17VGyu4SnFzscsO/9+BzEp
         8MdEHuwPW4hfoNaLNquDgJnovV86uHAUgpHJFLbBL/r0llZr6fiEc9COsb2ptVwNzqbY
         PiE1YGijy6S3c7dSPav+BhkPuKBgH1o+XQSMnDdIa5S6JHmab6/4AZuoVfT+pB+yKK0T
         U/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408580; x=1694013380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WUaXRaDRIjkZF5nHMeqQDMlSMpGdHODmzhwpaSYMnQ=;
        b=jclQmLgB+9yMynyud/0/d2OsQHxIj/Ldz6KyrNtAx5bTnx+cO7sTsfScsDsr0m4wyU
         /mMWWC/BAxky01o0MKySSUwCR8zg9fjNeKAysqYfexqmOHCcYwV1kaaDiVMuGMVmZ4gq
         qRuyhggwu7aiFcVEwXCQ4VwOdw6qWllzqhgO1M/twp26xTrxa1t6xU9777/1e2bM+6Yb
         fH+a50JkM/TL6z801pL5w16JsAoYckH9B0P3Ifu4qvuQ6Ao56mpnZlvSf3Jiifr4wTR6
         A7KLb958f6uwE52kfNOcD7ljN5Dy9RJBdDQptnXHbvkvYL9txmnsGwhC3J41YkXeQaWr
         6ROw==
X-Gm-Message-State: AOJu0Ywlv0GLwv6VZYtQfIG9bmHNs3jRJn1oBcDZST4epBKJrwSCOPBS
        odSOR0ecwhkw6owO346svJY5pQ==
X-Google-Smtp-Source: AGHT+IEzWglBFlXaFtDnNQHyghrReyNdxTkgzV7OuKijl1NY6s5D7823yKpZlXXoTnf2ERV/PqI+RA==
X-Received: by 2002:a5d:4b51:0:b0:31a:d90e:42cd with SMTP id w17-20020a5d4b51000000b0031ad90e42cdmr1738968wrs.35.1693408580394;
        Wed, 30 Aug 2023 08:16:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0030fd03e3d25sm16989961wru.75.2023.08.30.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:19 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] media: qcom: camss: Fix V4L2 async notifier error path
Date:   Wed, 30 Aug 2023 16:16:07 +0100
Message-ID: <20230830151615.3012325-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
References: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
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

Previously the jump label err_cleanup was used higher in the probe()
function to release the async notifier however the async notifier
registration was moved later in the code rendering the previous four jumps
redundant.

Rename the label from err_cleanup to err_v4l2_device_register to capture
what the jump does.

Fixes: 51397a4ec75d ("media: qcom: Initialise V4L2 async notifier later")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 75991d849b571..a925b2bfd8989 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1617,21 +1617,21 @@ static int camss_probe(struct platform_device *pdev)
 
 	ret = camss_icc_get(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		return ret;
 
 	ret = camss_configure_pd(camss);
 	if (ret < 0) {
 		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		goto err_cleanup;
+		return ret;
 	}
 
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		return ret;
 
 	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
 	if (ret)
-		goto err_cleanup;
+		return ret;
 
 	camss->media_dev.dev = camss->dev;
 	strscpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
@@ -1643,7 +1643,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup;
+		return ret;
 	}
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
@@ -1651,12 +1651,12 @@ static int camss_probe(struct platform_device *pdev)
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
-		goto err_cleanup;
+		goto err_v4l2_device_unregister;
 	}
 
 	ret = camss_register_entities(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_v4l2_device_unregister;
 
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
@@ -1690,7 +1690,7 @@ static int camss_probe(struct platform_device *pdev)
 
 err_register_subdevs:
 	camss_unregister_entities(camss);
-err_cleanup:
+err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
 
-- 
2.41.0

