Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A87E4A25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjKGUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjKGUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:55:17 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7A10D4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:55:15 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: [PATCH] objtool: Fix calloc call for new -Walloc-size
Date:   Tue,  7 Nov 2023 20:55:00 +0000
Message-ID: <20231107205504.1470006-1-sam@gentoo.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
like:
```
check.c: In function ‘cfi_alloc’:
check.c:294:33: error: allocation of insufficient size ‘1’ for type ‘struct cfi_state’ with size ‘320’ [-Werror=alloc-size]
  294 |         struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
      |                                 ^~~~~~
```

The calloc prototype is:
```
void *calloc(size_t nmemb, size_t size);
```

So, just swap the number of members and size arguments to match the prototype, as
we're initialising 1 struct of size `sizeof(struct ...)`. GCC then sees we're not
doing anything wrong.

Signed-off-by: Sam James <sam@gentoo.org>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e09ca9..548ec3cd7c00 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -291,7 +291,7 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
 
 static struct cfi_state *cfi_alloc(void)
 {
-	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+	struct cfi_state *cfi = calloc(1, sizeof(struct cfi_state));
 	if (!cfi) {
 		WARN("calloc failed");
 		exit(1);
-- 
2.42.1

