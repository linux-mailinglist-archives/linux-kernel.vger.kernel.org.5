Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A48044C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjLECZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbjLECYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B660129;
        Mon,  4 Dec 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p0QbRDSGTsnljguGwK4onaxu6aufljbSVtROKxqrxWo=; b=JCGDI0mdMpbr3QTQ3xsS99jCIF
        47/7SqdYFe8jCE+UeMmmKc2DP6Bt6JbuboXllqJHXoFfhHnuJltiSEbkKbO10C9LCz0qPC+vYwNIF
        bMHyARtjXbkOV4ej2DCtJtDQj4pSgSefY7qOiT92W740/S/ZCUcCGOmDYwvXMOWIry+JFhzTfl8Oc
        LvntpLu/5LTvAWeGh53Zws1qaOfXRnjS187tNPTtB74/bZKSy96Z0ytZSte3YqcrqAKQrAZZ/S0AW
        NhF8EoX0/+RhlaXQeHqvvnBPCAsSbfz42QiAhe0lM/s5oLx9fZ2Z2mgWAU1Fu9TFIQOWd1rejoy6R
        R1iPPwbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6k-00793j-3C;
        Tue, 05 Dec 2023 02:24:23 +0000
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
Subject: [PATCH v2 13/18] x86: merge csum_tcpudp_nofold() for 32bit and 64bit
Date:   Tue,  5 Dec 2023 02:24:13 +0000
Message-Id: <20231205022418.1703007-22-viro@zeniv.linux.org.uk>
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
 arch/x86/include/asm/checksum.h    | 25 +++++++++++++++++++++++++
 arch/x86/include/asm/checksum_32.h | 14 --------------
 arch/x86/include/asm/checksum_64.h | 26 --------------------------
 3 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 5e617a380537..c66fa797703a 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -26,6 +26,31 @@ static inline __sum16 csum_fold(__wsum sum)
 	return (__force __sum16)(~(__force u32)sum >> 16);
 }
 
+/**
+ * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
+ * @saddr: source address
+ * @daddr: destination address
+ * @len: length of packet
+ * @proto: ip protocol of packet
+ * @sum: initial sum to be added in (32bit unfolded)
+ *
+ * Returns the pseudo header checksum the input data. Result is
+ * 32bit unfolded.
+ */
+static inline __wsum
+csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
+		   __u8 proto, __wsum sum)
+{
+	asm("  addl %1, %0\n"
+	    "  adcl %2, %0\n"
+	    "  adcl %3, %0\n"
+	    "  adcl $0, %0\n"
+	    : "=r" (sum)
+	    : "g" (daddr), "g" (saddr),
+	      "g" ((len + proto)<<8), "0" (sum));
+	return sum;
+}
+
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index d920e6c335bc..959f8c6f5247 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -55,20 +55,6 @@ static inline __wsum_fault csum_and_copy_from_user(const void __user *src,
 	return ret;
 }
 
-static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	asm("addl %1, %0	;\n"
-	    "adcl %2, %0	;\n"
-	    "adcl %3, %0	;\n"
-	    "adcl $0, %0	;\n"
-	    : "=r" (sum)
-	    : "g" (daddr), "g"(saddr),
-	      "g" ((len + proto) << 8), "0" (sum));
-	return sum;
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 				      const struct in6_addr *daddr,
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index b80c82590d8d..e225a12cec68 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -11,32 +11,6 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 
-/**
- * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
- * @saddr: source address
- * @daddr: destination address
- * @len: length of packet
- * @proto: ip protocol of packet
- * @sum: initial sum to be added in (32bit unfolded)
- *
- * Returns the pseudo header checksum the input data. Result is
- * 32bit unfolded.
- */
-static inline __wsum
-csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
-		   __u8 proto, __wsum sum)
-{
-	asm("  addl %1, %0\n"
-	    "  adcl %2, %0\n"
-	    "  adcl %3, %0\n"
-	    "  adcl $0, %0\n"
-	    : "=r" (sum)
-	    : "g" (daddr), "g" (saddr),
-	      "g" ((len + proto)<<8), "0" (sum));
-	return sum;
-}
-
-
 /**
  * csum_partial - Compute an internet checksum.
  * @buff: buffer to be checksummed
-- 
2.39.2

