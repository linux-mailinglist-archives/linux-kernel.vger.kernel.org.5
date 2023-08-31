Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC378F4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbjHaVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:36:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ABE107;
        Thu, 31 Aug 2023 14:36:45 -0700 (PDT)
Date:   Thu, 31 Aug 2023 21:36:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693517803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jX0zvOyDMmr+364nqbvMi3q1nyFuXLKNAUbCWcZ9gEo=;
        b=Y67WsgqpLS8DpL9vFbZuNPdZ1AHKZkxqBT0toj39UdWY4oSbDP9gkcpJS+G1X9mZnjiRVK
        wqXEXt1LGMbSJqRG8MX7u/u8HLd9eSN3GLb4aOE84l8fvh7X6ROedgj+CjesjH5US4uLhq
        ZL/V3fjhCBZ3CvWPty1JavcbgmKU9wClUIpCkmIAKYDXMiMl81EVVGyZVjpMisMEa2rVki
        34H7kzBZfzdqDXg73tPfMr0lMRW7QFALINeks38pOC5blC5qOaFO+4bXLFNsOm8Gb4pv/E
        H+4cFyOP4g9jb0xCLw8/YSMFoAxT5wjRFR8f2fKb2BwOeuhzACjxJ39rCSWNJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693517803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jX0zvOyDMmr+364nqbvMi3q1nyFuXLKNAUbCWcZ9gEo=;
        b=a1KuHxYmmM7npRCDDo1of+OXdycYHThcC+10NFN12HlsVtnShvhuPBp8wcyd3KLi+bwB9Q
        Be/iwhvgkFPlD4BQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] powerpc: Fix pud_mkwrite() definition after
 pte_mkwrite() API changes
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZPEFw1XGrI69ZbJ6@gmail.com>
References: <ZPEFw1XGrI69ZbJ6@gmail.com>
MIME-Version: 1.0
Message-ID: <169351780302.27769.17248480254540451210.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     cc852156ee7cbd4c83dfd64e9b800f7932f867d0
Gitweb:        https://git.kernel.org/tip/cc852156ee7cbd4c83dfd64e9b800f7932f867d0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 31 Aug 2023 23:27:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Aug 2023 23:32:39 +02:00

powerpc: Fix pud_mkwrite() definition after pte_mkwrite() API changes

I believe there's one semantic conflict we missed, which breaks the powerpc64
build: recent changes to arch/powerpc/include/asm/book3s/64/pgtable.h created
a new semantic conflict due to the changes to the pte_mkwrite() API:

  161e393c0f63 ("mm: Make pte_mkwrite() take a VMA")

... resolved with the fix below.

Only build tested though.

The crossing upstream commit was:

  27af67f35631 ("powerpc/book3s64/mm: enable transparent pud hugepage")

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZPEFw1XGrI69ZbJ6@gmail.com
--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 136232a..5c497c8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -931,7 +931,7 @@ static inline pte_t *pudp_ptep(pud_t *pud)
 #define pud_mkdirty(pud)	pte_pud(pte_mkdirty(pud_pte(pud)))
 #define pud_mkclean(pud)	pte_pud(pte_mkclean(pud_pte(pud)))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
-#define pud_mkwrite(pud)	pte_pud(pte_mkwrite(pud_pte(pud)))
+#define pud_mkwrite(pud)	pte_pud(pte_mkwrite_novma(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
