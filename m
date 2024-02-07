Return-Path: <linux-kernel+bounces-56918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D434784D15C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7C2889D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E548528E;
	Wed,  7 Feb 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT4AAfqD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C783CBE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331347; cv=none; b=YJYHkM/ciriMXtXcQnhvguaWNk0ZuTfhiNi3kI2Q5U7z+7Y9v/4E7L3HQGx2c70iZ8Prm2JGe6OAhQvXvEiPFMUeLSJGmuKEvsBnYC6fYNi9u/S/j5fwrdjKO+tGodWdLEhWI6jin1RhhRI2mtSHXmyNB/PPRctxlXG/rCSa14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331347; c=relaxed/simple;
	bh=Dwy/u3XKKFj/qy3AWoxAcE6kPy3lkPw+HkoBS6KoqLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9cCqkXjXROw+P8HKECQWVryWEc//SBDnbjtSMbffm0aC0D/nhW9Dk779KP2mbl3wphK+RRGURotH1+SqNUPMkXD4JDHcKOHAVg4ndQZSlNPhZ/g3DIjYL9P7KlNQwR4LJUEnJZcYoR8H9zKKqC6FqG/teP/hd6EVthDlT4st9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NT4AAfqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7841DLyqRx4+GFENMTDanBPrbVQXHzKvu3LLMhu66w=;
	b=NT4AAfqDI6FVn8ldfJL1w74g5NhlQHEWElchsxd1s9HmS15rmD//ainlZ/Gzs/ooIfA3jZ
	wpxTZXvrD4mbzZd6jRSzsTpq8MMWIfLk5BkizdcXdPU/ailyjRYYcDhzvlT4cd9XPzxyBC
	ujJqIIz90g0EwDp1y3KQgerECGlJRmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-g0k1TawDMgiM8jXxLRJciw-1; Wed, 07 Feb 2024 13:42:22 -0500
X-MC-Unique: g0k1TawDMgiM8jXxLRJciw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 602F2185A780;
	Wed,  7 Feb 2024 18:42:22 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6DB24011FF1;
	Wed,  7 Feb 2024 18:42:21 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 3/6] pci bus async shutdown support
Date: Wed,  7 Feb 2024 13:40:57 -0500
Message-ID: <20240207184100.18066-4-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add async shutdown shutdown fields and Convert pci's shutdown logic into
async shutdown calls so that individual pci device drivers can implement
async shutdown.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/pci/pci-driver.c | 24 ++++++++++++++++++++++--
 include/linux/pci.h      |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..0ad418905115 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -502,16 +502,28 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_async_shutdown_start(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->async_shutdown_start)
+		drv->async_shutdown_start(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+}
+
+static void pci_device_async_shutdown_end(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->async_shutdown_end)
+		drv->async_shutdown_end(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
@@ -523,6 +535,12 @@ static void pci_device_shutdown(struct device *dev)
 		pci_clear_master(pci_dev);
 }
 
+static void pci_device_shutdown(struct device *dev)
+{
+	pci_device_async_shutdown_start(dev);
+	pci_device_async_shutdown_end(dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 /* Auxiliary functions used for system resume */
@@ -1682,6 +1700,8 @@ struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.async_shutdown_start	= pci_device_async_shutdown_start,
+	.async_shutdown_end	= pci_device_async_shutdown_end,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..6f61325c956a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -917,6 +917,8 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @async_shutdown_start:	This starts the asynchronous shutdown
+ * @async_shutdown_end:	This completes the started asynchronous shutdown
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -947,6 +949,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*async_shutdown_start)(struct pci_dev *dev);
+	void (*async_shutdown_end)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.43.0


