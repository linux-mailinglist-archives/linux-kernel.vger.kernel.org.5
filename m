Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108CD79D634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbjILQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjILQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:26:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2144F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694535976; x=1726071976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ltZ1RAODhf+ZyZGueAkDu0r0heKXiDqd7lSxiNg+s0=;
  b=M+qpAvvBQAnlVmGZECc6WAPa0tBdfmhjMXsVmwgwSZH/WBX19Qi/TDQl
   sru8ZW0bHEwAhclSkHzddNiCrPWwlWcRWQuXu/208TXYR6sjLMadli1KD
   +kicjMCJKPsLQPcOWasiN5e7IVdMCedqv9IdwF+dsXbFJnfsE2oTPc+56
   1pKsgZkwl94/H2dk3QzonvUMmOiQQsjQ7ewIzEWxaEXsxhuZaifktj4wT
   4H0v5LSRBfHfMgbnOePcljOUVZQVnZZZ6Q1KswjRekqohJ1pNfxd1Q6Ib
   GI3BuzFfhMtmxrkz544GIRXKiIo9ub+cCb4/absuq2pTZIcI9zgLaNwnh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357860025"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357860025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737173950"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737173950"
Received: from zmoussao-mobl1.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.37.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:26:13 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     tiwai@suse.com, perex@perex.cz, arnd@arndb.de
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ALSA: hda: intel-sdw-acpi: Use u8 type for link index
Date:   Tue, 12 Sep 2023 19:26:17 +0300
Message-ID: <20230912162617.29178-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use consistently u8 for sdw link index. The id is limited to 4, u8 is
adequate in size to store it.

This change will also fixes the following compiler warning/error (W=1):

sound/hda/intel-sdw-acpi.c: In function ‘sdw_intel_acpi_scan’:
sound/hda/intel-sdw-acpi.c:34:35: error: ‘-subproperties’ directive output may be truncated writing 14 bytes into a region of size between 7 and 17 [-Werror=format-truncation=]
   34 |                  "mipi-sdw-link-%d-subproperties", i);
      |                                   ^~~~~~~~~~~~~~
In function ‘is_link_enabled’,
    inlined from ‘sdw_intel_scan_controller’ at sound/hda/intel-sdw-acpi.c:106:8,
    inlined from ‘sdw_intel_acpi_scan’ at sound/hda/intel-sdw-acpi.c:180:9:
sound/hda/intel-sdw-acpi.c:33:9: note: ‘snprintf’ output between 30 and 40 bytes into a destination of size 32
   33 |         snprintf(name, sizeof(name),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   34 |                  "mipi-sdw-link-%d-subproperties", i);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The warnings got brought to light by a recent patch upstream:
commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/hda/intel-sdw-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index 5cb92f7ccbca..b57d72ea4503 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -23,7 +23,7 @@ static int ctrl_link_mask;
 module_param_named(sdw_link_mask, ctrl_link_mask, int, 0444);
 MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
 
-static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
+static bool is_link_enabled(struct fwnode_handle *fw_node, u8 idx)
 {
 	struct fwnode_handle *link;
 	char name[32];
@@ -31,7 +31,7 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-		 "mipi-sdw-link-%d-subproperties", i);
+		 "mipi-sdw-link-%hhu-subproperties", idx);
 
 	link = fwnode_get_named_child_node(fw_node, name);
 	if (!link)
@@ -51,8 +51,8 @@ static int
 sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(info->handle);
-	int ret, i;
-	u8 count;
+	u8 count, i;
+	int ret;
 
 	if (!adev)
 		return -EINVAL;
-- 
2.42.0

