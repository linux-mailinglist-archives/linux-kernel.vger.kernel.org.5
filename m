Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE77B7C97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjJDJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjJDJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:50:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26734B4;
        Wed,  4 Oct 2023 02:50:12 -0700 (PDT)
Date:   Wed, 04 Oct 2023 09:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696413010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvb8b/giLe1+Ig6ztHhXVSzK4lYodlkVlqCESw+5lJk=;
        b=PfJpwrDAF5lPyLxRmRCB86YssF3ZIV5sMrER0muv9YSmqNydIJ0iIb1rvyp2vSUx+LQSdd
        sFLqSI719wZHqEA0F5BaxfJ6hzXyE6VcEiLKmQ4r06egOPNAOCupmEzX6wNzWqLdGLWXr3
        KxpZGpMOLybSPf0Vo5zKhZEDu6ikvsSUSrBPC93Di/DurL7QHH1PErFUOYyGKRPdnIwB9v
        UGdpwQmrVVQa+Y8U3BUWE+jx+VFJk1InS+o6QHamG7Sv3UIEEdvKVHTgrCiA7oUdHwRcJi
        /EVYzMZl5Ug8lbs5E+MXZK5q+fONJYQhEi8DOjv+BZzxbP5RcBReXmS9TOTNOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696413010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvb8b/giLe1+Ig6ztHhXVSzK4lYodlkVlqCESw+5lJk=;
        b=S0twSuhVr0q6fHhplA+dqmy7oYPPafIYVCDxviNTKtEjz1Z/bjn1hrXysufVvI5qvK1kDq
        FfFzHzIbF0hpbyAQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Change npages to unsigned long in
 snp_accept_memory()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6d511c25576494f682063c9fb6c705b526a3757e=2E16874?=
 =?utf-8?q?41505=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C6d511c25576494f682063c9fb6c705b526a3757e=2E168744?=
 =?utf-8?q?1505=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169641301005.3135.2308946231716648881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     62d5e970d022ef4bde18948dd67247c3194384c1
Gitweb:        https://git.kernel.org/tip/62d5e970d022ef4bde18948dd67247c3194384c1
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 22 Jun 2023 08:45:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 14:55:41 +02:00

x86/sev: Change npages to unsigned long in snp_accept_memory()

In snp_accept_memory(), the npages variables value is calculated from
phys_addr_t variables but is an unsigned int. A very large range passed
into snp_accept_memory() could lead to truncating npages to zero. This
doesn't happen at the moment but let's be prepared.

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/6d511c25576494f682063c9fb6c705b526a3757e.1687441505.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826..d8c1e3b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,8 +868,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	unsigned long vaddr;
-	unsigned int npages;
+	unsigned long vaddr, npages;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
