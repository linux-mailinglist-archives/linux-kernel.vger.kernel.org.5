Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC47561B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGQLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789C10CF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57745160c1dso41998677b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593840; x=1692185840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4GzxuyU3vJn9v8U3mWqzLaFXfnE9ofQM/5FOa6/PYw=;
        b=TRhADAlnuCLbiGu1Z8fSaZaO8ThyU1u4h/oqBA8WWnXEPQrIlWo4fAT5TGnCam3mI4
         PScfWARXctzZJoglFnaeX4/4mXUgNbsR5JyhvUQAug+Vv3KpeCt3WCj5Fm1poyP+huJ7
         Fou4az0geM/C601sPT5rGVu2sYmfvq3oHsY2eBMXkhwYVp1cfyiGhxorRMM7lmrH9X0d
         OgW1NntxVRPZwEGrFfjEWlXZZ4fzEJSH/PWgVvRG+IPW4A3SRs9WTQqab6DqdxHhiaHu
         InkzhF7rowEHA7zC8IpLrEcQVL23wiD5U+B+UWJbhxSkiEDPR3kNDORikeMRKxcUZUL0
         d9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593840; x=1692185840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4GzxuyU3vJn9v8U3mWqzLaFXfnE9ofQM/5FOa6/PYw=;
        b=GICJEvwxB7dZz0Pipj65haK9JOQl5ZuM9IAnV07xZdc7grZ09sPW+6dlbS4PpKyE8H
         oAd7shX1xeYlGx/OQVcjas171Vq3vq/Nfv/K39XhnM4nhdX5KzvYzoz1k0duTztgIHNj
         5MQl5C9VFCQZMk2v9FBMjEjGbE1mcxSMlCs3FVDqmz5It9O1S7MJrt+JWIT3qPlVDtHq
         mB+n8Cx3N0bcJEeQtMURL42FZxuV91DOcXq7F1xouRyrDOp5Pcxf3wJNF1Qnroih2Qs/
         oRv9bSt1ifi2ZFormxNqU3/rKqqfleQK39GvqcADtHxE/iVOpDYrKNcObPtAys4dhKKu
         CWbQ==
X-Gm-Message-State: ABy/qLYW6JBEOtOKSGsHCa1j32T/3QCIx1rWx1S4ulWXsMD2S/8BexdV
        3lWkoxNmJp++c5R/cx74Bg9yV/UzzCg=
X-Google-Smtp-Source: APBJJlGxRxwFk/lAIDWsxE5jqRQNOsXKNet0IJa0/eqtzIqStMGXTrajbES2PduICITqhkUrZMjUSUZIydA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a81:ad5d:0:b0:573:285a:c2a3 with SMTP id
 l29-20020a81ad5d000000b00573285ac2a3mr126417ywk.1.1689593839923; Mon, 17 Jul
 2023 04:37:19 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:05 +0200
In-Reply-To: <20230717113709.328671-1-glider@google.com>
Mime-Version: 1.0
References: <20230717113709.328671-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-3-glider@google.com>
Subject: [PATCH v3 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
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
This patch was previously called
"lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"

v3:
 - switch to using bitmap_{set,get}_value()
 - change the expected bit pattern in test_set_get_value(),
   as the test was incorrectly assuming 0 is the LSB.
---
 lib/test_bitmap.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf1..c2ab54040c249 100644
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
@@ -1222,6 +1234,25 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+static void __init test_set_get_value(void)
+{
+	DECLARE_BITMAP(bitmap, BITS_PER_LONG * 2);
+	unsigned long val;
+	int i;
+
+	for (i = 0; i < BITS_PER_LONG * 2 - 7; i++) {
+		bitmap_zero(bitmap, BITS_PER_LONG * 2);
+		bitmap_set_value(bitmap, 0b10101UL, i, 5);
+		val = bitmap_get_value(bitmap, i, 5);
+		expect_eq_ulong(0b10101UL, val);
+		bitmap_set_value(bitmap, 0b101UL, i + 5, 3);
+		val = bitmap_get_value(bitmap, i + 5, 3);
+		expect_eq_ulong(0b101UL, val);
+		val = bitmap_get_value(bitmap, i, 8);
+		expect_eq_ulong(0b10110101UL, val);
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1249,6 +1280,8 @@ static void __init selftest(void)
 	test_for_each_clear_bitrange_from();
 	test_for_each_set_clump8();
 	test_for_each_set_bit_wrap();
+
+	test_set_get_value();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.41.0.255.g8b1d071c50-goog

