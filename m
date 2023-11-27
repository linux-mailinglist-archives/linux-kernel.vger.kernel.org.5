Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413767FA269
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjK0OTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjK0OSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:51 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1C3C22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5056059e0so55266601fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094585; x=1701699385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4fo0VIV7uqzpyPDAWdX5Jk/6XQkZo9JW17PTbGLI2E=;
        b=plkoYkmB9344i0oHWaJmZoffQRgZkzJ1Sx01e8tdZHSdQsj4PBZNoBL2aDS8zugNvt
         ix++MXL/nETMJMcpJUmIPSMPba0JFms3vZdWV11CPFjo+N/a2WPhox7AKDk323g1SIxM
         cZWTU+QlGh19thyyx7oHVuztVBPILN10g2kncaUBtk05DcsBmOHYV3YB3XT+0w49LbHx
         cVQ9aaY4vubs4CnyWKqQxMVF5WqRzgs9pMsYEnck3F+k0pfevQKwr4xT7+GmDgBfHFK8
         ymU8r2WHwsQod2Hhxif/nsejwuyURi+DFg8BkAquIi14Gzss/u5WNTuNwipKGTh6U4Ag
         m5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094585; x=1701699385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4fo0VIV7uqzpyPDAWdX5Jk/6XQkZo9JW17PTbGLI2E=;
        b=Z4+tiS9O4RZQRNktMS6GA/dM28wYDI4xGU4Ifq/PFQbmO6yMV8flONSPyrCvpHXp4R
         ckj4GlUfSJ5lpEv8P4O26JDFnsfbQcnxng+j1je9wI1Ejlsuyqv7rLpntRmG54aBTyhY
         Z4STU24w4tpyR9rOZMldfxM3lhdVkqAC7z4yr0v6PS2w0ZxbS5UTLRc4qagxljjbS7DC
         KfN4tpP3Fzs3jLOts0O5TsWprxYduO/1lbhvuhxqtXCiVMfHH92HmyTAQln5+zU6w7tD
         HyAEdy6Rrf12Wt72OpY1L8vp1+5omLX86M6X4wbEPuJenOwYbwX1gqcV9Cdb/V2Gbtkh
         Xhxg==
X-Gm-Message-State: AOJu0Yx3kuATeEi07jnIryT7Z8P9qpJVYZh5NnhpKnh8pSlO55sRExqj
        hRedbrWXwtIOxIQANeBS0lHHxA==
X-Google-Smtp-Source: AGHT+IE4q3cN3fNNKCJN0/rwHtASmaX4mdUnjMTHPVaZwS7nJPgA+zX7NazFQnJHsHbeV+bI2LGPTw==
X-Received: by 2002:a2e:a7cd:0:b0:2c9:a09a:dde0 with SMTP id x13-20020a2ea7cd000000b002c9a09adde0mr3080219ljp.28.1701094584920;
        Mon, 27 Nov 2023 06:16:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:23 -0800 (PST)
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
Subject: [PATCH v6 12/13] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date:   Mon, 27 Nov 2023 15:15:59 +0100
Message-Id: <20231127141600.20929-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
References: <20231127141600.20929-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

