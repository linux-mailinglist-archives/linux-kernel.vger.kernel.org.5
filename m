Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045737CA97D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjJPNcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjJPNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:31:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2EB18E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697463104; x=1728999104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOFuCBEF7qDzKsVu/1gVwELNt4UpUHZQWLqV2968srU=;
  b=NctZuDJnGmkN7u+/MJgobLEHquP1IMcmNHPZzfj46GmkciWecKSPmHdQ
   rwNrFDYLP1EjkcUE3bZmlXUwF+00B0wSEIBNccf1p5yr0DM0I2+3GHA4c
   F/YxtFxLERbl6nBbKKeQ6UL54t1eW7I0YzRtUUjqNScDnkgQVwUxHGobh
   d0DSIBIg1UQS4iOvJ9NxSdz/1qcmzTda9cOFMmXUn0yQ0QACLuKK3x15E
   vS7f4Ci37PacAvT3FZ4dre+9o+om2BfwxbmdN3uI94niu48pDFsU2Kzh9
   XpomAifLf190rglLpW2zYrVZjgKwu42zrldmQKxqauR6WCFXXpX33ZcKz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375892105"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="375892105"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002934887"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1002934887"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2023 06:31:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 409A7BF; Mon, 16 Oct 2023 16:31:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [resend, PATCH v1 1/3] parport: Use kasprintf() instead of fixed buffer formatting
Date:   Mon, 16 Oct 2023 16:31:33 +0300
Message-Id: <20231016133135.1203643-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
References: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/procfs.c | 53 +++++++---------------------------------
 drivers/parport/share.c  | 15 +++++-------
 include/linux/parport.h  |  2 --
 3 files changed, 15 insertions(+), 55 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 532d5cbbd344..bd388560ed59 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -32,13 +32,6 @@
 #define PARPORT_MAX_TIMESLICE_VALUE ((unsigned long) HZ)
 #define PARPORT_MIN_SPINTIME_VALUE 1
 #define PARPORT_MAX_SPINTIME_VALUE 1000
-/*
- * PARPORT_BASE_* is the size of the known parts of the sysctl path
- * in dev/partport/%s/devices/%s. "dev/parport/"(12), "/devices/"(9
- * and null char(1).
- */
-#define PARPORT_BASE_PATH_SIZE 13
-#define PARPORT_BASE_DEVICES_PATH_SIZE 22
 
 static int do_active_device(struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
@@ -423,8 +416,7 @@ int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
 	char *tmp_dir_path;
-	size_t tmp_path_len, port_name_len;
-	int bytes_written, i, err = 0;
+	int i, err = 0;
 
 	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
@@ -440,35 +432,23 @@ int parport_proc_register(struct parport *port)
 #endif /* IEEE 1284 support */
 	}
 
-	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
-	/*
-	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PORT/devices.
-	 * We calculate for the second as that will give us enough for the first.
-	 */
-	tmp_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
-	tmp_dir_path = kzalloc(tmp_path_len, GFP_KERNEL);
+	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s/devices", port->name);
 	if (!tmp_dir_path) {
 		err = -ENOMEM;
 		goto exit_free_t;
 	}
 
-	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
-				 "dev/parport/%s/devices", port->name);
-	if (tmp_path_len <= bytes_written) {
-		err = -ENOENT;
-		goto exit_free_tmp_dir_path;
-	}
 	t->devices_header = register_sysctl(tmp_dir_path, t->device_dir);
 	if (t->devices_header == NULL) {
 		err = -ENOENT;
 		goto  exit_free_tmp_dir_path;
 	}
 
-	tmp_path_len = PARPORT_BASE_PATH_SIZE + port_name_len;
-	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
-				 "dev/parport/%s", port->name);
-	if (tmp_path_len <= bytes_written) {
-		err = -ENOENT;
+	kfree(tmp_dir_path);
+
+	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s", port->name);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
 		goto unregister_devices_h;
 	}
 
@@ -508,34 +488,22 @@ int parport_proc_unregister(struct parport *port)
 
 int parport_device_proc_register(struct pardevice *device)
 {
-	int bytes_written, err = 0;
 	struct parport_device_sysctl_table *t;
 	struct parport * port = device->port;
-	size_t port_name_len, device_name_len, tmp_dir_path_len;
 	char *tmp_dir_path;
+	int err = 0;
 	
 	t = kmemdup(&parport_device_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
 		return -ENOMEM;
 
-	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
-	device_name_len = strnlen(device->name, PATH_MAX);
-
 	/* Allocate a buffer for two paths: dev/parport/PORT/devices/DEVICE. */
-	tmp_dir_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len + device_name_len;
-	tmp_dir_path = kzalloc(tmp_dir_path_len, GFP_KERNEL);
+	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s/devices/%s", port->name, device->name);
 	if (!tmp_dir_path) {
 		err = -ENOMEM;
 		goto exit_free_t;
 	}
 
-	bytes_written = snprintf(tmp_dir_path, tmp_dir_path_len, "dev/parport/%s/devices/%s",
-				 port->name, device->name);
-	if (tmp_dir_path_len <= bytes_written) {
-		err = -ENOENT;
-		goto exit_free_path;
-	}
-
 	t->vars[0].data = &device->timeslice;
 
 	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
@@ -548,9 +516,6 @@ int parport_device_proc_register(struct pardevice *device)
 	kfree(tmp_dir_path);
 	return 0;
 
-exit_free_path:
-	kfree(tmp_dir_path);
-
 exit_free_t:
 	kfree(t);
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 2d46b1d4fd69..8037bcd07bcf 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -438,7 +438,6 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	struct parport *tmp;
 	int num;
 	int device;
-	char *name;
 	int ret;
 
 	tmp = kzalloc(sizeof(struct parport), GFP_KERNEL);
@@ -467,11 +466,6 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	atomic_set(&tmp->ref_count, 1);
 	INIT_LIST_HEAD(&tmp->full_list);
 
-	name = kmalloc(PARPORT_NAME_MAX_LEN, GFP_KERNEL);
-	if (!name) {
-		kfree(tmp);
-		return NULL;
-	}
 	/* Search for the lowest free parport number. */
 
 	spin_lock(&full_list_lock);
@@ -487,11 +481,14 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	/*
 	 * Now that the portnum is known finish doing the Init.
 	 */
-	sprintf(name, "parport%d", tmp->portnum = tmp->number);
-	tmp->name = name;
+	tmp->name = kasprintf(GFP_KERNEL, "parport%d", tmp->portnum);
+	if (!tmp->name) {
+		kfree(tmp);
+		return NULL;
+	}
+	dev_set_name(&tmp->bus_dev, tmp->name);
 	tmp->bus_dev.bus = &parport_bus_type;
 	tmp->bus_dev.release = free_port;
-	dev_set_name(&tmp->bus_dev, name);
 	tmp->bus_dev.type = &parport_device_type;
 
 	for (device = 0; device < 5; device++)
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 999eddd619b7..fff39bc30629 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -180,8 +180,6 @@ struct ieee1284_info {
 	struct semaphore irq;
 };
 
-#define PARPORT_NAME_MAX_LEN 15
-
 /* A parallel port */
 struct parport {
 	unsigned long base;	/* base address */
-- 
2.40.0.1.gaa8946217a0b

