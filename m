Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5D7B3B08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjI2UN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjI2UNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:13:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C3B4;
        Fri, 29 Sep 2023 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018433; x=1727554433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LL2R/Qj7+7DI4JYYiF7vTxrwve3KWjISLiHeljiFl0I=;
  b=evKCtbmhka26CSAh/kyDkaCLk0SbJ4lQKNJzJmrujZJTB78P4fBNDZbL
   WplZgR7i4lUnc9rJYfQpxhx1ENdWyLbd6lxQzaMpUQkPbZIsomX28Jxy7
   FemCMVvKf71/F7gOiZG+dcERsuU/ZFaV2g2JX918JX2+8sOYbNVSUPUkM
   yxfeQIn2lgkuAW+NsUR9P96Ue6b+UQIc0wvr8Knk+PLKhkB6zTnJaK3Qd
   kSz34+J+zBGW/CijZknBOY7ecl0ENGDNT4VRTYAOG2Bjl3EAvOB5dLSoX
   ennUWBJur8LWq/eb680PXyumVMQDxQrLP3EZ1MGny9KCoQPN2kl3ghop5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362604234"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="362604234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="921793"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:16:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 0/3] Handle corrected machine check interrupt storms
Date:   Fri, 29 Sep 2023 11:16:23 -0700
Message-ID: <20230929181626.210782-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210813.291190-1-tony.luck@intel.com>
References: <20230718210813.291190-1-tony.luck@intel.com>
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

Changes since v7:

Applied all the suggestions from Yazen's review of v7

Link: https://lore.kernel.org/all/c76723df-f2f1-4888-9e05-61917145503c@amd.com/
Link: https://lore.kernel.org/all/6ae4df67-ba0b-4b50-8c1d-a5d382105ad2@amd.com/

Including placing most of the storm tracking code into threshold.c
instead of bloating core.c.

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation
  x86/mce: Handle Intel threshold interrupt storms

 arch/x86/kernel/cpu/mce/internal.h  |  47 +++-
 arch/x86/kernel/cpu/mce/core.c      |  45 ++--
 arch/x86/kernel/cpu/mce/intel.c     | 338 ++++++++++++----------------
 arch/x86/kernel/cpu/mce/threshold.c |  86 +++++++
 4 files changed, 293 insertions(+), 223 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.41.0

