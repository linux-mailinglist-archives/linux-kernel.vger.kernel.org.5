Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6639E766393
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjG1FLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjG1FLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:11:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF343AB3;
        Thu, 27 Jul 2023 22:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690521032; x=1722057032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tp8Y+kaJ7OLufB2ByMRaPwwLhVVjxBYCOuhdA7q99n0=;
  b=BA1HQECYc7T//eArPjJs0DD4lP/QLc0p1j/DhiFypQtNx7ux/E5V1aPQ
   J4YE5HRdbGfTS2yo2cpUL+vD78MejUD/nXZEYMbWqojhOTPh6+2pWX725
   AlejEajns3Bv3OkKzL4U9ZqxAYgtqImj6QS/Tb6ta9T8e96e3BWCJiSso
   0/4Rp008tsuhD6rmnl0xL5zaMZb6xOpKM+sJ+NqGR66EofkBBTtF+u5lK
   4Y+dTDMsMrhalHT2/9SEKG4E/Gss6hTb51WiJL1kPYrsd2gbcYNd/MwJ6
   eoYXq4f9ZcZQaJZER4uiwO5DhOHVW05lKG9ms4Zh9ejZp987qEe9dIhI7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="365967758"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="365967758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 22:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757008475"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="757008475"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 22:10:24 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     dave.hansen@linux.intel.com, kai.huang@intel.com,
        reinette.chatre@intel.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     dave.hansen@intel.com, kristen@linux.intel.com, seanjc@google.com,
        stable@vger.kernel.org, sohil.mehta@intel.com
Subject: [PATCH v6] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race
Date:   Thu, 27 Jul 2023 22:10:24 -0700
Message-Id: <20230728051024.33063-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: 6ccb705bc4345420e6c730245f871ba1d9413203.camel@intel.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC page for an
enclave and set secs.epc_page to NULL. The SECS page is used for EAUG
and ELDU in the SGX page fault handler. However, the NULL check for
secs.epc_page is only done for ELDU, not EAUG before being used.

Fix this by doing the same NULL check and reloading of the SECS page as
needed for both EAUG and ELDU.

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

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
Call Trace:
 ? __kmem_cache_alloc_node+0x16a/0x440
 ? xa_load+0x6e/0xa0
 sgx_vma_fault+0x119/0x230
 __do_fault+0x36/0x140
 do_fault+0x12f/0x400
 __handle_mm_fault+0x728/0x1110
 handle_mm_fault+0x105/0x310
 do_user_addr_fault+0x1ee/0x750
 ? __this_cpu_preempt_check+0x13/0x20
 exc_page_fault+0x76/0x180
 asm_exc_page_fault+0x27/0x30

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
v6:
- Removed 'Under heavy load' as it is not the required condition though
it makes the bug more likely happen. (Kai)
- Added mentioning of the NULL check and reloading already done for ELDU (Kai)
- Added Reviewed-by (Kai)

v5:
- Trimmed trace and added Acked-by (Reinette)

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

