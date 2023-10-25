Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80647D69E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJYLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjJYLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:18:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF50137;
        Wed, 25 Oct 2023 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232716; x=1729768716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GGWBLv1O7SHoGXNqpswjaidLqIzwApROs0cSW0Fp2r8=;
  b=XVnH2i6yhtAz/hY4hA0WS3OjmJbRC8Vi1L0e9WESRTIgx0xzGyvQdSdh
   ICZoR7QVgZJ6oduA7tWm0bpO4sTbbpAfBMgkSam53mK0peLfQIWRQGoLs
   iO/p6RBo/+BcI3Mi0NcR460Rm90FzkfA5vROZNb2Y3lUwFRBAt7O7JxGH
   udpKh6LqZS/++FPM9jZ8kpueie9omX0N52aLVeUeFTYWsSkBWdByDq+Hz
   QKsxaG+A604I67LIaXT918sT78A5daxmWE5GrIuH/26N5A9wV1JLFx+XD
   SlHwU92WkvO9x0PBbqlZMe8Hx8lsU+vC0jkY0RHBi19pa5FPc0UJqRroO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154628"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154628"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425103"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425103"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:22 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 3/6] ACPI: acpi_video: Remove unnecessary driver_data clear
Date:   Wed, 25 Oct 2023 14:18:03 +0300
Message-ID: <20231025111806.2416524-4-michal.wilczynski@intel.com>
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

Commit
0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add() fails")
introduced clearing driver_data every time probe fails, so it's not
necessary to clear it in the probe() callback.

Remove NULL assignment to driver_data in error path in
acpi_video_bus_add().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index e17474949bbb..0c93b0ef0feb 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2077,7 +2077,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	kfree(video->attached_array);
 err_free_video:
 	kfree(video);
-	device->driver_data = NULL;
 
 	return error;
 }
-- 
2.41.0

