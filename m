Return-Path: <linux-kernel+bounces-19501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C438D826DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE0D1C21DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954141771;
	Mon,  8 Jan 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuJpTN4M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22863405C6;
	Mon,  8 Jan 2024 12:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCDAC433C7;
	Mon,  8 Jan 2024 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716887;
	bh=U9PnBG/5EYHrVYhK6XkaKxR509BuwtcmocDK57PWsP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uuJpTN4ME0T49loCJjRpJxk0HhPgBqiSO43iUxquJiUuQxI0ZPhFdYXmoJtpPFGkh
	 IGkfk9DsHcDcZHWJqOutmlDPv6/1Mcn+5ucS86wN+qZTC51sG8Wr9pqte3cUzquKBE
	 lWg1QnCaPeAkTxymcgsmk+u6EYqoDuetNEb/WTRCkVD4tCQ/a/fg2Ki+BKWQwV/ZJC
	 kg9DzOlzyynHBcuc3t/cZ5FHFV2/LcTlFXsbslDCq/KjKGYCdQ6rxanMRBU3yWT0lf
	 rhoBsCvZvhSlXg+pHLiGpY37tJEM8ZmNCKTbeiaLBgOTAVySZB1b2aKAH8i48cUCtm
	 GekaUYgeL0AXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	goldstein.w.n@gmail.com,
	nathan@kernel.org,
	edumazet@google.com,
	david.laight@aculab.com
Subject: [PATCH AUTOSEL 6.6 7/8] x86/csum: clean up `csum_partial' further
Date: Mon,  8 Jan 2024 07:27:23 -0500
Message-ID: <20240108122745.2090122-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122745.2090122-1-sashal@kernel.org>
References: <20240108122745.2090122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.10
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit a476aae3f1dc78a162a0d2e7945feea7d2b29401 ]

Commit 688eb8191b47 ("x86/csum: Improve performance of `csum_partial`")
ended up improving the code generation for the IP csum calculations, and
in particular special-casing the 40-byte case that is a hot case for
IPv6 headers.

It then had _another_ special case for the 64-byte unrolled loop, which
did two chains of 32-byte blocks, which allows modern CPU's to improve
performance by doing the chains in parallel thanks to renaming the carry
flag.

This just unifies the special cases and combines them into just one
single helper the 40-byte csum case, and replaces the 64-byte case by a
80-byte case that just does that single helper twice.  It avoids having
all these different versions of inline assembly, and actually improved
performance further in my tests.

There was never anything magical about the 64-byte unrolled case, even
though it happens to be a common size (and typically is the cacheline
size).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/csum-partial_64.c | 81 ++++++++++++++++------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 557e42ede68ec..c9dae65ac01b5 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -16,6 +16,20 @@ static inline __wsum csum_finalize_sum(u64 temp64)
 	return (__force __wsum)((temp64 + ror64(temp64, 32)) >> 32);
 }
 
+static inline unsigned long update_csum_40b(unsigned long sum, const unsigned long m[5])
+{
+	asm("addq %1,%0\n\t"
+	     "adcq %2,%0\n\t"
+	     "adcq %3,%0\n\t"
+	     "adcq %4,%0\n\t"
+	     "adcq %5,%0\n\t"
+	     "adcq $0,%0"
+		:"+r" (sum)
+		:"m" (m[0]), "m" (m[1]), "m" (m[2]),
+		 "m" (m[3]), "m" (m[4]));
+	return sum;
+}
+
 /*
  * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
@@ -31,52 +45,31 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	u64 temp64 = (__force u64)sum;
 
-	/*
-	 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
-	 * has noticeable negative affect on codegen for all other cases with
-	 * minimal performance benefit here.
-	 */
-	if (len == 40) {
-		asm("addq 0*8(%[src]),%[res]\n\t"
-		    "adcq 1*8(%[src]),%[res]\n\t"
-		    "adcq 2*8(%[src]),%[res]\n\t"
-		    "adcq 3*8(%[src]),%[res]\n\t"
-		    "adcq 4*8(%[src]),%[res]\n\t"
-		    "adcq $0,%[res]"
-		    : [res] "+r"(temp64)
-		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_finalize_sum(temp64);
+	/* Do two 40-byte chunks in parallel to get better ILP */
+	if (likely(len >= 80)) {
+		u64 temp64_2 = 0;
+		do {
+			temp64 = update_csum_40b(temp64, buff);
+			temp64_2 = update_csum_40b(temp64_2, buff + 40);
+			buff += 80;
+			len -= 80;
+		} while (len >= 80);
+
+		asm("addq %1,%0\n\t"
+		    "adcq $0,%0"
+		    :"+r" (temp64): "r" (temp64_2));
 	}
-	if (unlikely(len >= 64)) {
-		/*
-		 * Extra accumulators for better ILP in the loop.
-		 */
-		u64 tmp_accum, tmp_carries;
 
-		asm("xorl %k[tmp_accum],%k[tmp_accum]\n\t"
-		    "xorl %k[tmp_carries],%k[tmp_carries]\n\t"
-		    "subl $64, %[len]\n\t"
-		    "1:\n\t"
-		    "addq 0*8(%[src]),%[res]\n\t"
-		    "adcq 1*8(%[src]),%[res]\n\t"
-		    "adcq 2*8(%[src]),%[res]\n\t"
-		    "adcq 3*8(%[src]),%[res]\n\t"
-		    "adcl $0,%k[tmp_carries]\n\t"
-		    "addq 4*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 5*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 6*8(%[src]),%[tmp_accum]\n\t"
-		    "adcq 7*8(%[src]),%[tmp_accum]\n\t"
-		    "adcl $0,%k[tmp_carries]\n\t"
-		    "addq $64, %[src]\n\t"
-		    "subl $64, %[len]\n\t"
-		    "jge 1b\n\t"
-		    "addq %[tmp_accum],%[res]\n\t"
-		    "adcq %[tmp_carries],%[res]\n\t"
-		    "adcq $0,%[res]"
-		    : [tmp_accum] "=&r"(tmp_accum),
-		      [tmp_carries] "=&r"(tmp_carries), [res] "+r"(temp64),
-		      [len] "+r"(len), [src] "+r"(buff)
-		    : "m"(*(const char *)buff));
+	/*
+	 * len == 40 is the hot case due to IPv6 headers, so return
+	 * early for that exact case without checking the tail bytes.
+	 */
+	if (len >= 40) {
+		temp64 = update_csum_40b(temp64, buff);
+		len -= 40;
+		if (!len)
+			return csum_finalize_sum(temp64);
+		buff += 40;
 	}
 
 	if (len & 32) {
-- 
2.43.0


