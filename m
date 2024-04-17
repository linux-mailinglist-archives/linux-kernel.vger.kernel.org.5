Return-Path: <linux-kernel+bounces-148499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F168F8A838D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C031F22026
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C713D53C;
	Wed, 17 Apr 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2ykT5l3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E302D60C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358697; cv=none; b=S2ZL+i9rlOQtushPhovP/YLGZacFjXyLq8wOePFmWDBVUFsLORaR4yu83NwWNV4J7aUSG/abwCPNvp7XQJqMbaawlh33RoW9GhlDqgks2jfQbQitx88kbrYooeBLQy3Ct4p40nDRVELxsS35TNxW2YRbkEZ2sPANsZfg68zEpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358697; c=relaxed/simple;
	bh=xUVxv5uVcS/o3YRJ3tUxLqy+20PCT8y2AZHO+yEkYno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I61/6brTIpC9CKUtDqY2SgX4NmQtg9O2JMnYLO4PtUyNwlBFD3P1OcBe5a1Jbp1C8Z2oV+CwVcXJFoYIZnsBf0JmOO44+btU6tibTHiafKMHHYHM6uEiPcHnZYGOhoitqaNnh1Z1JRhOONMrXi9PUxdYto1SxNjEXH82sBr7g4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2ykT5l3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5715a9ebdso44857035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713358695; x=1713963495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yL9WGELK0lOh3TihWfiAbxHM3HMliISVuJDXZFv+RLQ=;
        b=b2ykT5l3dIZg6VGbNf52gp4ujAM1IexopHnAw2lWQXgV92cQG9ewCgPxWOttQjWKBX
         Jk6vlbiF1PfPbylJq4sbXFsQvUORPY13I+uptmjNYgHyhpa6/p5A//ck6bDOyhYsG+y4
         K1VB4w8A2DgEaBjw9Cb16DiJZolsYVcZ+XCjuZiPaVj6xBKxIElME9gb3+RZf65sdb9b
         KQgItgtJYpPhrXl1raDRqYQU+Z67Khw1DDgaf9W0bk3K/QR5nG48DuQQ9WBfRGwGVFhE
         45wbKIq2ejhPM7jKVD87ChlAh+ki+IuTr6q29DRAK12FaLgNTy+VbMT5iKt6txWKVi1n
         uK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358695; x=1713963495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL9WGELK0lOh3TihWfiAbxHM3HMliISVuJDXZFv+RLQ=;
        b=hTWLM4ScqYx0q3rR6DDQ9i/7jpyrlogqzbmXa8SKx6ECZtdKNYlC266L0d0LmwXU0Q
         mPZidSg1Cnassrhq+wXF/1EJKOAlsv90nKj7uRkPMLhtv2iMgqSHjtGRvNRaMmXZazy+
         saYsq7qPt4qsbk0CUd0qXar+HMgOX/9diLpeIvI0eWrlyzI6HbEh3HnRF0ccUXPL/7W0
         +hXLaTJaJjfU6Zfs/YT4DT8oekDQ9ZLbnLqkOJTF93Worw4QLcSAXzT4vqkoNksvy8Ya
         R3E7RjJe363oXG+QD5ej7iwYWJBedl/EZVKZQGhScs0Y4myCHUhUkarOh68kIdN48daU
         rn+w==
X-Forwarded-Encrypted: i=1; AJvYcCVwmrJr550N+V2W1p6rkEAqonuPmUbRJTwQxRr07/1orCkTaaMccORzGKxYK2Rs81qSOTak3fE2Ub9nkid1VXXaO92Qj+eOoOP8bhc9
X-Gm-Message-State: AOJu0Yxj/786uZjuSC5li4fVIq5ze33tXHVUEFsxdzDWpu3pQO79Q4EO
	LH8G3LqTfLxWL+PvtTXPpy/UCRtx8D0hhV7Tq+3rxrgC7lg6TAww
X-Google-Smtp-Source: AGHT+IE3uI65dS5DMd4IViJ7mEQ8Eyo7T/dp6MU71+8KqD1Ldnwz74+7zn8Y/x7vgTg8CAXCvS0LTw==
X-Received: by 2002:a17:902:ce0e:b0:1e4:cb0e:2988 with SMTP id k14-20020a170902ce0e00b001e4cb0e2988mr19695759plg.2.1713358695289;
        Wed, 17 Apr 2024 05:58:15 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001e8415d303fsm724009plh.257.2024.04.17.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:58:15 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] linux/bitops.h: Refactor function fns to reduce branch usage and eliminate external calls
Date: Wed, 17 Apr 2024 20:57:07 +0800
Message-Id: <20240417125706.19899-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrote the function fns to use macro wrote in linux/include/asm-generic/bitops/const_hweight.h
Decrease the number of required branches and eliminate the need for external calls.
The number of branches is now constant, unaffected by input variations.

This commit improves code efficiency and clarity.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
 include/linux/bitops.h | 54 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5842d7d03f19..18899f11aaa7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -247,6 +247,13 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+
+#define __const_hweight2(w)                                                 \
+    ((unsigned int) (!!((word) & (1ULL << 0))) + (!!((word) & (1ULL << 1))))
+
+#define __const_hweight4(w)                                                 \
+    ((unsigned int) (!!((word) & (1ULL << 0))) + (!!((word) & (1ULL << 1))) + \
+                     (!!((word) & (1ULL << 2))) + (!!((word) & (1ULL << 3))))
 /**
  * fns - find N'th set bit in a word
  * @word: The word to search
@@ -255,13 +262,48 @@ static inline unsigned long __ffs64(u64 word)
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
 	unsigned int bit;
-
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-       }
+	unsigned int sum = 0;
+#if BITS_PER_LONG == 64
+	bits = __const_hweight32(word & 0xffffffff);
+	if (bits <= n) {
+		n -= bits;
+		word >>= 32;
+		sum += 32;
+ 	}
+#endif
+	bits = __const_hweight16(word & 0xffff);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 16;
+               sum += 16;
+       }
+	bits = __const_hweight8(word & 0xff);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 8;
+               sum += 8;
+       }
+	bits = __const_hweight4(word & 0xf);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 4;
+               sum += 4;
+       }
+       bits = __const_hweight2(word & 0x3);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 2;
+               sum += 2;
+       }
+       bits = (unsigned int) (word & 0x1);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 1;
+               sum += 1;
+       }
+	bits = (unsigned int) (word & 0x1);
+       if (bits <= n) {
+               n -= bits;
+               sum += 1;
+       }
+
+	if (!n)
+		return sum;
+
 
 	return BITS_PER_LONG;
 }
-- 
2.40.1


