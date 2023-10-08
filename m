Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B7BCDCD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbjJHKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjJHKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:30:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792EC6;
        Sun,  8 Oct 2023 03:30:36 -0700 (PDT)
Date:   Sun, 08 Oct 2023 10:30:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696761034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RFcgvCwtBkHjmjC5Kv59Tho8cI5sB4+dK7KBM8mjgEo=;
        b=kwiLjNQmuwlGGMi4EdsYkoz71pGXXZ0BIeUR/pN0bHENed0HdVB5+vK3OF7d+KDAAoCEUI
        Whqe2DtedUA5cOuGrJPI2iJlkIWFwVa66lWwv9z8LcybXPAzzWLUbRYR9Df7zgEO9j7ZAM
        sDf6+Oa16Tnkk/xwVb70G00/wvx0HzrmyQoqtsRKTYz80CyJy8jBYt0wdEEuC35UedBXPI
        xStItsIqbw+xG/xqkUtPCPM1o7JPCmaPw1H6r/OaTPhysn7YE9MdfXb2gZqZsXaXvxJxS7
        Ze2teRbhAUuDpCTxuSGrCMSSjh14BhtUT8oY68E3mD3lxF6vHYftgJrmgZjvXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696761034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RFcgvCwtBkHjmjC5Kv59Tho8cI5sB4+dK7KBM8mjgEo=;
        b=5SsDrl6Fd6RtNGDTB9P4PsIR2dJg2M//yECJsaid/TgeB4fr3GRxMotUyQpq8FXQP6/eoW
        BcWllE6zz6s4WcCA==
From:   "tip-bot2 for JP Kobryn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/lbr: Filter vsyscall addresses
Cc:     Alexei Starovoitov <ast@kernel.org>,
        JP Kobryn <inwardvessel@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169676103391.3135.1323905069105939036.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e53899771a02f798d436655efbd9d4b46c0f9265
Gitweb:        https://git.kernel.org/tip/e53899771a02f798d436655efbd9d4b46c0f9265
Author:        JP Kobryn <inwardvessel@gmail.com>
AuthorDate:    Fri, 06 Oct 2023 11:57:26 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Oct 2023 12:25:18 +02:00

perf/x86/lbr: Filter vsyscall addresses

We found that a panic can occur when a vsyscall is made while LBR sampling
is active. If the vsyscall is interrupted (NMI) for perf sampling, this
call sequence can occur (most recent at top):

    __insn_get_emulate_prefix()
    insn_get_emulate_prefix()
    insn_get_prefixes()
    insn_get_opcode()
    decode_branch_type()
    get_branch_type()
    intel_pmu_lbr_filter()
    intel_pmu_handle_irq()
    perf_event_nmi_handler()

Within __insn_get_emulate_prefix() at frame 0, a macro is called:

    peek_nbyte_next(insn_byte_t, insn, i)

Within this macro, this dereference occurs:

    (insn)->next_byte

Inspecting registers at this point, the value of the next_byte field is the
address of the vsyscall made, for example the location of the vsyscall
version of gettimeofday() at 0xffffffffff600000. The access to an address
in the vsyscall region will trigger an oops due to an unhandled page fault.

To fix the bug, filtering for vsyscalls can be done when
determining the branch type. This patch will return
a "none" branch if a kernel address if found to lie in the
vsyscall region.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/events/utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 76b1f8b..dab4ed1 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/insn.h>
+#include <linux/mm.h>
 
 #include "perf_event.h"
 
@@ -132,9 +133,9 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
 		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
+		 * a known text address and not a vsyscall address.
 		 */
-		if (kernel_text_address(from)) {
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
 			addr = (void *)from;
 			/*
 			 * Assume we can get the maximum possible size
