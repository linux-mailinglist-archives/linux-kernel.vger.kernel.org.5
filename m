Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50479039A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjIAWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjIAWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:21:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AB33A92
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:21:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bf038b8f87so241518a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693606867; x=1694211667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1V/aefBDrykxi2XZBbj4jwboXsH8TUW1I1YL0e0Rcs=;
        b=F1pqlboAkxKApHwe6WK54jqm9qNRoAJZ94qwllnkhK5MUtWGDiXf/L9NSFB7RXKOsg
         zc8ENOeamv5Q/hIkEZmT46T5x6MGvfnFHA5ZLtJ6Xr4Y4ZpeVxvPPzRWg8I0/6b4NtiY
         4n8eUWzeeMU50qXmQWMYSOUi7/MZQodKLLCg2B2URywrROBxUrogORvpPqup5JTCOnrB
         h1GpyrdVHspnUH2i56pYMBJBKRx3tLu32jqiMSRaqmvyKUeY26aXPDhOG7dUXXGxf7+w
         402kxyUWxNetlxuma+FG4Syeji97/ORWVmUui/faOEKX0JKmcIA8HCjf1CWXjMMInf2B
         MATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693606867; x=1694211667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1V/aefBDrykxi2XZBbj4jwboXsH8TUW1I1YL0e0Rcs=;
        b=VdBlqjduDSw1fc1RIrK/x+38vfvwb/O+Bdnj/FpL3JXNjZ1lsvDvsdIMGJrg+Mw0A4
         uZRcJAaqNOPLVPYGZ9p4nn0B8HCnqhjAghsKC4LZob7AFrbtCb2K9RT+xQ5OtoUyCiCc
         ko7dadOuxPtCZyZNiXL8HnvCmS+GRm4d0d18XJVc3nqAZUvG8psi3c20ZKkpwQ45eBfx
         DuO9Sf/ygm7LaD+O2u71B0nSD41m7gMOPCqz8CA+Lw7WroJqv4rdA9i2/gT1MAHcbEqv
         8BX3KMrbF9ktDyOxG1ZSmVJqVxtR4iFiS1wmDnwfyhUvOdhtb2tQMjjMNosBdyqOAfl5
         iQmA==
X-Gm-Message-State: AOJu0YwFAWo3bRbDYwxG4Kjh9PtsOTuVtTsKxNCMYaCRecqIgzdiE1LS
        W2GEN1hF/4MMAYdIkZmrQVI=
X-Google-Smtp-Source: AGHT+IHyucmlvoX0GqpxCVclWjyOv0/aBU0AunPLWu28JQw5JKhT/SB99NzdX8ZTMkfS/BDWgbmCyg==
X-Received: by 2002:a05:6830:3191:b0:6bd:90dd:c632 with SMTP id p17-20020a056830319100b006bd90ddc632mr3859652ots.13.1693606867554;
        Fri, 01 Sep 2023 15:21:07 -0700 (PDT)
Received: from noahgold-DESK.lan (035-146-022-000.res.spectrum.com. [35.146.22.0])
        by smtp.gmail.com with ESMTPSA id l18-20020a056830155200b006b95392cf09sm2244619otp.33.2023.09.01.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 15:21:06 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, edumazet@google.com,
        tglx@linutronix.de, mingo@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, goldstein.w.n@gmail.com
Subject: x86/csum: Remove unnecessary odd handling
Date:   Fri,  1 Sep 2023 17:21:00 -0500
Message-Id: <20230901222100.1027371-1-goldstein.w.n@gmail.com>
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
---
 arch/x86/lib/csum-partial_64.c | 37 ++--------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf..d06112e98893 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -11,28 +11,6 @@
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>
 
-static inline unsigned short from32to16(unsigned a)
-{
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
-}
-
 /*
  * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
@@ -47,17 +25,6 @@ static inline __wsum csum_tail(u64 temp64, int odd)
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
@@ -73,7 +40,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 		    : [res] "+r"(temp64)
 		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_tail(temp64, odd);
+		return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	}
 	if (unlikely(len >= 64)) {
 		/*
@@ -143,7 +110,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    : [res] "+r"(temp64)
 		    : [trail] "r"(trail));
 	}
-	return csum_tail(temp64, odd);
+	return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 }
 EXPORT_SYMBOL(csum_partial);
 
-- 
2.34.1

