Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06407C84F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjJMLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjJMLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788611B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so20608325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197747; x=1697802547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9Heyw2bPG0qaWUlPboXZ9YrcRBEbXtxsdZV2np9Ptk=;
        b=bkizvJdn7qJGt0KlLaSfH8Du5EBxmJoXZzEVA8GPG5r82fGRF4Uqe/c/uLsYN9qFoT
         RuZHbtuD3MhaewRhKwnyYIIyG8KA/NdOfGS3jMmABS547WHcEzzg80IWAsdpcaf7Uh6+
         IJwfR8AXbXYHE1BqrWglmF51Tk63drBGQY9orNGe+sxk68z87eYGyNt4FsbylvTCC7NP
         2LUVmjqZwPUKmd4EE93Mb47z+2qDfaxQF3n8i3aDJ726UwiQz73RoaDscD+MN7xkQ2QX
         YAfzwUGHhn6Ibxq9oeFehMxv3X6ZhsiZNYBNaWD46GK/t68XVuvSXDmhmBxztBzzhXqr
         llXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197747; x=1697802547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9Heyw2bPG0qaWUlPboXZ9YrcRBEbXtxsdZV2np9Ptk=;
        b=RnP5mV/s8JztcIvkH7AzYvwU1a66IjpAj8rn227QdHQ7cJCrQ9QU6VjHYnOwOcpwM4
         CSHZWtA8zhwj3SdYKEpd2tlYa04NhG44x1qPhRQy2O5+CwHundN/EJb7+qBknm1jJkJG
         pbvz+L9uabeyJ5gSwMw51uEiS/+j0Jb2NZfgzrqGGy4G/rVOCdBeZ/rXkUIcQnLTN0W+
         YHenXigc/gCAnwnQwGmBJ5ZAJV+PniJ83oWidGwtrrJ8IXC1eYwKBW66v/OJ2gO8Tr2D
         CeHuOpSrqDnQqvnYzCSdrlKxROpsHKYOCvZQOFER5gRXZiHwGI7Nc50mbRQhH62qx8xB
         USUQ==
X-Gm-Message-State: AOJu0YyhDow/e+rRvcJyPtFFynOuBUUriOe1MKFtUevXVNKogTBZGIQS
        Xbe9nzqW2JBsTJxEYAh+7vJ1yg==
X-Google-Smtp-Source: AGHT+IEnwo69CmHD5Qs5HcqhGzB/4dWNJStokIatU7263uXLolybJc7B7UGHuPytZ5oFSbz9IMF4RQ==
X-Received: by 2002:a05:600c:3b18:b0:407:536d:47ae with SMTP id m24-20020a05600c3b1800b00407536d47aemr9754099wms.38.1697197747308;
        Fri, 13 Oct 2023 04:49:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 14/15] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date:   Fri, 13 Oct 2023 13:48:42 +0200
Message-Id: <20231013114843.63205-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The "memory protection" mechanism mentioned in the comment is the SHM
Bridge. This is also the reason why we do not convert this call to using
the TZ memory allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 839773270a21..7ba5cff6e4e7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	struct qcom_scm_res res;
 
 	/*
-	 * During the scm call memory protection will be enabled for the meta
-	 * data blob, so make sure it's physically contiguous, 4K aligned and
-	 * non-cachable to avoid XPU violations.
+	 * During the SCM call the hypervisor will make the buffer containing
+	 * the program data into an SHM Bridge. This is why we exceptionally
+	 * must not use the TrustZone memory allocator here as - depending on
+	 * Kconfig - it may already use the SHM Bridge mechanism internally.
+	 *
+	 * If we pass a buffer that is already part of an SHM Bridge to this
+	 * call, it will fail.
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-- 
2.39.2

