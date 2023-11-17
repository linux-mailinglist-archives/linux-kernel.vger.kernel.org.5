Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373847EF65C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbjKQQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346122AbjKQQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:39:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E341D50
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700239193; x=1731775193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JasvbIs1uMFFus2bJjh62TF9c26P45idXBsuIb9qiJY=;
  b=bGRx4AXO3yurptGcWbqxI6/S60zpPTemPmG62YiWMV4J+HOD7ssZGcJz
   a4TQGQIffCcuDvNZByhDxh3VwD5KrQFtQmYPmsQNO6wz54AQySYv8pPcs
   Dd1AKWJu6ZWKgOeiOFQ3XkGBpmOwub51/ZDzRnwLE8+pT4yVhKlMtUN1x
   96t9ZTtj7MNYnDPySQKRCmFAj2P+FqBYgNsXlUASunYhZ0Q3wEPvH7Pz3
   SQj62S0D439kwVCfYb84mGN3RMl94Nt0vohQBSeX+7xdGW98sRUthWzna
   GshhfgYIPVgbnpykTmI2FoMocrujWJLaaR9aLOmrOQPWXAN4kafbprm/t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390185897"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390185897"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 08:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097146214"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097146214"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 08:39:50 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH V2 5/5] perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge
Date:   Fri, 17 Nov 2023 08:39:39 -0800
Message-Id: <20231117163939.2468007-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231117163939.2468007-1-kan.liang@linux.intel.com>
References: <20231117163939.2468007-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The same as Granite Rapids, the Sierra Forest and Grand Ridge also
supports the discovery table feature and the same type of the uncore
units. The difference of the available units and counters can be
retrieved from the discovery table automatically.
Just add the CPU model ID.

Tested-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Add Tested-by tag

 arch/x86/events/intel/uncore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7fb1c54c9879..7927c0b832fa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1877,6 +1877,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&gnr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&gnr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
-- 
2.35.1

