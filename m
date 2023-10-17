Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E217CBF40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjJQJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjJQJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:28:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4612F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4079ed65582so3383485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534876; x=1698139676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRiqTWR7MnlroI7LNrhzEhXqnAUPFNJNh2JMipiQfFk=;
        b=Qb2vp7ARsVPIEWWSBew0vmaUt9acUua2p9OyofofqE/3tlrlscyHIq31bhKggo5vfd
         bDetDigHqWGK6D8R3qrrlSwOmHVNy1LVZhd7nY+/BbvYOn2DNST5zOAxXQDrB2bYz4du
         bcjP8DmBcHjWaoJtzH1tAqn/DEDPWbo0zkYpUIH58kgi1p/FcicLHEEWZbrjLaD3dMDt
         F80oP3Emd7XGu7VdzCtm2DSwe9JuBGEnSgSe/TqB3+eC1ZhQBjJQLQvGRL1ungL8SOn4
         tnSM0F7T6CnchLAsgwREzdwW0Ev8jk1bZs3pVKMO2NOGYO1gMsvU3VKk/VjTZfcrCW9V
         lxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534876; x=1698139676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRiqTWR7MnlroI7LNrhzEhXqnAUPFNJNh2JMipiQfFk=;
        b=wr6pktZIDEvQbF7gueu0Eo5qM0M+/tm3PG5q3MvB1Odz3CKoyZAeT05C9kSxtDrnmB
         IYdC5MYWT9TDtgjRb20Qs0c/Y4QExVG1A+z2JYCWkZo39WGkYVfyIDTI5xB8MSi8dXp5
         NunFpuScs7xFuS0uWYDocvvdeSrhfb4XOGnWOedyOXK8w1go1xkuW/EuRBboM6zumwe2
         h/U1oVe4LPtfjLy2uj++4tEPs01W1O8nmnTbWLJ0yGdGglPJSTZEo9QjI9XL4Tcszx5/
         ut9iclSl5SjZhRYxuRdsQvieessADCWGakPBlss8tkS7V/pNEB3F071VwactFfXhdnSq
         y3lQ==
X-Gm-Message-State: AOJu0YyE/nqHu9iJUGs74/XmqsHtZ8+kMJSE0Dc03QClci+HgYvC3fCd
        OgqFrmYmBecKV1OskScV29vfutETcdxzdduhNhE=
X-Google-Smtp-Source: AGHT+IGjspsLXt3H2qeoIgJzZ6DxWYAR62nF3gpeS0HTcDZVahX430zrbmWpRwlot6FZMDHGBE9/TA==
X-Received: by 2002:a05:600c:4f02:b0:401:a0b1:aef6 with SMTP id l2-20020a05600c4f0200b00401a0b1aef6mr1409569wmq.2.1697534875913;
        Tue, 17 Oct 2023 02:27:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:55 -0700 (PDT)
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
Subject: [PATCH v5 14/15] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date:   Tue, 17 Oct 2023 11:27:31 +0200
Message-Id: <20231017092732.19983-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017092732.19983-1-brgl@bgdev.pl>
References: <20231017092732.19983-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
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

