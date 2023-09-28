Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867A7B28E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjI1XiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:38:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF22195;
        Thu, 28 Sep 2023 16:38:18 -0700 (PDT)
Date:   Thu, 28 Sep 2023 23:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695944296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8CmroMhSfWyOMfTzhtju1lshDiYJj149VGMIuDkgZ5o=;
        b=kNrvUWMfxPrZZHUDBxt6XnyuP8wSYOvBWORu5yUGfVdwlKSomdhFLRX4VoKCBqnN6cMlkJ
        w9WtUhOuP7MvBARKsMcuaFvd102RI16a6ePVBCzZ2DNbNzi9ekjxSmkzHg4Aj6As6enfdu
        P+GUONCf0fhiVxrzhKfLnz0EDlUidrRAO7sjKlFgdbPKWrUMW2Gm0tQi/q2FiplW0cm6TC
        7G7Zuvm3Z5gMZ4/BfV5KeRcddCapCqI05wvoBPkrNpig7vATJFCCyZNGpjq48HfLTKaghk
        JV5k2zrgdRbVQP01PdqP+RaryqAq4knD+bmhOeRzNr51RekeGR0VtHyuc8piVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695944296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8CmroMhSfWyOMfTzhtju1lshDiYJj149VGMIuDkgZ5o=;
        b=8/RiImtIhpcTEQ7NvznRc3ZMrnIvYqF4VMN3Y2vW/EKXVTEy3zkyhC8Vavn0pbGtv9IPkr
        KtfoSwnz4hi5S9Cg==
From:   "tip-bot2 for Haitao Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169594429559.27769.15062614937556087965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c6c2adcba50c2622ed25ba5d5e7f05f584711358
Gitweb:        https://git.kernel.org/tip/c6c2adcba50c2622ed25ba5d5e7f05f584711358
Author:        Haitao Huang <haitao.huang@linux.intel.com>
AuthorDate:    Thu, 27 Jul 2023 22:10:24 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 28 Sep 2023 16:16:40 -07:00

x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

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
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230728051024.33063-1-haitao.huang%40linux.intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 91fa70e..279148e 100644
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
