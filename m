Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4014E758686
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGRVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGRVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:09:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF4EC;
        Tue, 18 Jul 2023 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714539; x=1721250539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jD0ikaOVy5BVJjtayK1+12kc2csGinS7MH/OORdIRbU=;
  b=Ta+4ekeOGc4j6LAY/vSAA8G+cW/QsDKG6zsqQ16h9GGrHcNpXVOnZkg2
   9QgEsCm5h/jdPOlzz6zSoaElZgGiU45RcXFeVlgyGi/NuT3kBFaiWnNZ7
   UWfbb4hTeDpMFmx23gyQTFWWc53Sy9Ad+nhpnpGJmsOZhqpiQFFovu5hW
   y8NQtLnX/FmQa/w+fvbDB4plCvCM0e+DRiY5XupSaz00g6Flz6IuLMu28
   C2zOr+pQzlivXyUuUwSsWQbJfZ58HUAiYBi1nGKRuM88vcn7pamUluXG5
   sKKu/r/rsKqNc72LdGZI0470paUyoyxtL7jaJVzPfQ2t0M+4JCiUmf7Ll
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369872196"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369872196"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="813897793"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="813897793"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:58 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 0/3] Handle corrected machine check interrupt storms
Date:   Tue, 18 Jul 2023 14:08:10 -0700
Message-Id: <20230718210813.291190-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616182744.17632-1-tony.luck@intel.com>
References: <20230616182744.17632-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes since last version:

0) Rebased to v6.5-rc2
1) Yazen & Boris - dropped AMD patch pending integration of AMD
   machine check bank scanning with the core machine_check_poll()
   function.
2) Boris - rename track_cmci_storm() as track_storm() in prep for
   the day when AMD joins in - they don't call the interrupt "CMCI".
   This function is now "static" and local to core.c.
3) Boris - Define new "struct storm_bank" for all the storm tracking
   arrays.
4) Move the storm_poll_mode per-CPU tracker into the storm_desc
   structure.
5) Define STORM_END_POLL_THRESHOLD as "29" instead of "30" with comment
   that it is used as high end of a bitmask that counts from zero. Drop
   the " - 1" where it is used.
6) Don't user kernel-doc format comments in mce/internal.h.

Suggested change NOT taken:
> +      * If this is the first bank on this CPU to enter storm mode
> +      * start polling
> +      */
> +     if (++storm->stormy_bank_count == 1)

        if (++storm->stormy_bank_count)

> +             mce_timer_kick(true);

As the comment above this code says, only want to "kick" the timer when
first bank on a core goes into storm mode. If another bank also goes
into storm while the first storm is active, then no need to "start
polling" that's already happening for the first storm.

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation
  x86/mce: Handle Intel threshold interrupt storms

 arch/x86/kernel/cpu/mce/internal.h |  49 ++++-
 arch/x86/kernel/cpu/mce/core.c     | 131 +++++++++---
 arch/x86/kernel/cpu/mce/intel.c    | 333 +++++++++++++----------------
 3 files changed, 290 insertions(+), 223 deletions(-)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.40.1

