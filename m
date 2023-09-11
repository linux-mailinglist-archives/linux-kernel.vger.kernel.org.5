Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7183E79BCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbjIKVVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243539AbjIKRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:18:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B31AD;
        Mon, 11 Sep 2023 10:18:22 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:18:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694452700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=867yLIomPbzGLMNy6s8oxhGFE6oZmpPevaskEwqcT3I=;
        b=foWTQah0jByvHUUGQGZrfp6+CKSLZo9Nsyahb/IWgTRUxLhjSQ0jANuish83dCbTNoAdLA
        XqzXoF6OsNJAwNQ3nwx3PJvaQwGcDSquGh6MKQtGuPxq9xWvSqI5McO4mBhl/gjDUqyqFt
        Tz0n5VeF1xGqwNWiVzXUgD4mbfMzUF/uywFGQOjscrTH82+DKJTC/M2j/b16nAfX2xAlkJ
        LLSOV6/G7QQedPsd6X+67Lfdxp5luz9LJEGu3CVPQOxDkDj9JoNEEdagP56q6fO+2Zw9hf
        MGmHnDTxX7RsGvXClW5ZdTOtGkPYh5Fdgx/wu3nkYo12fP9GmimIW254TPtIyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694452700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=867yLIomPbzGLMNy6s8oxhGFE6oZmpPevaskEwqcT3I=;
        b=6NINBcfWk9RgsXZ4HiQ6NmlGotbL9nxcUy9vK+O72v9gc7Mcp+dd6YZUQi9EFh7c9rUi9e
        yLD4/mE9DEpcPkBA==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Use alternate source for socket to
 node data
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169445269945.27769.14010917111299045082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5290e88ba2c742ca77c5f5b690e5af549cfd8591
Gitweb:        https://git.kernel.org/tip/5290e88ba2c742ca77c5f5b690e5af549cfd8591
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Mon, 07 Aug 2023 09:17:30 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 10:06:22 -07:00

x86/platform/uv: Use alternate source for socket to node data

The UV code attempts to build a set of tables to allow it to do
bidirectional socket<=>node lookups.

But when nr_cpus is set to a smaller number than actually present, the
cpu_to_node() mapping information for unused CPUs is not available to
build_socket_tables(). This results in skipping some nodes or sockets
when creating the tables and leaving some -1's for later code to trip.
over, causing oopses.

The problem is that the socket<=>node lookups are created by doing a
loop over all CPUs, then looking up the CPU's APICID and socket. But
if a CPU is not present, there is no way to start this lookup.

Instead of looping over all CPUs, take CPUs out of the equation
entirely. Loop over all APICIDs which are mapped to a valid NUMA node.
Then just extract the socket-id from the APICID.

This avoid tripping over disabled CPUs.

Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230807141730.1117278-1-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9f5d74..205cee5 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1533,7 +1533,7 @@ static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
 	int nums, numn, nump;
-	int cpu, i, lnid;
+	int i, lnid, apicid;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
@@ -1584,15 +1584,14 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_possible_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int apicid, sockid;
+	for (apicid = 0; apicid < ARRAY_SIZE(__apicid_to_node); apicid++) {
+		int nid = __apicid_to_node[apicid];
+		int sockid;
 
-		if (lnid == nid)
+		if ((nid == NUMA_NO_NODE) || (lnid == nid))
 			continue;
 		lnid = nid;
 
-		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
 
 		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
