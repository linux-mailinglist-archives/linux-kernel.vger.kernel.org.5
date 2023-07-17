Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC737561B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGQLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGQLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:19 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBBBF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:17 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51e278a3a2dso2963097a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593836; x=1692185836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGuCnRoGjtuxCyYZwSXlSd4VQfcsRWWQdyiV1Wnie4Q=;
        b=lOGtagPBwApVjfpfXneYZBu8MWYD1OliVo2uXXUvPFvV6+APoIbAw6+/k3YWQj3eId
         ++zdOrcTldnSRQnleASyL9AkS3sHtgDNjCJqdxPyeYFLbcNbm7H47WMPCrL025NnVhlV
         G1Qol0TNu5t6DU2yoyQVV2/M6YY2bbB1S6KNkkNOFhBw/Gi3exXLENY44qDhbiI+qFGh
         XTOGJBYScj/gFqOpJMAG1/JvF8wnIW5CuArTM2y25y2u8rr7pO8KA2XD2gxTxG4FbLph
         Yo+NTPG4cWlDz+nePnG/bgJtDwcLrzw/IHDxEArbQPROIOahGhUPuqygOW0gEksJ4t/k
         Sb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593836; x=1692185836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGuCnRoGjtuxCyYZwSXlSd4VQfcsRWWQdyiV1Wnie4Q=;
        b=NHyjQM2ejPJiIBl/l4pJ9XcuK23hDk2cGV/X0flQGqtHXdrJm5cV22wHQ9c4i7fKjX
         r9PmCCME+SMGXAvmS1y39FEQU47z7uy2u3c4ZVLfy5q36bOs20dls1iPinJ6NntKrhIl
         juR8OA5LMY0Gxgeg8Wlj07duxZID41YBeuuM9jMwpGNCZe7F6npq4azMwtaK2XwXDEEF
         pbSwUyPKTXCCxb9RjgytKDNsjUUvu1zWaMKahw9DMn5G5ZSpbS+dmWY4a2s6HmKs1hhX
         Xp/RaGTkOPf8q6Us6gKNGyoWCXFvl5FLRpfDTon18yUhHz7VtwBX0thc/YjSo8jU1Z++
         WekQ==
X-Gm-Message-State: ABy/qLbhiupnYWHk834VLrIaTHUT/96cV8LvnrwJoU7LBRZQDD+3wU6t
        7jPoxaJ86vUp6cf6nHOcblk4PZTPnYc=
X-Google-Smtp-Source: APBJJlHU2OTCIg2LzbafyDqppv2wF6RJFGQojMIqEPAOBlxykPEq695ChnJkW5pC2kh2TPi2Dbwzn/+SnnY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a50:c310:0:b0:51b:ee9e:aad2 with SMTP id
 a16-20020a50c310000000b0051bee9eaad2mr66529edb.0.1689593835900; Mon, 17 Jul
 2023 04:37:15 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:04 +0200
In-Reply-To: <20230717113709.328671-1-glider@google.com>
Mime-Version: 1.0
References: <20230717113709.328671-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-2-glider@google.com>
Subject: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
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

The two new functions allow setting/getting values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a couple of minor changes:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value())

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/bitmap.h | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..4559366084988 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -76,7 +76,11 @@ struct device;
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
+ *  bitmap_get_value(map, start, nbits)         Get bit value of size 'nbits'
+ *                                              from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_set_value(map, value, start, nbits)  Set bit value of size 'nbits'
+ *                                              of map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -583,6 +587,31 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
 }
 
+/**
+ * bitmap_get_value - get a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits
+ *
+ * Returns value of nbits located at the @start bit offset within the @map
+ * memory region.
+ */
+static inline unsigned long bitmap_get_value(const unsigned long *map,
+					     unsigned long start,
+					     unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
 /**
  * bitmap_set_value8 - set an 8-bit value within a memory region
  * @map: address to the bitmap memory region
@@ -599,6 +628,34 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value - set n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value of nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits
+ */
+static inline void bitmap_set_value(unsigned long *map,
+				    unsigned long value,
+				    unsigned long start, unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long space = BITS_PER_LONG - offset;
+
+	value &= GENMASK(nbits - 1, 0);
+
+	if (space >= nbits) {
+		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
+		map[index] |= value << offset;
+		return;
+	}
+	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
+	map[index] |= value << offset;
+	map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.41.0.255.g8b1d071c50-goog

