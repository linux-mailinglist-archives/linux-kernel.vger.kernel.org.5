Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3947FA262
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjK0OT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjK0OSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4D3ABB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b34563987so24247425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094577; x=1701699377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqz1VK0mYS8f9CyDoxvSzBDgulCTNu27LF81cKbiT0w=;
        b=y4xuImJpJ6PaKSjRu3VTEEe9+KH8llXFw7JPaHkmzS1VbhGuj6yuPERbeD1owNcQ+m
         Fv68haC3A0zjQMPfVGLLJeZ5NIBuUyXf6CYlIG7QymD1O9wQ6ckvtA9L43kUr92/Ts8K
         jHgKmxaD5Lz54T1L0MfkKbocMc42BFuD6uUf7h4u8FnKP60twsDovOIuSK+XnT+NfrU0
         Qxuux97N19k4C6JiJi8OTBWGUIT+KoJrsypORvXWYMcBQ9v54KvAG3h6XXhN6Ip300kk
         Ng3SNKCffTLEQXlAU8AEEkBFnciA0Cw3t1fIg4uo8+6E5qrbdu8Uu/2/yKbBb32pgV7H
         GU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094577; x=1701699377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xqz1VK0mYS8f9CyDoxvSzBDgulCTNu27LF81cKbiT0w=;
        b=N5A3OLv2sC9tIzuH+ikFkuTLI2ivCKi/ayFV3hfZWxObe7URS4v7mqt15Fm5nFX2YC
         n3UZad3z/OBak6vSDb2gl2bqI0CtPrYsAr1cYZez0M8p5K9IPBXWdPMT9XPGJgDqjd80
         hmo6QUUYuJ5lrxPnf2MBqdd4o/XncZZMEWWJFmn6OBjJZoqBPh3ZGhdKL5B/HVMz8wC8
         5JSXzYXUMalHjEW2Wg6n+4Ydg24HpttkC7sA5x8OgPfTUI0Y+FTGDRZLMjPwZJ9Ro0rh
         DsqJR/P4R2WUxIiAkPL63Kxll20rN4WXdhALZ4YZ1BRdKvZKzvTw+2Cx6E+GHeeAlp2K
         fZsg==
X-Gm-Message-State: AOJu0YwHyKftD2CEe67VTGSNR8HlXiglWC6j+FC+y28W1t/gWkFhZKtC
        DnnrIyDBzfJrWCDKaq0hWjK4KQ==
X-Google-Smtp-Source: AGHT+IHMn0wWKy0PNcRLMmHMGiQMxo3AwVXygRjIyzuZuJGMIUuaMDA6AO6HM2buOAcnfZO9zniPxg==
X-Received: by 2002:a05:600c:4f12:b0:409:6e0e:e95a with SMTP id l18-20020a05600c4f1200b004096e0ee95amr9379119wmq.19.1701094576249;
        Mon, 27 Nov 2023 06:16:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:15 -0800 (PST)
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
Subject: [PATCH v6 06/13] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date:   Mon, 27 Nov 2023 15:15:53 +0100
Message-Id: <20231127141600.20929-7-brgl@bgdev.pl>
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
2.40.1

