Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855FF7CE814
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjJRTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJRTsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:41 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F34112;
        Wed, 18 Oct 2023 12:48:40 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D9F3D41278;
        Wed, 18 Oct 2023 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658517;
        bh=akRPdsuxgfM7TUpwqvyZcc5fI99VwIoThOnPdsadFUs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=haOA7IU0Yctk9yWOwRriiqZYVQ1Y5ofoilUpG6CeNxv/Z+F6X4Oqxtpx0n0hnXTPj
         SCyGRNZavw2ahrMYWci+37gkGp9yIJ7smfL/LZO6dCqbLZ833yRnaKEbZtrOC8lGdW
         ++nLy5HOf2J/0GdzjOSvqEb/eTpxKgaPV4XV1neKY8yQ+XKrH4yMQooGESt2GZt0Tu
         BYTUOSj1YLzAY5O6jC77mAp8gJz6IifrTAZB2GKgg7+ALdVe3Fy9Z3JGmfjXf6mLhQ
         IKbsmmWy9E6bi2rm56jhLAT42CftAyJk51PwvlncqB0h7L5LONi1gOVhBdR2UYg3/V
         26fleQ0Zi+uNA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>
Subject: [PATCH RT 01/12] io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().
Date:   Wed, 18 Oct 2023 15:48:22 -0400
Message-Id: <20231018194833.651674-2-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


io_mapping_map_atomic_wc() disables preemption and pagefaults for
historical reasons.  The conversion to io_mapping_map_local_wc(), which
only disables migration, cannot be done wholesale because quite some call
sites need to be updated to accommodate with the changed semantics.

On PREEMPT_RT enabled kernels the io_mapping_map_atomic_wc() semantics are
problematic due to the implicit disabling of preemption which makes it
impossible to acquire 'sleeping' spinlocks within the mapped atomic
sections.

PREEMPT_RT replaces the preempt_disable() with a migrate_disable() for
more than a decade.  It could be argued that this is a justification to do
this unconditionally, but PREEMPT_RT covers only a limited number of
architectures and it disables some functionality which limits the coverage
further.

Limit the replacement to PREEMPT_RT for now.  This is also done
kmap_atomic().

Link: https://lkml.kernel.org/r/20230310162905.O57Pj7hh@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
  Link: https://lore.kernel.org/CAFLxGvw0WMxaMqYqJ5WgvVSbKHq2D2xcXTOgMCpgq9nDC-MWTQ@mail.gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7eb16f23b9a415f062db22739e59bb144e0b24ab)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 include/linux/io-mapping.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index e9743cfd8585..b0f196e51dca 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,10 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
@@ -79,7 +82,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	kunmap_local_indexed((void __force *)vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
 
 static inline void __iomem *
@@ -168,7 +174,10 @@ static inline void __iomem *
 io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
@@ -178,7 +187,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
 
 static inline void __iomem *
-- 
2.34.1

