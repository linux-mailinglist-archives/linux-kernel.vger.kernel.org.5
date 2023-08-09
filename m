Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC27763C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjHIPeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjHIPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B4AE7F;
        Wed,  9 Aug 2023 08:34:14 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WILrrOGpLFY8XlMdloxHCDGWVqWLY6HfHNxqQ9dPRwE=;
        b=uCjV3VCE/dD6GzEiPnAGZyT2pg5DpW2PJiWO/1D5dv+lQdVV969oNaFX8zpmiquKWjzchb
        ZkIUFJ6HJcU6RnBgUwec71F2vcTVXMSictFH7JbWLTQ64BtOV+Gs7qQ61gAzWJTEe3JXwl
        +B6fKb5dudGoRGevcinIDGN+SPo5aYlLZ5v+M2Q7iPjKZA3FYfFouQOpHf/Go0wjb/iWlb
        O+4OQ1PpvABDQUragguy2HVG3dVpmSFa/5UTjlvhedmoGvrIW4M83cfV9UB7BQX7wZpOgk
        fDvCwmViE0HaZWyhXS++Mi/Hqw1mCNiMrOhlHLPyt3At0svF2F3Ecc6vMfzxvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WILrrOGpLFY8XlMdloxHCDGWVqWLY6HfHNxqQ9dPRwE=;
        b=Yf0VH66/Y/lsUGGVE6mSwoGJyvXTNWmRjXa0w7gCrO5Zs75B9gmwLrN2FnHet3bPfdBJ3t
        4NZnVuSHsmlXjKBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove check_phys_apicid_present()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525230.27769.8050526241257969168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b042d8d3878e80eda7ff89b1fe66d09f5dd026c5
Gitweb:        https://git.kernel.org/tip/b042d8d3878e80eda7ff89b1fe66d09f5dd026c5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:52 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Remove check_phys_apicid_present()

The only silly usage site is gone. Remove the gunk which was even outright
wrong in the bigsmp_32 case which returned true unconditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           | 2 --
 arch/x86/kernel/apic/apic_common.c    | 5 -----
 arch/x86/kernel/apic/apic_flat_64.c   | 2 --
 arch/x86/kernel/apic/apic_noop.c      | 2 --
 arch/x86/kernel/apic/apic_numachip.c  | 2 --
 arch/x86/kernel/apic/bigsmp_32.c      | 6 ------
 arch/x86/kernel/apic/probe_32.c       | 1 -
 arch/x86/kernel/apic/x2apic_cluster.c | 1 -
 arch/x86/kernel/apic/x2apic_phys.c    | 1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    | 1 -
 arch/x86/xen/apic.c                   | 1 -
 11 files changed, 24 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 35d236b..098d193 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -305,7 +305,6 @@ struct apic {
 	void	(*setup_apic_routing)(void);
 	int	(*cpu_present_to_apicid)(int mps_cpu);
 	void	(*apicid_to_cpu_present)(int phys_apicid, physid_mask_t *retmap);
-	int	(*check_phys_apicid_present)(int phys_apicid);
 	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(unsigned long x);
@@ -485,7 +484,6 @@ extern u32 apic_flat_calc_apicid(unsigned int cpu);
 extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
-extern int default_check_phys_apicid_present(int phys_apicid);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index e892506..41528bb 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -35,11 +35,6 @@ int default_cpu_present_to_apicid(int mps_cpu)
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
 
-int default_check_phys_apicid_present(int phys_apicid)
-{
-	return physid_isset(phys_apicid, phys_cpu_present_map);
-}
-
 int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 35cd1cb..00482cf 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -124,7 +124,6 @@ static struct apic apic_flat __ro_after_init = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
@@ -213,7 +212,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 90bf11e..c0c3b6b 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -107,8 +107,6 @@ struct apic apic_noop __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
-
 	.phys_pkg_id			= noop_phys_pkg_id,
 
 	.get_apic_id			= noop_get_apic_id,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index b6bbd7d..de16fde 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -257,7 +257,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip1_get_apic_id,
@@ -303,7 +302,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip2_get_apic_id,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 9e254dc..6f4bd71 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -63,11 +63,6 @@ static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *re
 	physids_promote(0xFFL, retmap);
 }
 
-static int bigsmp_check_phys_apicid_present(int phys_apicid)
-{
-	return 1;
-}
-
 static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
@@ -138,7 +133,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
-	.check_phys_apicid_present	= bigsmp_check_phys_apicid_present,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.get_apic_id			= bigsmp_get_apic_id,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 8d1e456..baa8b14 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -80,7 +80,6 @@ static struct apic apic_default __ro_after_init = {
 	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= default_phys_pkg_id,
 
 	.get_apic_id			= default_get_apic_id,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index ce1021c..931e0b9 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -250,7 +250,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 07bddaa..9cf32ce 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -174,7 +174,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0e23e41..0d812fd 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -846,7 +846,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index a5428d9..c8240af 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -154,7 +154,6 @@ static struct apic xen_pv_apic = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid, /* Used on 32-bit */
-	.check_phys_apicid_present	= default_check_phys_apicid_present, /* smp_sanity_check needs it */
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.get_apic_id 			= xen_get_apic_id,
