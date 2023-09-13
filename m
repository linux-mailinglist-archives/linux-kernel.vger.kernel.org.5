Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48579F205
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjIMT2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjIMT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:28:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843F19AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:28:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401187f8071so1689085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694633319; x=1695238119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ekWHFGFr1Y7FVdvQu8jbUa966DGJG/V+1XF1PnePVc=;
        b=twgeeaunRTz8NV6JI6cqcjfdMPpndAIYkNxMG/ZCvUXpsp3cTLXHFaTPI3cVj9VsCZ
         /cy6kl0ViaDRF1rBoyyuhOkB/YO/hZ6C/Nkoc4UXHyzT2YST48oLc2IR0PaEW4pQmPb5
         y6c7OCyqpei9TqUSJnch5sj0B8mjsX2WlYMOY+PXYS3ChMklA2QkTeJZiIKBO3mET21f
         ClPLJyfEKp/QO5eEWb1WK23gx3cUpQOnGXLe52bZVIXwuKeG3/30J6WSRc32n6NVeYpJ
         BBhZn3fXT0rhkzI9FI1RvB5ckGjrACRicjAMPuR+d/KXDAhdQ0x9FxfwyUrzQxcKNnaP
         KzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633319; x=1695238119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ekWHFGFr1Y7FVdvQu8jbUa966DGJG/V+1XF1PnePVc=;
        b=OY+7fI/eLZIn0OlBle39eItCVs2VDrBDYzFIXw9ybLKHM3n0YdCkTH3fHC53qtJjPj
         FOG+n4rfoJGLf3ZZkMiOmiy1VwtvS/eR5VXHoXii5PCAgaVev1DrgUSBUgUNt2lnLv7L
         SCZG3RUrut56zvCvSmBcTOVb9If0Aj1B+/e2mP/quOJb4gJcDvcvIxCQCZmiSljdvhy5
         Grcm/efKSTjSLjfR4fNul6ay8rTSXVOfnYiPhBoKTDnjLL2PlJK+jBEU1NTnrE4T2vsV
         DNLYxY3NHmfcqs+9dbcBsExSD/Vn78PPgjG/8TW+0cMCiu7rRV9tcMSGiKGsmw9tZkQR
         twpg==
X-Gm-Message-State: AOJu0Yw56Fe/WQ6UZoyoGNqmpOkhMrUzgJdxT6w5/pYRFKFZlZjbknDp
        PQiAgL1old11yfX7ggZ0PiNHZA==
X-Google-Smtp-Source: AGHT+IHvnLUKwGOsf87/ZFUt+3QAaRDU+QaxUIDhvJWGL5yWKNqKJqI+EYlSWvs4xyKD4YFlmme66Q==
X-Received: by 2002:a05:600c:1c16:b0:401:c7ec:b930 with SMTP id j22-20020a05600c1c1600b00401c7ecb930mr5284759wms.10.1694633319006;
        Wed, 13 Sep 2023 12:28:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3b50:bca5:a754:7463])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b004013797efb6sm2847248wmj.9.2023.09.13.12.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:28:38 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH 1/2] firmware: qcom-scm: drop unneeded 'extern' specifiers
Date:   Wed, 13 Sep 2023 21:28:25 +0200
Message-Id: <20230913192826.36187-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'extern' specifier in front of a function declaration has no effect.
Remove all of them from the qcom-scm header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 include/linux/firmware/qcom/qcom_scm.h | 87 ++++++++++++--------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 0c091a3f6d49..7a4e894d96f8 100644
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
@@ -72,54 +72,47 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
-extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
-				   size_t size,
-				   struct qcom_scm_pas_metadata *ctx);
-extern void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
-extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
-				  phys_addr_t size);
-extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
-extern int qcom_scm_pas_shutdown(u32 peripheral);
-extern bool qcom_scm_pas_supported(u32 peripheral);
+int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+			    struct qcom_scm_pas_metadata *ctx);
+void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
+int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size);
+int qcom_scm_pas_auth_and_reset(u32 peripheral);
+int qcom_scm_pas_shutdown(u32 peripheral);
+bool qcom_scm_pas_supported(u32 peripheral);
 
-extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
-extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
+int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 
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
+bool qcom_scm_restore_sec_cfg_available(void);
+int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
+int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
+int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
+int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
+int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
+				   u32 cp_nonpixel_start, u32 cp_nonpixel_size);
+int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz, u64 *src,
+			const struct qcom_scm_vmperm *newvm,
+			unsigned int dest_cnt);
 
-extern bool qcom_scm_ocmem_lock_available(void);
-extern int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
-			       u32 size, u32 mode);
-extern int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset,
-				 u32 size);
+bool qcom_scm_ocmem_lock_available(void);
+int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
+			u32 mode);
+int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size);
 
-extern bool qcom_scm_ice_available(void);
-extern int qcom_scm_ice_invalidate_key(u32 index);
-extern int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
-				enum qcom_scm_ice_cipher cipher,
-				u32 data_unit_size);
+bool qcom_scm_ice_available(void);
+int qcom_scm_ice_invalidate_key(u32 index);
+int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
+			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
 
-extern bool qcom_scm_hdcp_available(void);
-extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
-			     u32 *resp);
+bool qcom_scm_hdcp_available(void);
+int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
 
-extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
-extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
+int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
+int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
 
-extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
-			      u64 limit_node, u32 node_id, u64 version);
-extern int qcom_scm_lmh_profile_change(u32 profile_id);
-extern bool qcom_scm_lmh_dcvsh_available(void);
+int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
+		       u64 limit_node, u32 node_id, u64 version);
+int qcom_scm_lmh_profile_change(u32 profile_id);
+bool qcom_scm_lmh_dcvsh_available(void);
 
 #endif
-- 
2.39.2

