Return-Path: <linux-kernel+bounces-129273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082D89681D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7289287E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22B135A59;
	Wed,  3 Apr 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRb5fijM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A356135A4A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131659; cv=none; b=YgenAJgABrcAOltiASeA6Xp3xMbW0Te3eA7JZGyf0FS+XYu1uTS1KN6qWXylgaoOqbwRB2hA5Y08TdU1O69ZQCUKT0e5Y44h4Q0ygUh/tyPgJ86YuJBnCtgxeemsqzF6hClKyMX8/bvYqSsm9Ql4VTib3LeekEJy4kQlW34T3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131659; c=relaxed/simple;
	bh=egR1XUvwOxPeyIZd3sd9jzFwNHxic15Pnh9GwC3PxjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3zUXE6GdnD7XFoVVf0KN13oPm3yFkZu9TE3RHcq1K43zqRcRZojPKuPuAcUYboMf5XTZEFCUs3xdM0OVhE108YCMC23/5v4x5QiltvwXtrjLDy+jk6isQVbrdTD1Y306t/t6noqLXXLosKwK4iYVpHbifN56KVioBcOPL8ScDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRb5fijM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMdbSBwdbBKBdkE06cPmCOrD9+7wz7G2A47emsXg9D8=;
	b=hRb5fijM0bhS6IahlXfCWH+4AvUFexaZPML2C/1eU7MnetxaZZ5QGGc12KI2Wab+yffZta
	RIStULCyKue84RfNperA0tkZ8Z1XFRFqlloxgryfDcTjrvHomAVcNQDh0ImMKzscaQhN1z
	HtZPXg8WhDUP2+wmia0iFYcZY+iw/UM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-X89JtmZDNDSwx4Z9os817w-1; Wed, 03 Apr 2024 04:07:33 -0400
X-MC-Unique: X89JtmZDNDSwx4Z9os817w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d49872bbc0so14079951fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131652; x=1712736452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMdbSBwdbBKBdkE06cPmCOrD9+7wz7G2A47emsXg9D8=;
        b=IGjgz56RPqASEYYC0UoWA243aC/lDOVqAwv6HjOxT44cicSlc4R7LqzVJDM/czZg63
         JurSjvPRbFmwtUzXs8J3/twtJGrmZGmMu0ho0BKH7Swr3PxeD9RCVg2b8TDzmvdsv1zv
         RJZICE8kdrvikrBX2Pp04v8EOlBo/d9MNS0wyMRbgUqom9M/ihSj4xNp+ehujbSokWoE
         kGef+OchcIqqYRZTr/O/ugqmP0v4MCtm8FRHynxw0RZtWIoFBFjaRoKG3Ngd1HW+yKoH
         Xw8dBQZ+jGhcbXYSJiwinBx/jYCnPmyg2MyBZuWFwmLXBTkCS8sF0PJnEOPT4HVS9rz8
         EDEw==
X-Forwarded-Encrypted: i=1; AJvYcCXYENVHjzHjW/CS5ktMCepBLEPb0R1gh0KYDBh/Yes3TjQqe8YSmG8LGMvAsOhF+ty1sD68h4wTEns0FeX4wh/M4W/yoSRZbXh3ujVV
X-Gm-Message-State: AOJu0YyIQS3mT+GoO9rivXrWwj1Zj20hIzV2EAwPHtkKjXMmBSY4WMnz
	5dmieb8siz3tmhuPNSi+eqsgXCvn9I87TQL8vqEPrMAPL0Ubz7e9oDScAyDzGK2wZDthwXf3/qW
	zT5eVrUnUw7VDn7sEEbzLRQsUw783cUit9mnRwZrQbkkiUXrxJ/xLQcro9MNK/g==
X-Received: by 2002:a2e:a30b:0:b0:2d4:7f17:185d with SMTP id l11-20020a2ea30b000000b002d47f17185dmr8036433lje.0.1712131652230;
        Wed, 03 Apr 2024 01:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ZKJGDq33FEBegelSh+aW2RNhstu69B5Bp3FcmKj9z5wrufQ/wWrxjzl1ABxOamDyWxbX4Q==
X-Received: by 2002:a2e:a30b:0:b0:2d4:7f17:185d with SMTP id l11-20020a2ea30b000000b002d47f17185dmr8036412lje.0.1712131651855;
        Wed, 03 Apr 2024 01:07:31 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:31 -0700 (PDT)
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
Subject: [PATCH v5 05/10] PCI: Move dev-enabled status bit to struct pci_dev
Date: Wed,  3 Apr 2024 10:07:06 +0200
Message-ID: <20240403080712.13986-8-pstanner@redhat.com>
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
index c0c1ee17a06b..9f1419bac9b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2011,6 +2011,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -2025,7 +2028,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -2035,6 +2038,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2193,6 +2198,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2200,6 +2208,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2227,12 +2236,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
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
index 040ed2825554..2b6c0df133bf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0f203338f820..95cdd1bc73c4 100644
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
2.44.0


