Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA817C5A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjJKR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:57:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597E8F;
        Wed, 11 Oct 2023 10:57:35 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 80CDBC639E;
        Wed, 11 Oct 2023 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697047053; bh=fz91rxvql77qr9tMmn1NOBTiPcKPztIjFo5x3BgCYa0=;
        h=From:Date:Subject:To:Cc;
        b=kLRSZ4cvQ+/OfOwa9s6WqbjXcAx1pYKF5pYS0O/hb0MV7YGMz+rlqExYqw6JIuWTN
         UUy8DLgQI5pDlNAj9bTHZEjcvjcJykhFE821q3paKqR58k3sSvqaWRGEWKlT8lNEhj
         DmJLJsP7OurtMLMrZSH2092cBwQL49F3gxu7lfu0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 19:57:26 +0200
Subject: [PATCH] iommu/qcom: restore IOMMU state if needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAAXiJmUC/x3MQQ6CQAxG4auQrm1CZ0IAr2JcIPyjXQxjWjEmh
 Ls7Yfkt3tvJYQqna7OT4auuZa2QS0Pza1qfYF2qKbQhSivC2fMwdpG15LyxwT/FwGl6zAFREtB
 Tbd+GpL/ze7sfxx8DsOMqZwAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=7t+7cwQLSRo2oYCkBswJGXelQGziACs1O48hSiYmsM4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJuIMkTrnEcWE4KqdSmG3hMW26WWFXTvQfrfvu
 gizQyswB0CJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbiDAAKCRBy2EO4nU3X
 Vp2jD/oCIiYMI9Gil0+BaHzQDQWzcmZEdryBvCxe7aC8GDfuoj5QkCU2sluK7/LkrEVa0MV+nMA
 bmixiWu/ZKR7ZtvUk/8WSMGiqLAUNSNz1Ds5SsOwbrWuXhI///gNtZvJgv9WxZyVUt7Q2Jh4qiy
 ddlKvO3T+9KwGZMNYj5/vopBweXe7ezmB07/JQMj4vbgpPzsDbxzTNl9WHHs5c1wlTmAK/w9laE
 xMybXFkTZhMzH4IRJoRIrq09WDWf6c5CzSR0fuCftbsyagRDImLlDhzjDUMz96mxOx0qizBiVlS
 tUMjnWqm7TgOIXFdug3zAo1+SLHlRnhGE+Y/zG2ObdltYKVhQ86RUcNlRh/HId3pdsr+4yjQ37n
 jRAKIeD0IYkJZihKDsiPqwHhf6IaARmpfVeafrcFFpmnfNNh2qXIkJZF8A6qc/oIg3t3Fg54ZY5
 sSohEVTxoK9vlVmkuaHGahcMEIQHvg76KyLhIIdjn9cZSGEtuo/ooy4UwduZ++vQfyl6wJEhtKa
 CvFthJUvfN5MBavz7My4wY/faioQAbSS5PQfdbqc7PiT6cHp12p5F18ugc+zxgP0sEaQfQ16tUn
 5MTKxHAISqkCLQEpb8gyxf0tzRBV6H6X+HGCpg9Dn/zCs1jN7Ylh6QBsaz61wTIhT4QDTekuvG0
 1eCGezSsfC5QyRg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

If the IOMMU has a power domain then some state will be lost in
qcom_iommu_suspend and TZ will reset device if we don't call
qcom_scm_restore_sec_cfg before accessing it again.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
[luca@z3ntu.xyz: reword commit message a bit]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This patch is required for MSM8953 GPU IOMMU.

See also downstream sources:
https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/commit/f8464885dafc5b780b85de29d92a08c692d3a4d0
https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.r1-02500-89xx.0/drivers/iommu/arm-smmu.c#L4221-4225

Since the compatibles provided by this driver (qcom,msm-iommu-v*) is
only used on msm8916, msm8939 and msm8953, and both 8916 and 8939 don't
have a power domain on the IOMMU, I also don't expect anything to break
there.
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 97b2122032b2..67abeb02cf53 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -900,8 +900,16 @@ static void qcom_iommu_device_remove(struct platform_device *pdev)
 static int __maybe_unused qcom_iommu_resume(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
+	if (ret < 0)
+		return ret;
+
+	if (dev->pm_domain)
+		return qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
 
-	return clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
+	return ret;
 }
 
 static int __maybe_unused qcom_iommu_suspend(struct device *dev)

---
base-commit: 2933a1156742d8c47550493a77af8e2d81cf3c84
change-id: 20231011-msm8953-iommu-restore-fabc2e31fee7

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

