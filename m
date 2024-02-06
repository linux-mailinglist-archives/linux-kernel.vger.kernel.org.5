Return-Path: <linux-kernel+bounces-55033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418584B6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D11B2236B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06D131E32;
	Tue,  6 Feb 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4ggJ7N7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F38131E2A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226841; cv=none; b=slc62L0SGdS2HstzoQd3W9wGhH0ZMqirO9sIewstAFB1Zw40fSlx1wt6A/zT8todYCm8kjKb4J7eIOQW5IuhPkrSNCSw15UdlzWSUQp61CDoxgqK/k67qnFpzVk/JUrwnIjm4eFp7c67sxw6KdNuWiNHOUGKg5b/FLS/h0bAkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226841; c=relaxed/simple;
	bh=AAw/We9WI+NQKj7wqdsP135RjOGeGnoDC7qmIfjGo+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyxsWIdwI0fhyqfEwKTcUKVpLwtMGs/ytwt4Gq8p4XVhrPXCe6wMrAHJouYtqDhX8j32OKCVUSGHAn41dootuy+GwN12+psWv0kYuDydvUylPKQIf+109J3jz2deWQRJYKTVkgRGWpOBqzSjmydy5L3XGBh+AzPR3dtyAWDTTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4ggJ7N7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W8BzE0YxhsoFZleLy0MgAqqm8C3W0oimN6YDb86Ncw=;
	b=b4ggJ7N7UZLEkballnPqsikfZPOABYg7pafMvhGSHyB5rFZrUOgV4+pZHDzV47NYtmGbuF
	TEbHVVSqLa/hCZ3kRs+QcOSK/bHIgGixphh6OTKjpa9Ubk6Rs+G8hVWJhLBGRr40oH+A+i
	OZhDjrXo7w8T2/n9GbaJlzdWt3U/HqQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-d2OFRLtVNQq8ubH8ttWdAA-1; Tue, 06 Feb 2024 08:40:36 -0500
X-MC-Unique: d2OFRLtVNQq8ubH8ttWdAA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-59a1c8f2f98so1137820eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226836; x=1707831636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W8BzE0YxhsoFZleLy0MgAqqm8C3W0oimN6YDb86Ncw=;
        b=VXIbW1DzKW9Tv+vu1SVruIkUex+OpzdtNAJJ9ZXaisgVvKlvJ5thRcptXX46XFXaGZ
         lccccrHp2rcn0N3CHmBy3PqtRWSBK0M2XWCpnry7CRV6S99aUsM9Qc4FxNAks/a5f7Is
         Aq8PuVf4dnvfSdT+gposbwaPQDnINuq7Gk8d/5t77wwhlj3McrevANTJ1uT3GDO8vtsV
         PNh7+oy/IzGpotWdxR/EFdX2J7Y948DqMBVkzkZKRSf+aC+nl5jHcoxFrfUa9YPmSKAk
         HTNuik4c2zvubCGhIAF9nvMbsgGYXwxEnNAYtuVoJWvkEaEtgjUajbnkmeqeg9dO3yZT
         X4eQ==
X-Gm-Message-State: AOJu0YxQWD1l+wfpDdo1A2YpTBVn/2Hz5DkHJR5/j1Fq+Lq64aoulfkj
	ePJInC59UFTCLjQg5VWSwkJjPiu5izzs9jYRNkvO5hfFaj3QqRgF2FBuNvTDrOjW9une0IVGj4a
	oh9V2rAlvMAxFb+3DH0T1m1NQjFhHuI1wfZbXX4rAZkKSsJEhcE2Wt/8gN/BZdA==
X-Received: by 2002:a4a:cb8b:0:b0:59c:e48e:50fc with SMTP id y11-20020a4acb8b000000b0059ce48e50fcmr1959100ooq.1.1707226835596;
        Tue, 06 Feb 2024 05:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrKmzQ8RqxOT65hNl5+yWWkJnenxq7cHxzYXmffQW9AVzBNZGEa1gErlpjniW4BqbM4ybEOw==
X-Received: by 2002:a4a:cb8b:0:b0:59c:e48e:50fc with SMTP id y11-20020a4acb8b000000b0059ce48e50fcmr1959086ooq.1.1707226835264;
        Tue, 06 Feb 2024 05:40:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv8TZ9TKxI54TnpwOXmdUBR+ZSKgnm57uwFvG5jHQ0xBdMGfDi2j1wZHd+A7P7FRSmu5kbx1QKl0JzhJQueNA745kD5roozvpDHSYO0exuh2dh3Gzuxpj4tXVZNGhkm2k0DX7sTP3nDEpaKhLONSab1vN2eGHFoYrZ2aPtOR1F8XXSdNuO/THjytXzDXL9WyMvMDBmldz1udLwphDCKGGlkAEcB8nkI0yJZvd/gTzKRTk/B4RtXOosq2hx/nox87IEwv7XSdXC+x92nDEgd/v0/by2QdEqpHUMR3qNKOQZMqCPjNMaJlUAgI/EQu4Xt69o+WayLDv2T/3wx840DmOxvArl6DFygfqbGgihnMXefz280N693rSNMg0bRv2Sb4WvnRKS
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:34 -0800 (PST)
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
Subject: [PATCH v3 03/10] PCI: Warn users about complicated devres nature
Date: Tue,  6 Feb 2024 14:39:49 +0100
Message-ID: <20240206134000.23561-5-pstanner@redhat.com>
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

The PCI region-request functions become managed functions when
pcim_enable_device() has been called previously instead of
pci_enable_device().

This has already caused bugs by confusing users, who came to believe
that all pci functions, such as pci_iomap_range(), suddenly are managed
that way.

This is not the case.

Add comments to the relevant functions' docstrings that warn users about
this behavior.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c | 18 ++++++++++++++
 drivers/pci/pci.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index c9725428e387..ea3b9842132a 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -23,6 +23,11 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap_range().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -63,6 +68,10 @@ EXPORT_SYMBOL(pci_iomap_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 int bar,
@@ -106,6 +115,11 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -127,6 +141,10 @@ EXPORT_SYMBOL(pci_iomap);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index adf3c627c712..5c8bca2c5945 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3969,6 +3969,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3980,6 +3982,13 @@ EXPORT_SYMBOL(pci_release_region);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you need to implement a new pci
+ * function that does automatic cleanup, write a new pcim_* function that uses
+ * devres directly.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
@@ -4028,6 +4037,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -4035,6 +4046,12 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -4060,6 +4077,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 }
 EXPORT_SYMBOL(pci_release_selected_regions);
 
+/*
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 					  const char *res_name, int excl)
 {
@@ -4085,6 +4109,14 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
  * @res_name: Name to be associated with resource
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name)
@@ -4093,6 +4125,20 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
+/**
+ * pci_request_selected_regions_exclusive - Request regions exclusively
+ * @pdev: PCI device to request regions from
+ * @bars: bit mask of bars to request
+ * @res_name: name to be associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *res_name)
 {
@@ -4110,7 +4156,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4142,6 +4187,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4151,6 +4198,12 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -4482,6 +4535,11 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED!
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.43.0


