Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C300C7C84EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJMLtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjJMLs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:48:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350BC9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3231df054c4so1661434f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197734; x=1697802534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/djleLEuuC3lp+936owLmRGaug8G9ZraHIR1nlDHkk=;
        b=vQpLq5BEsHSJFDIWyeTUwztlXitR5jTrGFpQtMZPzSvJGXXdASYTeB0N9Koq2dCG5f
         kJx4U2IBoDC2MvsI6bnoOvmuqa33ESasC5tU0f8YLxlq+Ag4vonSB0UK4j0F8+A0BRDq
         FaqwYDMsguDkDhwUERaa7Q/UtKK+rXq3yPJ2tQVq2p1dEq6UbNWO2db7PjeeE27bMKDP
         00hwLmwQtVo0fbVqShSCEmFyREZYRgOtJzCmHG1eHK5ape1tZseI18/jf0L/1R5gblSy
         PtJwAgfZEE10ixYgYrCPYcnywCf1a7X5RBXAW9DL64WpXtSMuc55z3QeNdEhJNdOjscf
         H3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197734; x=1697802534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/djleLEuuC3lp+936owLmRGaug8G9ZraHIR1nlDHkk=;
        b=M6y0cPgWyaDXxsnx/M3KzHPLXn5TV4g0h+Fl8z3H4pNnb7Wau9aiVJ5bPhN8f6v+vn
         4/sOU+QuuiURU+L83DH3NvVO9XCHV3NqCGsxaQjEUdGDJkOlEs2+GS1aywLM+bk7OMrH
         5riPsrqzKjEvW4oDFYwKNR/LsV5PetR8aVioPtmTW+psh3shoxGIK8ORzTrn1sgGsdGp
         v71N1YU484zeynW3svWaJBQtcyoa0J8iEM8TnlsXeDp9DlHWqcHxwH5LWHfQM78b+wCR
         RcwXUTww8yYnJQC3jSKRtjDvKA8bJ2M5xhtuU3xgUqRmk39chxPZJ+5kE6E85X+0fONJ
         aiiQ==
X-Gm-Message-State: AOJu0YzCq6xVzPE3L1Zt8PHLNYoyQLDsj5HN5545CZXt8v9LaK1G/IMh
        te9eApgVT29wZkvGWzOly7LvVA==
X-Google-Smtp-Source: AGHT+IEnqeUgh11RR5em7SuKq8IrgD1o4vEng+unT6JpXvnQhWSAAdNm4wxzhZFquoM5eiAo/RcP8g==
X-Received: by 2002:a5d:5106:0:b0:32d:a101:689d with SMTP id s6-20020a5d5106000000b0032da101689dmr332421wrt.56.1697197734660;
        Fri, 13 Oct 2023 04:48:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:48:54 -0700 (PDT)
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
Subject: [PATCH v4 02/15] firmware: qcom: scm: add a missing forward declaration for struct device
Date:   Fri, 13 Oct 2023 13:48:30 +0200
Message-Id: <20231013114843.63205-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We reference struct device in the private scm header but we neither
include linux/device.h nor forward declare it. Fix it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/firmware/qcom/qcom_scm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 7b68fa820495..c88e29051d20 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -4,6 +4,8 @@
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
 
+struct device;
+
 enum qcom_scm_convention {
 	SMC_CONVENTION_UNKNOWN,
 	SMC_CONVENTION_LEGACY,
-- 
2.39.2

