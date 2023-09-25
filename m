Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1427ADA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIYOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjIYOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA61103;
        Mon, 25 Sep 2023 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653357; x=1727189357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOpMdyO7SSMZsEAVB9fj7jJCWOYh0eXeQ8klAvIERWQ=;
  b=MwJ030Bha82rB/OPDz5iQg9yN5Ub1zDpOn45B8SbyeRZc1zkgUdita0x
   40ijouFxZ0lH+2aLgShEB6NEWJ6Pekoi2d8fA5pVw+Mey6lize9ATVjFb
   B9jC/Ga1z2qIB3lER3ZhXIQdYbKKwF1sbfdxRPehzhCDxy8LUkh5ZeI72
   DRUf0CQ/s6t1arImyFh2DUgiLv+0wEn65qiMx0J59k37wPEzprJmKayTo
   KHJRf13BReubkQTTCvnU9pcGBpSBhU/QMp6rZ5K3+36ss/zKrxQHgUm2X
   V0tV0vnly6kamYadBFydq9GuqOhvVQJk4wZLD/z3VIBQabhv9eMujV55i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378547975"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378547975"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409421"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409421"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
Date:   Mon, 25 Sep 2023 17:48:34 +0300
Message-ID: <20230925144842.586829-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
are wrappers around ACPICA installers. They are meant to save some
duplicated code from drivers. However as we're moving towards drivers
operating on platform_device they become a bit inconvenient to use as
inside the driver code we mostly want to use driver data of platform
device instead of ACPI device.

Make notify handlers installer wrappers more generic, while still
saving some code that would be duplicated otherwise.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---

Notes:
    So one solution could be to just replace acpi_device with
    platform_device as an argument in those functions. However I don't
    believe this is a correct solution, as it is very often the case that
    drivers declare their own private structures which gets allocated during
    the .probe() callback, and become the heart of the driver. When drivers
    do that it makes much more sense to just pass the private structure
    to the notify handler instead of forcing user to dance with the
    platform_device or acpi_device.

 drivers/acpi/ac.c         |  6 +++---
 drivers/acpi/acpi_video.c |  6 +++---
 drivers/acpi/battery.c    |  6 +++---
 drivers/acpi/bus.c        | 14 ++++++--------
 drivers/acpi/hed.c        |  6 +++---
 drivers/acpi/nfit/core.c  |  6 +++---
 drivers/acpi/thermal.c    |  6 +++---
 include/acpi/acpi_bus.h   |  9 ++++-----
 8 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 225dc6818751..0b245f9f7ec8 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -256,8 +256,8 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
 
-	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify);
+	result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+						 acpi_ac_notify, device);
 	if (result)
 		goto err_unregister;
 
@@ -306,7 +306,7 @@ static void acpi_ac_remove(struct acpi_device *device)
 
 	ac = acpi_driver_data(device);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
 				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 948e31f7ce6e..025c17890127 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2059,8 +2059,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	acpi_video_bus_add_notify_handler(video);
 
-	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify);
+	error = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+						acpi_video_bus_notify, device);
 	if (error)
 		goto err_remove;
 
@@ -2092,7 +2092,7 @@ static void acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
 
 	mutex_lock(&video_list_lock);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 969bf81e8d54..45dae32a8646 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1213,8 +1213,8 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 1);
 
-	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify);
+	result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+						 acpi_battery_notify, device);
 	if (result)
 		goto fail_pm;
 
@@ -1241,7 +1241,7 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	battery = acpi_driver_data(device);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
 				       acpi_battery_notify);
 
 	device_init_wakeup(&device->dev, 0);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f41dda2d3493..479fe888d629 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -554,14 +554,13 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	acpi_os_wait_events_complete();
 }
 
-int acpi_dev_install_notify_handler(struct acpi_device *adev,
-				    u32 handler_type,
-				    acpi_notify_handler handler)
+int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type,
+				    acpi_notify_handler handler, void *context)
 {
 	acpi_status status;
 
-	status = acpi_install_notify_handler(adev->handle, handler_type,
-					     handler, adev);
+	status = acpi_install_notify_handler(handle, handler_type,
+					     handler, context);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -569,11 +568,10 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_install_notify_handler);
 
-void acpi_dev_remove_notify_handler(struct acpi_device *adev,
-				    u32 handler_type,
+void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type,
 				    acpi_notify_handler handler)
 {
-	acpi_remove_notify_handler(adev->handle, handler_type, handler);
+	acpi_remove_notify_handler(handle, handler_type, handler);
 	acpi_os_wait_events_complete();
 }
 EXPORT_SYMBOL_GPL(acpi_dev_remove_notify_handler);
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 46c6f8c35b43..e7e274c5cc9e 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -56,8 +56,8 @@ static int acpi_hed_add(struct acpi_device *device)
 		return -EINVAL;
 	hed_handle = device->handle;
 
-	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      acpi_hed_notify);
+	err = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					      acpi_hed_notify, device);
 	if (err)
 		hed_handle = NULL;
 
@@ -66,7 +66,7 @@ static int acpi_hed_add(struct acpi_device *device)
 
 static void acpi_hed_remove(struct acpi_device *device)
 {
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 				       acpi_hed_notify);
 	hed_handle = NULL;
 }
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f0e6738ae3c9..821870f57862 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3295,7 +3295,7 @@ static void acpi_nfit_remove_notify_handler(void *data)
 {
 	struct acpi_device *adev = data;
 
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
 				       acpi_nfit_notify);
 }
 
@@ -3390,8 +3390,8 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	if (rc)
 		return rc;
 
-	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify);
+	rc = acpi_dev_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_nfit_notify, adev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 10720a038846..0218c34c16b9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -978,8 +978,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
 
-	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						 acpi_thermal_notify);
+	result = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+						 acpi_thermal_notify, device);
 	if (result)
 		goto flush_wq;
 
@@ -1005,7 +1005,7 @@ static void acpi_thermal_remove(struct acpi_device *device)
 
 	tz = acpi_driver_data(device);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 				       acpi_thermal_notify);
 
 	flush_workqueue(acpi_thermal_pm_queue);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..95d5193f236f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -515,11 +515,10 @@ void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
 int acpi_bus_attach_private_data(acpi_handle, void *);
 void acpi_bus_detach_private_data(acpi_handle);
-int acpi_dev_install_notify_handler(struct acpi_device *adev,
-				    u32 handler_type,
-				    acpi_notify_handler handler);
-void acpi_dev_remove_notify_handler(struct acpi_device *adev,
-				    u32 handler_type,
+int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type,
+				    acpi_notify_handler handler,
+				    void *context);
+void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type,
 				    acpi_notify_handler handler);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
-- 
2.41.0

