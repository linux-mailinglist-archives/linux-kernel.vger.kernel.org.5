Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851537BE4E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjJIPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376903AbjJIPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:34:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE991
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32615eaa312so4296184f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696865684; x=1697470484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6eAwp+/NLgzsLQxQqIe9/6ILdI8QAjkHJ9+by+NSlg=;
        b=xhXKuHps+ybCrEyg8BHskK+FPz7fzSwdZi4aTPWwWwvKXH7BLV1R3hz/8tY2aiUorZ
         61aS9bBepbOFm4hAPOzVuqO45FhxlBNw6/96IUk9ajmiONQHuwF+FKR0zSBHZ0861uSz
         +08jsF7uSxSTbttElADRoY3tYX2xQmaf1t7x9W1sAEGo0mVUo/onpf5kVBGUdy3+qYKU
         XBAiWM1Ux/T9k6DCJPSLq8c/WRuiNkqd4X9fKyyptU9WWhHH7L9DsV6LBFHVkx6icbgn
         NsJ+DPcflylAOwkpQvSdccvKa32U4zChUHz2Nj665/3gQPpTXWOewEdyJF5rxwTcEtX4
         CZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865684; x=1697470484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6eAwp+/NLgzsLQxQqIe9/6ILdI8QAjkHJ9+by+NSlg=;
        b=Ut0STvZ43cMN9ClGQp09nAVt2XuMQ2SXerfbGaP2K2LD3pQjuwgWypFkzJ4KBi2kFX
         IZUIyaMP6MXojuKy9mO+gmrvtdYhISJHBkTqSs7YjCFl4mOq+xoajIB4v0RHKvizmK6m
         o/cUoUsswIIbSzDUA9bPArTJsMx/GQbz5X9cKVL2dAaP7UnciSc8mybDzaWhl+b9Sy4N
         6nGAqHHGfD6gBgZp4jL2W3JMM/AvHGjs6hYcjZYLTKwNaFNSTKb0J7KA9ozCflgNykmh
         bMQgRgz6k0HZmARpmHOfq9eQeDlPRseBcJArMJB+mUvVn9mt2T2kqU7nufXQDPE4M52z
         Pt2g==
X-Gm-Message-State: AOJu0YzM25t54SuawYl9nI7p99kPr/eys0K5vQpNj0iUACSUJpJNgNEt
        EDX1mMyJ8C51Kxag0IXNG6a+nQ==
X-Google-Smtp-Source: AGHT+IGQPbmjtWzlwmkDpMj8BrV+CGMweKgLmWJRazlR2GfQlg6tpQhTsj0X/JeH7Ks7AF7tx4ODyw==
X-Received: by 2002:adf:f407:0:b0:31f:eed7:2fdc with SMTP id g7-20020adff407000000b0031feed72fdcmr14360253wro.35.1696865683428;
        Mon, 09 Oct 2023 08:34:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f20d:2959:7545:e99f])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm10016521wrp.89.2023.10.09.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:34:43 -0700 (PDT)
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
Subject: [PATCH v3 03/15] firmware: qcom: scm: remove unneeded 'extern' specifiers
Date:   Mon,  9 Oct 2023 17:34:15 +0200
Message-Id: <20231009153427.20951-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009153427.20951-1-brgl@bgdev.pl>
References: <20231009153427.20951-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

'extern' specifiers do nothing for function declarations. Remove them
from the private qcom-scm header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index c88e29051d20..4532907e8489 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -66,18 +66,17 @@ int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
 int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
 
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
-extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
-			  enum qcom_scm_convention qcom_convention,
-			  struct qcom_scm_res *res, bool atomic);
+int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
+		   enum qcom_scm_convention qcom_convention,
+		   struct qcom_scm_res *res, bool atomic);
 #define scm_smc_call(dev, desc, res, atomic) \
 	__scm_smc_call((dev), (desc), qcom_scm_convention, (res), (atomic))
 
 #define SCM_LEGACY_FNID(s, c)	(((s) << 10) | ((c) & 0x3ff))
-extern int scm_legacy_call_atomic(struct device *dev,
-				  const struct qcom_scm_desc *desc,
-				  struct qcom_scm_res *res);
-extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
+int scm_legacy_call_atomic(struct device *dev, const struct qcom_scm_desc *desc,
 			   struct qcom_scm_res *res);
+int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
+		    struct qcom_scm_res *res);
 
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
-- 
2.39.2

