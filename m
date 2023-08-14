Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE077BABC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHNN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjHNN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:56:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5810F0;
        Mon, 14 Aug 2023 06:56:27 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPbVQ0btrzTmrQ;
        Mon, 14 Aug 2023 21:54:22 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 21:56:24 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <hdegoede@redhat.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPI: Remove unused declarations
Date:   Mon, 14 Aug 2023 21:56:23 +0800
Message-ID: <20230814135623.23084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_create_dir()/acpi_remove_dir() are never implemented since
the beginning of git history.
Commit f8d31489629c ("ACPICA: Debugger: Convert some mechanisms to OSPM specific")
declared but never implemented acpi_run_debugger().
Commit 781d737c7466 ("ACPI: Drop power resources driver")
removed acpi_power_init() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/acpi/internal.h | 1 -
 include/acpi/acpi_bus.h | 2 --
 include/acpi/acpixf.h   | 2 --
 3 files changed, 5 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 5f5c3a159872..866c7c4ed233 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -123,7 +123,6 @@ int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
-int acpi_power_init(void);
 void acpi_power_resources_list_free(struct list_head *list);
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 23fbe4a16972..18203ee9096d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -569,8 +569,6 @@ int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
 void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
 		       char *modalias, size_t len);
-int acpi_create_dir(struct acpi_device *);
-void acpi_remove_dir(struct acpi_device *);
 
 static inline bool acpi_device_enumerated(struct acpi_device *adev)
 {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0c1b69ad95d0..3d90716f9522 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -970,8 +970,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					       void **data,
 					       void (*callback)(void *)))
 
-void acpi_run_debugger(char *batch_buffer);
-
 void acpi_set_debugger_thread_id(acpi_thread_id thread_id);
 
 #endif				/* __ACXFACE_H__ */
-- 
2.34.1

