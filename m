Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711C759F00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGSTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGSTwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:52:46 -0400
X-Greylist: delayed 654 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 12:52:44 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3CA7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:52:44 -0700 (PDT)
Received: from [2601:18c:8180:ac39:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qMD3N-0007gS-36;
        Wed, 19 Jul 2023 15:41:41 -0400
Date:   Wed, 19 Jul 2023 15:41:37 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] mm,memblock: reset memblock.reserved to system init state
 to  prevent UAF
Message-ID: <20230719154137.732d8525@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memblock_discard function frees the memblock.reserved.regions
array, which is good.

However, if a subsequent memblock_free (or memblock_phys_free) comes
in later, from for example ima_free_kexec_buffer, that will result in
a use after free bug in memblock_isolate_range.

When running a kernel with CONFIG_KASAN enabled, this will cause a
kernel panic very early in boot. Without CONFIG_KASAN, there is
a chance that memblock_isolate_range might scribble on memory
that is now in use by somebody else.

Avoid those issues by making sure that memblock_discard points
memblock.reserved.regions back at the static buffer.

If memblock_discard is called while there is still memory
in the memblock.reserved type, that will print a warning
in memblock_remove_region.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/memblock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..068289a46903 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -374,6 +374,10 @@ void __init memblock_discard(void)
 			kfree(memblock.reserved.regions);
 		else
 			memblock_free_late(addr, size);
+		/* Reset to prevent UAF from stray frees. */
+		memblock.reserved.regions = memblock_reserved_init_regions;
+		memblock.reserved.cnt = 1;
+		memblock_remove_region(&memblock.reserved, 0);
 	}
 
 	if (memblock.memory.regions != memblock_memory_init_regions) {
-- 
2.34.1


