Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02478B85B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjH1T2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjH1T12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:27:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26541CF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so2945313f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250823; x=1693855623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD/cr04vsZ/9/IOH8u0P4R4N+JejbyXPUXltlkLTn0E=;
        b=M1YCfAkjhG7d0Ax1dScy8AVLJXABarbwhC5Mlo0zc9Ew3M2VGhafoaNLCteOa/m3yD
         a51pY+t6Juattc/dWgCcW5nI0pvqguxlPp5FJ5vGaAgvMjH1KJoO9MGqXY1f0LbEVuI7
         dJKjPfwyZAUduK1/So0X8teePZ51EJP1GYGb9KQA055/SgoaFN3Z3Q8eDsSODuQVesfi
         g0wRYh8KooCB5ZAbAUhIOIXfrHkPDuslgoYMfLAr3MefJGv3an8ZasW5fR8A78XVetVA
         euyZ0Es9Hjfyda8lIn2WMO4xWS1bmAZlTwxN+rxdnLC+ZZe9RX5vQ8mxd9qJ/kOV5sCJ
         rijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250823; x=1693855623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wD/cr04vsZ/9/IOH8u0P4R4N+JejbyXPUXltlkLTn0E=;
        b=lyNNHoG70JGkWQfBahuYnoEwyw6yql7EQG+x9J4lXo8F1QImjUgJekKbDqgHRpU6Ts
         +HiVn+CGjF/p3HnWVYD27p+j0/vP0stoXAfAJIH2LFW8KjOq44dIegnOZ7jR2HsQhUTh
         YF1fIwqhhXjH/UQrawOCaHFfLuopXKtGWu0S4jpjAQoKBQpOeTITqTDriaLR0ZPR+MVW
         HoS4U+LjqHtbG0ZyfnVVrhynQnj9Uq13MqFB8s8oMmPr+VYJYKmbX0i4AyUPMKFlFgoP
         Ctxl+RdDkuau3nDQyPGJL4vjMvWgWj+/7crjGwzz3jB36iutXPOjZrRYGO5uJd8+XXnN
         9JLA==
X-Gm-Message-State: AOJu0Ywa2hjPSArZz0HOSTyTpr71sHLRcJgTEmZeftvFssry4j8rhCVq
        e9uD0bqMQPrDyz71VzOUZC6bEQ==
X-Google-Smtp-Source: AGHT+IG2DjUhqTBQfx117neGDoGHgAk3CElFSNDlYxMkA8BW06/aoRj0xIELzMxoR+5xz/rb1iL0LQ==
X-Received: by 2002:adf:e4c9:0:b0:31a:dbd8:95d4 with SMTP id v9-20020adfe4c9000000b0031adbd895d4mr19219586wrm.12.1693250823568;
        Mon, 28 Aug 2023 12:27:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8bd:7f16:d368:115f])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b003141f96ed36sm11435319wra.0.2023.08.28.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:27:03 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 01/11] firmware: qcom-scm: drop unneeded 'extern' specifiers
Date:   Mon, 28 Aug 2023 21:24:57 +0200
Message-Id: <20230828192507.117334-2-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'extern' specifier in front of a function declaration has no effect.
Remove all of them from the qcom-scm header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/firmware/qcom/qcom_scm.h | 101 ++++++++++++-------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..0187fc54249e 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -59,12 +59,12 @@ enum qcom_scm_ice_cipher {
 #define QCOM_SCM_PERM_RW (QCOM_SCM_PERM_READ | QCOM_SCM_PERM_WRITE)
 #define QCOM_SCM_PERM_RWX (QCOM_SCM_PERM_RW | QCOM_SCM_PERM_EXEC)
 
-extern bool qcom_scm_is_available(void);
+bool qcom_scm_is_available(void);
 
-extern int qcom_scm_set_cold_boot_addr(void *entry);
-extern int qcom_scm_set_warm_boot_addr(void *entry);
-extern void qcom_scm_cpu_power_down(u32 flags);
-extern int qcom_scm_set_remote_state(u32 state, u32 id);
+int qcom_scm_set_cold_boot_addr(void *entry);
+int qcom_scm_set_warm_boot_addr(void *entry);
+void qcom_scm_cpu_power_down(u32 flags);
+int qcom_scm_set_remote_state(u32 state, u32 id);
 
 struct qcom_scm_pas_metadata {
 	void *ptr;
@@ -72,54 +72,49 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
-extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
-				   size_t size,
-				   struct qcom_scm_pas_metadata *ctx);
+int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
-extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
-				  phys_addr_t size);
-extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
-extern int qcom_scm_pas_shutdown(u32 peripheral);
-extern bool qcom_scm_pas_supported(u32 peripheral);
-
-extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
-extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
-
-extern bool qcom_scm_restore_sec_cfg_available(void);
-extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
-extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
-extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
-extern int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
-extern int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
-					  u32 cp_nonpixel_start,
-					  u32 cp_nonpixel_size);
-extern int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
-			       u64 *src,
-			       const struct qcom_scm_vmperm *newvm,
-			       unsigned int dest_cnt);
-
-extern bool qcom_scm_ocmem_lock_available(void);
-extern int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
-			       u32 size, u32 mode);
-extern int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset,
-				 u32 size);
-
-extern bool qcom_scm_ice_available(void);
-extern int qcom_scm_ice_invalidate_key(u32 index);
-extern int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
-				enum qcom_scm_ice_cipher cipher,
-				u32 data_unit_size);
-
-extern bool qcom_scm_hdcp_available(void);
-extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
-			     u32 *resp);
-
-extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
-extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
-
-extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
-			      u64 limit_node, u32 node_id, u64 version);
-extern int qcom_scm_lmh_profile_change(u32 profile_id);
-extern bool qcom_scm_lmh_dcvsh_available(void);
+int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size);
+int qcom_scm_pas_auth_and_reset(u32 peripheral);
+int qcom_scm_pas_shutdown(u32 peripheral);
+bool qcom_scm_pas_supported(u32 peripheral);
+
+int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
+int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+
+bool qcom_scm_restore_sec_cfg_available(void);
+int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
+int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
+int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
+int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
+int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
+				   u32 cp_nonpixel_start,
+				   u32 cp_nonpixel_size);
+int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz, u64 *src,
+			const struct qcom_scm_vmperm *newvm,
+			unsigned int dest_cnt);
+
+bool qcom_scm_ocmem_lock_available(void);
+int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
+			u32 size, u32 mode);
+int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size);
+
+bool qcom_scm_ice_available(void);
+int qcom_scm_ice_invalidate_key(u32 index);
+int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
+			 enum qcom_scm_ice_cipher cipher,
+			 u32 data_unit_size);
+
+bool qcom_scm_hdcp_available(void);
+int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
+
+int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
+int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
+
+int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
+		       u64 limit_node, u32 node_id, u64 version);
+int qcom_scm_lmh_profile_change(u32 profile_id);
+bool qcom_scm_lmh_dcvsh_available(void);
 
 #endif
-- 
2.39.2

