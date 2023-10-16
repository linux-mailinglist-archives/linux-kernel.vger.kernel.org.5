Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33A7CA6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjJPLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjJPLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:31:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486CDC;
        Mon, 16 Oct 2023 04:31:02 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697455860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0d6/dutpP/geIhcM1VULDwECIjIHiDxDL5beJt6QgU=;
        b=GEcDKHUeOjoUk9Oftp9KsjqJ5LkiFaPTpYPjTtgWGJK+5urZSBMsk2kC+Ve+seEbd3M5gI
        9NotfL/ofAAVwquQwuLFI6oU3wu86QsE79dSCcaYL23RhXYw34SfkDBYKCCTfOjFGfSctg
        QAPSTdfwWU5hSXFZd6UjburrPm+MPqC2deKBsUfeIYRZNwnDay8yy3FqaXzlC1Ig5xZhdt
        tehUwGEmCVs33Y5DSP8QO+k0Y7nInF2ErDPT7u5VUL+IFz7F/QXtUQMgO38d1CcWlYVFD7
        oWYzw8xpjAk7oW4+KoeiVdUitqpj8GCPHzbEzTl5Si9Sj0djrBpHWmrSmiCt1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697455860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0d6/dutpP/geIhcM1VULDwECIjIHiDxDL5beJt6QgU=;
        b=a24HrChwDnatPi9EPWyqIRoFPt/EFEjgZmgE6GB1Jdn61zdXn172S/2+sJ/8uTXRtU86h2
        eZj/7t8M1EhYl4Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] alpha: Fix up new futex syscall numbers
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
References: <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
MIME-Version: 1.0
Message-ID: <169745586011.3135.7148884690767482787.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dcc134510eefaec6dda4fe71ab824f0300ed9f9f
Gitweb:        https://git.kernel.org/tip/dcc134510eefaec6dda4fe71ab824f0300ed9f9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Oct 2023 13:12:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 16 Oct 2023 13:20:54 +02:00

alpha: Fix up new futex syscall numbers

As per Arnd, Alpha syscalls since time64 are offset by 120, retain
this offset.

Fixes: 9f6c532f59b2 ("futex: Add sys_futex_wake()")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com
---
 arch/alpha/kernel/syscalls/syscall.tbl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index b1865f9..b68f1f5 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,6 +492,7 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
-563	common	futex_wake			sys_futex_wake
-564	common	futex_wait			sys_futex_wait
-565	common	futex_requeue			sys_futex_requeue
+# 563 reserved for map_shadow_stack
+564	common	futex_wake			sys_futex_wake
+565	common	futex_wait			sys_futex_wait
+566	common	futex_requeue			sys_futex_requeue
