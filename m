Return-Path: <linux-kernel+bounces-135068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081789BAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F997B22B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF14CB45;
	Mon,  8 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8LXcaH5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448A4D9F7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565890; cv=none; b=mHzY/JJoMAQJylxZ52m4rHBfSc9Pgk0kPDX7XcOtn4YX70ImH0ZOY1xcxENKg9GI8V6VlHZr+Odu+SXIDgc3vntJeN7gInNsKgdvbwoIQaEQVI2+IqicupkiSb1ZXbDMs7QQME9dqN/lyf8H3Mg65D+QTnIf+BdnnIOnqPvOtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565890; c=relaxed/simple;
	bh=v7qaiBza5CJuo0crIKbY9+K6HZs5sPWVrRaHfMbRhT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/VrWDzXfKUZin0kxJHbN9gBlYfbmREQDa1stfbujAxJ2d54VhrZAclN778X1erUmCf6SK24oDSFuV8vV7SO7DmZxCIDI4DvFQrsCFHBDc4fXn2Ns1bO8tfCXAZsVTYJ0mDisrYc7Rz0sEHW5kadoLfkyZC/QKJt1P03w+GSO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8LXcaH5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JY3/LNjqLYiipt/EHsApjCI6ktJry9Gfg2HWZFwX/g=;
	b=R8LXcaH5bf03KON/eKo9cbvucKf36564aVCXVCPaFbBpd6dnSi1xSJBPwkfoUFhow9ZFu2
	S81C3RKFKHg3EA+Mq8d5S9oWsnxezGE3MDVAYlKc1Y+Sts42QmOPPjp5oquJRqCaF92neH
	xv4yWl3y3YHz+WVx4cwc0QljmH/MWqs=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-kRYXUrXhOLWWQ3MNPWwjQg-1; Mon, 08 Apr 2024 04:44:47 -0400
X-MC-Unique: kRYXUrXhOLWWQ3MNPWwjQg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-479caf002b9so583118137.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565886; x=1713170686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JY3/LNjqLYiipt/EHsApjCI6ktJry9Gfg2HWZFwX/g=;
        b=sb4g90dyl8y5E/lgH09Vb9M5LTk9D6cYqh9tCXq5RtwBgfGo2Ju/56g1fNyrOeJXCC
         dlKVjwLPcnOr/93zYli4Kd6dgviB7gLtVUZiFEif2UGapQtRy1+ajQrSJWa3c5yNKaMq
         nvkCLC8GfJ+92eYzrMJtU4n1QUW57FFjf67ZwjC2G0OP0d3ZYzvUu9nuSN7i0ksDcdWe
         IXXtlJ98Is+yXhb1czYRFpnP08GgYtbskMixWyX3/CCcNa7WUttQXMqsY2biu/Bi2i6Q
         RS2/zJ0gdK0gy2FRs/zkb1CDyPDa+gd0OeTl1P+BM3/j+8msW2sBREpfstK4auitEUl8
         gVtw==
X-Forwarded-Encrypted: i=1; AJvYcCVbLx+4RmYliZjvaF5lvXz4P5KYywpQeOSiWwUb95ffzfwx9XUdxUpKVeQlotu7F6KMSrh1YrpQKk4xrAT+15Hqnbrz+sZfkgw7QWGO
X-Gm-Message-State: AOJu0YzsGFwTCEny8YxnBgtQyO0MCOoX9cj1eOFwAXKmnm0qXXfbwZAf
	eSniQ+XbJ8eM0vWWqHmT2oIpG4wp5IOwnxFVZjEONPCLswZhMqtY6C5qEwhy5xx0q7OWgSP1qVa
	X32gZHOrFd0JSJfAHwSEEF5J32ACRYPJtAyRQRXh/LdgFikDrypzzYQ43yCwK3g==
X-Received: by 2002:a05:6102:515:b0:479:de3a:d2cf with SMTP id l21-20020a056102051500b00479de3ad2cfmr4448513vsa.1.1712565886516;
        Mon, 08 Apr 2024 01:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg2PNIk47UlCuBAj7CVpQLIdCLibVZ8sJoQWwna7z6edafKk216GeqWdnLp6oZ0KT5EWHqdQ==
X-Received: by 2002:a05:6102:515:b0:479:de3a:d2cf with SMTP id l21-20020a056102051500b00479de3ad2cfmr4448501vsa.1.1712565885919;
        Mon, 08 Apr 2024 01:44:45 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:45 -0700 (PDT)
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
Subject: [PATCH v6 08/10] PCI: Give pci(m)_intx its own devres callback
Date: Mon,  8 Apr 2024 10:44:20 +0200
Message-ID: <20240408084423.6697-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is one of the functions that have "hybrid mode" (i.e.,
sometimes managed, sometimes not). Providing a separate pcim_intx()
function with its own device resource and cleanup callback allows for
removing further large parts of the legacy pci-devres implementation.

As in the region-request-functions, pci_intx() has to call into its
managed counterpart for backwards compatibility.

As pci_intx() is an outdated function, pcim_intx() shall not be made
visible to other drivers via a public API.

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.
Remove the struct pci_devres from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 74 +++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.c    | 24 +++++++-------
 drivers/pci/pci.h    | 17 +---------
 3 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e257c212cd9c..b81bbb9abe51 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,6 +40,11 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCI_STD_NUM_BARS];
 };
 
+/* Used to restore the old intx state on driver detach. */
+struct pcim_intx_devres {
+	int orig_intx;
+};
+
 enum pcim_addr_devres_type {
 	/* Default initializer. */
 	PCIM_ADDR_DEVRES_TYPE_INVALID,
@@ -401,28 +406,69 @@ int pcim_set_mwi(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+static void pcim_intx_restore(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_intx_devres *res = data;
 
-static void pcim_release(struct device *gendev, void *res)
+	pci_intx(pdev, res->orig_intx);
+}
+
+static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
+	struct pcim_intx_devres *res;
 
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (res)
+		return res;
 
-	if (!dev->pinned)
-		pci_disable_device(dev);
+	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+	if (res)
+		devres_add(dev, res);
+
+	return res;
 }
 
-/*
- * TODO: After the last four callers in pci.c are ported, find_pci_dr()
- * needs to be made static again.
+/**
+ * pcim_intx - managed pci_intx()
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Returns: 0 on success, -ENOMEM on error.
+ *
+ * Enables/disables PCI INTx for device @pdev.
+ * Restores the original state on driver detach.
  */
-struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+int pcim_intx(struct pci_dev *pdev, int enable)
 {
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
+	u16 pci_command, new;
+	struct pcim_intx_devres *res;
+
+	res = get_or_create_intx_devres(&pdev->dev);
+	if (!res)
+		return -ENOMEM;
+
+	res->orig_intx = !enable;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
+		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+	return 0;
+}
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+
+	if (!dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f1419bac9b9..f59dbad69452 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3873,7 +3873,7 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
 	/*
-	 * This is done for backwards compatibility, because the old pci-devres
+	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
 	 * enabled with pcim_enable_device() instead of pci_enable_device().
 	 */
@@ -4461,11 +4461,22 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: Its normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance.
  * This hybrid feature is DEPRECATED!
+ * Use pcim_intx() if you need a managed version.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
+	/*
+	 * This is done for backwards compatibility, because the old PCI devres
+	 * API had a mode in which this function became managed if the dev had
+	 * been enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+		return;
+	}
+
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4473,17 +4484,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		struct pci_devres *dr;
-
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, new);
-
-		dr = find_pci_dr(pdev);
-		if (dr && !dr->restore_intx) {
-			dr->restore_intx = 1;
-			dr->orig_intx = !enable;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c98de280b16e..1ca591f37270 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -812,22 +812,7 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- *
- * TODO: Struct pci_devres and find_pci_dr() only need to be here because
- * they're used in pci.c.  Port or move these functions to devres.c and
- * then remove them from here.
- */
-struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-};
-
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
-- 
2.44.0


