Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE74786F53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjHXMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbjHXMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:41:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38415170C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880899; x=1724416899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V2Qi3HynsFYuFtwYDS/n5b/APFqDC8AVlZGUMZGGet8=;
  b=SZMEhIguSq0v9DAk2ZDEZG4TD6SUZQc2Rj3/EtYRKWdWNBE3ZM/eu2eO
   YsvGKu+eKRkE7wCeiDkFHwq+Mr4rFoiY3GgQzRVN7ksFpp+SOf47PZxaS
   VIHvDq3toqX6+4WKKUtDFdWoAWIrkp0I/jkxJ/1GhGlTfPFs6blkUbN79
   FU5jqPBXivxq216pkM47Z/wPFPhr0xXUCP05cS7MmVrsoT1RQi6WybEPr
   kQ8uJXtPpOjm8o+DxxnkIA5onBAXJR4dIFme4ArSHJSUDg/cxjkhi54US
   9ou9CAqEHv1Svftk2NuwMe/GNHuoj2YRoT4ZERIn0BNAycO9L8Z8W1Brz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460783942"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460783942"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740161412"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740161412"
Received: from mdziurdx-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.11.127])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:37 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH 1/3] selftests/resctrl: Fix schemata write error check
Date:   Thu, 24 Aug 2023 14:41:24 +0200
Message-ID: <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
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

Writing bitmasks to the schemata can fail when the bitmask doesn't
adhere to some constraints defined by what a particular CPU supports.
Some example of constraints are max length or being having contiguous
bits. The driver should properly return errors when any rule concerning
bitmask format is broken.

Resctrl FS returns error codes from fprintf() only when fclose() is
called. Current error checking scheme allows invalid bitmasks to be
written into schemata file and the selftest doesn't notice because the
fclose() error code isn't checked.

Add error check to the fclose() call.

Add perror() just after fprintf so a proper error message can be seen.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..a6d0b632cbc6 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -532,13 +532,17 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	}
 
 	if (fprintf(fp, "%s\n", schema) < 0) {
-		sprintf(reason, "Failed to write schemata in control group");
+		sprintf(reason, "fprintf() failed with error : %s",
+			strerror(errno));
 		fclose(fp);
 		ret = -1;
 
 		goto out;
 	}
-	fclose(fp);
+	ret = fclose(fp);
+	if (ret)
+		sprintf(reason, "Failed to write schemata in control group : %s",
+			strerror(errno));
 
 out:
 	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
-- 
2.42.0

