Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5B7846CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjHVQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjHVQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE4CE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so15397575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720989; x=1693325789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KplshhytImmpQyw5mB6IesvqS1E/jQySdpPPKRVH1y8=;
        b=PQZsT1oBoXy3CkrK7CfU4Mog1gDg+IkvheXQagG2Jgc0gA/jvFT0JT0mAQgcEOr4Y4
         WBpKNlxFmvy88fv6zzZ2clPSBiulmKpD9Vzzq2NpUJCbhX1kBOKl3APb4Jo1eISIF2eg
         1Sca/RLY0MfbyBdvJ1A+uD2x0Vi7wCAziGIbvv/v+kPdL6/zDSLDEosxexu4Hc3ujB2b
         p26xOPqqFwAorPCd7zKl8Y2kahh5NJ714ZVC5eDBGCAHgXOzOIG9/pB5jLRT0Y0bPMXX
         ij/VhsCPmOnj6Uaby+6tS5KomhidiRAidCCabA1dgqbvu/Ivi5Yt77NtrzBy5P1E+xNN
         Qn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720989; x=1693325789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KplshhytImmpQyw5mB6IesvqS1E/jQySdpPPKRVH1y8=;
        b=I9cJ8VF+N54ewY0lr3dgVDRZA9VQOuP/qU31GmIB5KekT4m+w3GUVRGi4IbiG4+Igr
         DSnesExXPp7M5W3lr+0vQk67Xk5zdSsmvwXZjzWZQMcGrcqgLqzi9ehnDabeB/M914IA
         S3p4jYtxlpfNPyqpUC9wbz+e39K66xo+fqze6jZsdaaDDkSHP3o28+cZ0hT+y/LC/ioR
         KNKajuhjDGJOsXof4xyjB52cfLXwxAaqlOXyWvTJ2j0jy07aiCUqfU0nuFIxQHAlN7sT
         D9OBxo7QyboTK0DbhNBWTHhUUeejSoTPU1lTsSHtnMxxGIVENtQ7JIsh1HXLYcj7FBh8
         kCuQ==
X-Gm-Message-State: AOJu0YyfE0vhQOfYhgWjWIi3w2Y7rVchMWYksxvFzQKC6oPcjPEYMoiC
        fAx8lFOctpj/wOBrtyNE4a1Liw==
X-Google-Smtp-Source: AGHT+IGy/dR0pSpgveaYmAS5O6XY6G3LxWbjGJHbUD3qLgNjJZmURcA4AwHrXXDSKYoFdBKGxBj2Vw==
X-Received: by 2002:a05:600c:22d4:b0:3f9:9a93:217f with SMTP id 20-20020a05600c22d400b003f99a93217fmr7667015wmg.3.1692720989382;
        Tue, 22 Aug 2023 09:16:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] media: qcom: camss: Fix V4L2 async notifier error path
Date:   Tue, 22 Aug 2023 17:16:13 +0100
Message-ID: <20230822161620.1915110-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 75991d849b571..f4948bdf3f8f9 100644
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
+		goto err_v4l2_device_register;
 	}
 
 	ret = camss_register_entities(camss);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_v4l2_device_register;
 
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
@@ -1690,7 +1690,7 @@ static int camss_probe(struct platform_device *pdev)
 
 err_register_subdevs:
 	camss_unregister_entities(camss);
-err_cleanup:
+err_v4l2_device_register:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
 
-- 
2.41.0

