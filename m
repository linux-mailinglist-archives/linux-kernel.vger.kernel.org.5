Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AC7B172C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjI1JV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjI1JVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2530194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32003aae100so9290847f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892871; x=1696497671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwhz75YMPOq4qEC9+ip9OVp9daQY2HSr3vN/IaeFnqw=;
        b=ZdFDth24YL6VP5Sf68aAW8r37uMQJFqqSeWLlHNT60ZZwMRLJLmztpN2sC5ES1hr22
         YLrnccYBdJoTe/3xD4rLP4gK9jYfIQwhSDPkcTsEz42Fsf/mA9zxww0I99nHpu9ibuGX
         gmVaEC8Qze5sMMlGLvWeUx7l7CGW914AZaNpoqhsTDtMbJ1ueW8WQco9+IO3xpoxEM+Q
         CGiwaZCzSPUR4curXfdiGNWm79c0MfqFEVfTrwzlmXErt6rBk4dxW3dO2d41B/VOQ7Hj
         T7/uLsj9JHSV/LlZjGlKZklaBqtNUptZV7v7IgN48pSlW9qmtgmyB7xHOuY7hF86xNNY
         9QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892871; x=1696497671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwhz75YMPOq4qEC9+ip9OVp9daQY2HSr3vN/IaeFnqw=;
        b=M8NPUdPtsR2hpScfZaMcL9ZR1AiBEPIMv150m/Y+xumN7dSRdBoK1PgZbBn0LYlldJ
         fGQnvPnCvSRJoxW8to5u6wnuAd6vcgfgmz7IOWz95HTqxd++eox4g3S48ts4nuQcbbSH
         fdgNGBxBhvVOWcGVtL9l0mwmmcCZuLgQEoGHAy4rnhl4N1Xt1KZ5LlXbcy5ca32af4dq
         EmewuwgJKeGfHTEwOQ0rij5xfom/62pf3ZdwEWYKfhXJKanIZdcFc6zh0EEy7zuZwBgM
         9+BkCuORaPLgB/Z0FAEaofFnJKX1Uv8xgnA1y9SB4Zv7JymO+vY5u5/wc1987KUVzvfq
         kE3A==
X-Gm-Message-State: AOJu0YytPUajvGCduchwc/vtXce99oVi+p/S50pF0V0agoixIaCTKlnr
        ZzOqgqL3RMxcg63lbDTTlPyyuQ==
X-Google-Smtp-Source: AGHT+IE3GsANY81UVfUlFWZkTjFrKFj1hDWRsy6MTw6h1c+EJ5jbfuVPbu8WWRLFLFkKE7PwmPfr8w==
X-Received: by 2002:a5d:574f:0:b0:319:6997:9432 with SMTP id q15-20020a5d574f000000b0031969979432mr783332wrw.1.1695892871336;
        Thu, 28 Sep 2023 02:21:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
Date:   Thu, 28 Sep 2023 11:20:40 +0200
Message-Id: <20230928092040.9420-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
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

Extens the SCM memory allocator with using the SHM Bridge feature if
available on the platform. This makes the trustzone only use dedicated
buffers for SCM calls. We map the entire SCM genpool as a bridge.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom/qcom_scm-mem.c
index eafecbe23770..12b12b15f46f 100644
--- a/drivers/firmware/qcom/qcom_scm-mem.c
+++ b/drivers/firmware/qcom/qcom_scm-mem.c
@@ -16,6 +16,8 @@
 
 #include "qcom_scm.h"
 
+#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
+
 static size_t qcom_scm_mem_pool_size = SZ_2M;
 module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
 		   ulong, 0400);
@@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
 	return chunk->paddr;
 }
 
+static int qcom_scm_mem_shm_bridge_create(void)
+{
+	uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
+
+	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
+	pfn_and_ns_perm = (u64)qcom_scm_mem.pbase | ns_perms;
+	ipfn_and_s_perm = (u64)qcom_scm_mem.pbase | ns_perms;
+	size_and_flags = qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_perm,
+					  ipfn_and_s_perm, size_and_flags,
+					  QCOM_SCM_VMID_HLOS);
+}
+
 int qcom_scm_mem_enable(struct device *dev)
 {
+	int ret;
+
 	INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
 	spin_lock_init(&qcom_scm_mem.lock);
 	qcom_scm_mem.dev = dev;
@@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
 
 	gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
 
-	return gen_pool_add_virt(qcom_scm_mem.pool,
-				 (unsigned long)qcom_scm_mem.vbase,
-				 qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
+	ret = gen_pool_add_virt(qcom_scm_mem.pool,
+				(unsigned long)qcom_scm_mem.vbase,
+				qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_enable_shm_bridge();
+	if (ret) {
+		if (ret == EOPNOTSUPP)
+			dev_info(dev, "SHM Bridge not supported\n");
+		else
+			return ret;
+	} else {
+		ret = qcom_scm_mem_shm_bridge_create();
+		if (ret)
+			return ret;
+
+		dev_info(dev, "SHM Bridge enabled\n");
+	}
+
+	return 0;
 }
-- 
2.39.2

