Return-Path: <linux-kernel+bounces-55031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF784B6A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840001C23A16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967A131E2B;
	Tue,  6 Feb 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZI2v/Bq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA3131754
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226837; cv=none; b=Ig9mPp8Me+EpQjkug2JnVpxOyY/TYInrqipXY6vqttzJ9uaQzwNW0v3vf/tNkRj4prAs8LSLUPFLFVC41EevZ1SOm8cWzbNO7gkDyqIfTaezlI60sH7e9UNEvoBRlNAxEA4sNSmXJO1wIla0hJ3w9tunkxNa+b6bE045SZ6EyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226837; c=relaxed/simple;
	bh=7KglswOihbbFIPfis3Yyk+inqTSCz1crMZ9ws0GOWR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z84f1jFVE0YoCSOhcvfgTOuP8zy3+2fg7e0MPfA7ypqfJpEAY47mRncQ5uB5RnRGdDsH7vOw6XxYf7739gJOqSWnVvAA4MKpm6sZ6npW9BKv2kgLQ3Ie7ByXqje4NSP3uyEsQt3Q8EoDANLnl53BaXe18Kpv1QAz9kuFljs1yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZI2v/Bq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPhqNOqxfCv1D+Eeh5ibCQbTiDS1skQv+I51iBzSayk=;
	b=XZI2v/BqFAhnQWAnu4R5OOT5w9nLqvIwdSB2yP99y7JK/UXMG8h68QXKlgsAsKdhBHz/Qh
	NQLF1YVGbZrTOS4oC5I7HiqSvuYVrA180bBGTFKa3T5PvQlkr4Um71Dy3MNzYFTvIOK6dQ
	iMig6ynslVfaOAY5UdP7H9NAWxJ66Fs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-pR25HTZKNyS-h8GLfDU88Q-1; Tue, 06 Feb 2024 08:40:31 -0500
X-MC-Unique: pR25HTZKNyS-h8GLfDU88Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78356ddf3cfso293205985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226831; x=1707831631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPhqNOqxfCv1D+Eeh5ibCQbTiDS1skQv+I51iBzSayk=;
        b=IRWTsgAnrnIv3m/1//2z4TqrdtoZcIXad1Ar1wWKZ7nq4JXXyW1MEKgNW4qqln2y2j
         E3AN82eDmbHpZnmFKZjMxJOV9heLCsdTqFSKrnfP4ohBn/BaITS6r/qQ5R99b/JledGE
         04C6mjDw21kwX4+rMxVm59kRc8Ng26/lL/KCLKUbuu3hJIIZfKQHby5+I9W0pvfX9Ek0
         TtJMK9Et2CkWFZclxfsNtb51z0XXo5JZtZXPBXehl6p+ZTMxzQ5eHTeLMmYpnxZFS2Y9
         eZHBi/389BwSBiiwLXTjOuMlL3StYjfk2CUDLJ/GowauHaE7Ed+GjZMmch8nCyhIc0mV
         qsQA==
X-Forwarded-Encrypted: i=1; AJvYcCXQa22a0c6RAhz1cvzMsblLVIvUXG786txu/jhMwgxF1EaaOi4LBeal13JrKVD4R8sul1zr4BX8E0FsX9r7wXA/X4IAYEoy/bR+fF+h
X-Gm-Message-State: AOJu0YxA2jyYMoSogtsShY8Pjv2cMdcpzgAxW7A5NfYUlKfuY/AHaQTr
	NPtoz62A0GNXD7lzOtIODSCYrAkFTijnUrZZb3L6FuhXfxFcd8tCqe6iYpwQJCUyLX6+V3H/9nE
	VQwlWcIsauolnGzgtma1zyoFfeV6CwGktZ+FFI05sdZIIpwchyzWka3HH24taEg==
X-Received: by 2002:a05:620a:17a1:b0:784:ae7:20c1 with SMTP id ay33-20020a05620a17a100b007840ae720c1mr2365427qkb.5.1707226830545;
        Tue, 06 Feb 2024 05:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH52idAS6O9FJ9RWw0GxYBqIOnKisI8gHhI/sA84DuYTUv88y9sJUL9Mr/XOEtzlI3sh0TuOg==
X-Received: by 2002:a05:620a:17a1:b0:784:ae7:20c1 with SMTP id ay33-20020a05620a17a100b007840ae720c1mr2365392qkb.5.1707226829972;
        Tue, 06 Feb 2024 05:40:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVSZrnY5CjerkB8j8yhcI+1q9GkDqgS7IO0ZpFdJvZpYj3TnYCRrbhi3hi3wAUdgfJnZHqpP0MFaeTxIt2Zx7u4FgHt/9cHsj5LBhSCqk4n75XEVaXYN0flL8fAtdcBU1BI/xY7h7cJwA0QOArhsWERp51JD+hJjK8v5/m76bkea7y6fkyrgynN6VmpGi2fE0AOyUYC2LVtLn4pS/qChitiw5DodMfn3b2RBby5O3Qb5DiImQ6QEu2/5PKPoJI6Q/ThvTCNoGAiGaHLCNQw6NNoYznLw3vmfIy7GxuIixHkJiBNGTRQDBHfyH7r3NhDlyb/lhzZKm8zM07nnBHki0hQyqEX/13gPuxOHxkHPbgBuas6ziX/0BK3fsUeex7lVjfmpBE
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:29 -0800 (PST)
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
Subject: [PATCH v3 01/10] PCI: Add new set of devres functions
Date: Tue,  6 Feb 2024 14:39:47 +0100
Message-ID: <20240206134000.23561-3-pstanner@redhat.com>
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

The PCI devres API is not extensible to partial BAR mappings and has
bug-provoking features. Improve that by providing better alternatives.

When the original PCI devres API was implemented, priority was given to
the creation of a set of "plural functions" such as
pcim_request_regions(). These functions have bit masks as parameters to
specify which BARs shall get mapped. Most users, however, only use those
to map 1-3 BARs.

A complete set of "singular functions" does not exist.

As functions mapping / requesting multiple BARs at once have (almost) no
mechanism in C to return the resources to the caller of the plural
function, the PCI devres API utilizes the iomap-table administrated by the
function pcim_iomap_table().

The entire PCI devres API was strongly tied to that table
which only allows for mapping whole, complete BARs, as the BAR's index
is used as table index. Consequently, it's not possible to, e.g., have a
pcim_iomap_range() function with that mechanism.

An additional problem is hat the PCI devres API has been ipmlemented in
a sort of "hybrid-mode": Some unmanaged functions have managed
counterparts (e.g.: pci_iomap() <-> pcim_iomap()), making their managed
nature obvious to the programmer. However, the region-request functions
in pci.c, prefixed with pci_, behave either managed or unmanaged,
depending on whether pci_enable_device() or pcim_enable_device() has
been called in advance.

This hybrid API is confusing and should be more cleanly separated by
providing always-managed functions prefixed with pcim_.

Thus, the existing PCI devres API is not desirable because:
  a) The vast majority of the users of the plural functions only ever
     sets a single bit in the bit mask, consequently making them singular
     functions anyways.
  b) There is no mechanism to request / iomap only part of a BAR.
  c) The iomap-table mechanism is over-engineered and complicated. Even
     worse, some users index over the table administration function
     directly:
     void __iomem *mapping = pcim_iomap_table(pdev)[my_index];
     This can not perform bounds checks; an invalid index won't cause
     return of -EINVAL or even NULL, resulting in undefined behavior.
  d) region-request functions being sometimes managed and sometimes not
     is bug-provoking.

Implement a set of singular pcim_ functions that use devres directly and
bypass the legacy iomap table mechanism.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 473 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h  |  11 +
 2 files changed, 479 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 4bd1e125bca1..4e47f00a03a2 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -8,10 +8,215 @@
  */
 #define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
 
+/*
+ * Legacy struct storing addresses to whole mapped BARs.
+ */
 struct pcim_iomap_devres {
 	void __iomem *table[PCIM_IOMAP_MAX];
 };
 
+enum pcim_addr_devres_type {
+	/* Default initializer. */
+	PCIM_ADDR_DEVRES_TYPE_INVALID,
+
+	/* A region spanning an entire BAR. */
+	PCIM_ADDR_DEVRES_TYPE_REGION,
+
+	/* A region spanning an entire BAR, and a mapping for that whole BAR. */
+	PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING,
+
+	/*
+	 * A mapping within a BAR, either spanning the whole BAR or just a range.
+	 * Without a requested region.
+	 */
+	PCIM_ADDR_DEVRES_TYPE_MAPPING,
+
+	/* A ranged region within a BAR, with a mapping spanning that range. */
+	PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING
+};
+
+/*
+ * This struct envelopes IO or MEM addresses, that means mappings and region
+ * requests, because those are very frequently requested and released together.
+ */
+struct pcim_addr_devres {
+	enum pcim_addr_devres_type type;
+	void __iomem *baseaddr;
+	unsigned long offset;
+	unsigned long len;
+	short bar;
+};
+
+static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
+{
+	memset(res, 0, sizeof(*res));
+	res->bar = -1;
+}
+
+/*
+ * The following functions, __pcim_*_region*, exist as counterparts to the
+ * versions from pci.c - which, unfortunately, can be in "hybrid mode", i.e.,
+ * sometimes managed, sometimes not.
+ *
+ * To separate the APIs cleanly, we define our own, simplified versions here.
+ */
+
+/**
+ * __pcim_request_region_range - Request a ranged region
+ * @pdev: PCI device the region belongs to
+ * @bar: The BAR the region is within
+ * @offset: offset from the BAR's start address
+ * @maxlen: length in bytes, beginning at @offset
+ * @name: name associated with the request
+ * @req_flags: flags for the request. For example for kernel-exclusive requests.
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ *
+ * Request a ranged region within a device's PCI BAR. This function performs
+ * sanity checks on the input.
+ */
+static int __pcim_request_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long maxlen,
+		const char *name, int req_flags)
+{
+	resource_size_t start = pci_resource_start(pdev, bar);
+	resource_size_t len = pci_resource_len(pdev, bar);
+	unsigned long dev_flags = pci_resource_flags(pdev, bar);
+
+	if (start == 0 || len == 0) /* That's an unused BAR. */
+		return 0;
+	if (len <= offset)
+		return  -EINVAL;
+
+	start += offset;
+	len -= offset;
+
+	if (len > maxlen && maxlen != 0)
+		len = maxlen;
+
+	if (dev_flags & IORESOURCE_IO) {
+		if (!request_region(start, len, name))
+			return -EBUSY;
+	} else if (dev_flags & IORESOURCE_MEM) {
+		if (!__request_mem_region(start, len, name, req_flags))
+			return -EBUSY;
+	} else {
+		/* That's not a device we can request anything on. */
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __pcim_release_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(pdev, bar);
+	resource_size_t len = pci_resource_len(pdev, bar);
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (len <= offset || start == 0)
+		return;
+
+	if (len == 0 || maxlen == 0) /* This an unused BAR. Do nothing. */
+		return;
+
+	start += offset;
+	len -= offset;
+
+	if (len > maxlen)
+		len = maxlen;
+
+	if (flags & IORESOURCE_IO)
+		release_region(start, len);
+	else if (flags & IORESOURCE_MEM)
+		release_mem_region(start, len);
+}
+
+static int __pcim_request_region(struct pci_dev *pdev, int bar,
+		const char *name, int flags)
+{
+	unsigned long offset = 0;
+	unsigned long len = pci_resource_len(pdev, bar);
+
+	return __pcim_request_region_range(pdev, bar, offset, len, name, flags);
+}
+
+static void __pcim_release_region(struct pci_dev *pdev, int bar)
+{
+	unsigned long offset = 0;
+	unsigned long len = pci_resource_len(pdev, bar);
+
+	__pcim_release_region_range(pdev, bar, offset, len);
+}
+
+static void pcim_addr_resource_release(struct device *dev, void *resource_raw)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_addr_devres *res = resource_raw;
+
+	switch (res->type) {
+	case PCIM_ADDR_DEVRES_TYPE_REGION:
+		__pcim_release_region(pdev, res->bar);
+		break;
+	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
+		pci_iounmap(pdev, res->baseaddr);
+		__pcim_release_region(pdev, res->bar);
+		break;
+	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
+		pci_iounmap(pdev, res->baseaddr);
+		break;
+	case PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING:
+		pci_iounmap(pdev, res->baseaddr);
+		__pcim_release_region_range(pdev, res->bar, res->offset, res->len);
+		break;
+	default:
+		break;
+	}
+}
+
+static struct pcim_addr_devres *pcim_addr_devres_alloc(struct pci_dev *pdev)
+{
+	struct pcim_addr_devres *res;
+
+	res = devres_alloc_node(pcim_addr_resource_release, sizeof(*res),
+			GFP_KERNEL, dev_to_node(&pdev->dev));
+	if (res)
+		pcim_addr_devres_clear(res);
+	return res;
+}
+
+/* Just for consistency and readability. */
+static inline void pcim_addr_devres_free(struct pcim_addr_devres *res)
+{
+	devres_free(res);
+}
+
+/*
+ * Used by devres to identify a pcim_addr_devres.
+ */
+static int pcim_addr_resources_match(struct device *dev, void *a_raw, void *b_raw)
+{
+	struct pcim_addr_devres *a, *b;
+
+	a = a_raw;
+	b = b_raw;
+
+	if (a->type != b->type)
+		return 0;
+
+	switch (a->type) {
+	case PCIM_ADDR_DEVRES_TYPE_REGION:
+	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
+		return a->bar == b->bar;
+	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
+		return a->baseaddr == b->baseaddr;
+	case PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING:
+		return a->bar == b->bar && a->offset == b->offset && a->len == b->len;
+	default:
+		return 0;
+	}
+}
 
 static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
 {
@@ -92,8 +297,8 @@ EXPORT_SYMBOL(devm_pci_remap_cfgspace);
  *
  * All operations are managed and will be undone on driver detach.
  *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example::
+ * Returns a pointer to the remapped memory or an IOMEM_ERR_PTR() encoded error
+ * code on failure. Usage example::
  *
  *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
@@ -341,15 +546,80 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 			tbl[i] = NULL;
 			return;
 		}
-	WARN_ON(1);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
+/**
+ * pcim_iomap_region - Request and iomap a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of a BAR to map
+ * @name: Name associated with the request
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Mapping and region will get automatically released on driver detach. If
+ * desired, release manually only with pcim_iounmap_region().
+ */
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar, const char *name)
+{
+	int ret;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
+	res->bar = bar;
+
+	ret = __pcim_request_region(pdev, bar, name, 0);
+	if (ret != 0)
+		goto err_region;
+
+	res->baseaddr = pci_iomap(pdev, bar, 0);
+	if (!res->baseaddr) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
+	devres_add(&pdev->dev, res);
+	return res->baseaddr;
+
+err_iomap:
+	__pcim_release_region(pdev, bar);
+err_region:
+	pcim_addr_devres_free(res);
+
+	return IOMEM_ERR_PTR(ret);
+}
+EXPORT_SYMBOL(pcim_iomap_region);
+
+/**
+ * pcim_iounmap_region - Unmap and release a PCI BAR
+ * @pdev: PCI device to operate on
+ * @bar: Index of BAR to unmap and release
+ *
+ * Unmap a BAR and release its region manually. Only pass BARs that were
+ * previously mapped by pcim_iomap_region().
+ */
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+{
+	struct pcim_addr_devres res_searched;
+
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
+	res_searched.bar = bar;
+
+	devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched);
+}
+EXPORT_SYMBOL(pcim_iounmap_region);
+
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
- * @name: Name used when requesting regions
+ * @name: Name associated with the requests
  *
  * Request and iomap regions specified by @mask.
  */
@@ -402,7 +672,7 @@ EXPORT_SYMBOL(pcim_iomap_regions);
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
- * @name: Name used when requesting regions
+ * @name: Name associated with the requests
  *
  * Request all PCI BARs and iomap regions specified by @mask.
  */
@@ -448,3 +718,196 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
+
+static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
+		int request_flags)
+{
+	int ret;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return -ENOMEM;
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
+	res->bar = bar;
+
+	ret = __pcim_request_region(pdev, bar, name, request_flags);
+	if (ret != 0) {
+		pcim_addr_devres_free(res);
+		return ret;
+	}
+
+	devres_add(&pdev->dev, res);
+	return 0;
+}
+
+/**
+ * pcim_request_region - Request a PCI BAR
+ * @pdev: PCI device to requestion region for
+ * @bar: Index of BAR to request
+ * @name: Name associated with the request
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ *
+ * Request region specified by @bar.
+ *
+ * The region will automatically be released on driver detach. If desired,
+ * release manually only with pcim_release_region().
+ */
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
+{
+	return _pcim_request_region(pdev, bar, name, 0);
+}
+EXPORT_SYMBOL(pcim_request_region);
+
+/**
+ * pcim_release_region - Release a PCI BAR
+ * @pdev: PCI device to operate on
+ * @bar: Index of BAR to release
+ *
+ * Release a region manually that was previously requested by
+ * pcim_request_region().
+ */
+void pcim_release_region(struct pci_dev *pdev, int bar)
+{
+	struct pcim_addr_devres res_searched;
+
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_REGION;
+	res_searched.bar = bar;
+
+	devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched);
+}
+EXPORT_SYMBOL(pcim_release_region);
+
+/**
+ * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of the BAR
+ * @offset: Offset from the begin of the BAR
+ * @len: Length in bytes for the mapping
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Creates a new IO-Mapping within the specified @bar, ranging from @offset to
+ * @offset + @len.
+ *
+ * The mapping will automatically get unmapped on driver detach. If desired,
+ * release manually only with pcim_iounmap().
+ */
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long len)
+{
+	void __iomem *mapping;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	mapping = pci_iomap_range(pdev, bar, offset, len);
+	if (!mapping) {
+		pcim_addr_devres_free(res);
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+	res->baseaddr = mapping;
+
+	/*
+	 * Ranged mappings don't get added to the legacy-table, since the table
+	 * only ever keeps track of whole BARs.
+	 */
+
+	devres_add(&pdev->dev, res);
+	return mapping;
+}
+EXPORT_SYMBOL(pcim_iomap_range);
+
+/**
+ * pcim_iomap_region_range - Request and map a range within a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of BAR to request within
+ * @offset: Offset from the begin of the BAR
+ * @len: Length in bytes for the mapping
+ * @name: Name associated with the request
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Request region with a range specified by @offset and @len within @bar and
+ * iomap it.
+ *
+ * The region will automatically be released and the mapping be unmapped on
+ * driver detach. If desired, release manually only with
+ * pcim_iounmap_region_range().
+ *
+ * You probably should only use this function if you explicitly do not want to
+ * request the entire BAR. For most use-cases, combining pcim_request_region()
+ * and pcim_iomap_range() should be sufficient.
+ */
+void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long len, const char *name)
+{
+	int ret;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING;
+	res->bar = bar;
+	res->offset = offset;
+	res->len = len;
+
+	ret = __pcim_request_region_range(pdev, bar, offset, len, name, 0);
+	if (ret != 0)
+		goto err_region;
+
+	res->baseaddr = pci_iomap_range(pdev, bar, offset, len);
+	if (!res->baseaddr) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
+	devres_add(&pdev->dev, res);
+	return res->baseaddr;
+
+err_iomap:
+	__pcim_release_region_range(pdev, bar, offset, len);
+err_region:
+	pcim_addr_devres_free(res);
+
+	return IOMEM_ERR_PTR(ret);
+}
+EXPORT_SYMBOL(pcim_iomap_region_range);
+
+/**
+ * pcim_iounmap_region_range - Unmap and release a range within a PCI BAR
+ * @pdev: PCI device to operate on
+ * @bar: Index of BAR containing the range
+ * @offset: Offset from the begin of the BAR
+ * @len: Length in bytes for the mapping
+ *
+ * Unmaps and releases a memory area within the specified PCI BAR.
+ *
+ * This function may not be used to free only part of a range. Only use this
+ * function with the exact parameters you previously used successfully in
+ * pcim_iomap_region_range().
+ */
+void pcim_iounmap_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long len)
+{
+	struct pcim_addr_devres res_searched;
+	pcim_addr_devres_clear(&res_searched);
+
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING;
+	res_searched.bar = bar;
+	res_searched.offset = offset;
+	res_searched.len = len;
+
+	devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched);
+}
+EXPORT_SYMBOL(pcim_iounmap_region_range);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..5c676a1a1a3f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2318,10 +2318,21 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar, const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *res_name);
+void pcim_release_region(struct pci_dev *pdev, int bar);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
+void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, int bar,
+				       unsigned long offset, unsigned long len,
+				       const char *res_name);
+void pcim_iounmap_region_range(struct pci_dev *pdev, int bar,
+			       unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.43.0


