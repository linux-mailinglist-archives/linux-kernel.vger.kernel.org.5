Return-Path: <linux-kernel+bounces-68587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFD857CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788471F218C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F1128824;
	Fri, 16 Feb 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PErlJbbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318B7867E;
	Fri, 16 Feb 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087137; cv=none; b=WrGN239/Crv5SdedEZPc4wsXy/S2StG5xUkOD9NssawEqOUZlKN2fbB9QocQ113X7VnzZD04FBfqlaB04vHFKotfuZzun23uzlfjNPSs84v161h2EeQBqhlfB6O3ZWZ6+CHbQ6//N7qURW69k8To3qSg/BEEXZAC5XQQODBZP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087137; c=relaxed/simple;
	bh=57FD/1eODFZ9dbfGNXBX0p70pg6RhSWmzxSwztEUgUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuINq3JgJM329JwxPGWcz5e8Z9UiFU2PZLB+GpbqVTngCDGNUAhW3r9pJlqgztRru8WqFWQjxISo4SiYvBhW6Lv1kbIamZlDY4qetfx6JLbqef8zaFoVTqf7j8YaQ5SHubXrOS5kqDa/NNnf+MNXw4SCQHKX7d2rW+pHdAAO4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PErlJbbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8DC43390;
	Fri, 16 Feb 2024 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708087136;
	bh=57FD/1eODFZ9dbfGNXBX0p70pg6RhSWmzxSwztEUgUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PErlJbbcE8GQ0AKDggMEs6PDd/jWQfLwzqEuyJsZl78d9jpJKodjsmLwcEkTs4zVx
	 49gk4PMHisgz0/TZ+XC9Z09Fe94NmECBV+IcMwajLGm9LcnOZYcc85gQhHSPwCq2Wc
	 N6Y4yb4cNSDqj7i6xEOnMjHCUwWeGhnfw6YEWXIi/CzPWPjkF5UgnOPFHOCRvQiS6B
	 b3fqgkjY468zMkUvgku2YXXdnlw3ZFcniPN22PXi1XLoqrrB5gcm1Ak3f+QhncTIpx
	 w79W3+q7DzxzgrDYMhSb3qYUTdYE1jLT7QkSQWRUBXpIU+FgoacZu9oH/lleUC2T4z
	 LKnmbSS7ZZttQ==
Date: Fri, 16 Feb 2024 13:38:51 +0100
From: Helge Deller <deller@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Message-ID: <Zc9XW-TxQKp84vMt@p100>
References: <20240213234631.940055-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213234631.940055-1-linux@roeck-us.net>

* Guenter Roeck <linux@roeck-us.net>:
> hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
> operations. The last add folds protocol and length fields into the 64-bit
> result. While unlikely, this operation can overflow. The overflow can be
> triggered with a code sequence such as the following.
> 
> 	/* try to trigger massive overflows */
> 	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
> 	csum_result = csum_ipv6_magic((struct in6_addr *)tmp_buf,
> 				      (struct in6_addr *)tmp_buf,
> 				      0xffff, 0xff, 0xffffffff);
> 
> Fix the problem by adding any overflows from the final add operation into
> the calculated checksum. Fortunately, we can do this without additional
> cost by replacing the add operation used to fold the checksum into 32 bit
> with "add,dc" to add in the missing carry.


Gunter,

Thanks for your patch for 32- and 64-bit systems.
But I think it's time to sunset the parisc inline assembly for ipv4/ipv6
checksumming.
The patch below converts the code to use standard C-coding (taken from the
s390 header file) and it survives the v8 lib/checksum patch.

Opinions?

Helge

Subject: [PATCH] parisc: Fix csum_ipv6_magic on 32- and 64-bit machines

Guenter noticed that the 32- and 64-bit checksum functions may calculate
wrong values under certain circumstances. He fixed it by usining
corrected carry-flags added, but overall I think it's better to convert
away from inline assembly to generic C-coding.  That way the code is
much cleaner and the compiler can do much better optimizations based on
the target architecture (32- vs. 64-bit). Furthermore, the compiler
generates nowadays much better code, so inline assembly usually won't
give any benefit any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b39..c72f14536353 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -18,160 +18,93 @@
  */
 extern __wsum csum_partial(const void *, int, __wsum);
 
+
 /*
- *	Optimized for IP headers, which always checksum on 4 octet boundaries.
- *
- *	Written by Randolph Chung <tausq@debian.org>, and then mucked with by
- *	LaMont Jones <lamont@debian.org>
+ * Fold a partial checksum without adding pseudo headers.
  */
-static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+static inline __sum16 csum_fold(__wsum sum)
 {
-	unsigned int sum;
-	unsigned long t0, t1, t2;
+	u32 csum = (__force u32) sum;
 
-	__asm__ __volatile__ (
-"	ldws,ma		4(%1), %0\n"
-"	addib,<=	-4, %2, 2f\n"
-"\n"
-"	ldws		4(%1), %4\n"
-"	ldws		8(%1), %5\n"
-"	add		%0, %4, %0\n"
-"	ldws,ma		12(%1), %3\n"
-"	addc		%0, %5, %0\n"
-"	addc		%0, %3, %0\n"
-"1:	ldws,ma		4(%1), %3\n"
-"	addib,<		0, %2, 1b\n"
-"	addc		%0, %3, %0\n"
-"\n"
-"	extru		%0, 31, 16, %4\n"
-"	extru		%0, 15, 16, %5\n"
-"	addc		%4, %5, %0\n"
-"	extru		%0, 15, 16, %5\n"
-"	add		%0, %5, %0\n"
-"	subi		-1, %0, %0\n"
-"2:\n"
-	: "=r" (sum), "=r" (iph), "=r" (ihl), "=r" (t0), "=r" (t1), "=r" (t2)
-	: "1" (iph), "2" (ihl)
-	: "memory");
-
-	return (__force __sum16)sum;
+	csum += (csum >> 16) | (csum << 16);
+	csum >>= 16;
+	return (__force __sum16) ~csum;
 }
 
 /*
- *	Fold a partial checksum
+ * This is a version of ip_compute_csum() optimized for IP headers,
+ * which always checksums on 4 octet boundaries.
  */
-static inline __sum16 csum_fold(__wsum csum)
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
-	u32 sum = (__force u32)csum;
-	/* add the swapped two 16-bit halves of sum,
-	   a possible carry from adding the two 16-bit halves,
-	   will carry from the lower half into the upper half,
-	   giving us the correct sum in the upper half. */
-	sum += (sum << 16) + (sum >> 16);
-	return (__force __sum16)(~sum >> 16);
+	__u64 csum = 0;
+	__u32 *ptr = (u32 *)iph;
+
+	csum += *ptr++;
+	csum += *ptr++;
+	csum += *ptr++;
+	csum += *ptr++;
+	ihl -= 4;
+	while (ihl--)
+		csum += *ptr++;
+	csum += (csum >> 32) | (csum << 32);
+	return csum_fold((__force __wsum)(csum >> 32));
 }
- 
-static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
+
+/*
+ * Computes the checksum of the TCP/UDP pseudo-header.
+ * Returns a 32-bit checksum.
+ */
+static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
+					__u8 proto, __wsum sum)
 {
-	__asm__(
-	"	add  %1, %0, %0\n"
-	"	addc %2, %0, %0\n"
-	"	addc %3, %0, %0\n"
-	"	addc %%r0, %0, %0\n"
-		: "=r" (sum)
-		: "r" (daddr), "r"(saddr), "r"(proto+len), "0"(sum));
-	return sum;
+	__u64 csum = (__force __u64)sum;
+
+	csum += (__force __u32)saddr;
+	csum += (__force __u32)daddr;
+	csum += len;
+	csum += proto;
+	csum += (csum >> 32) | (csum << 32);
+	return (__force __wsum)(csum >> 32);
 }
 
 /*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
+ * Computes the checksum of the TCP/UDP pseudo-header.
+ * Returns a 16-bit checksum, already complemented.
  */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
+					__u8 proto, __wsum sum)
 {
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
+	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
 }
 
 /*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
+ * Used for miscellaneous IP-like checksums, mainly icmp.
  */
-static inline __sum16 ip_compute_csum(const void *buf, int len)
+static inline __sum16 ip_compute_csum(const void *buff, int len)
 {
-	 return csum_fold (csum_partial(buf, len, 0));
+	return csum_fold(csum_partial(buff, len, 0));
 }
 
-
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-					  const struct in6_addr *daddr,
-					  __u32 len, __u8 proto,
-					  __wsum sum)
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+				      __u32 len, __u8 proto, __wsum csum)
 {
-	unsigned long t0, t1, t2, t3;
-
-	len += proto;	/* add 16-bit proto + len */
-
-	__asm__ __volatile__ (
-
-#if BITS_PER_LONG > 32
-
-	/*
-	** We can execute two loads and two adds per cycle on PA 8000.
-	** But add insn's get serialized waiting for the carry bit.
-	** Try to keep 4 registers with "live" values ahead of the ALU.
-	*/
-
-"	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
-"	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
-"	add		%4, %0, %0\n"
-"	ldd,ma		8(%1), %6\n"	/* 2nd saddr */
-"	ldd,ma		8(%2), %7\n"	/* 2nd daddr */
-"	add,dc		%5, %0, %0\n"
-"	add,dc		%6, %0, %0\n"
-"	add,dc		%7, %0, %0\n"
-"	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
-"	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
-"	depdi		0, 31, 32, %0\n"/* clear upper half */
-"	add		%4, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"	/* add carry */
-
-#else
-
-	/*
-	** For PA 1.x, the insn order doesn't matter as much.
-	** Insn stream is serialized on the carry bit here too.
-	** result from the previous operation (eg r0 + x)
-	*/
-"	ldw,ma		4(%1), %4\n"	/* get 1st saddr word */
-"	ldw,ma		4(%2), %5\n"	/* get 1st daddr word */
-"	add		%4, %0, %0\n"
-"	ldw,ma		4(%1), %6\n"	/* 2nd saddr */
-"	addc		%5, %0, %0\n"
-"	ldw,ma		4(%2), %7\n"	/* 2nd daddr */
-"	addc		%6, %0, %0\n"
-"	ldw,ma		4(%1), %4\n"	/* 3rd saddr */
-"	addc		%7, %0, %0\n"
-"	ldw,ma		4(%2), %5\n"	/* 3rd daddr */
-"	addc		%4, %0, %0\n"
-"	ldw,ma		4(%1), %6\n"	/* 4th saddr */
-"	addc		%5, %0, %0\n"
-"	ldw,ma		4(%2), %7\n"	/* 4th daddr */
-"	addc		%6, %0, %0\n"
-"	addc		%7, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
-
-#endif
-	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
-	  "=r" (t0), "=r" (t1), "=r" (t2), "=r" (t3)
-	: "0" (sum), "1" (saddr), "2" (daddr), "3" (len)
-	: "memory");
-	return csum_fold(sum);
+	__u64 sum = (__force __u64)csum;
+
+	sum += (__force __u32)saddr->s6_addr32[0];
+	sum += (__force __u32)saddr->s6_addr32[1];
+	sum += (__force __u32)saddr->s6_addr32[2];
+	sum += (__force __u32)saddr->s6_addr32[3];
+	sum += (__force __u32)daddr->s6_addr32[0];
+	sum += (__force __u32)daddr->s6_addr32[1];
+	sum += (__force __u32)daddr->s6_addr32[2];
+	sum += (__force __u32)daddr->s6_addr32[3];
+	sum += len;
+	sum += proto;
+	sum += (sum >> 32) | (sum << 32);
+	return csum_fold((__force __wsum)(sum >> 32));
 }
 
 #endif
-

