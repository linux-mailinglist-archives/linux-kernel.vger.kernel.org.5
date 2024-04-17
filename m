Return-Path: <linux-kernel+bounces-148541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99258A842A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B0B24F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914F13E043;
	Wed, 17 Apr 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCyxuG+d"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2013E041
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359963; cv=none; b=d4rLyp4JT2aCirJQnSnlLykZwUm8yeGkk1ZqKPf0wfCarUdiF03ss5ShWvcKCTqHYz1q6ZOascLU5MgLQVIVXrST7EK4Og/CYSVpBm3cYxXc/V1flZHxczWJQ3zTmMD0/YgFaGd8hY1TYaY55XQzAxVb3NDyp+aJEdqlA+xnBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359963; c=relaxed/simple;
	bh=Hm9S9kOueaae4Ku1kG2pXXiHnA+XJpcNftggbxIOTeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgUbwP+dNY2nqR353Tu8nbF+rt0amAlrwChi90p+FPAJ8/40E8/fbKhDuLaXK3BP+/qU+uRBNKDPpysrTf0/zADlG+Kzp4Q33LcRSfN9smrN+fzLdEd3oUPdDcSdsY6M7iHqtJwrCbus+MV9ipsfPM8yv1EEvq0BXvodK9dLYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCyxuG+d; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a526803fccso3312465a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713359961; x=1713964761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkjQhSA3tM6FeM9oFUUpRmH9XGP0wA/a2+dvEYG/feE=;
        b=BCyxuG+dtrtD1Mk1FMjHY9JFRuKgbYVl+wIOLjAuEGHpbNKLQXBRHDXEDaXJnJ1fOk
         jZcQl173oUOYDZjCp8ilOe00VRlyvCDNpo+4gol+1HE7xIYjbsR/CCs9VvvvSw4YyeF1
         4qD6nQDWDy1ygYaZZceiltbb9AmsuPIDPrek/m3P8Jhv8KOIQ+HJP/tZY1VORdVD3iZO
         aY0jq6yLJjmGIH0WufI5eY3f6oZeACTBlYhlgj/xgVDcsVrHz8sFB5HyojVM1Q+4YaLh
         GAfhX+M0KrkjmDYnTuYgmgm3O4OsyOGrZJmGpS31QX0LOQWMcLSNQz28GXy0nGojvYFO
         h4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359961; x=1713964761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkjQhSA3tM6FeM9oFUUpRmH9XGP0wA/a2+dvEYG/feE=;
        b=UcMD/6/l8HJTr5J+bO/4Z891bot9A01cf0umiuiWNVS8CTS8absj5WpJOg1b+0WxPi
         hguSaRXQIG3bT/FEn+4y/58zSkQRkI+ASf9YkC9uXBXdPPoHjA4M5bWDh4+Jw0/6dmgP
         jZz9sXs1QFgdevG6XI7961Kve+trM1M34bmAF4ezw0mM7IdbJhI+UdoX8/vLbsMBQerk
         sc+FMRZ805o7QbhuPPmEX6euqNqHftKWURqHXcVb4GMcT/l2IxNuhjXdUmjQ15L1T1y3
         F2lMllQmBDjLJxgdlWqgY8Zlt6J/UNZS8qJ4NWIaWkUpYUPkVIApjW6BSGWjlqGbHb5S
         rm5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcE7bPeSX6tzAro/0E+JXz1I70f8H60sQBdl/ibMDYIx+4Lq1xtgFTgRnbWfGz7g7R4DUZnlQ3JLjtdichuhOcdbgGNWWPM+ue2nfk
X-Gm-Message-State: AOJu0Yx/FcV6tYhatWHeWMJ82eRbYPx8q7mmf1uU6zeTvAqldTd6AjRm
	kO+VHeTPltxrv2vTXJa2Fwk6j90+cBa1wPTEbh1W9PyW/x/x8fhH2w+og8T4
X-Google-Smtp-Source: AGHT+IEi4sVGnYmz33zeYdTofl7frUX0AP4dAWS97/Q0txIa/JayTocCKiJlUL4Ymglg86dV1aSLfg==
X-Received: by 2002:a17:90a:ea81:b0:2a4:c2c4:4a84 with SMTP id h1-20020a17090aea8100b002a4c2c44a84mr15445513pjz.43.1713359961383;
        Wed, 17 Apr 2024 06:19:21 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090ad50d00b002a5dbfca370sm1329513pju.48.2024.04.17.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:19:21 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] linux/bitops.h: Refactor function fns to reduce branch usage and eliminate external calls
Date: Wed, 17 Apr 2024 21:16:56 +0800
Message-Id: <20240417131655.20629-1-chinchunchen2001@gmail.com>
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
-		if (--n == 0)
-			return bit;
-		__clear_bit(bit, &word);
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
+        if (bits <= n) {
+                n -= bits;
+                word >>= 16;
+                sum += 16;
+        }
+	bits = __const_hweight8(word & 0xff);
+        if (bits <= n) {
+                n -= bits;
+                word >>= 8;
+                sum += 8;
+        }
+	bits = __const_hweight4(word & 0xf);
+        if (bits <= n) {
+                n -= bits;
+                word >>= 4;
+                sum += 4;
+        }
+	bits = __const_hweight2(word & 0x3);
+        if (bits <= n) {
+                n -= bits;
+                word >>= 2;
+                sum += 2;
+        }
+	bits = (unsigned int) (word & 0x1);
+        if (bits <= n) {
+                n -= bits;
+                word >>= 1;
+                sum += 1;
+        }
+	bits = (unsigned int) (word & 0x1);
+        if (bits <= n) {
+                n -= bits;
+                sum += 1;
+        }
+
+	if (!n)
+		return sum;
+
+ 
+ 	return BITS_PER_LONG;
+ }
-- 
2.40.1


