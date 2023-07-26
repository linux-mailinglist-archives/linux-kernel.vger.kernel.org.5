Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BF7640C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGZUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGZUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:51:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D92723;
        Wed, 26 Jul 2023 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690404657; x=1721940657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CU51AV+dLzQIOLh1T8r3wZ1+RpKQssSydmBURGB+jDU=;
  b=WNNj16xRGizhEZLWO4DCPevXm9ZflgnyL7xtg2/w73WCIi1rFwLkX7au
   7gwDXXZ/fLeUd08tJGhgPsBZM+3lfnLX8WlqJ0zp+Lwf0MWkjc110lcLh
   xq3IVJlkDQrpHYK9YCZZoQSP3QRFyA3AdWUTsr5UWeK9a+u/WMNjhtJaU
   bom8JArhCp1msXer6QP1kG16EezVmWoN9QoJRsd1I/RLGVGol+PQ15fDz
   GWjNNQ1AE7qSvWv2wCSkxaLKRCRiJ81PLugnaz7tYleRdBgVYINZIJtB6
   X+sWGBIABtezGFXqIDb4lr/Cn2QNk898YGwTXosrZx157VjJvtkmMhzf1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371738993"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371738993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 13:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900582981"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900582981"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 13:50:56 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     dave.hansen@linux.intel.com, kai.huang@intel.com,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     dave.hansen@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org,
        sohil.mehta@intel.com
Subject: [PATCH v4] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race
Date:   Wed, 26 Jul 2023 13:50:56 -0700
Message-Id: <20230726205056.25592-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: df3ee23c71e9c653db43a38e1b3fddf31e0bce37.camel@intel.com
References: 
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

Under heavy load, the SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC
page for an enclave and set encl->secs.epc_page to NULL. But the SECS
EPC page is used for EAUG in the SGX page fault handler without checking
for NULL and reloading.

Fix this by checking if SECS is loaded before EAUG and loading it if it
was reclaimed.

The SECS page holds global enclave metadata. It can only be reclaimed
when there are no other enclave pages remaining. At that point,
virtually nothing can be done with the enclave until the SECS page is
paged back in.

An enclave can not run nor generate page faults without a resident SECS
page. But it is still possible for a #PF for a non-SECS page to race
with paging out the SECS page: when the last resident non-SECS page A
triggers a #PF in a non-resident page B, and then page A and the SECS
both are paged out before the #PF on B is handled.

Hitting this bug requires that race triggered with a #PF for EAUG.
Following is a trace when it happens.

[ 1682.914263] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1682.922966] #PF: supervisor read access in kernel mode
[ 1682.929115] #PF: error_code(0x0000) - not-present page
[ 1682.935264] PGD 0 P4D 0
[ 1682.938383] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1682.943620] CPU: 43 PID: 2681 Comm: test_sgx Not tainted 6.3.0-rc4sgxcet #12
[ 1682.951989] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[ 1682.965504] RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
[ 1682.971359] Code: 25 49 8b 96 98 04 00 00 48 8d 40 48 48 89 42 08 48 89 56 48 49 8d 96 98 04 00 00 48 89 56 50 49 89 86 98 04 00 00 49 8b 46 60 <8b> 10 48 c1 e2 05 488
[ 1682.993330] RSP: 0000:ffffb2e64725bc00 EFLAGS: 00010246
[ 1682.999585] RAX: 0000000000000000 RBX: ffff987e5abac428 RCX: 0000000000000000
[ 1683.008059] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff987e61aee000
[ 1683.016533] RBP: ffffb2e64725bcf0 R08: 0000000000000000 R09: ffffb2e64725bb58
[ 1683.025008] R10: 0000000000000000 R11: 00007f3f5c418fff R12: ffff987e61aee020
[ 1683.033479] R13: ffff987e505bc080 R14: ffff987e61aee000 R15: ffffb2e6420fcb20
[ 1683.041949] FS:  00007f3f5cb48740(0000) GS:ffff989cfe8c0000(0000) knlGS:0000000000000000
[ 1683.051540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1683.058478] CR2: 0000000000000000 CR3: 0000000115896002 CR4: 0000000000770ee0
[ 1683.067018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1683.075539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1683.084085] PKRU: 55555554
[ 1683.087465] Call Trace:
[ 1683.090547]  <TASK>
[ 1683.093220]  ? __kmem_cache_alloc_node+0x16a/0x440
[ 1683.099034]  ? xa_load+0x6e/0xa0
[ 1683.103038]  sgx_vma_fault+0x119/0x230
[ 1683.107630]  __do_fault+0x36/0x140
[ 1683.111828]  do_fault+0x12f/0x400
[ 1683.115928]  __handle_mm_fault+0x728/0x1110
[ 1683.121050]  handle_mm_fault+0x105/0x310
[ 1683.125850]  do_user_addr_fault+0x1ee/0x750
[ 1683.130957]  ? __this_cpu_preempt_check+0x13/0x20
[ 1683.136667]  exc_page_fault+0x76/0x180
[ 1683.141265]  asm_exc_page_fault+0x27/0x30
[ 1683.146160] RIP: 0033:0x7ffc6496beea
[ 1683.150563] Code: 43 48 8b 4d 10 48 c7 c3 28 00 00 00 48 83 3c 19 00 75 31 48 83 c3 08 48 81 fb 00 01 00 00 75 ec 48 8b 19 48 8d 0d 00 00 00 00 <0f> 01 d7 48 8b 5d 101
[ 1683.172773] RSP: 002b:00007ffc64935b68 EFLAGS: 00000202
[ 1683.179138] RAX: 0000000000000003 RBX: 00007f3800000000 RCX: 00007ffc6496beea
[ 1683.187675] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 1683.196200] RBP: 00007ffc64935b70 R08: 0000000000000000 R09: 0000000000000000
[ 1683.204724] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1683.213310] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1683.221850]  </TASK>
[ 1683.224636] Modules linked in: isofs intel_rapl_msr intel_rapl_common binfmt_misc kvm_intel nls_iso8859_1 kvm ppdev irqbypass input_leds parport_pc joydev parport rapi
[ 1683.291173] CR2: 0000000000000000
[ 1683.295271] ---[ end trace 0000000000000000 ]---

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- Refined the title (Kai, Dave)
- Added a trace to commit meesage (Kai)
- Added a few details for the race.

v3:
- Added comments on sgx_encl_load_secs(). (Dave)
- Added theory of the race condition to hit the bug. (Dave)
- Added Reviewed-by, and applicable stable release. (Jarkko)

v2:
- Fixes for style, commit message (Jarkko, Kai)
- Removed unneeded WARN_ON (Kai)
---
 arch/x86/kernel/cpu/sgx/encl.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 91fa70e51004..279148e72459 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -235,6 +235,21 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
+/*
+ * Ensure the SECS page is not swapped out.  Must be called with encl->lock
+ * to protect the enclave states including SECS and ensure the SECS page is
+ * not swapped out again while being used.
+ */
+static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
+{
+	struct sgx_epc_page *epc_page = encl->secs.epc_page;
+
+	if (!epc_page)
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 						  struct sgx_encl_page *entry)
 {
@@ -248,11 +263,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return entry;
 	}
 
-	if (!(encl->secs.epc_page)) {
-		epc_page = sgx_encl_eldu(&encl->secs, NULL);
-		if (IS_ERR(epc_page))
-			return ERR_CAST(epc_page);
-	}
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
 	if (IS_ERR(epc_page))
@@ -339,6 +352,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 
 	mutex_lock(&encl->lock);
 
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page)) {
+		if (PTR_ERR(epc_page) == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
+		goto err_out_unlock;
+	}
+
 	epc_page = sgx_alloc_epc_page(encl_page, false);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)

base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.25.1

