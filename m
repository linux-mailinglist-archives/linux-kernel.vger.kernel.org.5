Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9577FD62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354176AbjHQR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354236AbjHQR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:58:08 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6098E;
        Thu, 17 Aug 2023 10:58:06 -0700 (PDT)
Received: from [2601:18c:8180:ac39:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qWhFv-0006En-1X;
        Thu, 17 Aug 2023 13:57:59 -0400
Date:   Thu, 17 Aug 2023 13:57:59 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] mm,ima,kexec,of: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230817135759.0888e5ef@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to
drivers/of/kexec.c")
Cc: stable@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Mike Rappoport <rppt@kernel.org>
---
 drivers/of/kexec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

