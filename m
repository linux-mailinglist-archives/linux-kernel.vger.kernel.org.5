Return-Path: <linux-kernel+bounces-55035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893784B6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58F71F22BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6C131E53;
	Tue,  6 Feb 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwYPWZSU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77E132479
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226846; cv=none; b=R7gx+dBLAwYtTNuMeBowuNbWT8aNJhVJM3t9OudtvB9Bn7/tMZ0yKGZtJ16MNM4HhTWqWVoYYmEFOJ6rKFeEjJe//8dUnWxO15qiWh84oBYJmgwKNKDarSkX831MHI3THNrgtHY5glOo/SZ/nW0z70lZQZ5hkUaNHVlqNUA9eeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226846; c=relaxed/simple;
	bh=bnxwDEgv9QFQUVRxuPEvyxebBStu2y9kJ562+f/7/NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+Q4qjoD7EJq46pre3GBbM2JjGUN/3B41dqkscU0PITZgaA68CgrvyJd8agGmINWhFYrIchZgqM4HFwhLWZuT4JS5/l8Q/Y56L0V9a1u8VG1BfHebIWkh2/MMGLdBDVCdXb/FMhcKeaXhWkm8CsX+yo06/DtRd5DfKq4csph3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwYPWZSU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3QB4wa/ZeBRooj+eB6dP6QJm1U/XuptG2DuaZLsRqk=;
	b=OwYPWZSUv0MviBvLgG9o8MgfVncAgMlB+2ftTSiKjYuEzSF+PiH1BuEUuK5QxAKVd3hvsp
	4J9uEoCSTmFttHahbg8dAqdO+QCBJfW14KXtRqvJTTmm8/XwACFv3EXefr8QqaX3BTUrXE
	X6i626R5S0Q7D3PyN1K91tHW9HCvS4Y=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-DINitj3zNYqjDscG6I3y-g-1; Tue, 06 Feb 2024 08:40:42 -0500
X-MC-Unique: DINitj3zNYqjDscG6I3y-g-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5ff64f5a960so11236447b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226841; x=1707831641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3QB4wa/ZeBRooj+eB6dP6QJm1U/XuptG2DuaZLsRqk=;
        b=BihMQL1CtUosuSjOYbdFnMlttd/kgxBcaRFJXQnRmSJGnaxZKQrnSkIgyr7UoKxsnp
         iPEqQz+33HaCbLwOaqhcwFuaHyHscLce5hFEUlh0bqE6ghUWpsUz2uxXI/q58ZaYe2A4
         Cw3blikhi1f1nyqEtsWZpI7wnFfbPM17FUekIX7+icmAJ3Hav9z6gESJGa8lRW0Y1KR1
         Y5ZT6hWlI9gs1unFcTlrP8TThzQt3afukfgmThTVVMDTztalxkvSXIh25gmK1jrCDHV7
         UG62RXlKVMFs9OKlI3T42i53fEbLXRhOdAmkQbBRzJBy6D/5MRi/8z9aS/D3EEkRm+Og
         Uv+g==
X-Forwarded-Encrypted: i=1; AJvYcCWuH2xZX5Yv49q4aA6dtYRLBcZw5z62uWMfZdfX+OLKh59uCcNPlMowd/F0zzRSBOVuEldh7vz7W/4CJ0KdpcuMAiXJdJvWa1g+v0DZ
X-Gm-Message-State: AOJu0Yyz4qHqYhD9gXJnHS+dBO3dVvCOrgIh8Z6zDM5x7c0lggc3Ul/o
	mwcqFPQecpXezN9a4iI8VgSCOveWR7cdFLdoFC5PPgDw3OkZLqZlsg3VUk/hKJH2ojrwZFIO9Ec
	k4xYWcC2BPQXEY80aFM4cARa//bKZMp5jUBD4Ok2djN2NeOCzm2b1sEQZqNQc7Q==
X-Received: by 2002:a81:c542:0:b0:604:7ab0:dcc7 with SMTP id o2-20020a81c542000000b006047ab0dcc7mr1129899ywj.1.1707226841025;
        Tue, 06 Feb 2024 05:40:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8/G4ktvjQYBWJ9XOMuvIr/+hFPsHHVcRV0pjyiDjiAIFKooshwXkqRfJAq7y8LqUPTyE38g==
X-Received: by 2002:a81:c542:0:b0:604:7ab0:dcc7 with SMTP id o2-20020a81c542000000b006047ab0dcc7mr1129872ywj.1.1707226840648;
        Tue, 06 Feb 2024 05:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4ChpH2LRg+my/aRS16W7LPb6AplmZo0EHMKniRUO0w+shgnOak1Q/IIGUrMQ8BLGe6fQuD5eR+frJ8KO2WcF+zxKo6oDfnwJapOv6j0mvLg6sZ9sVR4eUpwvpT/XPwucq4Bb/f/3XifcysR651YtpBhzZfIs0cUZ/pxFR7ktvEx73h0G1d6IBz1HbZ29T578T+GxMGw+fVvVnk+gsy3nqC0OfBtYSizlx5XHrYkOKUkeQ0xhQ2c2vIVAMhbwzfxNiqE3xyEmrzn+LXEu4GjPQMeYugVSrvjKxdrY/vQ9JoROMecA6h18RiX1MEV68WWWzIXMpoD1B2IfISEQLX0thVTyDJRZWLMpxZnXcKWMIOBFNhbRYyUYFe5+MbCfdLq3BJW+A
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:40 -0800 (PST)
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
Subject: [PATCH v3 05/10] PCI: Move dev-enabled status bit to struct pci_dev
Date: Tue,  6 Feb 2024 14:39:51 +0100
Message-ID: <20240206134000.23561-7-pstanner@redhat.com>
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
index a0e8e47b2de9..3d84f13ec9b7 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -448,14 +448,11 @@ int pcim_enable_device(struct pci_dev *pdev)
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
@@ -473,7 +470,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c919f85a269d..a6b5140fc6f6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2013,6 +2013,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -2027,7 +2030,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -2037,6 +2040,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2206,6 +2211,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2213,6 +2221,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2240,12 +2249,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
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
index f5944e3cb7fb..9038d7c822ae 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -811,7 +811,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83a683a1f4e5..f3ed3ee6b9c4 100644
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


