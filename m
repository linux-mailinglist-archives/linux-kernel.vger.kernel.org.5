Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C17B8C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbjJDTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbjJDTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F135A6;
        Wed,  4 Oct 2023 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696446254; x=1727982254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rEhsAdm4qprufCY9YFBrMJoK6i9PZwnuJiNdBtxSWU=;
  b=m67+ql9A/+xqQEzFpZDrCpdf4eH0sSSFaCVTWu1G4V5Yp/wU93QemSmA
   g5DE9DglETUMPHLkQJypQt9he8rQHFCXKm07gloInEZWUinsHnbhGr3hG
   A/DXWwtJ/E/37je1ALV2iXv8wqVMo8dFijtVAvEJyiJbUo9E5azlKHNb4
   P4W/AgQGd4GF3tae/mktarsJcKsHC6zzemEkhUWMS9EoOZcPz3iYFsAlP
   VE+n0LgN0uOr1pjTi9noODT3epuzI3B6TCsI8TpJ9ZNVSIckmRlylnjqt
   EHaR98ctJuvBaDtnhA80viMMmFvU8kgXFUWphRi6Aq7cWQoMfjemfu3A6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="4838619"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="4838619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 12:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745098524"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="745098524"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 12:04:12 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 6/9] platform/x86/intel/ifs: Metadata validation for start_chunk
Date:   Wed,  4 Oct 2023 12:00:09 -0700
Message-Id: <20231004190009.3028495-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e8bcbdcc-8cba-57ec-b0fc-4d66305d5aed@linux.intel.com>
References: <e8bcbdcc-8cba-57ec-b0fc-4d66305d5aed@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 - changed the dev_warn printk format specifiers (Ilpo Järvinen)

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

