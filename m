Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD297D212C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjJVFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVFxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 01:53:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C44CC;
        Sat, 21 Oct 2023 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697954004; x=1729490004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/QZoRJe08f8RU60jeWxeNdjpSy9+XWvu0aStnMl+Gkc=;
  b=OP+lcVhELgPjh13t6HyLgiwLGDpquc10LXEYMRlnOvEYcZYq9AWoVlfe
   5b+4aepnl0+g97QlM9igKwtMxvNCJ/qGrGkpWQ+NI9wuoNOkyeNeLupvU
   fZ+mfe0ozzYInmZRyki6BNKlDbnUlTA+WP0SMZ4DtMlLgX5wiJNfV6xEv
   EYJdL9/bYwiBi8E3x4nfUD57zd23DxxIkGEUb62jgOv18RbEfOj7ZaWEg
   NwVOmPHwp66za/AHEhmXR1P7TCCBuM1fHynjRM9aapDFV0MAIOOSaPVyz
   wAwoqSCho2DxBuT//PeTzbFEihqzTSaUYvpFR3BmzAYvUkgL6YI2AuO37
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="8242360"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="8242360"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 22:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="874341289"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="874341289"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2023 22:53:22 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Subject: [RFC PATCH] tools/power turbostat: Do not print negative LPI residency
Date:   Sun, 22 Oct 2023 13:52:21 +0800
Message-Id: <20231022055221.569634-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

turbostat prints the abnormal SYS%LPI across suspend-to-idle:
SYS%LPI = 114479815993277.50

This is reproduced by:
Run a freeze cycle, e.g. "sleepgraph -m freeze -rtcwake 15".
Then do a reboot. After boot up, launch the suspend-idle-idle
and check the SYS%LPI field.

The slp_so residence counter is in LPIT table, and BIOS does not
clears this register across reset. The PMC expects the OS to calculate
the LPI residency based on the delta. However, there is an firmware
issue that the LPIT gets cleared to 0 during the second suspend
to idle after the reboot, which brings negative delta value.

Prints a simple 0 to indicate this error to not confuse the user.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9a10512e3407..3fa5f9a0218a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1472,8 +1472,16 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->pc8 = new->pc8 - old->pc8;
 	old->pc9 = new->pc9 - old->pc9;
 	old->pc10 = new->pc10 - old->pc10;
-	old->cpu_lpi = new->cpu_lpi - old->cpu_lpi;
-	old->sys_lpi = new->sys_lpi - old->sys_lpi;
+	if (new->cpu_lpi > old->cpu_lpi) {
+		old->cpu_lpi = new->cpu_lpi - old->cpu_lpi;
+	} else {
+		old->cpu_lpi = 0;
+	}
+	if (new->sys_lpi > old->sys_lpi) {
+		old->sys_lpi = new->sys_lpi - old->sys_lpi;
+	} else {
+		old->sys_lpi = 0;
+	}
 	old->pkg_temp_c = new->pkg_temp_c;
 
 	/* flag an error when rc6 counter resets/wraps */
-- 
2.25.1

