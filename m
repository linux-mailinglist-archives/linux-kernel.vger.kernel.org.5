Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEED7C8254
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjJMJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJMJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313F3DA;
        Fri, 13 Oct 2023 02:38:16 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Tdn9YzZqvXLzEj18H/HtmAGqNqRPcJ+Ga59SnQmz6o=;
        b=BXbdsGSowodu3hAWxSP8kCy0/apsBjQKrYaIxUEge1PHG58p+zEHDMR8qrabG/jS1r3uNn
        /XY2+l3hOFVR+ghivBFFAAiHiULTJX4Dl/r8MNE13pUzWuj+oZ9zpxwU/LJueJqTzdzb8r
        1bMr6ApVcLVd2ZPTmuce/+5FOF4/VI4XudSaJX3dyYOO229YGdzBJ48HRGoQa9SZwQgbmH
        esN2ffsJj1mPARiVYN/Ra0bzWJTcveM6JzFAEdkNVitl4hYJrnfuNE/HGE2uSV0hQc40im
        Bce96eb5x9JphOaUlOpZb2+dTYroigO79zYWStQX8JXAee0qmyY/SaSv5bfXQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Tdn9YzZqvXLzEj18H/HtmAGqNqRPcJ+Ga59SnQmz6o=;
        b=PwP3o0WEqKmuLbJWVEmMYTMg39RMPKFOhpuMya5GATkLVwdGAk782BRfMoeWBsTo6yQM1Z
        ktkJ6ufKsk2HH/Cg==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/hygon: Fix the CPU topology evaluation for real
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <stable@vger.kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com>
References: <tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com>
MIME-Version: 1.0
Message-ID: <169718989416.3135.5181697052679641742.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ee545b94d39a00c93dc98b1dbcbcf731d2eadeb4
Gitweb:        https://git.kernel.org/tip/ee545b94d39a00c93dc98b1dbcbcf731d2eadeb4
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Mon, 14 Aug 2023 10:18:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:16 +02:00

x86/cpu/hygon: Fix the CPU topology evaluation for real

Hygon processors with a model ID > 3 have CPUID leaf 0xB correctly
populated and don't need the fixed package ID shift workaround. The fixup
is also incorrect when running in a guest.

Fixes: e0ceeae708ce ("x86/CPU/hygon: Fix phys_proc_id calculation logic for multi-die processors")
Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com
Link: https://lore.kernel.org/r/20230814085112.089607918@linutronix.de
---
 arch/x86/kernel/cpu/hygon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index defdc59..a7b3ef4 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -87,8 +87,12 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+		/*
+		 * Socket ID is ApicId[6] for the processors with model <= 0x3
+		 * when running on host.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
+			c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
