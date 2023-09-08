Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18F799113
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbjIHUi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjIHUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:38:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519569C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694205481; x=1725741481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=czKC5dxGaaT5mVC4zBQrCY8qxocjuzVj27OScS55AaE=;
  b=YfoZVLv/Kp6YvdiKVK2EVOjlTMPrsIVq/DrbRViqNIM4vlSt6qcoS09A
   CUDM0EcdTNDuPsPyd4YDhX6zAqmY/eo9jmkEakh1qAS5clxi4Wr3jJLxs
   IGujtF/vsDv+Ju0KGP+Y59iGxl7TIaIHUPPm7PAmzzvqdEPyHwBB+vBkG
   D5DRecnYHYSLPKwCTYLvzgDh0DOrvqymtLHY83NdV3sMtWRV/X0GVM+yW
   fEaI/JDQWNnfqTzXJKCUPY24DVLyXyjh2IegjjRHTWYJ/ELIj4DFOdwc+
   mDprKc20G5yXnyahdzV8v6dWQgCFnTGPI9lcqrVm4QJKcKoYbN/sdh/aG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376650572"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376650572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832781664"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832781664"
Received: from imilose-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.14.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:18 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, hjl.tools@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 0/3] Fix shadow stack issues in clone error handling
Date:   Fri,  8 Sep 2023 13:36:52 -0700
Message-Id: <20230908203655.543765-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
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

HJ reported a crash when running a new glibc test added two weeks ago, 
with his (out of tree) rebased glibc shadow stack patches on top. The 
issue turned out to be a bug in shadow stack clone error handling. The new 
test exercises clone(CLONE_PIDFD|CLONE_VFORK) with the fd limit exhausted, 
which causes the clone to fail after the shadow stack handling. A failure 
at that point will normally try to clean up the shadow stack that it 
allocated before returning the error to userspace. But for vfork, it 
should not do this as nothing was allocated and the thread's shadow stack 
is the parent's shadow stack too. The logic for not unmapping the thread's 
shadow stack for CLONE_VFORK children works in the normal (exec() or 
exit()) case, but is buggy in the clone failure case. So on clone failure 
with those particular args, the parent will end up with a missing shadow 
stack.

When working on the solution I did a review of the surrounding logic and 
found another more minor issue.

Patch 1 is the bug fix for the main issue, and 2 is the other issue. Patch
3 is optional and adds a new warning to catch the issue in patch 2.

Rick Edgecombe (3):
  x86/shstk: Handle vfork clone failure correctly
  x86/shstk: Remove useless clone error handling
  x86/shstk: Add warning for shadow stack double unmap

 arch/x86/include/asm/mmu_context.h |  3 +--
 arch/x86/kernel/process.c          |  7 -------
 arch/x86/kernel/shstk.c            | 33 ++++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.34.1

