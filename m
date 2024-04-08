Return-Path: <linux-kernel+bounces-135064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842489BA9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAE9B22AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520439FDD;
	Mon,  8 Apr 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYRfPEna"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5B3D54C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565880; cv=none; b=J4V8jv2/8PaC62xYUMb0BRCJR1SnLZ7LfQ8rf4r/MzeGs/IoFFUalDAuh641ais4VHdPP02kXrgDWppriAduqaZbKUsfJtcnRdssRPCFF9DdfB2EZVg1y2lxi/kUImrT2gRQgrJzTY9Pw7LltR7NOJuTiuSUhAcDiN13rCA1Mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565880; c=relaxed/simple;
	bh=nBKWG5c5FhCBx7bhOlD5JxIgz1Oj/+3VoPRHxP5kZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNmpgac3LLgg3RIMYqtffVBnQmIiygtrbrdwqUEgU1trM9IBCBP0K0zrE51HHo5KiapZK9bMp9nHHiyVJNy32JBUSY2+7+Z8d1BD/Bu1TMrz7L9MhMfBcEQ9Exe1h0WDLQr20ppiB1FSUnQje6n/3eQg24AlQz9OCV4WzZSrQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYRfPEna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqd0XV6NVHg28KpejWCVVeMq/IoUZp7GtZTIzYnrVC8=;
	b=HYRfPEnaxcGRChN3kjaSjgqyhfo87RdxRqJZHrRqkp0YZ2iIjE92+NjYGERXxHwZym+WCm
	AsM51mk5t6ORM5RYyhpiPOnPPovkygv32b+mTfTvzEVevbne9ReSuv4yNCb4F6JkfGVbiY
	nfxwHs0SZnXmuER355J0saZ0hfH4Mgo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-VcVi57frPt-k-kBM26ErxQ-1; Mon, 08 Apr 2024 04:44:35 -0400
X-MC-Unique: VcVi57frPt-k-kBM26ErxQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4311d908f3cso17905101cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565875; x=1713170675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqd0XV6NVHg28KpejWCVVeMq/IoUZp7GtZTIzYnrVC8=;
        b=P2T7hZvrSMKtqrGyf1IFAezP/FqcpNzWM9C3M+wc88TjLm/hSsuJNsMcVe16rIMEZN
         9coLgZebpBOIkLsw4PtgE9hIXt127nDl55ujmLDJeBM6FJbXKNwNM5yKa0nnUX3qaIYM
         hw63UOglHS5CIwWdmtgLpskHnJYVOCZZv2kDbxNEQQSgNmS77bknBT/I2Hrc9WbyW6Cj
         U+59OFpL8kfcvNSak7mZlXGABbRk2qDiBhl6RXhKkCaElW6lIaiyIyudTRTRTRN5aYbB
         Xl0JsNETl1oqqE9p1YmR4wWnSjUFbWQeHssRUwJDivUsm6N63HiS1iDUWY8UMpTb6EZE
         XwGA==
X-Forwarded-Encrypted: i=1; AJvYcCWdW9ijie6dg1yyTbPdqqF9N7y+1az9gDdKXLpT2rK7n9O/4sJVabOnRgdh77hk6IDqyKNTrw03UhW+7fVVGW9M8j+zjI93402sT+vP
X-Gm-Message-State: AOJu0Ywk9dcVQir/BCIYMIxpUQQli8GYrJ9KaC0nYdFfUaOBZR8u5A5z
	tJWebgIe0YUsuLdNl7xNFASbTQTnziFMKb12KinhCWsHpKFLR7BJMdcqxA8LpIpcsW/bQeDhIjM
	YDRw92OD6/hybC0WOx+Q8MiTvSXZN+eEcaIqQqqb2qOXB377zT2AFCTOFSaA+5g==
X-Received: by 2002:a05:620a:4590:b0:78a:1ee:5c0f with SMTP id bp16-20020a05620a459000b0078a01ee5c0fmr9642452qkb.6.1712565875233;
        Mon, 08 Apr 2024 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR7midRoJI1FNPA+UU8XSvGoaEgXHEXcx1Kf1HaHyevfXZ+2+YLJhdeNw61JvfoOji+zi2BQ==
X-Received: by 2002:a05:620a:4590:b0:78a:1ee:5c0f with SMTP id bp16-20020a05620a459000b0078a01ee5c0fmr9642439qkb.6.1712565874920;
        Mon, 08 Apr 2024 01:44:34 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:34 -0700 (PDT)
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
Subject: [PATCH v6 03/10] PCI: Warn users about complicated devres nature
Date: Mon,  8 Apr 2024 10:44:15 +0200
Message-ID: <20240408084423.6697-4-pstanner@redhat.com>
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
index b5d21d8207d6..9d9d09534efe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3903,6 +3903,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3914,6 +3916,13 @@ EXPORT_SYMBOL(pci_release_region);
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
@@ -3962,6 +3971,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3969,6 +3980,12 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
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
@@ -3994,6 +4011,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
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
@@ -4019,6 +4043,14 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
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
@@ -4027,6 +4059,20 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
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
@@ -4044,7 +4090,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4076,6 +4121,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4085,6 +4132,12 @@ EXPORT_SYMBOL(pci_request_regions);
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
@@ -4416,6 +4469,11 @@ void pci_disable_parity(struct pci_dev *dev)
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
2.44.0


