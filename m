Return-Path: <linux-kernel+bounces-55040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8784B6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4580F1C24063
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE6133423;
	Tue,  6 Feb 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaCwSqEH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB0A133401
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226864; cv=none; b=jVk70hqqN0KIU5ILZgrmzR3MEunbfMUxbIjjymCrjkw3klM69np1LifIb5UOqNL9gsDefe8WWWaQLAyAQ9qzyO8dfmIThDOmf8WE74cBJz2F0V+vmmABMzd++wYQcN4QEP1jpwuYL64jybq2x1Cp8co6O+LF0MegDLM+LPRZAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226864; c=relaxed/simple;
	bh=TeuRzMDENTP+mrbhGHtQfvvCYg0RN9gxYq3N6G/Xkt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMgEDVyhSX1cvDfYZlyFBP2vMIFBh/hrIZAeB/LAai1XKPAhO6keyZO/3g6HI1rG5xzqXN6pWeyizyxMVsNQ+i9SESgCwOXs/vv4AHcgxRW9MCJEm/2HFCgVlQfo1EVCGKoGOopicwM9F4qRbhwgd+MuO94jhH6xrYMwO4Fy87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaCwSqEH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
	b=JaCwSqEHUGKTx68twpIU6PrIKE/Ae8iZn+Ayh7Z4ALyjG7qfNPJoyQlh2Fl8yiu8vcTY8K
	q4h0r1dP39fPrcad9Eo0/kbjRq6M5cy59HUAGYxqQh4QCrOYawxtmEWZ/lFGE2RzcA9k43
	PMK0UZy5QQHFrFSFPfa84Bc0hcKYOxk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-QzTy7-gnPsiLvNh33mBz9w-1; Tue, 06 Feb 2024 08:40:56 -0500
X-MC-Unique: QzTy7-gnPsiLvNh33mBz9w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78130939196so253319685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226856; x=1707831656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
        b=BV4a1Jqo5VVlKUTaXFe8L93/tgKEeL4OB/tPDZG+mFOfj52s+hbPEtUSWle99+8abR
         h1jhJjrVi4n7SqEkgYBmzPuqxgrJjwHfmWa7rWY17Qdhek7U62nQDEdyZFfh7TkUDKXm
         ilvxC+VoG7TnWnQ73vSeZHS8QTdTS30NoFAgs/WcCj8d07C/aQpU2Tlach1ZrX3xQZ5s
         bgjcf0KfGSm2OI68l+kok2aNYr3DGlcTwEIyTUemZs6lOaYWv3Uc3RtPQ5yANxYWBvvv
         jv3QN06bmnHl0jCdDfXXUfbOud7EBPcwis3Yr2rEiYheqesSp2tjUzE+Fr1wTeOsND+s
         6cKg==
X-Gm-Message-State: AOJu0YwsMk2T13Qh955QTREsaBC5GBtxPFp5ckfbZQ3MvSyKOAe150/3
	T5ADHqDYs4XLC+IcvmkvBM5Whs9el2I+GJm6m0bI2TdmeI0mZqrT/ilvRYQgaC94B5Fo1RyG2Q1
	KDOZK1mzDKPQ8Oxj1BLuDzfR0wUtMf+G3ltZRc8YyL7aXraQUU/DXEXtGg/I4gw==
X-Received: by 2002:a05:620a:4722:b0:785:4588:7a09 with SMTP id bs34-20020a05620a472200b0078545887a09mr2762772qkb.3.1707226856086;
        Tue, 06 Feb 2024 05:40:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV1JhLewj2WzyuV6mJbjtKqCzdBMh7UJ+3tI4Yg38PSz9EUg3UpxjFWaNX43CrNpj4fEFLiA==
X-Received: by 2002:a05:620a:4722:b0:785:4588:7a09 with SMTP id bs34-20020a05620a472200b0078545887a09mr2762751qkb.3.1707226855798;
        Tue, 06 Feb 2024 05:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXY73u7g+juzT4qNhBv3adaHj4fe+28SURqOK6AMlIWi7SNnZKGhEb2SSunmcFOciqesjrdctJWePLgX61nFQtGT5DaHz6Drpqx3G76kNq/mJa5K3DoJrAWl6f6g4DFCZF0ILo9JChZ4/clq2pplqhGRQMKv+BDBiNhFo86TN0jVsQ0QNTSA6pXfzo/lV39SDF7eXdr0HLEdQW8DLwItLzDNvPVqbSGxXWzQmvii1m9FK8AvubZrpLmdghe10es0xS+rE+5D09CNNgsmtT/eZjDpF1Pbzdgh0a3oxdS5CUX+UBfXjFLQWbZ8iPUzFmXBwQhDDVav0ymM1W7urvifsSe2K0KvynAiVS3TjOJqMuTG/VdoSvxMAAzsrZG9Gk6tkYfCuMm
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:54 -0800 (PST)
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
Subject: [PATCH v3 09/10] PCI: Remove legacy pcim_release()
Date: Tue,  6 Feb 2024 14:39:55 +0100
Message-ID: <20240206134000.23561-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
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
2.43.0


