Return-Path: <linux-kernel+bounces-35031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF9838AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D08F28A540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4212F5D727;
	Tue, 23 Jan 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuXEKh6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099965F86E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003110; cv=none; b=FWrawKfjBHqDgqINSekdVKiVKQK1rLM0kFeAYx186AAweL0edJRPDzm1lq4eXnYVsm0+2kQFirVkOxXx+tWDjZYjEAQWt0eGF1pI7bGgETl+sVKaMDqvRl0S9vnaIVao6tLpAqvE8SA8c8/Rv4d8Olj/7no7Gil1GMQz7LhK1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003110; c=relaxed/simple;
	bh=q2R0g7Hy2U3uiquhdJnwowChrgBPdiPXucNQWzskgyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C94nfq1Cp+eTqfOC2wFlwMt73OpMSp3PnEj0rmlkWWXFQCDVUxffZJmdhBfrdJnvAi3/Wi818Tyqw9Ma+aUl9HLbbIe54XPeqpZ2C0sM265ezjAxQdECwQpMzD3XosV2AryBkMuGqZJc7k3S2IYtNNtMeHhwPFZMA0VeoNZuPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuXEKh6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8ldR1APM7FCb8Va/7W7rWsZ/5PXg9NQPlDweLxrFR8=;
	b=KuXEKh6Pzz35ynpJAK06nvAGnEdSMLah4Lc2r2Ig5GM8KNhvsdFSVzMg+Ubk7mXSI+KOT5
	1Qd4Th7YLqgZhUGlCcnvl3OWSwKatRWrUbHUvVfyXxvUMvltFCubroPEqgrKDiVPA+Viwr
	dGTqCDho+YG0IhuQiOlI5l3yWw/h+IU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-q4U8t4FvMzS7VZcTLW9rig-1; Tue, 23 Jan 2024 04:45:06 -0500
X-MC-Unique: q4U8t4FvMzS7VZcTLW9rig-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46a9d50a8b4so216873137.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003105; x=1706607905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8ldR1APM7FCb8Va/7W7rWsZ/5PXg9NQPlDweLxrFR8=;
        b=S9FK4Qq1d7uDAYOzjcj6V/bgdyIW4vyilsrKgg8m/J997gD3iec6cYVay2L4O3SaW8
         3KFROu5bEQGaX8q1Uo8fPt3RmKAJckfXh6y0fsZV2mTO2R+G1YzzKQuvG05ol5RBP5Ry
         EcUBsAsZ5pLAh7Z7/k9BFggovYgyHQsmYL5nvievZMIdyEG60FXH9jgotc5upBVKSUz3
         qF3D1FuQ84tl0teLTkBfVIvwoo2zh6t+6PefhlHm7lRci6l8j6W8zV/EDn5eJiFI+R6K
         uaE3JWm3iusFxrszZapqR6h16MSS1858UjNANV2kvlOqJ65qacwS/pALDiqVLqNrT6U5
         mkEw==
X-Gm-Message-State: AOJu0YxKVRZVBLBusGhU6bsYkXJx1vD+0WFIxArgwUDpSUwXZO/MF/x9
	PhOzW4qTekruTr+S0bIaPDc3Ui1ElEI99CTBEciJ1LJoqPRsGv9XrhRBkoWft0eoOvlafa3SFcl
	ij2fsgJWukz3Pd/Ja96U4LfVHE1gtiM6A+agComsXuUS1qGROt/sa0CWgx4Eu77FM/LMedQ==
X-Received: by 2002:a05:6102:5493:b0:469:b7ba:85e2 with SMTP id bk19-20020a056102549300b00469b7ba85e2mr3802818vsb.1.1706003105398;
        Tue, 23 Jan 2024 01:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBtpt9W0N9DjO3th5WheR6cQoXtCbywpbrf12aGS9J/9nurG+TirAyDVaNm7jxUkx0ffoI5g==
X-Received: by 2002:a05:6102:5493:b0:469:b7ba:85e2 with SMTP id bk19-20020a056102549300b00469b7ba85e2mr3802807vsb.1.1706003105097;
        Tue, 23 Jan 2024 01:45:05 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:45:04 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 09/10] PCI: remove legacy pcim_release()
Date: Tue, 23 Jan 2024 10:43:06 +0100
Message-ID: <20240123094317.15958-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
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
index 4314d0863282..f368181c6c92 100644
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


