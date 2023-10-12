Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD17C76F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442498AbjJLTdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442277AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAFEB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D93CC433CB;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=tZdEqn1w87WS+WM9ek7GyN3isDR74GNY4m47jLbGxXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9/IyE5486myflRKbOIpKz4H5i1HFLoTbEeSeVn/aO/yv+eMJ3JbgCzgY7ptHx/Bl
         tVNvw7873SGZkgClEtpEsR9cvrdeVFQYeWsWzYsh7jBcQEy9v9HikO1lYTPcqWmcR/
         9CvGDIeTVw1wXqlOBuAOqiwtll43YE70tgEonZ1jDXFnMjC8y/SKVJeEagBacexZEt
         89Aoe1Holaz1mlbGCDdLv2LjvwIC1TbnlaYgkauLiI0mD3P6vt5gZbgPQxDTCzrkG2
         vuGGZ9cfWeELq+285bnduaOdYG3WHJe7+Rg4EXAfQgk+DIodHruWV3oGRgLWQtqaU4
         S5JgaQNO8rBzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D148CE0B6E; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 07/19] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
Date:   Thu, 12 Oct 2023 12:32:21 -0700
Message-Id: <20231012193233.207857-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Simplify memset() on the x86-64 arch.

The x86-64 arch has a 'rep stosb' instruction, which can perform
memset() using only a single instruction, given:

    %al  = value (just like the second argument of memset())
    %rdi = destination
    %rcx = length

Before this patch:
```
  00000000000010c9 <memset>:
    10c9: 48 89 f8              mov    %rdi,%rax
    10cc: 48 85 d2              test   %rdx,%rdx
    10cf: 74 0e                 je     10df <memset+0x16>
    10d1: 31 c9                 xor    %ecx,%ecx
    10d3: 40 88 34 08           mov    %sil,(%rax,%rcx,1)
    10d7: 48 ff c1              inc    %rcx
    10da: 48 39 ca              cmp    %rcx,%rdx
    10dd: 75 f4                 jne    10d3 <memset+0xa>
    10df: c3                    ret
```

After this patch:
```
  0000000000001511 <memset>:
    1511: 96                    xchg   %eax,%esi
    1512: 48 89 d1              mov    %rdx,%rcx
    1515: 57                    push   %rdi
    1516: f3 aa                 rep stos %al,%es:(%rdi)
    1518: 58                    pop    %rax
    1519: c3                    ret
```

v2:
  - Use pushq %rdi / popq %rax (Alviro).
  - Use xchg %eax, %esi (Willy).

Link: https://lore.kernel.org/lkml/ZO9e6h2jjVIMpBJP@1wt.eu
Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Suggested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h | 13 +++++++++++++
 tools/include/nolibc/string.h      |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index aece7d895153..68609f421934 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -179,6 +179,9 @@ void *memmove(void *dst, const void *src, size_t len);
 #define NOLIBC_ARCH_HAS_MEMCPY
 void *memcpy(void *dst, const void *src, size_t len);
 
+#define NOLIBC_ARCH_HAS_MEMSET
+void *memset(void *dst, int c, size_t len);
+
 __asm__ (
 ".section .text.nolibc_memmove_memcpy\n"
 ".weak memmove\n"
@@ -200,6 +203,16 @@ __asm__ (
 	"rep movsb\n\t"
 	"cld\n\t"
 	"retq\n"
+
+".section .text.nolibc_memset\n"
+".weak memset\n"
+"memset:\n"
+	"xchgl %eax, %esi\n\t"
+	"movq  %rdx, %rcx\n\t"
+	"pushq %rdi\n\t"
+	"rep stosb\n\t"
+	"popq  %rax\n\t"
+	"retq\n"
 );
 
 #endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 6eca267ec6fa..1bad6121ef8c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -84,6 +84,7 @@ void *memcpy(void *dst, const void *src, size_t len)
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMCPY */
 
+#ifndef NOLIBC_ARCH_HAS_MEMSET
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
@@ -99,6 +100,7 @@ void *memset(void *dst, int b, size_t len)
 	}
 	return dst;
 }
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMSET */
 
 static __attribute__((unused))
 char *strchr(const char *s, int c)
-- 
2.40.1

