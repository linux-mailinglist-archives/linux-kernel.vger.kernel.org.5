Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4EC78D98E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjH3SdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbjH3N5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:57:53 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED5C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403870;
        bh=+oMZFii0whVGbdwH8pUpekgq85QDy15fOQgKa9a73pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tUranpan3lHKDejmmUM6IFSKipf93sVsIUWGiRLkuDyZJI5nSJHwKhP0mnLK5fP+3
         uR1snhiBNUCgPaRvnbpDB/9DkkmlGeuEjomvpkqhRII9or/GSZLDnbley7ahM9qCM5
         /FcdRKKwIgp2u/hSaEGM58shCpe+dNqrcFyma7k6WHSfCxh2q1lVgcJkFOLVzyNsRv
         kQTXEA2BKi6xSerLZUuqf9DGJ2Z9HLgwAQjCrevgjO3uq5iRmAYlKfG6f4u1yliVBm
         VFfSzcArGOrKbtrLtltVr6Ik3WZxU+mdIMp/U6nZyiuG8nR/ci0ytWjJL9tIhtBFfv
         lk4lwD92oEadA==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 3CE9324B32D;
        Wed, 30 Aug 2023 20:57:46 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for `memcmp()`
Date:   Wed, 30 Aug 2023 20:57:24 +0700
Message-Id: <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify memcmp() on the x86-64 arch.

The x86-64 arch has a 'rep cmpsb' instruction, which can be used to
implement the memcmp() function.

    %rdi = source 1
    %rsi = source 2
    %rcx = length

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 19 +++++++++++++++++++
 tools/include/nolibc/string.h      |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 42f2674ad1ecdd64..6c1b54ba9f774e7b 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -214,4 +214,23 @@ __asm__ (
 	"retq\n"
 );
 
+#define NOLIBC_ARCH_HAS_MEMCMP
+static int memcmp(const void *s1, const void *s2, size_t n)
+{
+	const unsigned char *p1 = s1;
+	const unsigned char *p2 = s2;
+
+	if (!n)
+		return 0;
+
+	__asm__ volatile (
+		"rep cmpsb"
+		: "+D"(p2), "+S"(p1), "+c"(n)
+		: "m"(*(const unsigned char (*)[n])s1),
+		  "m"(*(const unsigned char (*)[n])s2)
+	);
+
+	return p1[-1] - p2[-1];
+}
+
 #endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 1bad6121ef8c4ab5..3c941289d5dd0985 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -15,6 +15,7 @@ static void *malloc(size_t len);
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+#ifndef NOLIBC_ARCH_HAS_MEMCMP
 static __attribute__((unused))
 int memcmp(const void *s1, const void *s2, size_t n)
 {
@@ -26,6 +27,7 @@ int memcmp(const void *s1, const void *s2, size_t n)
 	}
 	return c1;
 }
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMCMP */
 
 static __attribute__((unused))
 void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
-- 
Ammar Faizi

