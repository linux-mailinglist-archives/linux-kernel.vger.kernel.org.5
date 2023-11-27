Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B27FA26A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjK0OTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjK0OSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281F3C31
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so17370865e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094586; x=1701699386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFfJP54/xc7BHA8KKJGYnGca16T3qiUmmV3jKwTKBQY=;
        b=cRAMTeieivsjBt3avR+Ku8wbD7USPcTI+VQgBm1XvLzK/brMTu3AP8cO5HzIpey8HI
         Bf7gLKsxI+jTcFKYnhoATmSYZkQnHfoqq/Q04pWBNzo4+wDdysgNZppkncwHk7eiVK1X
         5Aidk6/DLkDndCHIYPVU46XRgH1rjdiBrTXTY0y4k5SXm/o/IYvkdtwQTzY2OvSN76uq
         e8zP7dnMUIO4teYD+KL2Ne72K0+bSKNYZh+FWYPNfw+alDQhkZb39FlmOgIwjJ1jPKTI
         5WVE8PrTn5gGRJq+t5wMgD3GdO2by596Xc0KCRZYTYamq9FxuSGJT0FW848qK18b8oap
         KiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094586; x=1701699386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFfJP54/xc7BHA8KKJGYnGca16T3qiUmmV3jKwTKBQY=;
        b=sqhsO9T+WuTKFF+A7fdLbCYhQmzjKf6hBAa9fOXF9GZBii2+v1sWsRr9bjtSJ4Ue8w
         m7Gd6JINUjX42XijomloouOZJ8XyzQaaCwT5fcig9aYdmNsTeZL3cbGXTzboUdtZSwHs
         yIDqsokRtPIUTVHUCmUBGFs+DBAWoCjkR9Ezqvw1LAOG+RpIYuNIBZBkqtk380pMcHdK
         aUkbRXMl0tAA7Bzn2pKGmAM6u6+oaMwEB82FCjAQOpbkiMuaU3wpHz5eilcLlVx9Jh5G
         WqOKIz+uJSeYhwDIjVnKqkehKw1il4sxBcIC1KLPy/MaKf/icgExU6GWkYXUh0Gi+yaM
         qRyg==
X-Gm-Message-State: AOJu0YzP4SQ+PYm8Wkt2ShG/z5HJy7koY5/JgL0hecy/ljyLVA65/DCU
        n8CIYz/6y3CEbSyId0QUEvWzWw==
X-Google-Smtp-Source: AGHT+IEIgowsVDZas+3HVfgHYGIPV66wNOaSjrs3VAw1BwpW78zUkRBqHRUWw0OYTYY+L65OxkyE0Q==
X-Received: by 2002:a05:600c:600a:b0:40b:32e7:2e89 with SMTP id az10-20020a05600c600a00b0040b32e72e89mr8536462wmb.18.1701094585913;
        Mon, 27 Nov 2023 06:16:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:25 -0800 (PST)
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
Subject: [PATCH v6 13/13] arm64: defconfig: enable SHM Bridge support for the TZ memory allocator
Date:   Mon, 27 Nov 2023 15:16:00 +0100
Message-Id: <20231127141600.20929-14-brgl@bgdev.pl>
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

Enable SHM Bridge support in the Qualcomm TrustZone allocator by default
as even on architectures that don't support it, we automatically fall
back to the default behavior.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..5380e78087a7 100644
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
2.40.1

