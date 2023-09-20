Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BD7A8CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjITTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjITTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:23:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E28F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:23:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98377c5d53eso13301666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237791; x=1695842591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ChiqShwLX1gNz0mQdxUhhrEbGWvJcnG/XL0z7xrAJ0=;
        b=fiQoKXSv3nRhVTzziLQn8xYXQW2wQxsO2I39eI0xhlLuxta8ShWOWUv6TzVubbjMlC
         Ro+RI2cqPlF/iqGNEDf2tOKmPUDawt73RSoiFNSBK1KAPajSG50q7GnIUvsoQwL2WV2j
         xPuhvt77evDW7D9xlDfcnPCMyxwUip5k1IdKFwX2XEmA7UVfgqclAThXHlAzXB2oJlJE
         ZFbQ9wQl4jShPTYCmxhGBM6M6TWIJScZ7+78DWaLqwCKn1cfKZna6DHqB22HDYjvy/uM
         3+1pahVtvB9dJ3RBcaOSLMi7cjn8EipnO9nBUPuRoGKqaFWYp99T2+SkWaryHrObV7hs
         fMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237791; x=1695842591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ChiqShwLX1gNz0mQdxUhhrEbGWvJcnG/XL0z7xrAJ0=;
        b=LBP6zMU7cTYX1RuKsyEjB2doLCeXaSV/yOzPU6dK5x/ddOuATMwjJK6BN1qNsfo2dg
         lIXSlU397yesQCyNUAw0jKJAnRYgp9ub6+CYJNGKJV7oOFlE6iW9MmCtSOTzgA5rgUrE
         9fjeyjTMaz7+8vrgZ5EeES3DgZU6XsXYS39Qu+w846Y7qDzZIn69NMGkJ3yVKzEtlfvP
         4mVI3V1RODL1QOxPbeO+aUp6d2vnH528oa22nkS523IN/KdTrdKgruLslXzNxeggl/77
         Bb6zvzO/QFv7letQqYV2ZoNga0pfGKNqGdSsvoym3cTtA0ocDpcxwIQfv/vOz02jUvbd
         TOog==
X-Gm-Message-State: AOJu0Yy1bJ4HwOXgKIoL/RouA+wyN8ZvEMWw3TbSTv3UP0CcrglyoR4s
        aINEZdbXCbqdEH/n/txK6HGx79Rd3jI=
X-Google-Smtp-Source: AGHT+IGn+0fFTcDDeeQtPqWT0lERZTAMLIJq0o9tW0uIHLb6ggFnpHs2OHv6KMzVvCF8NOz8U+I3BQ==
X-Received: by 2002:a17:906:1da9:b0:9ae:1872:d01a with SMTP id u9-20020a1709061da900b009ae1872d01amr2928910ejh.76.1695237790360;
        Wed, 20 Sep 2023 12:23:10 -0700 (PDT)
Received: from noahgold-DESK.intel.com ([192.55.55.56])
        by smtp.gmail.com with ESMTPSA id rh1-20020a17090720e100b009ad8ba6976bsm9885812ejb.9.2023.09.20.12.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:23:09 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, edumazet@google.com,
        tglx@linutronix.de, mingo@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, goldstein.w.n@gmail.com,
        David Laight <david.laight@aculab.com>
Subject: x86/csum: Remove unnecessary odd handling
Date:   Wed, 20 Sep 2023 14:23:00 -0500
Message-Id: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628020657.957880-1-goldstein.w.n@gmail.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index cea25ca8b8cf..b83c8accd756 100644
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
+	return (temp64 + ror64(temp64, 32)) >> 32;
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

