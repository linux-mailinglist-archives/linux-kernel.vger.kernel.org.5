Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5E7D5E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjJXWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbjJXWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:43:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBFF10C9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:43:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40850b244beso39634135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698187391; x=1698792191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrQaHUrwh7HJvf21NYxjrE9wnjwO6QY5+QCpxbGvHFY=;
        b=l90hOl7CuvqmFnXTPORBMNy5/Y/R4Ai2jYIA8Qfhr4fvQLtV6rPrOHTbOpQ/6P21tW
         nEtFatviDFy02eyCjIwTHtQY4oq21nP+JldvmKp1THmBv50WyRZzpE6aalw5Yk165IbB
         ZQlsH80hRp+cuSjF7s/hdGKlytb1pXv+IJcN0/eriYKSQoqIU8f+dDcg+F+XKwnOuptq
         ZaXZPmjkg5rfu+aywNRCx3/UopnipyCNUawtE+bfFn/9x3T0yBVxE/qG7D3FFi/rvNGg
         9Lo6rfdQQKspIEeHVXqSc2XQi4AYmAJtdtqx9L/oe/nu14yihvP6ZmR9qrmrV9dbC6KC
         jbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698187391; x=1698792191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrQaHUrwh7HJvf21NYxjrE9wnjwO6QY5+QCpxbGvHFY=;
        b=LC91BgWXX6fVOgq37DpulzMOu/XZylDERNUZuLtLLIRNKMU8+PVzXPcnKl8HqmtMhB
         jygk1ubMKJCjr3fJOUTDvABE+EFuRCiL/SsBWkY9jiL/in1F/+fkK5FKSvTT22DvnbM3
         99+6s6ROJB4z6Hiz5lJLpMaM9BsRJQSeO0ko5uzO4T07PFy8X86NrACQxXyTOAJ0BIst
         P6OtpUOJIzNUO6uAjLxQLGpV1XNDXZtIqrPKuBNBFW4jp66hoQ7mzHR+/EEbwToqdZMh
         earwueEr+0gaa1HMx34xrXzhC4LPtZ+ZH7+al3hjf5idhCcwWq5UFHcIDEISn8XE4la6
         Ag5w==
X-Gm-Message-State: AOJu0Yx4YbVlV+8S17/937wUuHhhxgKrUKrzv6p7bIdS9u/S4mSnyES5
        blKiKgdEGGgh6TZoIEmNhpcOfg==
X-Google-Smtp-Source: AGHT+IH3El5r8BZAxqxEWrtMM2P1MvtwTTWIE8tDk6kZdHK1qx+HR75WBrMqGzKiqBJf5SADeBboAw==
X-Received: by 2002:a05:600c:1d22:b0:408:4475:8cc1 with SMTP id l34-20020a05600c1d2200b0040844758cc1mr11448428wms.35.1698187391213;
        Tue, 24 Oct 2023 15:43:11 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0040641a9d49bsm13049531wmq.17.2023.10.24.15.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 15:43:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/4] media: qcom: camss: Convert to per-VFE pointer for power-domain linkages
Date:   Tue, 24 Oct 2023 23:42:52 +0100
Message-ID: <20231024224255.754779-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
References: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we use the top-level camss structure to provide pointers via
VFE id index back to genpd linkages.

In effect this hard-codes VFE indexes to power-domain indexes in the
dtsi and mandates a very particular ordering of power domains in the
dtsi, which bears no relationship to a real hardware dependency.

As a first step to rationalising the VFE power-domain code and breaking
the magic indexing in dtsi use per-VFE pointers to genpd linkages.

The top-level index in msm_vfe_subdev_init is still used to attain the
initial so no functional or logical change arises from this change.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 12 ++++++------
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 12 ++++--------
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 10 ++++------
 drivers/media/platform/qcom/camss/camss-vfe-480.c | 12 ++++++------
 drivers/media/platform/qcom/camss/camss-vfe.c     |  3 +++
 drivers/media/platform/qcom/camss/camss-vfe.h     |  2 ++
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 0b211fed12760..59b0ea0aac48f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -638,7 +638,7 @@ static void vfe_pm_domain_off(struct vfe_device *vfe)
 	if (vfe->id >= camss->res->vfe_num)
 		return;
 
-	device_link_del(camss->genpd_link[vfe->id]);
+	device_link_del(vfe->genpd_link);
 }
 
 /*
@@ -653,11 +653,11 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	if (id >= camss->res->vfe_num)
 		return 0;
 
-	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
-						DL_FLAG_STATELESS |
-						DL_FLAG_PM_RUNTIME |
-						DL_FLAG_RPM_ACTIVE);
-	if (!camss->genpd_link[id])
+	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
+					  DL_FLAG_STATELESS |
+					  DL_FLAG_PM_RUNTIME |
+					  DL_FLAG_RPM_ACTIVE);
+	if (!vfe->genpd_link)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index b65ed0fef595e..c668494ee1e98 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1109,14 +1109,10 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
  */
 static void vfe_pm_domain_off(struct vfe_device *vfe)
 {
-	struct camss *camss;
-
 	if (!vfe)
 		return;
 
-	camss = vfe->camss;
-
-	device_link_del(camss->genpd_link[vfe->id]);
+	device_link_del(vfe->genpd_link);
 }
 
 /*
@@ -1128,10 +1124,10 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	struct camss *camss = vfe->camss;
 	enum vfe_line_id id = vfe->id;
 
-	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id], DL_FLAG_STATELESS |
-						DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
+					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
 
-	if (!camss->genpd_link[id]) {
+	if (!vfe->genpd_link) {
 		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
 		return -EINVAL;
 	}
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 7b3805177f037..5bd5b6b3c992a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -1099,9 +1099,7 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
  */
 static void vfe_pm_domain_off(struct vfe_device *vfe)
 {
-	struct camss *camss = vfe->camss;
-
-	device_link_del(camss->genpd_link[vfe->id]);
+	device_link_del(vfe->genpd_link);
 }
 
 /*
@@ -1113,10 +1111,10 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	struct camss *camss = vfe->camss;
 	enum vfe_line_id id = vfe->id;
 
-	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id], DL_FLAG_STATELESS |
-						DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
+					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
 
-	if (!camss->genpd_link[id]) {
+	if (!vfe->genpd_link) {
 		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
 		return -EINVAL;
 	}
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index f2368b77fc6d6..ca16a7ebb2903 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -463,7 +463,7 @@ static void vfe_pm_domain_off(struct vfe_device *vfe)
 	if (vfe->id >= camss->res->vfe_num)
 		return;
 
-	device_link_del(camss->genpd_link[vfe->id]);
+	device_link_del(vfe->genpd_link);
 }
 
 /*
@@ -478,11 +478,11 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	if (id >= camss->res->vfe_num)
 		return 0;
 
-	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
-						DL_FLAG_STATELESS |
-						DL_FLAG_PM_RUNTIME |
-						DL_FLAG_RPM_ACTIVE);
-	if (!camss->genpd_link[id])
+	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
+					  DL_FLAG_STATELESS |
+					  DL_FLAG_PM_RUNTIME |
+					  DL_FLAG_RPM_ACTIVE);
+	if (!vfe->genpd_link)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 4839e2cedfe58..3d31f4289b724 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1347,6 +1347,9 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	if (!res->line_num)
 		return -EINVAL;
 
+	if (camss->genpd)
+		vfe->genpd = camss->genpd[id];
+
 	vfe->line_num = res->line_num;
 	vfe->ops->subdev_init(dev, vfe);
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 09baded0dcdd6..c1c50023d4876 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -150,6 +150,8 @@ struct vfe_device {
 	const struct vfe_hw_ops_gen1 *ops_gen1;
 	struct vfe_isr_ops isr_ops;
 	struct camss_video_ops video_ops;
+	struct device *genpd;
+	struct device_link *genpd_link;
 };
 
 struct camss_subdev_resources;
-- 
2.42.0

