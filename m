Return-Path: <linux-kernel+bounces-35027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0E838AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD1A2898BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418D5D729;
	Tue, 23 Jan 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhdSC7yY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652815C8EF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003103; cv=none; b=NOWtovM83O68JV3ZyguuBYd5ldD0jeN3OQKA7XZuXrew7H7gHMTVsOlOJN0cQ7gjgyQOY1tr23tOXJEpXCLN2uODmhhnPzrFvEKO0ELDHaLRKQ8p148l7ORs8gp2S6HiELHnIECjfQsK3JZ84Pff7easUyF8xPOHB/z3oY1c2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003103; c=relaxed/simple;
	bh=4ifRbNE/UvC5FcM85a3SetEYfA018CmEKjlHBrPer30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExDX5Pwp4w5NmkRvR5m38RLEh87+dLhxKLN5eLyYdv41qtFYfHpCrXEZVpkLQntMFTzRbww+WqN1N+ZgGebJfRX4PgOlyChZHDE7fp1yREcLNLL6aj2HvFsgwmFxkX45ojfCJINh6Gl2cFOSatekXfjjeow684w/yGe/v3VJiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhdSC7yY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ38BpMLw1nmEQJiWPTNL5fM1ejJipykQi7icSpF5L4=;
	b=PhdSC7yYd4QK+NOcFU3S4EqVrVhxV0wmJI32PGm+qaSYOirTJC7wUjTWZ+m75ZrKFLAdZY
	I5B//zrRaCMvk5sGlITLZb1ZFkqqeyy8sEnYCvQjAxxaCDA+6ewR7FMWuY8NnAQ0a47Q7P
	58cZvVKE3NtydRqejL9V3rcT91cLW60=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-UwaQxAeaO46g9_umUoVGTw-1; Tue, 23 Jan 2024 04:44:59 -0500
X-MC-Unique: UwaQxAeaO46g9_umUoVGTw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-469adc951fdso231034137.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003098; x=1706607898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ38BpMLw1nmEQJiWPTNL5fM1ejJipykQi7icSpF5L4=;
        b=rTp71+oVJbPs03GNiJOHb01aYYjpaMzOldaV6Mksl2mLvlkuQLYLmyiOmz2MzuS7s9
         ZDkleDoTrhvDzNKIxk9MzLd2xj221Juk3Ti3y2jlVeRIkHwPuTxJYtP32rsQwUXEg2UW
         VJnbeaHAB/cVnVCP9c9+56Pow/zIeS+53f+HeEmYY/tSw23aJgPHEsB2zM/bTFuB+thY
         0E0qF00iFxkDVNYxKJlTGZ6sd5/528iw44AVfvfl1OVrr8FwUgtYqSz2nQjb+LIY3sMU
         x+CVQyOjoodbgOWvrwJ2CdOj2Bs4VEFSoUDH5ISOPFv++JrCEB3k5XS7ue8wCKXdni0S
         FCdw==
X-Gm-Message-State: AOJu0Yw1v3CpfSkyaNzFioVHTbTFENB2mwo/8mH/qH7JaJOQp3W+Nr9B
	kZunjl4jsCu2KjtCWOETfDQvWGgbbu6edZJChlvTTJQKB/nAryn6WS7axU63v1l4aELcKVJi++f
	fRO5Gy1OxsDOJ3m60RStTSuz6yxCaH4wjbptG4tvVZYP2iRHarAkvrnIiqpmEeg==
X-Received: by 2002:a05:6102:5594:b0:469:a652:8df5 with SMTP id dc20-20020a056102559400b00469a6528df5mr5138870vsb.1.1706003098545;
        Tue, 23 Jan 2024 01:44:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEivN7OX9YY7oVy+KgkCGjsC3T0Q8wxZ8vUmiA80b9QIyaRCXaYkhUqcQ/3h07xKSGdWjW0qA==
X-Received: by 2002:a05:6102:5594:b0:469:a652:8df5 with SMTP id dc20-20020a056102559400b00469a6528df5mr5138858vsb.1.1706003098225;
        Tue, 23 Jan 2024 01:44:58 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:44:58 -0800 (PST)
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
Subject: [PATCH v2 06/10] PCI: move pinned status bit to struct pci_dev
Date: Tue, 23 Jan 2024 10:43:03 +0100
Message-ID: <20240123094317.15958-7-pstanner@redhat.com>
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

The bit describing whether the PCI device is currently pinned is stored
in struct pci_devres. To clean up and simplify the PCI devres API, it's
better if this information is stored in struct pci_dev, because it
allows for checking that device's pinned-status directly through
struct pci_dev.

This will later permit simplifying  pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  5 +++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 696541c65c8f..03336a2f00d6 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (!this->pinned)
+	if (!dev->pinned)
 		pci_disable_device(dev);
 }
 
@@ -461,18 +461,12 @@ EXPORT_SYMBOL(pcim_enable_device);
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
+ * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
+ * detach. @pdev must have been enabled with pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !pdev->enabled);
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbb76a3fb0e4..3d9908a69ebf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -809,7 +809,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a356bdcc14cc..efbe2ed92343 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,11 +367,12 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
-	unsigned int	enabled:1;	/* Whether this dev is enabled */
-	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.43.0


