Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25C756E13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGQUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGQUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:19:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6084194;
        Mon, 17 Jul 2023 13:19:41 -0700 (PDT)
Date:   Mon, 17 Jul 2023 20:19:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689625180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5g+e7Kt7N77MeQFIg5zCypZ5xcAyk/U+HKCYby31Fyo=;
        b=0Vkkqv6rXDXMJrftEIS7sj/xF2s8HAlmY5tPQsQv9ftbwGa1hyvrFCvbw6HjEW81duQAKQ
        oM41APpPcBvkJoKb6nZIH9CWx3F2qw8sXwISmA3Xt5jCXaXdzD5gfvZDO5FcnwHlq7Y4CC
        E8Gv2XpRVCIpA4ZpwObGgZTyctY5TDulHPp3IsC73pysjdEt0O8AfZg9piXAQx143LXFs/
        rUt4c8JLzwoJVakcIoTgdjknn0l6eQervtWqkmJsyUYdBcuQZki+sPCHVMrdsWnNlVZfrP
        Kf5q9L1xsQJwJer6p3jJdja6T2c5vps4ES/FaE/+plPV+HtQOX4RuSJWfDB8+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689625180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5g+e7Kt7N77MeQFIg5zCypZ5xcAyk/U+HKCYby31Fyo=;
        b=PntMVBuDpiscCrpCJJP7/KmrkK9UkFUvnK/C0M3O9/t6Eriz4+M+p1yGmUtf4awGnJdai1
        9IlqBoZU1oEETeCg==
From:   "tip-bot2 for Janusz Krzysztofik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix PAT bit missing from page protection modify mask
Cc:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        marmarek@invisiblethingslab.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168962517947.28540.12391028567128094902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     548cb932051fb6232ac983ed6673dae7bdf3cf4c
Gitweb:        https://git.kernel.org/tip/548cb932051fb6232ac983ed6673dae7bdf=
3cf4c
Author:        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
AuthorDate:    Mon, 10 Jul 2023 09:36:14 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 17 Jul 2023 07:41:45 -07:00

x86/mm: Fix PAT bit missing from page protection modify mask

Visible glitches have been observed when running graphics applications on
Linux under Xen hypervisor.  Those observations have been confirmed with
failures from kms_pwrite_crc Intel GPU test that verifies data coherency
of DRM frame buffer objects using hardware CRC checksums calculated by
display controllers, exposed to userspace via debugfs.  Affected
processing paths have then been identified with new IGT test variants that
mmap the objects using different methods and caching modes [1].

When running as a Xen PV guest, Linux uses Xen provided PAT configuration
which is different from its native one.  In particular, Xen specific PTE
encoding of write-combining caching, likely used by graphics applications,
differs from the Linux default one found among statically defined minimal
set of supported modes.  Since Xen defines PTE encoding of the WC mode as
_PAGE_PAT, it no longer belongs to the minimal set, depends on correct
handling of _PAGE_PAT bit, and can be mismatched with write-back caching.

When a user calls mmap() for a DRM buffer object, DRM device specific
.mmap file operation, called from mmap_region(), takes care of setting PTE
encoding bits in a vm_page_prot field of an associated virtual memory area
structure.  Unfortunately, _PAGE_PAT bit is not preserved when the vma's
.vm_flags are then applied to .vm_page_prot via vm_set_page_prot().  Bits
to be preserved are determined with _PAGE_CHG_MASK symbol that doesn't
cover _PAGE_PAT.  As a consequence, WB caching is requested instead of WC
when running under Xen (also, WP is silently changed to WT, and UC
downgraded to UC_MINUS).  When running on bare metal, WC is not affected,
but WP and WT extra modes are unintentionally replaced with WC and UC,
respectively.

WP and WT modes, encoded with _PAGE_PAT bit set, were introduced by commit
281d4078bec3 ("x86: Make page cache mode a real type").  Care was taken
to extend _PAGE_CACHE_MASK symbol with that additional bit, but that
symbol has never been used for identification of bits preserved when
applying page protection flags.  Support for all cache modes under Xen,
including the problematic WC mode, was then introduced by commit
47591df50512 ("xen: Support Xen pv-domains using PAT").

The issue needs to be fixed by including _PAGE_PAT bit into a bitmask used
by pgprot_modify() for selecting bits to be preserved.  We can do that
either internally to pgprot_modify() (as initially proposed), or by making
_PAGE_PAT a part of _PAGE_CHG_MASK.  If we go for the latter then, since
_PAGE_PAT is the same as _PAGE_PSE, we need to note that _HPAGE_CHG_MASK
-- a huge pmds' counterpart of _PAGE_CHG_MASK, introduced by commit
c489f1257b8c ("thp: add pmd_modify"), defined as (_PAGE_CHG_MASK |
_PAGE_PSE) -- will no longer differ from _PAGE_CHG_MASK.  If such
modification of _PAGE_CHG_MASK was irrelevant to its users then one might
wonder why that new _HPAGE_CHG_MASK symbol was introduced instead of
reusing the existing one with that otherwise irrelevant bit (_PAGE_PSE in
that case) added.

Add _PAGE_PAT to _PAGE_CHG_MASK and _PAGE_PAT_LARGE to _HPAGE_CHG_MASK for
symmetry.  Split out common bits from both symbols to a common symbol for
clarity.

[ dhansen: tweak the solution changelog description ]

[1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/0f0754413f14

Fixes: 281d4078bec3 ("x86: Make page cache mode a real type")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>
Link: https://gitlab.freedesktop.org/drm/intel/-/issues/7648
Link: https://lore.kernel.org/all/20230710073613.8006-2-janusz.krzysztofik%40=
linux.intel.com
---
 arch/x86/include/asm/pgtable_types.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgta=
ble_types.h
index ba3e255..a6deb67 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -125,11 +125,12 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
-			 _PAGE_UFFD_WP)
-#define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
+#define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	      =
 \
+				 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |\
+				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC | \
+				 _PAGE_UFFD_WP)
+#define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
+#define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
=20
 /*
  * The cache modes defined here are used to translate between pure SW usage
