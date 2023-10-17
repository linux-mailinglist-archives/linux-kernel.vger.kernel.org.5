Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAFC7CBF43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJQJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjJQJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:28:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D0FC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40651a726acso49584425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534877; x=1698139677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lat5LBCONELfTSKuQh7UaGsk4CzrOVkCNiW5d2Bd3pU=;
        b=yLf2Xb5cip94+58Knt49Fc4Os48Tc1EwXYDfSgQT9Cvyi/pyHgJaUaqg4RRL1nzSoz
         dx7KcShrlyAKJJNU2xwqgv/i0GaC/LbZfp+NRyE389Py0nsW2YnNH874XVdR/BV9DwNB
         BoN3S8QilewY5BjILp7mRJTRWxYzQPFzOaUVl6h+7ilAS+1nOHva5OzBQbizlPLuadnp
         uiUmC0+MlSXGjNFhRFdN3/TzT03/jOvy3KalnYP+3QLTIOu3KQj1JxsdISXhr4Ib59pw
         +gWxqyvqgMMWihxQQGN/ZVWm4SPzn4ipSm8LwQfBCF7WU/hGsUohB+yoIMt7D9D+ZHsy
         xDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534877; x=1698139677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lat5LBCONELfTSKuQh7UaGsk4CzrOVkCNiW5d2Bd3pU=;
        b=sRp9/R3PuwmFtN+qVef/m/hgM6AsuQ1oloMtfnZODgTkvk0rfJIgTc6HN6LblryTN5
         DVGuN9fKBeBS5xfk5PT8c58jEAtt4r+/s522HqY3EUV1mDYq13/a/zJ86Qm98ksNn+8s
         TEn9dCx7PaNraFVuL4xaz88vro9YHJqKTtNo01Di4JsC+cHpimqI1z2ZXjUPMCD/Ux1M
         QkFCOhFoJ+NalCD/rfYgz/4ihulkGwIprgkUzYOOpwQs0anbHfpnZn1WKGloMV+DpvZU
         kiUtObOgLV0ORNFX7DPFATfoTwNtLqMdUu/7siFRXtGBFOQM4nvaFHAWdyINqorsKYhx
         ZLpQ==
X-Gm-Message-State: AOJu0YwCfOKy8MJLg8WL29oYlGlxBKXV2AtU3naK3JJZCJ7A8V2/aJuv
        Y7l3HyJD8BNkAT9xWGAkBhbi5w==
X-Google-Smtp-Source: AGHT+IF5pE+s+nVn4IPwa/JvdUdWof0PfdGqnRAEc7IxIZ6BMACKlg7romWsW12pvPUwOk5p0/QsNw==
X-Received: by 2002:a05:600c:524a:b0:405:3dd0:6ee9 with SMTP id fc10-20020a05600c524a00b004053dd06ee9mr1214231wmb.34.1697534877079;
        Tue, 17 Oct 2023 02:27:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:56 -0700 (PDT)
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
Subject: [PATCH v5 15/15] arm64: defconfig: enable SHM Bridge support for the TZ memory allocator
Date:   Tue, 17 Oct 2023 11:27:32 +0200
Message-Id: <20231017092732.19983-16-brgl@bgdev.pl>
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

Enable SHM Bridge support in the Qualcomm TrustZone allocator by default
as even on architectures that don't support it, we automatically fall
back to the default behavior.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bf102ed3ce83..36d5062dc27f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -255,6 +255,7 @@ CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
+CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
-- 
2.39.2

