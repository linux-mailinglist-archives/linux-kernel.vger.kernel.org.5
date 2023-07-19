Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD77589EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGSAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGSAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:08:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F91B3;
        Tue, 18 Jul 2023 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689725328; x=1721261328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3muhF4TVLTmFnacHCBx1v4aTgvnhsmIso8E7HfJdXW8=;
  b=PczfkfBa3wKxA9YERbrYpBmqQx2Kq2beOYf1hfl2Dycoy1be2FNJ2nav
   0vpoITlTaFDBt9GL6udhJS5pIfjVuFjY4xXsFliCfslX4e2axrmAZfOen
   ajWRt8sU0D9I96PCTpHFhDAipXpTujzXMjg9M39Fe6btDI1ojOu50DVqk
   jo+JuayMpPNNb0PhcR8MDpNvLRxDGgHPe7g+ZDtbxPr1FMTvlWo0OwE4W
   alP54YWcuYqrN1FLacN7iAz5qBTYRA3V3/X+lc+fcpVTCDdf6blhhssGN
   ZAFC9P+iOjI4PH1ZYQYVjWA/ESW8hHVh/DBeBkuZb2db4oth2xFhj0uLI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432522001"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432522001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753509743"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="753509743"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 17:08:47 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: [PATCH v3] x86/sgx: Fix a NULL pointer
Date:   Tue, 18 Jul 2023 17:08:47 -0700
Message-Id: <20230719000847.12800-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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
EPC page is used for EAUG in the SGX #PF handler without checking for
NULL and reloading.

Fix this by checking if SECS is loaded before EAUG and loading it if it
was reclaimed.

The SECS page holds global enclave metadata. It can only be reclaimed
when there are no other enclave pages remaining. At that point,
virtually nothing can be done with the enclave until the SECS page is
paged back in.

An enclave can not run nor generate page faults without a resident SECS
page. But it is still possible for a #PF for a non-SECS page to race
with paging out the SECS page.

Hitting this bug requires triggering that race.

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

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
index 2a0e90fe2abc..f682d1fa7497 100644
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

base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.25.1

