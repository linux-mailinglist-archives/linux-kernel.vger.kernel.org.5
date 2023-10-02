Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA77B51EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjJBL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjJBL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA52D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:38 -0700 (PDT)
Message-ID: <20231002115902.156063939@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MpCnK67GELVxPmL+nKHxE4OtoLy/US/2UWS6ahSC0yw=;
        b=KKzAKlH7CbuBMSxI0yGr7SlgHQhn+BM3XhYs8LN3BViOeoy3EZ6qW48HIPZzUZlrHdv5WN
        R5bekrTnkJzZNRLV4bTmaf/nV6spDCSibVbXD3u15tP3W7P5GafrnJ2v/LyjWQLoCCNd6p
        nVGLth1Rs3cDzIOxz6fxoS3UMDt4h6gPoNO0K6yuSyR9i3mWUZr66jYrSbCHsoYGQYR6p1
        J20dij6nXx0ThVltKAvpki2v8LLDO03C+EaCb81R1p9TLtyPTU49sFzOmKfctYf+ib9SNM
        DmvUK6r9ZDJd0Ax+LsybxI6muT8/oD9p41i/V4uDB63Xqkq9h5L9hp1q3M0PBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MpCnK67GELVxPmL+nKHxE4OtoLy/US/2UWS6ahSC0yw=;
        b=HHGzqGpDHgoB65PMZaOFO1tJw+6BVaXiVwp8FJCDZpuiCtek8/uBNemv8bq4pViA56iZdt
        2E2nPs1TqqOIfbDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 02/30] x86/boot/32: Disable stackprotector and tracing for
 mk_early_pgtbl_32()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:36 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stackprotector cannot work before paging is enabled. The read from the per
CPU variable __stack_chk_guard is always accessing the virtual address
either directly on UP or via FS on SMP. In physical address mode this
results in an access to memory above 3GB.

So this works by chance as the hardware returns the same value when there
is no RAM at this physical address. When there is RAM populated above 3G
then the read is by chance the same as nothing changes that memory during
the very early boot stage.

Stop relying on pure luck and disable the stack protector for the only C
function which is called during early boot before paging is enabled.

Remove function tracing from the whole source file as there is no way to
trace this at all, but in case of CONFIG_DYNAMIC_FTRACE=n
mk_early_pgtbl_32() would access global function tracer variables in
physical address mode which again might work by chance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/Makefile |    1 +
 arch/x86/kernel/head32.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -16,6 +16,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_head32.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -73,7 +73,8 @@ asmlinkage __visible void __init __noret
  * always zero at this stage.
  */
 void __init mk_early_pgtbl_32(void);
-void __init mk_early_pgtbl_32(void)
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 #ifdef __pa
 #undef __pa

