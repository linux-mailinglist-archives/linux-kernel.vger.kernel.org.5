Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE575B125
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGTOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjGTOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:22:47 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 07:22:45 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8782703;
        Thu, 20 Jul 2023 07:22:44 -0700 (PDT)
Received: from [2601:18c:8180:ac39:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qMUQN-0001k2-2d;
        Thu, 20 Jul 2023 10:14:35 -0400
Date:   Thu, 20 Jul 2023 10:14:31 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, Mike Rapoport <rppt@kernel.org>,
        devicetree@vger.kernel.org, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] mm,ima,kexec: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230720101431.71640c8a@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code calling ima_free_kexec_buffer runs long after the memblock
allocator has already been torn down, potentially resulting in a use
after free in memblock_isolate_range.

With KASAN or KFENCE, this use after free will result in a BUG
from the idle task, and a subsequent kernel panic.

Switch ima_free_kexec_buffer over to memblock_free_late to avoid
that issue.

Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c")
Cc: stable@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Mike Rappoport <rppt@kernel.org>
---
 arch/x86/kernel/setup.c | 8 ++------
 drivers/of/kexec.c      | 3 ++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..aa0df37c1fe7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -359,15 +359,11 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 #if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
 int __init ima_free_kexec_buffer(void)
 {
-	int rc;
-
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
-	rc = memblock_phys_free(ima_kexec_buffer_phys,
-				ima_kexec_buffer_size);
-	if (rc)
-		return rc;
+	memblock_free_late(ima_kexec_buffer_phys,
+			   ima_kexec_buffer_size);
 
 	ima_kexec_buffer_phys = 0;
 	ima_kexec_buffer_size = 0;
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f26d2ba8a371..68278340cecf 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -184,7 +184,8 @@ int __init ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_phys_free(addr, size);
+	memblock_free_late(addr, size);
+	return 0;
 }
 #endif
 
-- 
2.41.0

