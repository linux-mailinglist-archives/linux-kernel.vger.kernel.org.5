Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10579DC96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjILXU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjILXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:20:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45410F7;
        Tue, 12 Sep 2023 16:20:21 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694560819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ihL4A5HiQP2/aKniH3tdyLo8HIv7di4qMOIz4xPrnAc=;
        b=I6/7rzZX9aXBFIWPlHAjlPWPuZ0p//EJPDIDSESE0SI+Bwtm6Yh1jIykRXCI7pQWw6vMcp
        QKQ6GmCQuzkYuUgGOSb3srV48ydmbnR2NTYzeCFx4Z/Uv6nSzug3kFah0rQQ4uHjMlgyby
        m10JFh/idwXd3KS0EzQ0gZeYyPV989y09fIqUb/tLKXuzryFFuTpmdi9t7irAnre8X08nt
        lgHgOTzAgLuMZLXFv+Dmu5i24bNYWngktASO3v/gCDAbmap1fZiTWakhznuBa+I5uSsnlH
        l/cAv2BgCvFUYFbY6Klf2BRTZVb490W/6J50yzjj+kSTTvkL+pXebguIb95wiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694560819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ihL4A5HiQP2/aKniH3tdyLo8HIv7di4qMOIz4xPrnAc=;
        b=hLHgBA6ZrOY0qVfqBSuP4NkmGZaBGErtqRhtmpvNthp1gAQ5KdoZwePAGWsPZij7dvto4H
        nNpw55mfR53kdWBA==
From:   "tip-bot2 for Alison Schofield" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window
Cc:     Derick Marks <derick.w.marks@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169456081810.27769.10707287336222746575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8f1004679987302b155f14b966ca6d4335814fcb
Gitweb:        https://git.kernel.org/tip/8f1004679987302b155f14b966ca6d4335814fcb
Author:        Alison Schofield <alison.schofield@intel.com>
AuthorDate:    Mon, 10 Jul 2023 13:02:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Sep 2023 16:13:34 -07:00

ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window

Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
CFMWS not in SRAT") did not account for the case where the BIOS
only partially describes a CFMWS Window in the SRAT. That means
the omitted address ranges, of a partially described CFMWS Window,
do not get assigned to a NUMA node.

Replace the call to phys_to_target_node() with numa_add_memblks().
Numa_add_memblks() searches an HPA range for existing memblk(s)
and extends those memblk(s) to fill the entire CFMWS Window.

Extending the existing memblks is a simple strategy that reuses
SRAT defined proximity domains from part of a window to fill out
the entire window, based on the knowledge* that all of a CFMWS
window is of a similar performance class.

*Note that this heuristic will evolve when CFMWS Windows present
a wider range of characteristics. The extension of the proximity
domain, implemented here, is likely a step in developing a more
sophisticated performance profile in the future.

There is no change in behavior when the SRAT does not describe
the CFMWS Window at all. In that case, a new NUMA node with a
single memblk covering the entire CFMWS Window is created.

Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
Link: https://lore.kernel.org/all/eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield%40intel.com
---
 drivers/acpi/numa/srat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1f4fc5f..12f330b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -310,11 +310,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
-	/* Skip if the SRAT already described the NUMA details for this HPA */
-	node = phys_to_target_node(start);
-	if (node != NUMA_NO_NODE)
+	/*
+	 * The SRAT may have already described NUMA details for all,
+	 * or a portion of, this CFMWS HPA range. Extend the memblks
+	 * found for any portion of the window to cover the entire
+	 * window.
+	 */
+	if (!numa_fill_memblks(start, end))
 		return 0;
 
+	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
 
 	if (node == NUMA_NO_NODE) {
