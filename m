Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA87D1B76
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJUHPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:15:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68529D63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jiSiBuiy3MfeRHwTKx9ggo7j9CK0Yf7MhEKnGAukTI0=; b=Ttx3OJ37Haak9Mxpn8CZdlQqJm
        brejpnByJQXwoMBLIJuZ/JflPnKiyDt/6794OF700DqzQVOu3LNtvgtJZ454xUu8tHy611yUSofdq
        VZJ/tiUUjTV+qmUWcQz7slTdxelXrnZZMbpM4i13pHaafPWFaQ2FDjc8IwFOlYjqdXwewd2kGEI61
        5nsit4105QxMAkAxpqDuazzNnNOV8SdWYpM+I53IuckfoGpo7FxH+WRxssbr4mTd8tJjBjtFXzQhK
        jrcrb+sbXqGnOU6S2P67RqMPDCixGmHlJuPv+GDrqBRwCUfbuQKrLARvOB1tjt41ni0zaOT0Ifh0N
        cpiD7COQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qu6Cj-003KDt-2v;
        Sat, 21 Oct 2023 07:15:26 +0000
Date:   Sat, 21 Oct 2023 08:15:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Dumazet <edumazet@google.com>
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
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231021071525.GA789610@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019080615.GY800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:06:15AM +0100, Al Viro wrote:
> On Thu, Oct 19, 2023 at 09:39:45AM +0200, Eric Dumazet wrote:
> 
> > I wonder if the csum_and_copy_...() helpers are really needed in modern days,
> > with much bigger cpu caches.
> > 
> > Maybe we could remove them and use more standard copy + standard
> > checksum over kernel buffers.
> 
> FWIW, the reason we don't hit that shit all the time is that on almost
> all paths all-zeroes block of data would be rejected anyway/could not
> happen.  Note that e.g. for ICMPv6 the csum includes the pseudo-header
> and there's no way for that to be all-zeroes, etc.
> 
> Whatever we do long-term (and I'd really like to get that mess dealt
> with properly - fuckup is definitely mine, and I should have checked
> the users of that stuff properly back then), I don't believe that
> it's doable this late in the cycle.

Actually, I think I've a usable approach to fixing it for good.
Look: we need some way to return 32bit csum *and* report a fault
if it happens.  So let's make csum_and_copy_...() return u64 -
(u64)csum on success and -1ULL on failure.

It's not hard to adjust the sole callers of those primitives
to new calling conventions, and we don't have to mess with
overloading 0 for reporting, so we can start the sum at 0 instead
of ~0U.  Overhead is very low and it doesn't pull revolting
tricks with thread flags, etc.

I don't think -rc7 is a good time for that, though.  At the
very least it needs a review on linux-arch - I think I hadn't
fucked the ABI for returning u64 up, but...

Anyway, completely untested patch follows:

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 99d631e146b2..80c57b370edb 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -43,7 +43,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len);
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index 4d180d96f09e..72a67aebae09 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -75,8 +75,6 @@ static inline unsigned short from64to16(unsigned long x)
 	return out_v.us[0] + out_v.us[1];
 }
 
-
-
 /*
  * Ok. This isn't fun, but this is the EASY case.
  */
@@ -84,13 +82,13 @@ static inline unsigned long
 csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 			 long len)
 {
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 	unsigned long carry = 0;
 
 	while (len >= 0) {
 		unsigned long word;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return -1;
 		checksum += carry;
 		src++;
 		checksum += word;
@@ -104,7 +102,7 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 	if (len) {
 		unsigned long word, tmp;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return -1;
 		tmp = *dst;
 		mskql(word, len, word);
 		checksum += word;
@@ -113,7 +111,7 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16 (checksum);
 }
 
 /*
@@ -129,16 +127,16 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 	unsigned long first;
 	unsigned long word, carry;
 	unsigned long lastsrc = 7+len+(unsigned long)src;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	if (__get_word(ldq_u, first,src))
-		return 0;
+		return -1;
 	carry = 0;
 	while (len >= 0) {
 		unsigned long second;
 
 		if (__get_word(ldq_u, second, src+1))
-			return 0;
+			return -1;
 		extql(first, soff, word);
 		len -= 8;
 		src++;
@@ -157,7 +155,7 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 		unsigned long tmp;
 		unsigned long second;
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return -1;
 		tmp = *dst;
 		extql(first, soff, word);
 		extqh(second, soff, first);
@@ -169,7 +167,7 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16 (checksum);
 }
 
 /*
@@ -185,12 +183,12 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	unsigned long carry = 0;
 	unsigned long word;
 	unsigned long second_dest;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
 		if (__get_word(ldq, word, src))
-			return 0;
+			return -1;
 		len -= 8;
 		insql(word, doff, second_dest);
 		checksum += carry;
@@ -205,7 +203,7 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	if (len) {
 		checksum += carry;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return -1;
 		mskql(word, len, word);
 		len -= 8;
 		checksum += word;
@@ -226,7 +224,7 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	stq_u(partial_dest | second_dest, dst);
 out:
 	checksum += carry;
-	return checksum;
+	return from64to16 (checksum);
 }
 
 /*
@@ -242,10 +240,10 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 	unsigned long carry = 0;
 	unsigned long first;
 	unsigned long lastsrc;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	if (__get_word(ldq_u, first, src))
-		return 0;
+		return -1;
 	lastsrc = 7+len+(unsigned long)src;
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
@@ -253,7 +251,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, src+1))
-			return 0;
+			return -1;
 		extql(first, soff, word);
 		checksum += carry;
 		len -= 8;
@@ -275,7 +273,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return -1;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -297,7 +295,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return -1;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -310,22 +308,21 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		stq_u(partial_dest | word | second_dest, dst);
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16 (checksum);
 }
 
-static __wsum __csum_and_copy(const void __user *src, void *dst, int len)
+static unsigned long __csum_and_copy(const void __user *src, void *dst, int len)
 {
 	unsigned long soff = 7 & (unsigned long) src;
 	unsigned long doff = 7 & (unsigned long) dst;
-	unsigned long checksum;
 
 	if (!doff) {
 		if (!soff)
-			checksum = csum_partial_cfu_aligned(
+			return csum_partial_cfu_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst, len-8);
 		else
-			checksum = csum_partial_cfu_dest_aligned(
+			return csum_partial_cfu_dest_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				soff, len-8);
@@ -333,31 +330,28 @@ static __wsum __csum_and_copy(const void __user *src, void *dst, int len)
 		unsigned long partial_dest;
 		ldq_u(partial_dest, dst);
 		if (!soff)
-			checksum = csum_partial_cfu_src_aligned(
+			return csum_partial_cfu_src_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				doff, len-8, partial_dest);
 		else
-			checksum = csum_partial_cfu_unaligned(
+			return csum_partial_cfu_unaligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				soff, doff, len-8, partial_dest);
 	}
-	return (__force __wsum)from64to16 (checksum);
 }
 
-__wsum
-csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return -1;
 	return __csum_and_copy(src, dst, len);
 }
 
-__wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return __csum_and_copy((__force const void __user *)src,
+	return (__force __wsum)__csum_and_copy((__force const void __user *)src,
 						dst, len);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index d8a13959bff0..d56afc54192f 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -38,16 +38,16 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
-__wsum
+__u64
 csum_partial_copy_from_user(const void __user *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return -1;
 
 	return csum_partial_copy_from_user(src, dst, len);
 }
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 0fd5c10e90a7..5db935eaf165 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -86,7 +86,7 @@ sum	.req	r3
 
 FN_ENTRY
 		save_regs
-		mov	sum, #-1
+		mov	sum, #0
 
 		cmp	len, #8			@ Ensure that we have at least
 		blo	.Lless8			@ 8 bytes to copy.
@@ -160,6 +160,7 @@ FN_ENTRY
 		ldr	sum, [sp, #0]		@ dst
 		tst	sum, #1
 		movne	r0, r0, ror #8
+		mov	r1, #0
 		load_regs
 
 .Lsrc_not_aligned:
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 6928781e6bee..f273c9667914 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -73,11 +73,11 @@
 #include "csumpartialcopygeneric.S"
 
 /*
- * We report fault by returning 0 csum - impossible in normal case, since
- * we start with 0xffffffff for initial sum.
+ * We report fault by returning ~0ULL csum
  */
 		.pushsection .text.fixup,"ax"
 		.align	4
-9001:		mov	r0, #0
+9001:		mov	r0, #-1
+		mov	r1, #-1
 		load_regs
 		.popsection
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 692e7b6cc042..efe1d224092b 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -32,7 +32,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
-extern __wsum csum_and_copy_from_user(const void __user *src,
+extern __u64 csum_and_copy_from_user(const void __user *src,
 						void *dst,
 						int len);
 
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 5acb821849d3..25c2e6c18fba 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -128,7 +128,7 @@ EXPORT_SYMBOL(csum_partial);
  * copy from user space while checksumming, with exception handling.
  */
 
-__wsum
+__u64
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	/*
@@ -137,7 +137,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	 * code.
 	 */
 	unsigned long tmp1, tmp2;
-	__wsum sum = ~0U;
+	unsigned int sum = 0;
 
 	__asm__("movel %2,%4\n\t"
 		"btst #1,%4\n\t"	/* Check alignment */
@@ -240,7 +240,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 		".even\n"
 		/* If any exception occurs, return 0 */
 	     "90:\t"
-		"clrl %0\n"
+		"moveq #1,%5\n"
 		"jra 7b\n"
 		".previous\n"
 		".section __ex_table,\"a\"\n"
@@ -262,7 +262,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 		: "0" (sum), "1" (len), "2" (src), "3" (dst)
 	    );
 
-	return sum;
+	return tmp2 ? -1ULL : sum;
 }
 
 
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 4044eaf989ac..0bab8fe61678 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -34,16 +34,16 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_from_user(const void __user *src, void *dst, int len);
-__wsum __csum_partial_copy_to_user(const void *src, void __user *dst, int len);
+__u64 __csum_partial_copy_from_user(const void __user *src, void *dst, int len);
+__u64 __csum_partial_copy_to_user(const void *src, void __user *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	might_fault();
 	if (!access_ok(src, len))
-		return 0;
+		return -1;
 	return __csum_partial_copy_from_user(src, dst, len);
 }
 
@@ -52,11 +52,11 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
  */
 #define HAVE_CSUM_COPY_USER
 static inline
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
+__u64 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
 	might_fault();
 	if (!access_ok(dst, len))
-		return 0;
+		return -1;
 	return __csum_partial_copy_to_user(src, dst, len);
 }
 
@@ -65,10 +65,10 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
  * we have just one address space, so this is identical to the above)
  */
 #define _HAVE_ARCH_CSUM_AND_COPY
-__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len);
+__u64 __csum_partial_copy_nocheck(const void *src, void *dst, int len);
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return __csum_partial_copy_nocheck(src, dst, len);
+	return (__force __wsum)__csum_partial_copy_nocheck(src, dst, len);
 }
 
 /*
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 3d2ff4118d79..71618b42a4eb 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -437,7 +437,7 @@ EXPORT_SYMBOL(csum_partial)
 
 	.macro __BUILD_CSUM_PARTIAL_COPY_USER mode, from, to
 
-	li	sum, -1
+	move	sum, zero
 	move	odd, zero
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
@@ -723,6 +723,14 @@ EXPORT_SYMBOL(csum_partial)
 1:
 #endif
 	.set	pop
+#ifndef CONFIG_64BIT
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	move	v1, zero
+#else
+	move	v1, v0
+	move	v0, zero
+#endif
+#endif
 	.set reorder
 	jr	ra
 	.set noreorder
@@ -730,8 +738,11 @@ EXPORT_SYMBOL(csum_partial)
 
 	.set noreorder
 .L_exc:
+#ifndef CONFIG_64BIT
+	li	v1, -1
+#endif
 	jr	ra
-	 li	v0, 0
+	 li	v0, -1
 
 FEXPORT(__csum_partial_copy_nocheck)
 EXPORT_SYMBOL(__csum_partial_copy_nocheck)
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 4b573a3b7e17..2cc2db44fa64 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -18,18 +18,18 @@
  * Like csum_partial, this must be called with even lengths,
  * except for the last fragment.
  */
-extern __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+extern __u64 csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
+extern __u64 csum_and_copy_from_user(const void __user *src, void *dst,
 				      int len);
 #define HAVE_CSUM_COPY_USER
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
+extern __u64 csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len)   \
-        csum_partial_copy_generic((src), (dst), (len))
+        (__force __wsum)csum_partial_copy_generic((src), (dst), (len))
 
 
 /*
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index cd00b9bdd772..79b3ce0af858 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -122,7 +122,7 @@ LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
 
 _GLOBAL(csum_partial_copy_generic)
-	li	r12,-1
+	li	r12,0
 	addic	r0,r0,0			/* clear carry */
 	addi	r6,r4,-4
 	neg	r0,r4
@@ -233,12 +233,15 @@ _GLOBAL(csum_partial_copy_generic)
 	slwi	r0,r0,8
 	adde	r12,r12,r0
 66:	addze	r3,r12
+	mr	r4,r3
+	li	r3,0
 	beqlr+	cr7
-	rlwinm	r3,r3,8,0,31	/* odd destination address: rotate one byte */
+	rlwinm	r4,r4,8,0,31	/* odd destination address: rotate one byte */
 	blr
 
 fault:
-	li	r3,0
+	li	r3,-1
+	li	r4,-1
 	blr
 
 	EX_TABLE(70b, fault);
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index d53d8f09a2c2..3bbfeb98d256 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -208,7 +208,7 @@ EXPORT_SYMBOL(__csum_partial)
  * csum_partial_copy_generic(r3=src, r4=dst, r5=len)
  */
 _GLOBAL(csum_partial_copy_generic)
-	li	r6,-1
+	li	r6,0
 	addic	r0,r6,0			/* clear carry */
 
 	srdi.	r6,r5,3			/* less than 8 bytes? */
@@ -406,7 +406,7 @@ dstnr;	stb	r6,0(r4)
 	ld	r16,STK_REG(R16)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 .Lerror_nr:
-	li	r3,0
+	li	r3,-1
 	blr
 
 EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index 1a14c8780278..f59555b619df 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -11,13 +11,13 @@
 #include <asm/checksum.h>
 #include <linux/uaccess.h>
 
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+__u64 csum_and_copy_from_user(const void __user *src, void *dst,
 			       int len)
 {
-	__wsum csum;
+	__u64 csum;
 
 	if (unlikely(!user_read_access_begin(src, len)))
-		return 0;
+		return -1;
 
 	csum = csum_partial_copy_generic((void __force *)src, dst, len);
 
@@ -25,12 +25,12 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	return csum;
 }
 
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
+__u64 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	__wsum csum;
+	__u64 csum;
 
 	if (unlikely(!user_write_access_begin(dst, len)))
-		return 0;
+		return -1;
 
 	csum = csum_partial_copy_generic(src, (void __force *)dst, len);
 
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 2b5fa75b4651..8d5cd2554415 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -31,7 +31,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __u64 csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 /*
@@ -44,15 +44,15 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return (__wsum)csum_partial_copy_generic(src, dst, len);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return -1;
 	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
@@ -193,12 +193,12 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static inline __wsum csum_and_copy_to_user(const void *src,
+static inline __u64 csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len)
 {
 	if (!access_ok(dst, len))
-		return 0;
+		return -1;
 	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif /* __ASM_SH_CHECKSUM_H */
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..3ea88455d600 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -193,7 +193,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
 ! r6:	int LEN
 !
 ENTRY(csum_partial_copy_generic)
-	mov	#-1,r7
+	mov	#0,r7
 	mov	#3,r0		! Check src and dest are equally aligned
 	mov	r4,r1
 	and	r0,r1
@@ -352,14 +352,21 @@ EXC(	mov.b	r0,@r5	)
 6:	addc	r0,r7
 	mov	#0,r0
 	addc	r0,r7
-7:
 
 # Exception handler:
 .section .fixup, "ax"							
 
 6001:
+	mov	#-1,r1
 	rts
-	 mov	#0,r0
+	 mov	#-1,r0
 .previous
+#ifdef __LITTLE_ENDIAN__
+	mov	#0,r1
 	rts
 	 mov	r7,r0
+#else
+	mov	#0,r0
+	rts
+	 mov	r7,r1
+#endif
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index ce11e0ad80c7..5bb521017f20 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -50,7 +50,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 
 	__asm__ __volatile__ (
 		"call __csum_partial_copy_sparc_generic\n\t"
-		" mov -1, %%g7\n"
+		" clr %%g7\n"
 	: "=&r" (ret), "=&r" (d), "=&r" (l)
 	: "0" (ret), "1" (d), "2" (l)
 	: "o2", "o3", "o4", "o5", "o7",
@@ -59,20 +59,50 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 	return (__force __wsum)ret;
 }
 
-static inline __wsum
+static inline __u64
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
+	register unsigned int ret asm("o0") = (unsigned int)src;
+	register char *d asm("o1") = dst;
+	register int l asm("g1") = len; // used to return an error
+
 	if (unlikely(!access_ok(src, len)))
-		return 0;
-	return csum_partial_copy_nocheck((__force void *)src, dst, len);
+		return -1;
+
+	__asm__ __volatile__ (
+		"call __csum_partial_copy_sparc_generic\n\t"
+		" clr %%g7\n"
+	: "=&r" (ret), "=&r" (d), "=&r" (l)
+	: "0" (ret), "1" (d), "2" (l)
+	: "o2", "o3", "o4", "o5", "o7",
+	  "g2", "g3", "g4", "g5", "g7",
+	  "memory", "cc");
+	if (unlikely(l < 0))
+		return -1;
+	return ret;
 }
 
-static inline __wsum
+static inline __u64
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	if (!access_ok(dst, len))
-		return 0;
-	return csum_partial_copy_nocheck(src, (__force void *)dst, len);
+	register unsigned int ret asm("o0") = (unsigned int)src;
+	register char *d asm("o1") = (__force void *)dst;
+	register int l asm("g1") = len; // used to return an error
+
+	if (unlikely(!access_ok(dst, len)))
+		return -1;
+
+	__asm__ __volatile__ (
+		"call __csum_partial_copy_sparc_generic\n\t"
+		" clr %%g7\n"
+	: "=&r" (ret), "=&r" (d), "=&r" (l)
+	: "0" (ret), "1" (d), "2" (l)
+	: "o2", "o3", "o4", "o5", "o7",
+	  "g2", "g3", "g4", "g5", "g7",
+	  "memory", "cc");
+	if (unlikely(l < 0))
+		return -1;
+	return ret;
 }
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index d6b59461e064..ce8abb00ddf1 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -39,8 +39,8 @@ __wsum csum_partial(const void * buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
+__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len);
+__u64 csum_and_copy_to_user(const void *src, void __user *dst, int len);
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
  * the majority of the time.
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 84ad709cbecb..546968db199d 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
-	 clr	%o0
+	retl
+	 mov -1, %g1
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index f968e83bc93b..9312d51367d3 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -71,7 +71,7 @@
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
-	mov		-1, %o3
+	clr		%o3
 	clr		%o4
 	andcc		%g1, 0x3, %g0
 	bne,pn		%icc, 95f
diff --git a/arch/sparc/lib/csum_copy_from_user.S b/arch/sparc/lib/csum_copy_from_user.S
index b0ba8d4dd439..d74241692f0f 100644
--- a/arch/sparc/lib/csum_copy_from_user.S
+++ b/arch/sparc/lib/csum_copy_from_user.S
@@ -9,7 +9,7 @@
 	.section .fixup, "ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	0, %o0;		\
+	 mov	-1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
diff --git a/arch/sparc/lib/csum_copy_to_user.S b/arch/sparc/lib/csum_copy_to_user.S
index 91ba36dbf7d2..2878a933d7ab 100644
--- a/arch/sparc/lib/csum_copy_to_user.S
+++ b/arch/sparc/lib/csum_copy_to_user.S
@@ -9,7 +9,7 @@
 	.section .fixup,"ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	0, %o0;		\
+	 mov	-1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 17da95387997..44ce43bc7c0e 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -27,7 +27,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __u64 csum_partial_copy_generic(const void *src, void *dst, int len);
 
 /*
  *	Note: when you get a NULL pointer exception here this means someone
@@ -38,17 +38,17 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
  */
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return (__force __wsum)csum_partial_copy_generic(src, dst, len);
 }
 
-static inline __wsum csum_and_copy_from_user(const void __user *src,
+static inline __u64 csum_and_copy_from_user(const void __user *src,
 					     void *dst, int len)
 {
-	__wsum ret;
+	__u64 ret;
 
 	might_sleep();
 	if (!user_access_begin(src, len))
-		return 0;
+		return -1;
 	ret = csum_partial_copy_generic((__force void *)src, dst, len);
 	user_access_end();
 
@@ -168,15 +168,15 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 /*
  *	Copy and checksum to user
  */
-static inline __wsum csum_and_copy_to_user(const void *src,
+static inline __u64 csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len)
 {
-	__wsum ret;
+	__u64 ret;
 
 	might_sleep();
 	if (!user_access_begin(dst, len))
-		return 0;
+		return -1;
 
 	ret = csum_partial_copy_generic(src, (__force void *)dst, len);
 	user_access_end();
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 4d4a47a3a8ab..3a4543b75977 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -129,10 +129,10 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
 /* Do not call this directly. Use the wrappers below */
-extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+extern __visible __u64 csum_partial_copy_generic(const void *src, void *dst, int len);
 
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
+extern __u64 csum_and_copy_from_user(const void __user *src, void *dst, int len);
+extern __u64 csum_and_copy_to_user(const void *src, void __user *dst, int len);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /**
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 23318c338db0..5ab8dccbcc24 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -262,7 +262,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst,
 
 #define EXC(y...)						\
 	9999: y;						\
-	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLEAR_AX)
+	_ASM_EXTABLE_TYPE(9999b, 8f, EX_TYPE_UACCESS)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -278,7 +278,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movl ARGBASE+4(%esp),%esi	# src
 	movl ARGBASE+8(%esp),%edi	# dst
 
-	movl $-1, %eax			# sum
+	xorl %eax,%eax			# sum
 	testl $2, %edi			# Check alignment. 
 	jz 2f				# Jump if alignment is ok.
 	subl $2, %ecx			# Alignment uses up two bytes.
@@ -357,12 +357,16 @@ EXC(	movb %cl, (%edi)	)
 6:	addl %ecx, %eax
 	adcl $0, %eax
 7:
-
+	xorl %edx, %edx
 	popl %ebx
 	popl %esi
 	popl %edi
 	popl %ecx			# equivalent to addl $4,%esp
 	RET
+8:
+	movl $-1,%eax
+	movl $-1,%edx
+	jmp 8b
 SYM_FUNC_END(csum_partial_copy_generic)
 
 #else
@@ -388,7 +392,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movl ARGBASE+4(%esp),%esi	#src
 	movl ARGBASE+8(%esp),%edi	#dst	
 	movl ARGBASE+12(%esp),%ecx	#len
-	movl $-1, %eax			#sum
+	xorl %eax, %eax			#sum
 #	movl %ecx, %edx  
 	movl %ecx, %ebx  
 	movl %esi, %edx
@@ -430,11 +434,13 @@ EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
-
 	popl %esi
 	popl %edi
 	popl %ebx
 	RET
+8:
+	movl $-1,%eax
+	jmp 8b
 SYM_FUNC_END(csum_partial_copy_generic)
 				
 #undef ROUND
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index d9e16a2cf285..084181030dd3 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -44,7 +44,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movq  %r13, 3*8(%rsp)
 	movq  %r15, 4*8(%rsp)
 
-	movl  $-1, %eax
+	xorl  %eax, %eax
 	xorl  %r9d, %r9d
 	movl  %edx, %ecx
 	cmpl  $8, %ecx
@@ -249,8 +249,8 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	roll $8, %eax
 	jmp .Lout
 
-	/* Exception: just return 0 */
+	/* Exception: just return -1 */
 .Lfault:
-	xorl %eax, %eax
+	movq -1, %rax
 	jmp  .Lout
 SYM_FUNC_END(csum_partial_copy_generic)
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 145f9a0bde29..10c0e024e8c1 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -14,20 +14,18 @@
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad source address.
  *
- * Returns an 32bit unfolded checksum of the buffer.
+ * Returns an 32bit unfolded checksum of the buffer or -1ULL on error
  * src and dst are best aligned to 64bits.
  */
-__wsum
+__u64
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	__wsum sum;
+	__u64 sum;
 
 	might_sleep();
 	if (!user_access_begin(src, len))
-		return 0;
+		return -1;
 	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
 	user_access_end();
 	return sum;
@@ -38,20 +36,18 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad destination address.
  *
- * Returns an 32bit unfolded checksum of the buffer.
+ * Returns an 32bit unfolded checksum of the buffer or -1ULL on error
  * src and dst are best aligned to 64bits.
  */
-__wsum
+__u64
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	__wsum sum;
+	__u64 sum;
 
 	might_sleep();
 	if (!user_access_begin(dst, len))
-		return 0;
+		return -1;
 	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
 	user_access_end();
 	return sum;
@@ -62,14 +58,13 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
  * @src: source address
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @sum: initial sum that is added into the result (32bit unfolded)
  *
  * Returns an 32bit unfolded checksum of the buffer.
  */
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return (__force __wsum)csum_partial_copy_generic(src, dst, len);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 44ec1d0b2a35..a99c67220011 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -37,7 +37,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __u64 csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 /*
@@ -47,16 +47,16 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return (__force __wsum)csum_partial_copy_generic(src, dst, len);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+__u64 csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return -1;
 	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
@@ -237,11 +237,11 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
+static __inline__ __u64 csum_and_copy_to_user(const void *src,
 					       void __user *dst, int len)
 {
 	if (!access_ok(dst, len))
-		return 0;
+		return -1;
 	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif
diff --git a/arch/xtensa/lib/checksum.S b/arch/xtensa/lib/checksum.S
index ffee6f94c8f8..6084b84a05f5 100644
--- a/arch/xtensa/lib/checksum.S
+++ b/arch/xtensa/lib/checksum.S
@@ -192,7 +192,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
 ENTRY(csum_partial_copy_generic)
 
 	abi_entry_default
-	movi	a5, -1
+	movi	a5, 0
 	or	a10, a2, a3
 
 	/* We optimize the following alignment tests for the 4-byte
@@ -310,7 +310,13 @@ EX(10f)	s8i	a9, a3, 0
 #endif
 	ONES_ADD(a5, a9)
 8:
+#ifdef __XTENSA_EB__
+	mov	a3, a5
+	movi	a2, 0
+#else
 	mov	a2, a5
+	movi	a3, 0
+#endif
 	abi_ret_default
 
 5:
@@ -353,7 +359,8 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
 # Exception handler:
 .section .fixup, "ax"
 10:
-	movi	a2, 0
+	movi	a2, -1
+	movi	a3, -1
 	abi_ret_default
 
 .previous
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e7..72cfa74a532f 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <asm/types.h>
 #include <asm/byteorder.h>
+
 #include <asm/checksum.h>
 #if !defined(_HAVE_ARCH_COPY_AND_CSUM_FROM_USER) || !defined(HAVE_CSUM_COPY_USER)
 #include <linux/uaccess.h>
@@ -25,24 +26,24 @@
 
 #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static __always_inline
-__wsum csum_and_copy_from_user (const void __user *src, void *dst,
+u64 csum_and_copy_from_user (const void __user *src, void *dst,
 				      int len)
 {
 	if (copy_from_user(dst, src, len))
-		return 0;
-	return csum_partial(dst, len, ~0U);
+		return -1;
+	return csum_partial(dst, len, 0);
 }
 #endif
 
 #ifndef HAVE_CSUM_COPY_USER
-static __always_inline __wsum csum_and_copy_to_user
+static __always_inline u64 csum_and_copy_to_user
 (const void *src, void __user *dst, int len)
 {
-	__wsum sum = csum_partial(src, len, ~0U);
+	__wsum sum = csum_partial(src, len, 0);
 
 	if (copy_to_user(dst, src, len) == 0)
-		return sum;
-	return 0;
+		return (__force u64)sum;
+	return -1;
 }
 #endif
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..43b1be69c61d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1184,15 +1184,16 @@ EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-	__wsum sum, next;
+	__wsum sum;
+	__u64 next;
 	sum = *csum;
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_from_user(base, addr + off, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
+		sum = csum_block_add(sum, (__force __wsum)next, off);
+		unlikely(next >> 32) ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(addr + off, base, len, sum, off);
 	})
@@ -1206,7 +1207,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 			     struct iov_iter *i)
 {
 	struct csum_state *csstate = _csstate;
-	__wsum sum, next;
+	__wsum sum;
+	__u64 next;
 
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
@@ -1222,8 +1224,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	sum = csum_shift(csstate->csum, csstate->off);
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_to_user(addr + off, base, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
+		sum = csum_block_add(sum, (__force __wsum)next, off);
+		unlikely(next >> 32) ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(base, addr + off, len, sum, off);
 	})
