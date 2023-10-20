Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843E27D0A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjJTIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjJTIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:10:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33D115;
        Fri, 20 Oct 2023 01:10:12 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:10:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697789411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k9cEt6RCZsT0SZQPSsNYDc8lc1K/B93bfA94NveKhpA=;
        b=4JBehA5jx76Rw26JYeV/ASsBKFT7qpmbFqMSLszlJZPmTwyNBUFNV/tk8vxktzQAVqNBLZ
        AHgx6BL2u8XKicajRaUoiHooKp08us58oruMaNC/h17qm2qsp537mULqfruvBNCv5fWJXR
        gxbi8/kQ4djykoxAIbAd4D8/u/cxdn/8lRX3UsUWb7dSyW8/zepmpnmNooPQUE9FY4Adv0
        Gpxoy+Og9ryXtgFrr755gH8JaQAXsGPmtI3NNdhhWqh/I8hmzoRWK6WHJD9CLRl60dqb5a
        OXYvy/+w9D9gs3pwOsFCVenAQY3Xv9bURb32jVzKb/hwpdJbm+4GlaEpibs+UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697789411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k9cEt6RCZsT0SZQPSsNYDc8lc1K/B93bfA94NveKhpA=;
        b=BOSjsx4/4hrH6pRn7i+EnDSW9EDoHsBU9K5pLd1iFlncWR2Pbxnesey4TJ6qysHf4N68ww
        8hDvIOH7AsJMFBCw==
From:   "tip-bot2 for Haitao Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Return VM_FAULT_SIGBUS instead of
 VM_FAULT_OOM for EPC exhaustion
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        #@tip-bot2.tec.linutronix.de, v6.0+@tip-bot2.tec.linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169778941056.3135.14169781154210769341.tip-bot2@tip-bot2>
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

Commit-ID:     6b7b71a70af6d75e0a9eddf4b01e4383a78b8a5e
Gitweb:        https://git.kernel.org/tip/6b7b71a70af6d75e0a9eddf4b01e4383a78b8a5e
Author:        Haitao Huang <haitao.huang@linux.intel.com>
AuthorDate:    Thu, 19 Oct 2023 19:53:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 10:05:48 +02:00

x86/sgx: Return VM_FAULT_SIGBUS instead of VM_FAULT_OOM for EPC exhaustion

In the EAUG on page fault path, VM_FAULT_OOM is returned when the
Enclave Page Cache (EPC) runs out. This may trigger unneeded OOM kill
that will not free any EPCs. Return VM_FAULT_SIGBUS instead.

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org # v6.0+
---
 arch/x86/kernel/cpu/sgx/encl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e..d13b7e4 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -322,7 +322,7 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
  * ENCLS[EAUG] instruction.
  *
  * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was installed
- * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
+ * successfully, VM_FAULT_SIGBUS as error otherwise.
  */
 static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 				     struct sgx_encl *encl, unsigned long addr)
@@ -348,7 +348,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
 	encl_page = sgx_encl_page_alloc(encl, addr - encl->base, secinfo_flags);
 	if (IS_ERR(encl_page))
-		return VM_FAULT_OOM;
+		return VM_FAULT_SIGBUS;
 
 	mutex_lock(&encl->lock);
 
