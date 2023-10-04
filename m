Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494F17B8AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbjJDSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbjJDSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:38:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FBAC4;
        Wed,  4 Oct 2023 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444675; x=1727980675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TTblblbDN1W4j6G8QhSl9EaeyJL5JAlnQkhiVd7lKhg=;
  b=UzDUs+k7BYSIixCDq+Jf4CpG9tWsxoFEm5r4/SOAoqKkem3IcM2k7OFf
   gjR/dzDoLoATiQFyliQhuD2vFE/xjnoAR4TxGALznyWCvgElTyXb1o0HJ
   AL0ZnxsXvKDe3O3rLasjPu3LdYIJeguzA+I7HwvHMkWEiEJHLVZGolzo9
   YBdSdJ9H7HSndOyIQIeNCd+zvjJSjwM6E3GrfXxa7/Gq2oLxpdJTVDGaZ
   KSz1lkM5P/RnvHZTjlUSWtnMPKQtpaZAuOKkaOgLTkyq96D3Ez71CGPd1
   2guY6GzF/KvV3k2e8Bn8joQLnooyJ2zYGima8VUIx/G8GSzZiutEbO4lz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387133505"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387133505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701236050"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701236050"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:32 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 0/3] Handle corrected machine check interrupt storms
Date:   Wed,  4 Oct 2023 11:36:20 -0700
Message-ID: <20231004183623.17067-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929181626.210782-1-tony.luck@intel.com>
References: <20230929181626.210782-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux CMCI storm mitigation is a big hammer that just disables the CMCI
interrupt globally and switches to polling all banks.

There are two problems with this:
1) It really is a big hammer. It means that errors reported in other
banks from different functional units are all subject to the same
polling delay before being processed.
2) Intel systems signal some uncorrected errors using CMCI (e.g.
memory controller patrol scrub on Icelake Xeon and newer). Delaying
processing these error reports negates some of the benefit of the patrol
scrubber providing early notice of errors before they are consumed and
cause a machine check.

This series throws away the old storm implementation and replaces it
with one that keeps track of the weather on each separate machine check
bank. When a storm is detected from a bank. On Intel the storm is
mitigated by setting a very high threshold for corrected errors to
signal CMCI. This threshold does not affect signaling CMCI for
uncorrected errors.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v8:

Fixed issue reported by lkp with randconfig build with neither
CONFIG_X86_MCE_INTEL not CONFIG_X86_MCE_AMD set by making a
cleaner division between the storm tracking code in threshold.c
with the restof the code using more function accessors that can
be stubbed out.

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation
  x86/mce: Handle Intel threshold interrupt storms

 arch/x86/kernel/cpu/mce/internal.h  |  48 ++++-
 arch/x86/kernel/cpu/mce/core.c      |  45 ++---
 arch/x86/kernel/cpu/mce/intel.c     | 303 ++++++++++++----------------
 arch/x86/kernel/cpu/mce/threshold.c | 115 +++++++++++
 4 files changed, 304 insertions(+), 207 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.41.0

