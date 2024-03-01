Return-Path: <linux-kernel+bounces-88349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB086E05D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F2DB2164C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8DB6E610;
	Fri,  1 Mar 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDJMZm+A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA076E607
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292626; cv=none; b=O+T7NQdfCrfoSZQHG2bmrRaOnpagDdYRLJjP2GdVPB6yYWqGriIsLbXe0lNc/QypbC420tMuelaCH7KRXQweg744HDaJT/koEBELBh2fLteiMzG1+AgGFQC973wnXzKIdvw2MoHlUBbQo1oCSDYnYDvKCN0MAv8BZ+RdQzfbVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292626; c=relaxed/simple;
	bh=eSnyzOdtUFJhBK0qF7Mzs85BLz3XsL0UztlDw124YIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVF9kYRiHgZafzy+3bfa1tB2fHIHiv9qJWbEH39tmoWma4AGy3/5DlddJa1Ca16H9yp/uplts4fRwepwSizRtBYv+34bKWhoMm5G+ESmlFZVQ+H+gA4zkOvdF/i6Bq5vmiuuzKdRUkGnWcCQmwqk42fMEkslyVRNTsPS+nDQLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDJMZm+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waA643Nz8VSxmSriLnjZTP86MMy861LOzD7Kbbfqeh0=;
	b=PDJMZm+A2rrJNJSutermJfRdW3jDbenMpu99Jo7mN+Ws8qlvzVmq1ZzbB9cmqC+0q+baN5
	ADzicd47sFueNt2DytY1ztJ5ziXXzN9qINTSTUyKl7NEnsQnDDgtajrE2N+F3P0RmCA+Qd
	D+pJvjueTVAr8OGpjbGaXYUNZtr3uyM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-h0qmpg32PKediVM-ZveStQ-1; Fri, 01 Mar 2024 06:30:23 -0500
X-MC-Unique: h0qmpg32PKediVM-ZveStQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6083dfaf44cso2560197b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292622; x=1709897422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waA643Nz8VSxmSriLnjZTP86MMy861LOzD7Kbbfqeh0=;
        b=b8CdgaZmBVVrgWC1bo+3969B/w6h6/oRw2j4utroNt5ccZb9gOHl1JjbzlJDJkbtXM
         PGC3VgVQ+YPqXp3hlTSzEZhfBcikGVLM+KWYi5izo172SN0XQwWmB8VLP8TRsoEsooqE
         HEAFLD7VmRBl5uoEgy4YwSA+pVEssaLGa2/6HnnvTsb6tX38rz82uEhxG54P8mfOG+63
         XwLEck58ST11J8BQok5BiSxMSLIghMnnW48mBA6GP/riAEgaerCnSUoiK2em2+KptE8s
         RVe4FDmkhiGD00FJtsaJL7xq7XV4AJzgwclro37qyjn31qOamKZQlXscG2FRjgXVpW+v
         daRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8fFd/YbaVhceRTzYTsPK6OWXhiWbiGR1BH7UGpNeYj5WL4bWSXes5TmoU91JaWyyS2LJUQpuzL+5CXjLoF3OZCG64wfYc46Voaxp2
X-Gm-Message-State: AOJu0Yy0AfNDu0VZi0iLhibfNmiPFLP0uG41b6fkTBak/CEGZz74DSz7
	AAf3CsgKlTmACfkvbbC0BMKwHHo0i3slu6YCTQk0pdn9jUilpayP8bNjo/AI5ekWZYpNUHGq7Pg
	KtlS9b0ZQJX+XEO7G/GxZB2YY1q1TFvosJvhVA2eYv8ohtkU+prvbqhH5APhDTQ==
X-Received: by 2002:a81:8d04:0:b0:609:8450:547 with SMTP id d4-20020a818d04000000b0060984500547mr990990ywg.4.1709292622092;
        Fri, 01 Mar 2024 03:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFMbY2wCQKKSWifzmLpics1CUNIv9kD53c9sHws2ffoOfs+I/p72A+atlLHSEiSevaj6yoXw==
X-Received: by 2002:a81:8d04:0:b0:609:8450:547 with SMTP id d4-20020a818d04000000b0060984500547mr990910ywg.4.1709292620276;
        Fri, 01 Mar 2024 03:30:20 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:20 -0800 (PST)
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
Subject: [PATCH v4 05/10] PCI: Move dev-enabled status bit to struct pci_dev
Date: Fri,  1 Mar 2024 12:29:53 +0100
Message-ID: <20240301112959.21947-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently enabled is stored
in struct pci_devres. Besides this struct being subject of a cleanup
process, struct pci_device is in general the right place to store this
information, since it is not devres-specific.

Move the 'enabled' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    | 17 ++++++++++-------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 03662760d629..6bf93c6cbb66 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -446,14 +446,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -471,7 +468,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ff52e840d9e..862dab87732a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1990,6 +1990,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -2004,7 +2007,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -2014,6 +2017,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2172,6 +2177,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2179,6 +2187,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2206,12 +2215,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3452684e5611..97bd1c074d26 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,7 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8964ef9f2e9b..f29c9289b378 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,6 +367,7 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.43.0


