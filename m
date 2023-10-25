Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACE7D69E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbjJYLSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJYLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:18:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EE18E;
        Wed, 25 Oct 2023 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232718; x=1729768718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxS//e/ZqjIB0NhbIBluRHpqaStKqMVqrAs7nUrO30A=;
  b=eh9Gv0dTUI1E0jFNHkSYABwrN+ihY+6BYLLbG5iBBlZwxgJTt1ST2VuX
   Q2J2j5uLjkwfuhj/ewWJMPu03pgshcH6ozOb2FCxXwnk0Z4yHQYBW1+pe
   UFmwrpicpCe9CqyV2zbjzlDbCJX8RSWMrgJeUMfN8vyX4xA/1RPVbT1pl
   Gt87B8Amnf7ZYt+oUPFS9sPS+7rX8fGukFfNJESG1Cm+Za4vfkx5cLO1w
   QIcgKGaepK+J/OBwJPJYj2UEjfggL6qDy5LI+IJYw/LsAkeFL7QaCMib/
   5t/dOYdtdif0BYkfABZMDBecNHUj2hAuXvAP73jATyhs0RXmSWfNZSLRK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154641"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154641"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425139"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425139"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 6/6] ACPI: acpi_video: Fix holes in acpi_video_bus
Date:   Wed, 25 Oct 2023 14:18:06 +0300
Message-ID: <20231025111806.2416524-7-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As identified by 'pahole' utility there are holes in acpi_video_bus
struct. Rearrange elements to get rid of the holes. Put elements
biggest in size first, and one-byte elements later.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bfc7f51a527d..1e10d5b748b2 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -155,19 +155,19 @@ struct acpi_video_enumerated_device {
 
 struct acpi_video_bus {
 	struct acpi_device *device;
+	struct acpi_video_enumerated_device *attached_array;
+	struct list_head video_device_list;
+	struct mutex device_list_lock;	/* protects video_device_list */
+	struct list_head entry;
+	struct input_dev *input;
+	struct notifier_block pm_nb;
 	bool backlight_registered;
 	u8 dos_setting;
-	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
 	u8 child_count;
 	struct acpi_video_bus_cap cap;
 	struct acpi_video_bus_flags flags;
-	struct list_head video_device_list;
-	struct mutex device_list_lock;	/* protects video_device_list */
-	struct list_head entry;
-	struct input_dev *input;
 	char phys[32];	/* for input device */
-	struct notifier_block pm_nb;
 };
 
 struct acpi_video_device_flags {
-- 
2.41.0

