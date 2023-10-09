Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D317BE4EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377655AbjJIPf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376940AbjJIPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:35:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33884F4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406619b53caso42956825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696865689; x=1697470489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT7V6AZ26cidOG3ruLe3K86NfrAEQ3oBaGfcZy0uWnU=;
        b=woYXjaalu9aIkvPxURRfbCqsZZKg8A1DQuPnzTNWvTT23IIlWuSUniowhaoiBVtuhw
         FAKnL06YGzF2nJSxH21ZZpquVHTclrZ7AxbCUrTUPoj2BTvbURLJBOOGh9PUEt6U9VYG
         jjg437gA22tZZ7KbHL9Nc4M6MH6aZhVa/ySBpwt9VfGt+tEPUZwr0/N2G9DyesNAAbFM
         V6swssNeH/vViLAV5r1WIjkPcsvrZin77yRYlGDDSMJ19Q6xJ2NeR4+aJMstgpO9PCY7
         OovQAYRZWL+gePhGff1OBSe9TBwMdmp+dAz5mwddP01DksM6EmBKV/NeZLGkVEvxYQaf
         94YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865689; x=1697470489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT7V6AZ26cidOG3ruLe3K86NfrAEQ3oBaGfcZy0uWnU=;
        b=g7MiYtcSxnXytUUx9n3CvTl6dWhSeXsZUANchBjiRNJHfCtCD0rPsPLIrexztjL6mM
         Tcom4LZCBSzZaKyNCg2pmrO22gvZYPNYK3zWp3X+jkKrM6pZ7pxp3zoUwSwy/V9IdrcW
         LYiB1zEBp9Lqbq7zLbsTpUYlECtZb7/6QfkOSYHPjyUO/WUK25DR76MJNdhFWBm0/IGr
         uR3BqsEhMYyG/jmMazvYt0NCr//LW0cNtvg2/IxpOlJgmS0tHVomU4CYNC9MFT0ApZPc
         IoR/HkAz2mbdyvGL37RxDsnLqTYvt7SOzEb4wCdO82heCJnL3Px55rddzw4GQWO+ssTr
         Ez1w==
X-Gm-Message-State: AOJu0Yw6cDJNE7pb5BdyQH+Do4oh2SPDeLHtaonNInOpDJAYmbGDVo9N
        TeWZFlLgFK+uJm7WNgfROX+vdQ==
X-Google-Smtp-Source: AGHT+IG2Kyg2+eJFy8yr/9Sv3Py49/NM5wcjqgfeeWHCRX3tIetOY73CKPk4pgTaDtvl/4eX4+JlKQ==
X-Received: by 2002:a5d:58f2:0:b0:31f:f326:766b with SMTP id f18-20020a5d58f2000000b0031ff326766bmr13334322wrd.6.1696865689675;
        Mon, 09 Oct 2023 08:34:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f20d:2959:7545:e99f])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm10016521wrp.89.2023.10.09.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:34:49 -0700 (PDT)
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
Subject: [PATCH v3 08/15] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date:   Mon,  9 Oct 2023 17:34:20 +0200
Message-Id: <20231009153427.20951-9-brgl@bgdev.pl>
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

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

