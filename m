Return-Path: <linux-kernel+bounces-19500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70488826DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963C61C224E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42337405CC;
	Mon,  8 Jan 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSeX1p81"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F534176C;
	Mon,  8 Jan 2024 12:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3B9C433C8;
	Mon,  8 Jan 2024 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716882;
	bh=Ui7zcn2jU08tIy45HAoyCBjZfQchDQCgD2TSQS1iqhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSeX1p81ymePRAWkdhbtaua5Tq776UJRBjR4GO0D21+1uCAyN129GRoUgmknoJqFN
	 dshqUCxK8GMvv1uiksTTzlEJvQX5JUmEwunuBAkXNq13STTBvudhG/ermss2STu1t5
	 hz5PUYGD/Rwr8BeJ3JEh2vcTx9bhpXGVIKzgdp03FHf3DM8DEOwSM+grYYU+FZc0q6
	 T6RgNw9Bt52BrB8I5nm/HgTc7iMYaBnOhjnFBHfcgyJ4JpB9vyCciNyAA/q5U6LZPQ
	 XGpGkYmDJLdIe4CQ/FQYha+fjaoJ37YxEw9s8zxNm4iY2Y7JHCS6G1n+sQl25dl888
	 ytJFJwQSKLmzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Noah Goldstein <goldstein.w.n@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight@aculab.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	nathan@kernel.org
Subject: [PATCH AUTOSEL 6.6 6/8] x86/csum: Remove unnecessary odd handling
Date: Mon,  8 Jan 2024 07:27:22 -0500
Message-ID: <20240108122745.2090122-6-sashal@kernel.org>
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

From: Noah Goldstein <goldstein.w.n@gmail.com>

[ Upstream commit 5d4acb62853abac1da2deebcb1c1c5b79219bf3b ]

The special case for odd aligned buffers is unnecessary and mostly
just adds overhead. Aligned buffers is the expectations, and even for
unaligned buffer, the only case that was helped is if the buffer was
1-byte from word aligned which is ~1/7 of the cases. Overall it seems
highly unlikely to be worth to extra branch.

It was left in the previous perf improvement patch because I was
erroneously comparing the exact output of `csum_partial(...)`, but
really we only need `csum_fold(csum_partial(...))` to match so its
safe to remove.

All csum kunit tests pass.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Laight <david.laight@aculab.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/csum-partial_64.c | 36 ++++------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf6..557e42ede68ec 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -11,26 +11,9 @@
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>
 
-static inline unsigned short from32to16(unsigned a)
+static inline __wsum csum_finalize_sum(u64 temp64)
 {
-	unsigned short b = a >> 16;
-	asm("addw %w2,%w0\n\t"
-	    "adcw $0,%w0\n"
-	    : "=r" (b)
-	    : "0" (b), "r" (a));
-	return b;
-}
-
-static inline __wsum csum_tail(u64 temp64, int odd)
-{
-	unsigned int result;
-
-	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
-	if (unlikely(odd)) {
-		result = from32to16(result);
-		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
-	}
-	return (__force __wsum)result;
+	return (__force __wsum)((temp64 + ror64(temp64, 32)) >> 32);
 }
 
 /*
@@ -47,17 +30,6 @@ static inline __wsum csum_tail(u64 temp64, int odd)
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	u64 temp64 = (__force u64)sum;
-	unsigned odd;
-
-	odd = 1 & (unsigned long) buff;
-	if (unlikely(odd)) {
-		if (unlikely(len == 0))
-			return sum;
-		temp64 = ror32((__force u32)sum, 8);
-		temp64 += (*(unsigned char *)buff << 8);
-		len--;
-		buff++;
-	}
 
 	/*
 	 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
@@ -73,7 +45,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 		    : [res] "+r"(temp64)
 		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_tail(temp64, odd);
+		return csum_finalize_sum(temp64);
 	}
 	if (unlikely(len >= 64)) {
 		/*
@@ -143,7 +115,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    : [res] "+r"(temp64)
 		    : [trail] "r"(trail));
 	}
-	return csum_tail(temp64, odd);
+	return csum_finalize_sum(temp64);
 }
 EXPORT_SYMBOL(csum_partial);
 
-- 
2.43.0


