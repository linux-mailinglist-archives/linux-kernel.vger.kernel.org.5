Return-Path: <linux-kernel+bounces-148636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCF8A8561
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26B31C20E07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6BE140E40;
	Wed, 17 Apr 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2zDDx9r"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CE139F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362233; cv=none; b=SBLhMyCn2QkeHaewz2u3TBrWvQAzQDSJgw/vJBH51CavcabUGWVup5LNryCXh6jOfQzQP2lullKfdLR3NOERQ+kp9+jpoJQTGhfsaAY9nx4N8O3qQESzf1cIUPzFdWztlblOuIHFhvaB0IOnA27RFQdPuz7I6IaJGLnG4nss1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362233; c=relaxed/simple;
	bh=XLvYLU4eF/dPhXr9R4HaBFMJ+6xEWfr8YB2tRLmE8JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnyQLQgNxTi9u/NZ0+R0VgXfUR/Mwipv8YEcwfvuM3lRPuUtHR7KYElFayAqNd6WCYjH36zUwenat+OpD3s9/4b8KDZsVlP4ceBgDJi8I92xP26h8E1Sruas2mJE/kMzqA2iUVUV5qXyhRgJd69DFIUJy4/RVSrplh/xASY/Qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2zDDx9r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e651a9f3ffso21031785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362231; x=1713967031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoWPGw5XhVyWYSlc/o5noqumx8xqX3eLJxgrmq9khU4=;
        b=d2zDDx9rDVjNqHSwVDjgCqod/0Tusgf+4cfVEwEWsmtFDZvM9b+hPD5Y6PBkOAdw5U
         e61s7rYm916Q0DUqQcER0Dyv1D3wGpOj27Fj7j4Z0l31fTI+itUiRZULVSk/xQEAYNhF
         2EsH+zouX4ukA0RFpA5odVLxvYYtP7WZZ/ldTRx6U5U0rNZnQFpS4kKAwD1nONAfrlyI
         UbyPxbFuQeux5nVgw2gyoGQyO0GJO019Uxylj2OKlPGd5yB9n6Jm1KzF1uf489OKeJek
         Fo4lCl7m9PNT6WnuzBd+miUS6rH5MSXkgfvJUaZnQJGEbu4TEe4GnTDjKpaGd8WnU7e4
         Vtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362231; x=1713967031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoWPGw5XhVyWYSlc/o5noqumx8xqX3eLJxgrmq9khU4=;
        b=JkzBqkk/nRAixE0xbf+LeisjogwTbXIsm7rabitFSsrJRuL7NRiazTJy0UcDteYpkt
         3v26BcC4Gfg6aVTbJGtFz7lfw4tHxO2sqCw48B+wsVPFMlTOYMNQE8rce62cXtcfhem5
         3xssreJLu+PS8nhQnbqedv35lE9y8iUoMpphzUag4WZB1i/Y6XUnRgAO8yxc6UARhaAA
         HB9mQaicgnuMj1sN4R8SpSNwgiERHdkSJrGiLWW1vOMQrIybWYCc+Zh3iZLj7LMB/Mg2
         i9b44/qPawnXXjnNd5wxhaSrHBjQL+2SBSwIcM82665yigNcR2UUATI0RoXeMZqFSsDq
         UeWA==
X-Forwarded-Encrypted: i=1; AJvYcCXrL7c0fV/IJdAhnIvSenym3jaieWi6RI6XLPBL/QswDRbUfbWW8HnDpeL/xXuyF81QmfzZM8JnlzDv2HEmkRm4JvwTnG/t12xJG9KL
X-Gm-Message-State: AOJu0YyMYvXl5QWJrzlYhcIdLLhzanWzemyVdrxamqqsIFWD/s4+Cvpm
	XSlnxwypMuz0s8zbBIeR9wL27ytnxXWBDZ1GM3XkS82G2I1TFQ9Q
X-Google-Smtp-Source: AGHT+IG7HeoSlD6WjfLHgM947oAumt6yz9jgDNwugrmLPHmmflMNTCRcFoC2QKrXSPvFCaMZhJKrlg==
X-Received: by 2002:a17:902:c951:b0:1dd:6ce3:7442 with SMTP id i17-20020a170902c95100b001dd6ce37442mr15422757pla.39.1713362231529;
        Wed, 17 Apr 2024 06:57:11 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id jz5-20020a170903430500b001e41f1dda43sm11623485plb.75.2024.04.17.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:57:11 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH v2] linux/bitops.h: Refactor function fns to reduce branch usage and eliminate external calls
Date: Wed, 17 Apr 2024 21:51:07 +0800
Message-Id: <20240417135106.21640-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417132252.20773-1-chinchunchen2001@gmail.com>
References: <20240417132252.20773-1-chinchunchen2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrote the function fns to use macro wrote in linux/include/asm-generic/bitops/const_hweight.h.
Decrease the number of required branches and eliminate the need for external calls.
The number of branches is now constant, unaffected by input variations.

This commit improves code efficiency and clarity.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
Changes since v1:
 * wrong patch send in v1

 include/linux/bitops.h | 62 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..55d81755e56f 100644
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
@@ -254,14 +261,55 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
-
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-       }
-
-       return BITS_PER_LONG;
+	unsigned int bits;
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
+	bits = __const_hweight2(word & 0x3);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 2;
+               sum += 2;
+       }
+	bits = (unsigned int) (word & 0x1);
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
+ 
+ 	return BITS_PER_LONG;
 }

base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
-- 
2.40.1


