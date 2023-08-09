Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE59E776A54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjHIUg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD2213D;
        Wed,  9 Aug 2023 13:36:14 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=390e1jRSm3hwpNGR9vjwORo14I3UCDhbjNCU2U4aOHo=;
        b=t5gpDV9wzZgMDzScbMNtPUqbjJw//+L3XdI/iNznPlYI80qHhxdr7NV1eLSD0RKbwv9S7r
        6szE+8MM5q4j7TbwYBGO1WNpCR57Sd3q5Vo75vfk999oP0YAXRz8ZY0pnUHZv8SUC0zKRs
        ukzjXmPBS1Eq/hoIeQ5ZUlvbo+vDxU6aVc9O85P7jLDYpLrgvxSSBPD37kgT63RCEc2bWe
        sAYCpeYp19sqGzYBoew/OAC7Qnc8ETrntymFA9nn6j9/Mr4N1Bm2wh6lbOQczwvKIFl7iA
        /T/VbGw2BBqoR+wgiT+Ar29J6+8JrKEdAxbWmBt3E5AGltRG9zgokPOYCJLUdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=390e1jRSm3hwpNGR9vjwORo14I3UCDhbjNCU2U4aOHo=;
        b=GBYllFpPoXNGME3oIJzutoL6PXc1r9X6o5swhaWeq33mYhVqy/twzkAwH48+12YFg1uEdB
        Ig2GQcxkMHXHtwBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Add max_apic_id member
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337228.27769.249432729938017857.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d92e5e7cf580ac59678fa40fd99aa8eb00f1ff52
Gitweb:        https://git.kernel.org/tip/d92e5e7cf580ac59678fa40fd99aa8eb00f1ff52
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:10 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:31 -07:00

x86/apic: Add max_apic_id member

There is really no point to have a callback which compares numbers.

Add a field which allows each APIC to store the maximum APIC ID supported
and fill it in for all APIC incarnations.

The next step will remove the callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           | 3 +++
 arch/x86/kernel/apic/apic_flat_64.c   | 2 ++
 arch/x86/kernel/apic/apic_noop.c      | 1 +
 arch/x86/kernel/apic/apic_numachip.c  | 2 ++
 arch/x86/kernel/apic/bigsmp_32.c      | 1 +
 arch/x86/kernel/apic/probe_32.c       | 1 +
 arch/x86/kernel/apic/x2apic_cluster.c | 1 +
 arch/x86/kernel/apic/x2apic_phys.c    | 1 +
 arch/x86/kernel/apic/x2apic_uv_x.c    | 1 +
 arch/x86/xen/apic.c                   | 1 +
 10 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5a01d51..42d3240 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -277,6 +277,9 @@ struct apic {
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
 
+	/* The limit of the APIC ID space. */
+	u32	max_apic_id;
+
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 1da865f..b5e85bb 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -94,6 +94,7 @@ static struct apic apic_flat __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
@@ -170,6 +171,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 36c1e28..d49c10d 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -80,6 +80,7 @@ struct apic apic_noop __ro_after_init = {
 
 	.phys_pkg_id			= noop_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
 	.set_apic_id			= NULL,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index e879dbb..43cbc24 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -239,6 +239,7 @@ static const struct apic apic_numachip1 __refconst = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
 	.set_apic_id			= numachip1_set_apic_id,
 
@@ -278,6 +279,7 @@ static const struct apic apic_numachip2 __refconst = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
 	.set_apic_id			= numachip2_set_apic_id,
 
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 32984bf..5f7a94b 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -91,6 +91,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
 	.set_apic_id			= NULL,
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index a861a77..7c4b5f7 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -47,6 +47,7 @@ static struct apic apic_default __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= default_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
 	.set_apic_id			= NULL,
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index afd2676..036dd1c 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -239,6 +239,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index c40d19b..d6495ac 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -163,6 +163,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index a8ed237..7d4eaa8 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -822,6 +822,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 0f71b2e..572814b 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -138,6 +138,7 @@ static struct apic xen_pv_apic = {
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id 			= xen_get_apic_id,
 	.set_apic_id 			= xen_set_apic_id, /* Can be NULL on 32-bit. */
 
