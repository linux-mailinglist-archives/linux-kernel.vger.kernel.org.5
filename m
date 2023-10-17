Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B287CBF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjJQJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjJQJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC71AD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso2148495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534863; x=1698139663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8azA4SdwAI3O+M9NxjKvwETkPtXq8E9q96rJRgU4/c=;
        b=qj7zXFLM5kvdHqla76QjSNAaSGWWmIbl8s4nymQocY8oZftSceNPqtD6dgQo1GAB8J
         fXVJOuGPiuWbI094nnj49Bg1mDxSfch8OgT6cGt3hQ50uOBDpFdyKqGMMLfOY5I9v72i
         8PuBN4UI5fEWCBXi3B81tFN+hHWTgc7nqA+j50DrdTCeR+paGObNdr0r/g5v3W9gwr6P
         OOX+UNc33PsaPh8QN4ckdfpiSR3HAhUbmklPADVl9uYnN/rC2npjYjqPNhXWLD96GvM6
         zagzHJ8pP16y5lp+GfVwyyZmoEzzABRIygZJD3wfn2uE2vmG5W7Q0gLar+46KLPgk436
         ej+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534863; x=1698139663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8azA4SdwAI3O+M9NxjKvwETkPtXq8E9q96rJRgU4/c=;
        b=mfnomYzcDD6j2z2oxqd85rNU6ug3jw7WaLk7zNPvuNGaMaDlC/apMeJX5yZDKhxJYq
         3KF65SWhGk5CjFQWtMiD6bKWFJXh/y6IgZTNNSwdiQVpgbIFAcbBR2anxtYZcPHdoatj
         zmTQoUFo4EeTjhHeUof1yYmD8Mpl+rxZp++FQ2MLctNmDWpHXX1nUMdpyrI03tIvqIvi
         WwCetYXr72O7deftMt1YJCVgMMvxA+mgigvUh2KUCovTQIP3HCJkBjUrVPEdTukcDNxR
         bjHVpsWAyoSLhfCkQ974teuSlM5hyoKAV/A14URZf1WG6n1s1SAyNmuqounZS0dIhFVn
         ICpA==
X-Gm-Message-State: AOJu0Yx9DIv+gF9T5CvpXYNgirRFjeoI6JxVVo5rv6xdsZlvmrQGY7QV
        xy/L/YVTger+w9PdHoz06CB+jg==
X-Google-Smtp-Source: AGHT+IHflIoUzX5n/LgAwZCY1tCYKHPMyHblRzgofmZ3EfYlYUSmeSipZ1D1TPvCFQDa208MDhrgrQ==
X-Received: by 2002:a05:600c:3155:b0:407:8129:46ec with SMTP id h21-20020a05600c315500b00407812946ecmr1224531wmo.24.1697534862925;
        Tue, 17 Oct 2023 02:27:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:42 -0700 (PDT)
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
Subject: [PATCH v5 05/15] firmware: qcom: scm: enable the TZ mem allocator
Date:   Tue, 17 Oct 2023 11:27:22 +0200
Message-Id: <20231017092732.19983-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017092732.19983-1-brgl@bgdev.pl>
References: <20231017092732.19983-1-brgl@bgdev.pl>
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

Select the TrustZone memory allocator in Kconfig and create a pool of
memory shareable with the TrustZone when probing the SCM driver.

This will allow a gradual conversion of all relevant SCM calls to using
the dedicated allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 drivers/firmware/qcom/Kconfig    |  1 +
 drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b80269a28224..237da40de832 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -7,6 +7,7 @@
 menu "Qualcomm firmware drivers"
 
 config QCOM_SCM
+	select QCOM_TZMEM
 	tristate
 
 config QCOM_TZMEM
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..0d4c028be0c1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -8,8 +8,10 @@
 #include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/export.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_tzmem.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -20,9 +22,11 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 #include "qcom_scm.h"
+#include "qcom_tzmem.h"
 
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
@@ -41,6 +45,8 @@ struct qcom_scm {
 	int scm_vote_count;
 
 	u64 dload_mode_addr;
+
+	struct qcom_tzmem_pool *mempool;
 };
 
 struct qcom_scm_current_perm_info {
@@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
 		qcom_scm_disable_sdi();
 
+	ret = qcom_tzmem_enable(__scm->dev);
+	if (ret)
+		return dev_err_probe(__scm->dev, ret,
+				     "Failed to enable the TrustZone memory allocator\n");
+
+	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K);
+	if (IS_ERR(__scm->mempool))
+		return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
+				     "Failed to create the SCM memory pool\n");
+
 	/*
 	 * Initialize the QSEECOM interface.
 	 *
-- 
2.39.2

