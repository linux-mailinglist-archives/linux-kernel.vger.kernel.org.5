Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F627C84F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJMLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJMLtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E28D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso20095195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197741; x=1697802541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o08KoJEp1jyjQ9dNvbb3XNbjVFJz+FU0ksbtua1h9kU=;
        b=vDaPYF+adfV81tK+HR46pTeOCItb18NbJqiN3VoqZhj0J91mxQToL1F2kK+MLpg6nO
         HtFlN0EdrSTRKkW3Bn5IXWg0wn6PM+NYtZ+0Igjil1Fw+tI/lXP65/Y+eDzIooq/gfEK
         999c8k4hN1Wu6hrzM3+OL/AFj0lEeXATn0+PK1pwmEHvs88iWN2dkzUixwfFSkEUrjXj
         srwN16SEislxfNtn9g0x/uSLE81tBnBg+h+k4aOF/bTajESIc1M+8DrXRFmNdkD8jOI5
         6HtbPld/DXHMxq04ZAEC32uCrTjkdbIHo6nDO3kkgKYdHj/xj8dXhewAFktYyNYNwVBA
         hJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197741; x=1697802541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o08KoJEp1jyjQ9dNvbb3XNbjVFJz+FU0ksbtua1h9kU=;
        b=D4K91r9V9P/kVi+kusuTlEtqvrYbCnm5oziks17kuRBHp8RztKtLwzveOqDcDGEgSL
         o3D5ShfhC3jEU+YgNIqU2wqsSGY3k2ILCvXgOdMwX69b8O0+Hn2B8HznOF73Eh+Bs8q0
         tUcluzdFoxJQ7t0lALtuzKntFopwkhByN8iTFTj0TjOMIa3xYypjezOwwySa1fxGz00/
         CleDVrq2Qt3CeAydmcYAcgySwBuppUjsjyOkqZrGekdY9KVt1yogatUZb5l6QGcvaJga
         9XvWS2vVh2NvPVn5G0rzJlgFrawuDZNC8Llkz/QikLDU/eHdM1PrGtiRstd7KypAYHau
         W9qA==
X-Gm-Message-State: AOJu0YznzP+8lXphdNl1QpsIYZxhfQbYE0hrPpXQPxDytjgK1Li5LuUy
        jZmSw91XqS1V2hZbh8t+bJaKEQ==
X-Google-Smtp-Source: AGHT+IESLcsz5LctZsBuJll13spdgRKIkc+P4hRt3xAF1eR7x09EBzVgQ3xnO+6UB5cR8FVzALdv8A==
X-Received: by 2002:a05:600c:4f51:b0:403:aced:f7f4 with SMTP id m17-20020a05600c4f5100b00403acedf7f4mr20749395wmq.12.1697197740780;
        Fri, 13 Oct 2023 04:49:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:00 -0700 (PDT)
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
Subject: [PATCH v4 08/15] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date:   Fri, 13 Oct 2023 13:48:36 +0200
Message-Id: <20231013114843.63205-9-brgl@bgdev.pl>
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

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/firmware/qcom/qcom_scm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 754f6056b99f..31071a714cf1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1197,32 +1197,21 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 		.args[4] = data_unit_size,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
-	void *keybuf;
-	dma_addr_t key_phys;
+
 	int ret;
 
-	/*
-	 * 'key' may point to vmalloc()'ed memory, but we need to pass a
-	 * physical address that's been properly flushed.  The sanctioned way to
-	 * do this is by using the DMA API.  But as is best practice for crypto
-	 * keys, we also must wipe the key after use.  This makes kmemdup() +
-	 * dma_map_single() not clearly correct, since the DMA API can use
-	 * bounce buffers.  Instead, just use dma_alloc_coherent().  Programming
-	 * keys is normally rare and thus not performance-critical.
-	 */
-
-	keybuf = dma_alloc_coherent(__scm->dev, key_size, &key_phys,
-				    GFP_KERNEL);
+	void *keybuf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							   key_size,
+							   GFP_KERNEL);
 	if (!keybuf)
 		return -ENOMEM;
 	memcpy(keybuf, key, key_size);
-	desc.args[1] = key_phys;
+	desc.args[1] = qcom_tzmem_to_phys(keybuf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
 	memzero_explicit(keybuf, key_size);
 
-	dma_free_coherent(__scm->dev, key_size, keybuf, key_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
-- 
2.39.2

