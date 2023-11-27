Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7A7FA268
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjK0OTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjK0OSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:51 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1B3C16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c8879a1570so54536161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094583; x=1701699383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi8eKf9Bk+MHBCMvhATqbV/lq6r88mkgwcH/G87faK0=;
        b=Yc1JaowH8yN3IYwp7jKq8C9mK4qs7w1oYBKTLVeO9TYqjHDZLuoQyxY1lCGY/KMy9F
         CXrFs2YH/4+tGz8vS6DQXCIGCnjHAYjYPmOWAjydRLjVXvEOZzGGtb0jbnZN8yveWW+y
         8Crct/s5hMIaLyWt+ofoTwjNQ60H7MqXrx1xwNzUDLT/O7tTL/BCZRyP8APkewjaCeEE
         CTcffaIoBujDusGXadNulMlslyukMWZit1see3dDiIg0jhRHeWAafmAVuzjawHrpnJkD
         ExtyusDBAL0/2573b4clftsr5NHhJBUNHlRhg4//jCpcEQRz17z+DORm4IrWMD7RlH3n
         Kdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094583; x=1701699383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mi8eKf9Bk+MHBCMvhATqbV/lq6r88mkgwcH/G87faK0=;
        b=rF4hkRhvSIEV3UG+uIuR27u9Du7k2yZ6Uk4Eral+Bck/iVAgh+g6cKKQT3+H5g7oJ/
         lmLLRktjkCS5Z1e9wsMWRg6+BkxnzLLQkkaPIlcZcRQ7Tkid8WcPSfZzhZBU9poPTDTq
         w7W2bcRW1Pai84ZAOHIKSDdnV1L1noOkhghUE3iEGpRKL/J9fdEJOiIeKfyhujtX3Y9C
         KOCOA8mlAVhKgG0Kx1y04vU8ESLUImHuSy4u93J0v94UDzIgc5CJ3OqHV1XDIjZ2id6D
         NqfXJsYkDHhKU7SKGur3nP7WA3DWem6k9+lKiCr8ZbSUoCxm/VN36znZdqqb6qd6qP9o
         952w==
X-Gm-Message-State: AOJu0Yz35grk+NNUcNUgv8Jx3nnh/dJhFG3BAzvOOjPYHbvTnouOIDvv
        X8L/EqcuBkSLAZxxc+D1Ov6LUzE0OUdd8bLv/vqCJQ==
X-Google-Smtp-Source: AGHT+IFNL1Em68j1sMBW/4w1EkRoANc+xc8NwuXyMpzGr/usWcq8SWNsyNFhkYwxwMDQJxFCSq7AIg==
X-Received: by 2002:a2e:88c2:0:b0:2bc:c4af:36b9 with SMTP id a2-20020a2e88c2000000b002bcc4af36b9mr7465362ljk.52.1701094583228;
        Mon, 27 Nov 2023 06:16:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:22 -0800 (PST)
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
Subject: [PATCH v6 11/13] firmware: qcom: tzmem: enable SHM Bridge support
Date:   Mon, 27 Nov 2023 15:15:58 +0100
Message-Id: <20231127141600.20929-12-brgl@bgdev.pl>
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

Add a new Kconfig option for selecting the SHM Bridge mode of operation
for the TrustZone memory allocator.

If enabled at build-time, it will still be checked for availability at
run-time. If the architecture doesn't support SHM Bridge, the allocator
will work just like in the default mode.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 drivers/firmware/qcom/Kconfig      | 10 +++++
 drivers/firmware/qcom/qcom_tzmem.c | 65 +++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 237da40de832..e01407e31ae4 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
 	  Use the default allocator mode. The memory is page-aligned, non-cachable
 	  and contiguous.
 
+config QCOM_TZMEM_MODE_SHMBRIDGE
+	bool "SHM Bridge"
+	help
+	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
+	  in the 'Default' allocator but is also explicitly marked as an SHM Bridge
+	  buffer.
+
+	  With this selected, all buffers passed to the TrustZone must be allocated
+	  using the TZMem allocator or else the TrustZone will refuse to use them.
+
 endchoice
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 44a062f2abd4..1ca3773263e5 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -55,7 +55,70 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
 
 }
 
-#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
+#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+
+#include <linux/firmware/qcom/qcom_scm.h>
+
+#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
+
+static bool qcom_tzmem_using_shm_bridge;
+
+static int qcom_tzmem_init(void)
+{
+	int ret;
+
+	ret = qcom_scm_shm_bridge_enable();
+	if (ret == -EOPNOTSUPP) {
+		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
+		return 0;
+	}
+
+	if (!ret)
+		qcom_tzmem_using_shm_bridge = true;
+
+	return ret;
+}
+
+static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
+{
+	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
+	int ret;
+
+	if (!qcom_tzmem_using_shm_bridge)
+		return 0;
+
+	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
+	pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
+	ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
+	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
+					 ipfn_and_s_perm, size_and_flags,
+					 QCOM_SCM_VMID_HLOS, handle);
+	if (ret)
+		return ret;
+
+	pool->priv = no_free_ptr(handle);
+
+	return 0;
+}
+
+static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
+{
+	u64 *handle = pool->priv;
+
+	if (!qcom_tzmem_using_shm_bridge)
+		return;
+
+	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
+	kfree(handle);
+}
+
+#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
 
 /**
  * qcom_tzmem_pool_new() - Create a new TZ memory pool.
-- 
2.40.1

