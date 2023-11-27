Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA207FA263
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjK0OTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjK0OSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:47 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC1F3ABD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so56505681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094578; x=1701699378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNRTBYkQ35refPua6fnWM3rCBTplvWDVxVAY6Q7+Wo=;
        b=ZxAcd3fAtdQJ3ooQw2VB96QiEzOjjCVR2TBtb6hPAjOzKjwcUNkKOdajs3M1rViqNQ
         Agraw2xK4ZsA4uDKhFqoUQY8o3fNgySf1UnMuqPkikrtFcDeYuKSf6YzN8BHSKIjMQ+8
         2LE2LI7FzBnadeVUL1BWtFSZ4S+rBv0+4X8iDDYm9FiV3vuRUeRuwkQkRokHPeEhT/+8
         JPdwcFznU8n4aJ3GguAIj7cjonnmAgy7EfX22gqxdgHsCJNwz0VTOZI+kmfen900bTrA
         sEKDRKTn9TjzJhuIw0uf2XEF/bJDVSjrm4ShO7axi3kxhs8uDsulnupO/Bcz1fN2k9Wr
         DwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094578; x=1701699378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVNRTBYkQ35refPua6fnWM3rCBTplvWDVxVAY6Q7+Wo=;
        b=bHXQ1y0/46uub6MoWPE8X/R3FY4BdnGre5KitjI2ZPkp5TkCSdlAaH1Q4myfYL3pP2
         iDTSka5SRkQcxju/DinShT/ZHDZiz0EOZDDcisMcwiOOp/gl5x40S4uv2ZYTjbziVaZy
         oOi+HPv9heA9vi77kz4GCMjJ1ZMYCKs/M2xQFPsjKsol9tILQQw4ahO9olxWHuGvGxoa
         aLyiQFzdf5OHW4zPL5XA0HNEUndtbWO9MHA3EPlDIqedVVLJLTlQxYZrOpoCN51LkpYh
         Wyt+zbYHGkhk6eFBiUuRNmbXX6gKUjDprGlyCskCjH+yV1inovlG+UraxdyqanBrMcQU
         uCZg==
X-Gm-Message-State: AOJu0YxSXhdfdqx2o/kCWWkygjoObPy4kCugKkQAlcxSiZ/SCeuwrXgS
        iRFAyJkHvY9eU9Bc9Cvdqn5bGw==
X-Google-Smtp-Source: AGHT+IEZUxmSOKvYVwtL0F7BrhlYoGaqOU8AJQaYo2RkaaxHLkEg9bcAwxd0mdj4l3PkFiSHNjGBmg==
X-Received: by 2002:a2e:b5b6:0:b0:2c9:9a20:f496 with SMTP id f22-20020a2eb5b6000000b002c99a20f496mr3657189ljn.29.1701094577880;
        Mon, 27 Nov 2023 06:16:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:17 -0800 (PST)
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
Subject: [PATCH v6 07/13] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date:   Mon, 27 Nov 2023 15:15:54 +0100
Message-Id: <20231127141600.20929-8-brgl@bgdev.pl>
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

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.40.1

