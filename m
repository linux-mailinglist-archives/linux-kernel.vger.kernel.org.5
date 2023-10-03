Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4B7B714F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbjJCSt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjJCStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:49:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E95AF;
        Tue,  3 Oct 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358962; x=1727894962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gtDwlyRMPjMakfQV2TP11BN397Sa0+Y1SbuUIeH4uU=;
  b=moA2ZdPk44tAsFaud9YeIVkK7VTtg+0EK3FJaWGXREepsuAA8vi5b1yL
   rdBtnIVvdvxpcMUcOuBgf8a39mBd3le/8bmIs5y3hvDQnYwduxwT3MQzq
   ywm79nTv7XI2qwJsG/AGomDmrXLptNEYwDNuV98no+NTFRwS5C/m14LC7
   KxF4ZiS8lSB063ey3vIMrG/TRRy3kdiTist/eGpcXyxs04+Z5qCZF6o+Y
   B7x6u7uQDSYpWkwgBlcwVuMSmEJrsqnqCyK9DluvKrTCQIFAoBTI/DfFx
   usK46W1rMczTuLUy5IIwEvHRAkppGJqzErDgWzhRfZNVOT5qD2PVwBevs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363221953"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363221953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700814541"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700814541"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2023 11:49:20 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] platform/x86/intel/tpmi: Add defines to get version information
Date:   Tue,  3 Oct 2023 11:49:14 -0700
Message-Id: <20231003184916.1860084-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines to get major and minor version from a TPMI version field
value. This will avoid code duplication to convert in every feature
driver. Also add define for invalid version field.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
No change

 include/linux/intel_tpmi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 04d937ad4dc4..ee07393445f9 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -6,6 +6,12 @@
 #ifndef _INTEL_TPMI_H_
 #define _INTEL_TPMI_H_
 
+#include <linux/bitfield.h>
+
+#define TPMI_VERSION_INVALID	0xff
+#define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
+#define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)
+
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
  * @package_id:	CPU Package id
-- 
2.41.0

