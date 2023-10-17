Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EC7CCDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjJQUZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:25:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E0F0;
        Tue, 17 Oct 2023 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574329; x=1729110329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GidCfHFt8RPhycoP1wfXlb89hDpzBE5Ubdb1ihTFzYc=;
  b=oIiPe8O3j8PAnMJTJfNGS/VZZGuavCLCy8IrqRjMo4qbGfR81/dJoo+b
   T78DiMw6DE6fQKZT+k5QqM9gZ137zevxfFU0JFdg7RPDKrAUPHGyOpujq
   NUUCSjgnvFjzlaRefFN1cTxXXf7aDem3Cik0fZlTcbwA5yPx25asXnd91
   lDSpaHIpLJTga07S6j3OP7LM7tBszLfFycNg2N2IpEB5EwoRfVW3Tnid8
   XCI87PxH5Djwig+3Lj3NP1d31Rv1rCfsAQf+CrRAvz/1o/uERZaMdkFzr
   HlHaKZJdObF3zAswzK4Fi9xaqVjeJQy1gCyFHiFJTYICkcQRdvKG8WQbg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429472"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429472"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040430"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040430"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:24 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 00/10] Handle set_memory_XXcrypted() errors
Date:   Tue, 17 Oct 2023 13:24:55 -0700
Message-Id: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared pages should never return to the page allocator, or future usage of
the pages may allow for the contents to be exposed to the host. They may
also cause the guest to crash if the page is used in way disallowed by HW 
(i.e. for executable code or as a page table).

Normally set_memory() call failures are rare. But on TDX 
set_memory_XXcrypted() involves calls to the untrusted VMM, and an attacker
could fail these calls such that:
 1. set_memory_encrypted() returns an error and leaves the pages fully
    shared.
 2. set_memory_decrypted() returns an error, but the pages are actually
    full converted to shared.

This means that patterns like the below can cause problems:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail)
	free_pages(addr, 0);

And:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail) {
	set_memory_encrypted(addr, 1);
	free_pages(addr, 0);
}

Unfortunately these patterns are all over the place. And what the 
set_memory() callers should do in this situation is not clear either. They 
shouldn’t use them as shared because something clearly went wrong, but 
they also need to fully reset the pages to private to free them. But, the 
kernel needs the VMMs help to do this and the VMM is already being 
uncooperative around the needed operations. So this isn't guaranteed to 
succeed and the caller is kind of stuck with unusable pages.

Looking at QEMU/KVM as an example, these VMM converstion failures either 
indicates an attempt to attack the guest, or resource constraints on the 
host. Preventing a DOS attack is out of scope for the coco threat model. 
So this leaves the host resource constraint cause. When similar resource 
constraints are encountered in the host, KVM punts the problem to 
userspace and QEMU terminates the guest. When similar problems are 
detected inside set_memory(), SEV issues a command to terminate the guest. 

This all makes it appealing to simply panic (via tdx_panic() call 
which informs the host what is happening) when observing troublesome VMM 
behavior around the memory conversion. It is:
 - Consistent with similar behavior on SEV side.
 - Generally more consistent with how host resource constraints are handled
   (at least in QEMU/KVM)
 - Would be a more foolproof defense against the attack scenario.

Never-the-less, doing so would be an instance of the “crash the kernel for 
security reasons” pattern. This is a big reason, and crashing is not fully 
needed because the unusable pages could just be leaked (as they already 
are in some cases). So instead, this series does a tree-wide search and 
fixes the callers to handle the error by leaking the pages. Going forward 
callers will need to handle the set_memory() errors correctly in order to 
not reintroduce the issue.

I think there are some points for both sides, and we had some internal
discussion on the right way to handle it. So I've tried to characterize
both arguments. I'm interested to hear opinions on which is the best.

I’ve marked the hyperv guest parts in this as RFC, both because I can’t 
test them and I believe Linux TDs can’t run on hyperv yet due to some
missing support. I would appreciate a correction on this if it’s wrong.

Rick Edgecombe (10):
  mm: Add helper for freeing decrypted memory
  x86/mm/cpa: Reject incorrect encryption change requests
  kvmclock: Use free_decrypted_pages()
  swiotlb: Use free_decrypted_pages()
  ptp: Use free_decrypted_pages()
  dma: Use free_decrypted_pages()
  hv: Use free_decrypted_pages()
  hv: Track decrypted status in vmbus_gpadl
  hv_nstvsc: Don't free decrypted memory
  uio_hv_generic: Don't free decrypted memory

 arch/s390/include/asm/set_memory.h |  1 +
 arch/x86/kernel/kvmclock.c         |  2 +-
 arch/x86/mm/pat/set_memory.c       | 41 +++++++++++++++++++++++++++++-
 drivers/hv/channel.c               | 18 ++++++++-----
 drivers/hv/connection.c            | 13 +++++++---
 drivers/net/hyperv/netvsc.c        |  7 +++--
 drivers/ptp/ptp_kvm_x86.c          |  2 +-
 drivers/uio/uio_hv_generic.c       | 12 ++++++---
 include/linux/dma-map-ops.h        |  3 ++-
 include/linux/hyperv.h             |  1 +
 include/linux/set_memory.h         | 13 ++++++++++
 kernel/dma/contiguous.c            |  2 +-
 kernel/dma/swiotlb.c               | 11 +++++---
 13 files changed, 101 insertions(+), 25 deletions(-)

-- 
2.34.1

