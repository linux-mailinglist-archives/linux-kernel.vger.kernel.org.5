Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5B7FA25F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjK0OTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjK0OSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9D3AA9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50ba75e33f3so3224874e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094573; x=1701699373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkEfLIdUazWHVoS/f6N40pGJ+r4HD9QT8ToB//6WjKI=;
        b=LSYcZMTCNaRrj6L8z+aF/OKYEJbWcexUWhK33Q8zuPPp4wq/acijnx4yWpBpTT5W0n
         d9WibDy97tueE2jy+oTHhkVe7tDy1us9e3zNTuOG+nDtVhA5LT+/Z1y6d4jerxdcjyS8
         H74OEwqhtU1oTD83lYTOiXKOd4h4AYlQBS5L1cdPSkqJxOGYN8trK5c/7WSR78mywwx7
         vAJwut24mh/o1+vbYjYkqlS9DuZVrHSxYpuEDHu+126rCDz1gTELP5EbJRMOEd2tN5q2
         6LXsUg98mYzBMyfRoQh9sOPgovA1F22KiE2Wv8eEGePsnLMOPlQusY5r48m+VzleuzGj
         goMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094573; x=1701699373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkEfLIdUazWHVoS/f6N40pGJ+r4HD9QT8ToB//6WjKI=;
        b=BdoGasG4RU3Y9/3x9Penvqr8P8Ok/K/I4VJhVfq9VONZKJfO+d3e7BiEEH14cqRQB6
         VssX1FFoDYN+j5DxUcvF6X3IJ1/61MYfLxcw+Vlqos+ootgNMyHBUN/TvQf9xRCvcMBw
         LwyThoy6zLwISGYH6AKmIW03MOkWRu1BHXDm1gI4XN6gX0yRfL2Kz8+viiiomZcwZxzQ
         KlqRZkMUOhSJVRRhbPeMnxyu/mIxIPu2qfr9vwSYOXjk45c1+DSOCDNNu1nhzXmgjjWL
         d9VOy/23r3x3MKYEykZGXzEQ1bq83CeXNySbJfXjKF/mehj0VWRd3djGWsMUtPN/Mafz
         r3jQ==
X-Gm-Message-State: AOJu0YxQUxDN33Txjj+MN5vee6y9PAszY/jkC5wvKEJXcQHJXC6oEcLG
        tQdwZJa0sMcOUCezkZVxfLeFTw==
X-Google-Smtp-Source: AGHT+IHu7l09DTCJJuDJ288P8P+c4aWNjuqsJh1cEjuw9t082HlZXCAWJIkZM5tGipzeUI3odwZCeg==
X-Received: by 2002:a05:6512:239e:b0:50a:763f:ecf1 with SMTP id c30-20020a056512239e00b0050a763fecf1mr10914778lfv.12.1701094572678;
        Mon, 27 Nov 2023 06:16:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:11 -0800 (PST)
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
Subject: [PATCH v6 03/13] firmware: qcom: scm: enable the TZ mem allocator
Date:   Mon, 27 Nov 2023 15:15:50 +0100
Message-Id: <20231127141600.20929-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
References: <20231127141600.20929-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

