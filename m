Return-Path: <linux-kernel+bounces-35030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69335838ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FE028D383
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE215F874;
	Tue, 23 Jan 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC4WNEc7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AD5F842
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003108; cv=none; b=BO7Fnzgj19ddJ6M6rcSRfNiBqlfrTHkzSnvx3btjlINF2C/fxE8J9lXhy46C6bYx4RvRETHkLZVPtCWdIGWqb1ekS95QNh1UXP71XyipkyiKXZQE/TQ0t8xYv1wZCTvLSc68CKR11OMNa808EvRPEX696w5PgsoyOybAOlwBgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003108; c=relaxed/simple;
	bh=5SBUvOssUDD+2gGAiGFtJKi4a09NTizmqH1j3HCBM0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9Vt72lw7WSkVZJIXoy3txHLHdPEa1cXzLYlPeKMusuwDwetK03tkEQGeFKeCsH+0pnewLrMMCwLbrIvU3FyyfwKK/nm34xmEd/AxSCTVLJZQt8suFgMfJVxAavE/BuobSy8j3RAfSlbj+NU5gY/zfBwtzyPda8AlRsvpYpLeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JC4WNEc7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPaQbXk8XLEaVElIGgvAHXLJscVCCVhCxcSL8y0kSzA=;
	b=JC4WNEc7jZ+5j5/pCUglqcJX3cDZONmNY+U4B6LmFN+yLYJgYkSfFSN4g6GVDpjoFns9+7
	wV7EUiFLAKru+3xUk74lLhPqg4BxJC/YJGO9c9WlfTxbXeBeo6IaqupE2VsatN0qs8SOU/
	/aR2sUrw2R4c5t3+Ed7kb6VMz+h24/k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-tRl7XzI6Mx2ijmihY1ct5w-1; Tue, 23 Jan 2024 04:45:03 -0500
X-MC-Unique: tRl7XzI6Mx2ijmihY1ct5w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78356ddf3cfso127858185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003103; x=1706607903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPaQbXk8XLEaVElIGgvAHXLJscVCCVhCxcSL8y0kSzA=;
        b=nd52eL9R4c7j3zy4z0d0gEJKkCxHfI7EbZH7F85AtxE8EoX8O6W0o5+exTBJoheWWH
         vfV4BbXCLArX9peeKW7bXAXVZWeH8aFSOje1juVzlHUYH1PqnEqomve3Q093oWtVYXE3
         c4886wUKceU0UuQwDxgb8ezsZgAdViD+rVTahafW+OKUvfUq3rSZ7drinVo4adS+n/rA
         1gnTMRM8bV6tLdSr9eeW6K7ehPhYFAjq537+bK6U5h5KVvv9iESxzc60mrG7j/LsFxhk
         +WtAdwhbaJfIEDQ2bSb2Qm0vcira7+psn9TS0EYYIEX2CvWEGajCcCBztUAA39SdWVLJ
         y3kQ==
X-Gm-Message-State: AOJu0YzOiESQIF6DHx/26v4qGjTYgkmaU/NZflJ8VszcA1ibg4ihUUvn
	am1iUmDBZ4RRoQKBdqJPbZICJ8sRbAbBLiBQT6UajQuQhSmSUvzD3TzGJBFzUuXBNeJ3V6zYHuO
	VGoQq/TVfdAG6H4d5qRPIujYg1LnsO+xqqmrMLE24dr8RXseZGdDMm5FvtfPVAg==
X-Received: by 2002:a05:6214:f26:b0:685:7cfd:34eb with SMTP id iw6-20020a0562140f2600b006857cfd34ebmr9324897qvb.4.1706003103114;
        Tue, 23 Jan 2024 01:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtcDj2ng1o0t8y8DdObSU32+uI7sQsarbF6v7QkK54odso969HOgDvhCFed+0S/Tvhd8Mu/g==
X-Received: by 2002:a05:6214:f26:b0:685:7cfd:34eb with SMTP id iw6-20020a0562140f2600b006857cfd34ebmr9324885qvb.4.1706003102866;
        Tue, 23 Jan 2024 01:45:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:45:02 -0800 (PST)
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
Subject: [PATCH v2 08/10] PCI: give pci(m)_intx its own devres callback
Date: Tue, 23 Jan 2024 10:43:05 +0100
Message-ID: <20240123094317.15958-9-pstanner@redhat.com>
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
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c    | 24 +++++++-------
 drivers/pci/pci.h    | 21 +++---------
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index d396d672a6f4..4314d0863282 100644
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
@@ -401,31 +406,70 @@ int pcim_set_mwi(struct pci_dev *pdev)
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
- * TODO:
- * Once the last four callers in pci.c are ported, this function here needs to
- * be made static again.
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
-EXPORT_SYMBOL(find_pci_dr);
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ab8d66e05662..323d5b52f669 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3877,7 +3877,7 @@ EXPORT_SYMBOL_GPL(pci_common_swizzle);
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
 	/*
-	 * This is done for backwards compatibility, because the old pci-devres
+	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
 	 * enabled with pcim_enable_device() instead of pci_enable_device().
 	 */
@@ -4465,11 +4465,22 @@ void pci_disable_parity(struct pci_dev *dev)
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
@@ -4477,17 +4488,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
index 667bfdd61d5e..e6d4b81ff09e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -796,24 +796,11 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 #endif
 
 /*
- * TODO:
- * The following two components wouldn't need to be here if they weren't used at
- * four last places in pci.c
- * Port or move these functions to devres.c and then remove the
- * pci_devres-components from this header file here.
+ * This is a helper that shall only ever be called by pci_intx(). It helps
+ * cleaning up the PCI devres API in which pci_intx() became a managed function
+ * under certain conditions.
  */
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
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
2.43.0


