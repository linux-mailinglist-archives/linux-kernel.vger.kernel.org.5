Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA217DB7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjJ3KTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjJ3KSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:18:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85395B95
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-408382da7f0so31322825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698660218; x=1699265018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssP4KB5jQYMoyjKlHdy1AaYK1DfyUFr3e4RTz1dsus8=;
        b=ZGRR8Mnz0fweLmmMNEjm3tQyiiZRS0IovK/tz1SRgor5DRM0kFKsZL+7G1aTaqzTan
         xRudOLeO0MvNL5embfgSpW2rlUrKrBHpehJwsd1GfHKSxQKKe8KBS+F8rBexghJpNhxU
         eF1+AhqfjEbx8c+S3Ai0zrxzt+oktdcs1F7vyLOp4kkAg2/MQNsZ3j51LGAz7n0HNnx7
         rqaDQOCmtTj273O3Kyz6c9qxksqXHgHzXnbdysJXrkDF8oKKyWDKUgxJVEdB8d+aiL6D
         CJ61nf9OM6vU4XSfKLYGhMNfLwkUdMui5usqDaTvtwKBudIVi9jXKvfXHS3WmyVG3a/c
         eDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660218; x=1699265018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssP4KB5jQYMoyjKlHdy1AaYK1DfyUFr3e4RTz1dsus8=;
        b=DffYjLgrv2wcAdgT2SLspe3TNmkSLTxuLZIJRA4T7TFwc8bTGKntwIknSpj0rE435f
         fz2ndVqNqg8cTRIcASYpF9POPIXbCfTjPAI7Ji9djEDbAjavOzA29m5inml8RKdR3mOD
         fRsbfV1HQlSAnH6YmXABJkdYBFWNUSpBEOIjBWgJbnsvI2gLegNVB/AX5isWV1FVdXCz
         LrwlRQ78pOUhAulkVwxqMat49r0f0QgQ8aWG3pOg8TYQc8ZitKQ/xAkWj9RPyvYlqdle
         SEUeoDHt4MyvV5HUuMHTk9X5Vqq9AxILREImLUnuSx/QaCY/CwLagWcUcp8Ekg0g9RKP
         UuBQ==
X-Gm-Message-State: AOJu0YzyiKgRKRndA2TcKCrc52IazKEU1u2lN02QWKIO53DAPt8zDCZp
        WWWiwZ5z0EbEH9J0jFx26ileYA==
X-Google-Smtp-Source: AGHT+IGU4WGLWFwmmfINDCqcuCN3MipD9JqGNMvyYWk3kt4Gd8D6RntrGPdd34aBqxa6DICnnsJpQA==
X-Received: by 2002:a05:600c:5488:b0:401:2ee0:7558 with SMTP id iv8-20020a05600c548800b004012ee07558mr7491764wmb.32.1698660217674;
        Mon, 30 Oct 2023 03:03:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm8776700wmq.14.2023.10.30.03.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:03:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 11:03:14 +0100
Subject: [PATCH v2 2/3] remoteproc: qcom: pas: make region assign more
 generic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-remoteproc-v2-2-609ee572e0a2@linaro.org>
References: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6167;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=i9GgDCC6g7mU5EIa98I5Xi71yOCJg6QFzSORhu8lHB4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP391B5JQ3SVWxZ+JqmrRuIDVmqL7qt9tDX1CD0DS
 8ej5dAqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9/dQAKCRB33NvayMhJ0SyrD/
 43VvuyHtjG2+8030sfn/NxmEgUB3wb4hy2Y7AKO5ms0D6OEPXthtQN8n7jbDtRI6aRclAl5CigNE60
 eb6h+Pt+NLBDsZL/QH48chngz8kCfEfsRkZz+7T5oJqF2pAWf0qy7h8d8K3fhyOemOoeGZ/ywUKJfN
 TMywfWYZsNcj4kIflyJ32DydzaErEWRtin4Swba0EXs698AzR0qCBGKtF6dj17s20m3W+wn4lara+t
 Mgd0WGheM5AXZ6CIBN8ioTtGIudtWpChrADsB7KWArP6zwx5oTdXUlLtLC3lnlTxLIEWmc1O3zJKal
 4ZNAISEipw003Kk8c//7WXbiRkTohQMN2k4TUzKcVFQ3bVwn9I2UWc2DLZ1ScmyU6Ai88/27sG9NI2
 QkmBXfikgnyMMFVhbnlStM3zAhOcqdnHG8xY9PkbS1dgIkCkay5TrSmaXTzybCbVGFPDjXe63ibLqS
 vi3MpO5CHta3N1hOgq8LZ8m8J250/X6kDFtRs1v4vYf1jpp5CItbkVXPsHdm39zjkMK1iv8jqNnZZZ
 Pmt8TWeoIIeL2E0lUh3zWqjDWOh7eZYHtzOZ4QSDyEPFFEIwoKEC9Y6ZYpdu5Z0YfVUDjAuDFBXpSV
 lPl99CHBgkkaCN5gs5oQOJbIgtFR5949Anx6kjfG7FVKm7RY0D3IbpSqdvjw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current memory region assign only supports a single
memory region.

But new platforms introduces more regions to make the
memory requirements more flexible for various use cases.
Those new platforms also shares the memory region between the
DSP and HLOS.

To handle this, make the region assign more generic in order
to support more than a single memory region and also permit
setting the regions permissions as shared.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 102 ++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 36 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 913a5d2068e8..4829fd26e17d 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -33,6 +33,8 @@
 
 #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
 
+#define MAX_ASSIGN_COUNT 2
+
 struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -51,6 +53,9 @@ struct adsp_data {
 	int ssctl_id;
 
 	int region_assign_idx;
+	int region_assign_count;
+	bool region_assign_shared;
+	int region_assign_vmid;
 };
 
 struct qcom_adsp {
@@ -87,15 +92,18 @@ struct qcom_adsp {
 	phys_addr_t dtb_mem_phys;
 	phys_addr_t mem_reloc;
 	phys_addr_t dtb_mem_reloc;
-	phys_addr_t region_assign_phys;
+	phys_addr_t region_assign_phys[MAX_ASSIGN_COUNT];
 	void *mem_region;
 	void *dtb_mem_region;
 	size_t mem_size;
 	size_t dtb_mem_size;
-	size_t region_assign_size;
+	size_t region_assign_size[MAX_ASSIGN_COUNT];
 
 	int region_assign_idx;
-	u64 region_assign_perms;
+	int region_assign_count;
+	bool region_assign_shared;
+	int region_assign_vmid;
+	u64 region_assign_perms[MAX_ASSIGN_COUNT];
 
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
@@ -590,37 +598,52 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 
 static int adsp_assign_memory_region(struct qcom_adsp *adsp)
 {
-	struct reserved_mem *rmem = NULL;
-	struct qcom_scm_vmperm perm;
+	struct qcom_scm_vmperm perm[MAX_ASSIGN_COUNT];
+	unsigned int perm_size = 1;
 	struct device_node *node;
-	int ret;
+	int offset, ret;
 
 	if (!adsp->region_assign_idx)
 		return 0;
 
-	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
-	if (node)
-		rmem = of_reserved_mem_lookup(node);
-	of_node_put(node);
-	if (!rmem) {
-		dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
-		return -EINVAL;
-	}
+	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
+		struct reserved_mem *rmem = NULL;
+
+		node = of_parse_phandle(adsp->dev->of_node, "memory-region",
+					adsp->region_assign_idx + offset);
+		if (node)
+			rmem = of_reserved_mem_lookup(node);
+		of_node_put(node);
+		if (!rmem) {
+			dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
+				offset);
+			return -EINVAL;
+		}
 
-	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
-	perm.perm = QCOM_SCM_PERM_RW;
+		if (adsp->region_assign_shared)  {
+			perm[0].vmid = QCOM_SCM_VMID_HLOS;
+			perm[0].perm = QCOM_SCM_PERM_RW;
+			perm[1].vmid = adsp->region_assign_vmid;
+			perm[1].perm = QCOM_SCM_PERM_RW;
+			perm_size = 2;
+		} else {
+			perm[0].vmid = adsp->region_assign_vmid;
+			perm[0].perm = QCOM_SCM_PERM_RW;
+			perm_size = 1;
+		}
 
-	adsp->region_assign_phys = rmem->base;
-	adsp->region_assign_size = rmem->size;
-	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
+		adsp->region_assign_phys[offset] = rmem->base;
+		adsp->region_assign_size[offset] = rmem->size;
+		adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
 
-	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
-				  adsp->region_assign_size,
-				  &adsp->region_assign_perms,
-				  &perm, 1);
-	if (ret < 0) {
-		dev_err(adsp->dev, "assign memory failed\n");
-		return ret;
+		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
+					  adsp->region_assign_size[offset],
+					  &adsp->region_assign_perms[offset],
+					  perm, perm_size);
+		if (ret < 0) {
+			dev_err(adsp->dev, "assign memory %d failed\n", offset);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -629,20 +652,22 @@ static int adsp_assign_memory_region(struct qcom_adsp *adsp)
 static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
 {
 	struct qcom_scm_vmperm perm;
-	int ret;
+	int offset, ret;
 
-	if (!adsp->region_assign_idx)
+	if (!adsp->region_assign_idx || adsp->region_assign_shared)
 		return;
 
-	perm.vmid = QCOM_SCM_VMID_HLOS;
-	perm.perm = QCOM_SCM_PERM_RW;
+	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RW;
 
-	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
-				  adsp->region_assign_size,
-				  &adsp->region_assign_perms,
-				  &perm, 1);
-	if (ret < 0)
-		dev_err(adsp->dev, "unassign memory failed\n");
+		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
+					  adsp->region_assign_size[offset],
+					  &adsp->region_assign_perms[offset],
+					  &perm, 1);
+		if (ret < 0)
+			dev_err(adsp->dev, "unassign memory failed\n");
+	}
 }
 
 static int adsp_probe(struct platform_device *pdev)
@@ -696,6 +721,9 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	adsp->region_assign_idx = desc->region_assign_idx;
+	adsp->region_assign_count = min_t(int, MAX_ASSIGN_COUNT, desc->region_assign_count);
+	adsp->region_assign_vmid = desc->region_assign_vmid;
+	adsp->region_assign_shared = desc->region_assign_shared;
 	if (dtb_fw_name) {
 		adsp->dtb_firmware_name = dtb_fw_name;
 		adsp->dtb_pas_id = desc->dtb_pas_id;
@@ -1163,6 +1191,8 @@ static const struct adsp_data sm8550_mpss_resource = {
 	.sysmon_name = "modem",
 	.ssctl_id = 0x12,
 	.region_assign_idx = 2,
+	.region_assign_count = 1,
+	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
 static const struct of_device_id adsp_of_match[] = {

-- 
2.34.1

