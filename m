Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FA7BAAD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjJET4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJETzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:55:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F50E8;
        Thu,  5 Oct 2023 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696535749; x=1728071749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMn5zpNP8+ffHcP9eBj+rXkV8aG9ATI7kUf+LVAcPHo=;
  b=fd42rx4u0SehggpgZ+MxmRhqMCWlJkvoPkJzReImALVsTcF5PnQIjOym
   fw+LZb5DLIgS3Sj+FszX+j3StV73Wsq+DSPR9j1m9NZsFPT1ObhK4s4mz
   Gv4JEG40ARlGDnPUOvO+nx6zUHVwyt4Cbp8akvsILE0FVW/83MF9pg8/Z
   ObzeNFs1zzY+2qIBkJBW82zLIfS+tq/d35fTAI3ni3+4Ls9JnaglNZHqN
   zxQJQfLbhcI2wL4lGyGI1ytZcIZ8LdyBB0RI3xXVT8xQLrZkU+zb7pSkh
   bPUPIPFAoUgX9/k8H1wi8EdLrR3Ls8ZDlBGxohvjUXPrv9oSQ8n0nF5la
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386432585"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386432585"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755600134"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755600134"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:44 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH v4 6/9] platform/x86/intel/ifs: Metadata validation for start_chunk
Date:   Thu,  5 Oct 2023 12:51:34 -0700
Message-Id: <20231005195137.3117166-7-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005195137.3117166-1-jithu.joseph@intel.com>
References: <20230929202436.2850388-1-jithu.joseph@intel.com>
 <20231005195137.3117166-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional check to validate IFS image metadata field prior to
loading the test image.

If start_chunk is not a multiple of chunks_per_stride error out.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 582f1801aaaa..959b1878cae6 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -291,6 +291,13 @@ static int validate_ifs_metadata(struct device *dev)
 		return ret;
 	}
 
+	if (ifs_meta->chunks_per_stride &&
+	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride != 0)) {
+		dev_warn(dev, "Starting chunk num %u not a multiple of chunks_per_stride %u\n",
+			 ifs_meta->starting_chunk, ifs_meta->chunks_per_stride);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

