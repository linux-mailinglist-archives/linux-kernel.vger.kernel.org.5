Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E035B7ACA0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIXOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIXOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:36:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BBFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:35:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65af7e20f39so13001426d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695566152; x=1696170952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKmidxGA713iO3U8UQepy4attClwHmpcYOKxNrg1rc4=;
        b=HKXchKs2E/3D1Ds0Q546E2AwbWrd81b7nxJNV+BhrLWUwilXk5radRJlLhgoaIMSVu
         QeqWbOKlCny0ydPSE2m88JdN41bM87u2zZJLzpTreSNWqZzbknJ2o2Oa07XuHYWhAbU6
         I+0hoPW8c9WSX6oZrMq5ygja1qNaYOtpJa8vYOoU/c2AgenuoQcLxCJ0v/qD3yxEIxBB
         o8rsvkQJGKh+aKpbvpZfFFDIEldRjZ2W9Epmt+bFbVmMeM6K3A560y/wMA3UMef935ki
         cBcBz8p4xnhzzibOT9bPGu3ev4J1dqzqPgn5pES7RQgWx8nXnFWN2hLUreUsviGX3vpT
         J0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695566152; x=1696170952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKmidxGA713iO3U8UQepy4attClwHmpcYOKxNrg1rc4=;
        b=UT0sFrV5g4OfANO9cbqzAC7vvSqLiKenp0cN/CwOBl2Bzc4OlheMbYUJj+jkmOSYfr
         rMfzBxES4KixZI4XhdWzKOHsxdHpWwck/SF2Gic9x2G80KVuN027jm8Tks1yTPSSaQEN
         GJFcnYaOTuwdM718CaDa2dAKQrcp140qqCajIEN9VNrGGovRPORClXAjfQg+kUAw0wYm
         sLyYSReYLSTdqXsedP5mdFg02EB1yJIXSa/FaVeRdwZQhMosqd6DSbvVZ57H1F2zIYYy
         XBM5ArPq6HFHr68qsUliuDLSq5QHYLbFuCJ6X6xaBMU+MvgspAkhVOOIog/FopNqPktX
         +Bxg==
X-Gm-Message-State: AOJu0Yy4SBsXdOqYdOc9QVO2Dk4cG+fJU3+dM3ru9k/54lcZF2Sw9vBb
        EG26YtiyLyFGurvh+G9dq0Q=
X-Google-Smtp-Source: AGHT+IFsz4jx/+w8ZGrFptQKuWFBNKto3xuds3bYTMvvAIintwZasdznMzUKTxrMhwaReQGccm/aXQ==
X-Received: by 2002:a05:6214:4505:b0:656:3b4c:b98b with SMTP id oo5-20020a056214450500b006563b4cb98bmr5032160qvb.11.1695566152488;
        Sun, 24 Sep 2023 07:35:52 -0700 (PDT)
Received: from noahgold-DESK.. (pool-100-37-150-153.nycmny.fios.verizon.net. [100.37.150.153])
        by smtp.gmail.com with ESMTPSA id a11-20020a0cca8b000000b0063f88855ef2sm3254275qvk.101.2023.09.24.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 07:35:51 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, edumazet@google.com,
        tglx@linutronix.de, mingo@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, goldstein.w.n@gmail.com,
        David Laight <david.laight@aculab.com>
Subject: x86/csum: Remove unnecessary odd handling
Date:   Sun, 24 Sep 2023 09:35:49 -0500
Message-Id: <20230924143549.539396-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628020657.957880-1-goldstein.w.n@gmail.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/lib/csum-partial_64.c | 36 ++++------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf..557e42ede68e 100644
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
2.34.1

