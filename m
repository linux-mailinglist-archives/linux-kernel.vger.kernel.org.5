Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB07B2EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjI2JCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjI2JCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:02:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B01A5;
        Fri, 29 Sep 2023 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695978133; x=1727514133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7N3r11ZPTiRU3UdIEyXIXr+ZZSWSJgkPRmWmAkiOUU=;
  b=NfOyZGW2ceHF00MLL22uhypzotO0ZRG2qDkPaEIH6APwgdZJmRxCOCSY
   M2sIRRF5KQQoRa+pWnewvn5QV2wGdn5/P6x/PsBAGFssmHAaPOvNRCZVW
   kb6P35dVEpGZDCJ+3USDRxdOcOeZ4a12lhHs2XJR1GUXIimrJAq1m6TMC
   P+fPvog0Q0lA6qG7ae/cAH15soTKuCvhQHoDc/5AxQD2wlqpYucJs8mzZ
   b99srpZyes6DKpmOQ5PGWKu0f+qqNSI4TtvGTtdqnvm7Th/EN3F+bxtw2
   C25n6KvrltkRBl6WT9oohA26L2i0S6UJ2Gu7l6PsJNq7nWcGeycS02kXM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="385078451"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="385078451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749904385"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="749904385"
Received: from tzebrows-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.26.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:02:08 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Date:   Fri, 29 Sep 2023 11:00:24 +0200
Message-ID: <cover.1695977733.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until recently Intel CPUs didn't support using non-contiguous 1s
in Cache Allocation Technology (CAT). Writing a bitmask with
non-contiguous 1s to the resctrl schemata file would fail.

Intel CPUs that support non-contiguous 1s can be identified through a
CPUID leaf mentioned in the "Intel® 64 and IA-32 Architectures
Software Developer’s Manual" document available at:
https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html

Add kernel support for detecting if non-contiguous 1s in Cache
Allocation Technology (CAT) are supported by the hardware. Also add a
new resctrl FS file to output this information to the userspace.
Keep the hardcoded value for Haswell CPUs only since they do not have
CPUID enumeration support for Cache allocation.

Since the selftests/resctrl files are going through many rewrites and
cleanups the appropriate selftest is still a work in progress. For
basic selftesting capabilities use the bash script attached below this
paragraph. It checks whether various bitmasks written into resctrl FS
generate output consistent with reported feature support.

Changelog v3:
- Add Peter's tested-by and reviewed-by tags.
- Change patch order to make 4th one the 1st.
- Add error checking to schema_len variable.
- Update cover letter since now the feature has moved from the SDM.

Changelog v2:
- Change git signature from Wieczor-Retman Maciej to Maciej
  Wieczor-Retman.
- Change bitmap naming convention to bit mask.
- Add patch to change arch_has_sparce_bitmaps name to match bitmask
  naming convention.

Fenghua Yu (2):
  x86/resctrl: Add sparse_masks file in info
  Documentation/x86: Document resctrl's new sparse_masks

Maciej Wieczor-Retman (2):
  x86/resctrl: Rename arch_has_sparse_bitmaps
  x86/resctrl: Enable non-contiguous CBMs in Intel CAT

 Documentation/arch/x86/resctrl.rst        | 16 ++++++++++++----
 arch/x86/kernel/cpu/resctrl/core.c        | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 14 ++++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 ++++++++++++++++++
 include/linux/resctrl.h                   |  4 ++--
 6 files changed, 56 insertions(+), 16 deletions(-)


base-commit: 27bbf45eae9ca98877a2d52a92a188147cd61b07
-- 
2.42.0

