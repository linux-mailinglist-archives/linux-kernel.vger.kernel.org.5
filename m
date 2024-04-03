Return-Path: <linux-kernel+bounces-129278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD420896828
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E121F21673
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34A139581;
	Wed,  3 Apr 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hspMDvwk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2713A41A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131667; cv=none; b=iEqi7gR1DVqj5zoX1H3MZZJongIwQvduZPkcWNVxTfQGomDj6yOUmGENhStNzua2a0usoy7CWY0jo502VveqA6Z1bRxeV5Qz6mZj2tqpbpVYA3PWRYLE3TLdVEGqIARnLe3Jd2uPU35ZLsUZgKXIiXSgk9MN6+JJXwiqq0B1mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131667; c=relaxed/simple;
	bh=fRZfn29n+p71TfhVA+U/lx8UE07JAa/x9BZNBbrEgzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF7sEETvl69slR5RmswkWSYYPvJqgRNVyGzQdYCVHRBUo8VJS3aHZSFbphciecJW/3sPx9K2pIVNUAlFxAwlYbhGyUtY5N7UZjW6IS7looXjgrYe+1yL7MbDkQKLRLL1XgR5BIWg+T3OPi0c2AwXUi3dxApNLX9XS8EMpqrfTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hspMDvwk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0nMjCQAiDf49AN80TJHWT8W1hBn+/o753fWI/QiFHA=;
	b=hspMDvwk4PI/3NTrkyAY/iHnn9draUbO9l8W6jiniBv2rjsRVAZDetuiR/N1HhpaiuAYeV
	QvWFsCpDuqo1fccEydZ6t5gNX2wPIkaP+6XQLtbGvdY+VCuZlqLP5wVsdTvJ6toc3LUIOi
	Z6mEJMXWOf/aa4oUUfvyqJoUV+Z18yM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Pn7lj-LdOmOS5M3HOdK-Cg-1; Wed, 03 Apr 2024 04:07:37 -0400
X-MC-Unique: Pn7lj-LdOmOS5M3HOdK-Cg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343740ca794so324879f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131656; x=1712736456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0nMjCQAiDf49AN80TJHWT8W1hBn+/o753fWI/QiFHA=;
        b=VctKLnO0Ag9U+bTRLkGOKHSBlrsBMQtTh/J4jxKkmhS1gsNjtw5f9CaMVYk33zc8Bg
         +aYCHnViCjVvr+XPH2OSU3f+C6BLdsNPB4GylcdrGTRffl0me2G5YwlU6dISBiHw1xA6
         96yUn8hiVLWEWVLF5oZtd4JH27KqKadW91Ff03xnqCvXOTvgHSFhieLwXIehbtEaqGcM
         M/Bw7kPhycClFQHHx9M5LYFrFJgkwZ95ZmvyD3+DFX6wSrrsNABULDdYl+7KtusAI/QE
         TswW84F8DUF2U5VimhnL651RlhkVaXNf7Jm8ciYeJcvXBoruMR2LTeJB6x/JRhG1k8gO
         FdxA==
X-Forwarded-Encrypted: i=1; AJvYcCUkrsItjsyjeR1o+TtNkp6kdz/q8q7nTVPhD1h6BOKHIoUde5HWYOQhq+PaM8ct14FntdvyxE4zb67eclIpbpWSfxtmrRKjoosqdMtM
X-Gm-Message-State: AOJu0YyPof0Ufs5+f/eRCoUOZgod5I90f/KS0mTZ9Bmc9RmMWzHe37Zs
	E3WMzRr0LyPe4JTSeAB484GQdHPJRUPjS/zuqkECVCWulte2RfgAJ5l0sSOFUsv4pU3cIvGQWi4
	t1GvEfBM1IDDxEkbZmplvv+QaaA27IJYAZaJAD8SSkdhVj9xgC+CR4w/LVHNTUQ==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11645146wms.0.1712131656621;
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiVKQLb+f1OrEQQkeHaGoynxvE5CB8UQaKuohoK/Tyncy87LGCNAzMSYeiGEEBVT7VkIsd9w==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11645125wms.0.1712131656385;
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v5 09/10] PCI: Remove legacy pcim_release()
Date: Wed,  3 Apr 2024 10:07:10 +0200
Message-ID: <20240403080712.13986-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old devres API.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 49 +++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 8a643f15140a..3e567773c556 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -463,48 +463,41 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (!dev->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
+	struct pci_dev *pdev = pdev_raw;
 
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+	if (!pdev->pinned)
+		pci_disable_device(pdev);
 }
 
 /**
  * pcim_enable_device - Managed pci_enable_device()
  * @pdev: PCI device to be initialized
  *
- * Managed pci_enable_device().
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Managed pci_enable_device(). Device will automatically be disabled on
+ * driver detach.
  */
 int pcim_enable_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-	int rc;
+	int ret;
 
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, pcim_disable_device, pdev);
+	if (ret != 0)
+		return ret;
 
-	rc = pci_enable_device(pdev);
-	if (!rc)
-		pdev->is_managed = 1;
+	/*
+	 * We prefer removing the action in case of an error over
+	 * devm_add_action_or_reset() because the later could theoretically be
+	 * disturbed by users having pinned the device too soon.
+	 */
+	ret = pci_enable_device(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, pcim_disable_device, pdev);
 
-	return rc;
+	return ret;
 }
 EXPORT_SYMBOL(pcim_enable_device);
 
-- 
2.44.0


