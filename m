Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA0752202
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjGMM5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjGMM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:35 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A233D1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:33 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51e288d2a40so428793a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253052; x=1691845052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmq0b/Ecy0ZNTUuWhSR14tYQI4JHnYovo+aDrld9UN0=;
        b=CgGc1u5qyG9QHrPLJIfRm5/iPctCseTN5qUO7jdfNfbBcVi7VSxsjYA0omtf3+hxMV
         cXIv7arRK7gICiBo+wRZ0QeyQM5TkdW7LR6MVSqklD70rENHC3Kn/OtihQiIfy9xaTzN
         wW1b3m2v3U+lURK1LCBKW57m2ukspaRu3Y2VcJaSk1BrbVheIGUBDjMQNvUI6bj/s6Gn
         nguC8zsoqWo8SifiF54s/ew9mLcz7zKfklVijPUvCFpOFSCLihYXTnHFenJclDY06PxO
         /stMdLKDH8TjLnFVY9UeQTLsN2IhCEKY0G+QXw3TBsoATXET5UrQenfGfZNKL2ULWiKi
         IhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253052; x=1691845052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmq0b/Ecy0ZNTUuWhSR14tYQI4JHnYovo+aDrld9UN0=;
        b=ZFwwwloSREP5JtZO6JrzwfOSdv+5khZXltKsKgQ3TuRH75dz315QRtcUqenaPEsgVq
         2HJ46fd1exA1xf69oYfzUPpViPGrN6vSZVuAGSYrx7R6JOwiv754JvlbGXjdYix+kDCB
         E8go6dpNI9XoYYURiXL7vvo5E2UMBngA0vYknlfNhcY7iRgjuOAUYbbw9c/THz3/4ySp
         iNyVYQUDKwYXnDW/SsIdU8RFTUhURJyiOLGPV6l/5nNA8yRDLNDf3rnxLjTT90WZztu7
         phwPWZbHMUwxomQKE/FxwIweMV5lOXoDmLAUJRHHtxCEYAS4TTqDAbsNi2Brjr3M6o5k
         zsJw==
X-Gm-Message-State: ABy/qLZ3Rb0YIZnwZNbPiDu932z2HNnIo/Eb9bHOhFDCn3aZsfyM98yP
        Rfp1wZFqduw5R1ihPna3zCV5YnBOIfs=
X-Google-Smtp-Source: APBJJlHeRD8uLG+3QTCDR74WA5gMF3fPZWDdb23eDq3tUHkrau4iIYKWhnpbLYG6CkJUYvO244cOyYRq2s0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a50:f688:0:b0:51e:23e9:5c85 with SMTP id
 d8-20020a50f688000000b0051e23e95c85mr7587edn.6.1689253052246; Thu, 13 Jul
 2023 05:57:32 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:02 +0200
In-Reply-To: <20230713125706.2884502-1-glider@google.com>
Mime-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-3-glider@google.com>
Subject: [v2 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic tests ensuring that values can be added at arbitrary positions
of the bitmap, including those spanning into the adjacent unsigned
longs.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/test_bitmap.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf1..8ca61f6e7f26e 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -71,6 +71,17 @@ __check_eq_uint(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init
+__check_eq_ulong(const char *srcfile, unsigned int line,
+		 const unsigned long exp_ulong, unsigned long x)
+{
+	if (exp_ulong != x) {
+		pr_err("[%s:%u] expected %lu, got %lu\n",
+			srcfile, line, exp_ulong, x);
+		return false;
+	}
+	return true;
+}
 
 static bool __init
 __check_eq_bitmap(const char *srcfile, unsigned int line,
@@ -186,6 +197,7 @@ __check_eq_str(const char *srcfile, unsigned int line,
 	})
 
 #define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
+#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
@@ -1222,6 +1234,26 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+static void __init test_set_get_value_unaligned(void)
+{
+	DECLARE_BITMAP(bitmap, BITS_PER_LONG * 2);
+	unsigned long val;
+	int i;
+
+	for (i = 0; i < BITS_PER_LONG * 2 - 7; i++) {
+		bitmap_zero(bitmap, BITS_PER_LONG * 2);
+		bitmap_set_value_unaligned(bitmap, 0b10101UL, i, 5);
+		val = bitmap_get_value_unaligned(bitmap, i, 5);
+		expect_eq_ulong(0b10101UL, val);
+		bitmap_set_value_unaligned(bitmap, 0b101UL, i + 5, 3);
+		val = bitmap_get_value_unaligned(bitmap, i + 5, 3);
+		expect_eq_ulong(0b101UL, val);
+		val = bitmap_get_value_unaligned(bitmap, i, 8);
+		expect_eq_ulong(0b10101101UL, val);
+	}
+}
+
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1249,6 +1281,8 @@ static void __init selftest(void)
 	test_for_each_clear_bitrange_from();
 	test_for_each_set_clump8();
 	test_for_each_set_bit_wrap();
+
+	test_set_get_value_unaligned();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.41.0.255.g8b1d071c50-goog

