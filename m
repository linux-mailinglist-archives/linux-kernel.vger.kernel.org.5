Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF97FF045
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjK3Ngi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjK3Ngf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:36:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1232790;
        Thu, 30 Nov 2023 05:36:41 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701351400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6K7kd2z3kKnUokpb+0NcJO6tvamF5TDjcjebi3KIdqc=;
        b=iEQD2jW+DhKq7megFOrR7h4hOkpEvBpmbGC4TLamh8x5nyKYRvh4T0wM5VceYBMg/LDKqc
        lVr/GAgVLbYsIQGKHzYmLcK5gDtBtkrt80HNC0o80Q3MjpYYkgl9KuO0CoICQNAe1laa1I
        K1VYV47Shsa5O+3BNYT2R4NG8VsBpQ+bx0yd2p6g/azqQ4MPwY1R3nVC9AO3ZUDvdmnGyl
        vPCf5QXUUkq51rTAoASi9qqoxZdb4kCCmFEqMBMJq0gzbSV/E57KQecxzG9MM0I0Fngu/B
        g12XFIng4bbAeSr8HdXTVVd4QJzhvtwq3BW4FIccGf4YR2rYmxEozW0c9RsDIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701351400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6K7kd2z3kKnUokpb+0NcJO6tvamF5TDjcjebi3KIdqc=;
        b=fuXRn3EiFJ+BulRBIxVFbwLX6fGXfv737gRrWs7PLVCO8qv1biZrWZq2HR66EWOarAYe6u
        L/GZwf8dKpZButDQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix NULL pointer dereference
 issue in upi_fill_topology()
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231127185246.2371939-2-alexander.antonov@linux.intel.com>
References: <20231127185246.2371939-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170135139956.398.13686814243901771133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1692cf434ba13ee212495b5af795b6a07e986ce4
Gitweb:        https://git.kernel.org/tip/1692cf434ba13ee212495b5af795b6a07e986ce4
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 27 Nov 2023 10:52:45 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Nov 2023 14:29:52 +01:00

perf/x86/intel/uncore: Fix NULL pointer dereference issue in upi_fill_topology()

Get logical socket id instead of physical id in discover_upi_topology()
to avoid out-of-bound access on 'upi = &type->topology[nid][idx];' line
that leads to NULL pointer dereference in upi_fill_topology()

Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://lore.kernel.org/r/20231127185246.2371939-2-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index aeaa8ef..1efbacf 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5596,7 +5596,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 	struct pci_dev *ubox = NULL;
 	struct pci_dev *dev = NULL;
 	u32 nid, gid;
-	int i, idx, ret = -EPERM;
+	int i, idx, lgc_pkg, ret = -EPERM;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 
@@ -5614,8 +5614,13 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 		for (i = 0; i < 8; i++) {
 			if (nid != GIDNIDMAP(gid, i))
 				continue;
+			lgc_pkg = topology_phys_to_logical_pkg(i);
+			if (lgc_pkg < 0) {
+				ret = -EPERM;
+				goto err;
+			}
 			for (idx = 0; idx < type->num_boxes; idx++) {
-				upi = &type->topology[nid][idx];
+				upi = &type->topology[lgc_pkg][idx];
 				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
 				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
 								  ubox->bus->number,
@@ -5626,6 +5631,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 						goto err;
 				}
 			}
+			break;
 		}
 	}
 err:
