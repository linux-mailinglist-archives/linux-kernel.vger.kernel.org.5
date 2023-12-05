Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D78044C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjLECYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbjLECYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BA124;
        Mon,  4 Dec 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wU9rQ0WHNb7K2eVSmVt58rzaZ/jgSlXiNPhlH8JqqSU=; b=CMNsJnAO5W5GUIm/GCGKdv1gnh
        AbtJE1nqZ29lQH0iAZEBT2kYC4PGP4YqaXvRId7cbLU1qWwjwN94UgtgAK33snpgWe6weYNB7uUqE
        N9ONXc0u75jYiCYa55Q0u/koNQA9Zp2BJOvY31JiafAdEOBZfGhXxPy69Lj3/jFpK7269yac9jSbv
        DeYCtUJv5CvXqLyw/1KYr5ER1yKNOQpfvPsD7iHygUhKaOvuf2UgrSjJkaWTcaFCalMf7LDI1ipfC
        e3B4G0YG7EhesWIrTJ5L/PqC8Qf8F5nOTgz6Z494KtIZ9ARBqV8zZ4teTdThh+QfyH/h48/bFV9II
        rUBBAwbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6k-00793P-1b;
        Tue, 05 Dec 2023 02:24:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 11/18] x86: merge csum_fold() for 32bit and 64bit
Date:   Tue,  5 Dec 2023 02:24:11 +0000
Message-Id: <20231205022418.1703007-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identical.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 22 ++++++++++++++++++++++
 arch/x86/include/asm/checksum_32.h | 14 --------------
 arch/x86/include/asm/checksum_64.h | 18 ------------------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 6df6ece8a28e..eaa5dda09bee 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,13 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CHECKSUM_H
+#define _ASM_X86_CHECKSUM_H
 #ifdef CONFIG_GENERIC_CSUM
 # include <asm-generic/checksum.h>
 #else
 # define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
 # define HAVE_CSUM_COPY_USER
 # define _HAVE_ARCH_CSUM_AND_COPY
+
+/**
+ * csum_fold - Fold and invert a 32bit checksum.
+ * sum: 32bit unfolded sum
+ *
+ * Fold a 32bit running checksum to 16bit and invert it. This is usually
+ * the last step before putting a checksum into a packet.
+ * Make sure not to mix with 64bit checksums.
+ */
+static inline __sum16 csum_fold(__wsum sum)
+{
+	asm("  addl %1,%0\n"
+	    "  adcl $0xffff,%0"
+	    : "=r" (sum)
+	    : "r" ((__force u32)sum << 16),
+	      "0" ((__force u32)sum & 0xffff0000));
+	return (__force __sum16)(~(__force u32)sum >> 16);
+}
+
 # ifdef CONFIG_X86_32
 #  include <asm/checksum_32.h>
 # else
 #  include <asm/checksum_64.h>
 # endif
 #endif
+#endif
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 7570bdff7dea..4e96d0473f88 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -92,20 +92,6 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return (__force __sum16)sum;
 }
 
-/*
- *	Fold a partial checksum
- */
-
-static inline __sum16 csum_fold(__wsum sum)
-{
-	asm("addl %1, %0		;\n"
-	    "adcl $0xffff, %0	;\n"
-	    : "=r" (sum)
-	    : "r" ((__force u32)sum << 16),
-	      "0" ((__force u32)sum & 0xffff0000));
-	return (__force __sum16)(~(__force u32)sum >> 16);
-}
-
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
 					__wsum sum)
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 2bd75710eea1..d261b4124ca6 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -11,24 +11,6 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 
-/**
- * csum_fold - Fold and invert a 32bit checksum.
- * sum: 32bit unfolded sum
- *
- * Fold a 32bit running checksum to 16bit and invert it. This is usually
- * the last step before putting a checksum into a packet.
- * Make sure not to mix with 64bit checksums.
- */
-static inline __sum16 csum_fold(__wsum sum)
-{
-	asm("  addl %1,%0\n"
-	    "  adcl $0xffff,%0"
-	    : "=r" (sum)
-	    : "r" ((__force u32)sum << 16),
-	      "0" ((__force u32)sum & 0xffff0000));
-	return (__force __sum16)(~(__force u32)sum >> 16);
-}
-
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
-- 
2.39.2

