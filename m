Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EF7A27CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjIOUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbjIOUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FC30E4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2749b3e682aso807696a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808728; x=1695413528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaNuUJuW11NFNseyUchCJwnKQBn96YBnagapJs4sYso=;
        b=eF42z4GEWwRThsG61i0rxJ/t166E7yblV3VYNI71u9207fanZ1hDNZWRbnG2KDQBtv
         6paNIJIiISNUrSO6ym6fN2rnvwrn97GG6THTQb5AehNe2/NZb12luZkJ+pP5tx1LZM8G
         QQRANJJjttv5zTaTdbINq+y6XJ7ZlWgY2JrzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808728; x=1695413528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaNuUJuW11NFNseyUchCJwnKQBn96YBnagapJs4sYso=;
        b=wQLSG/+M3l2HHx42x8WMoB3Lm/0sVCXXrtW8r0my5rXD+kkzxgrPisEPC8SZC30c0P
         ofUgHW5o3f1ZSSLo77Zes/LrtJWS8oZ03jXA4/dFrA9czpVBmdFNeziEQDJxCEGFFL0W
         NIIo3nwdz67SYXOy2jIdYLgBj3KBP1BmlJdOxGXqn/cn7MRVRIIfUrcwW7Lfa0e1zgGE
         j/5TdOV1jUCXQolAoeAgVC4WS0hQP8NXna7RlPg4AK+nE/OaQKl2JO7weuaKXpJIoE6k
         E7H8vrt24HaQSskVOWt2l/Atd4IuHrAxR9Exk7jDqdUPrZMQvbPurDyNja4uL4JJykzZ
         r2JA==
X-Gm-Message-State: AOJu0YwWss523WeX53ZWeSGrlvQuQYKYwZ1lkjUM8Xh0SZOyvy7/KiDk
        bvSo2J0Zcif4dOBfBg1Zpv8wvQ==
X-Google-Smtp-Source: AGHT+IENQ+3ljrMvkLNjV5WcuTAeCHeTqiHUCoaqBNiK5cW9S7xH1rsrjHRo+U8DYzSeMzsRRNUnqw==
X-Received: by 2002:a17:90a:c981:b0:268:3ea0:7160 with SMTP id w1-20020a17090ac98100b002683ea07160mr2561819pjt.0.1694808728027;
        Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w30-20020a17090a6ba100b0025dc5749b4csm1923373pjj.21.2023.09.15.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: cfi: Annotate struct cfi_private with __counted_by
Date:   Fri, 15 Sep 2023 13:12:06 -0700
Message-Id: <20230915201206.never.107-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kJgErR26UlIfECbb6XvY8Wt1mjzpcX6fBOuJe21FNYc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqWagQwTd4LDC+TCrz67AZZmCb7zzFJT3Wg+
 FjYR7jZxCuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6lgAKCRCJcvTf3G3A
 JjaoD/462fmKAJmqNZoJP+mdtzZMTuK5Ftpvj1hxiYcJHGsAvHIjskTS6/QIhml3KId+AW/Z/9h
 3o9kD9vTeovneN67dHl76ayl35/i72aMm0mtq24r5wGFw0zjc+cdbDX0q4Qo6IZp/tk2+X1LvfH
 Z4ajg+xMKjB6ioDbCl8IPLC4q1syKk8Ka86gpC4n3Is24kUoPD9TEHkN0L3wCoxGpe57ipbKawn
 typcjdBmfXci+xlk8ib6bsm8MXHEd6YuvHvgmla3Ls6PMV1M7CqGDxhri7CcgGMLyj0oznNIGWn
 BeAUmpnecYm7pMfB8qGaaPdJK2JZg0cQEJiEJbydaegKkOP0LBX+ARtgEl6/YqJLRxOLqAa+lhl
 zbJfIMw73QVehDJRd5tMFpx3uo580CHgYtL9AK0jJdl2/GI0RA5QJ3EJagXbJqlEFmf3Zd4dlsB
 9T7le0v+qGBFDn8YTwH1ANVE+8ZKb+DpSmGJ49TOm8BVE5lM3IWRqyKhnARx4yFVbqfj/A+rSYR
 RaYwA1HC6rE7lNzRB8pqnCye4X5ZZvugfwxMPLqx4aN0j8KQ94DrwplD97QrMSxTED+OMOdd69R
 Z1O1uOE31Lr9YOlurQ7SC22SowmH2dFId0hd3dwkM/Y4/UV5sa4Ayld7UzlEOtMZTYHtdeuDiGq
 FI7fa3+ p30cf+Mg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfi_private.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mtd/cfi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index d88bb56c18e2..947410faf9e2 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -287,7 +287,7 @@ struct cfi_private {
 	unsigned long chipshift; /* Because they're of the same type */
 	const char *im_name;	 /* inter_module name for cmdset_setup */
 	unsigned long quirks;
-	struct flchip chips[];  /* per-chip data structure for each chip */
+	struct flchip chips[] __counted_by(numchips);  /* per-chip data structure for each chip */
 };
 
 uint32_t cfi_build_cmd_addr(uint32_t cmd_ofs,
-- 
2.34.1

