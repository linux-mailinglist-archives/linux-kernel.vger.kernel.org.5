Return-Path: <linux-kernel+bounces-148565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6A8A847C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C125C1F212C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0B13F431;
	Wed, 17 Apr 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHQZNkyz"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB513F42A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360347; cv=none; b=ZxTzNnXGVfECySvBWsubbbSDY9TvgSRXyYIzO8tFjxh3OqcXjd2O0MHggUoKQdEJzGMA4JdmHIsqld51Cfl7kQoZwZNsMK+RoyNe8BjhYSey5agZIpkThytD/rl0VBZ6Se/UdsZU1YO17//Zcdh13149wTrvsl5AqIXcvO/luAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360347; c=relaxed/simple;
	bh=ZwsaIiVHVcCeS/Y+U6ld+aI2D7mHfJVlxiHqDirD6Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soQR91mRWRYCkobP5rfXGzxGIXgbXSL0sqrh+eFs8NKpdFOnj+3Q7NoMTLUfeIqMeawNDCDztuMD4wU6YwfBDR1a4phxpZo1ZYmKmz4TTX4KxMqz2BwXBBiKxFLQO1HxKCqyk90CiJvoCteShjRd93kPyHfKhPjquFFplZImZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHQZNkyz; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a0f64f5e0so24877855ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713360345; x=1713965145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+zZdTXWkV9gVF184HLDzNZ7nVVv6bcbAinsMPWeWaE=;
        b=YHQZNkyzOWjxdfC5G9ZomaBNvo/dkepz+nbcsi3Hde6lg+AqZnU3yH3d3290aSRgzM
         5iGgJ4/sv6lXZJmUck6veCgtM/Ojf1Tysz+7rcIPSZkk/scgeLa5+s1HNCjAOxNK2F1O
         sHcZpRs2S2thq8GaQ0R4Uw1UjCnCMsHTeKlBtYAhPcBxIDDfz1jLd+yCABAaybpyY02z
         mH/k6j90qAhQnvWtui96yUiKfqVhADAGcafH3K1Fjj09B05rw3dq5KQ72f3N4RVwPCKz
         yQQ5yEXzw2UB01SXsI5LgAs13OMM11hdPAiUNg9EOKkF3Cycpte78yqEVPW08F9XSySQ
         v7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713360345; x=1713965145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+zZdTXWkV9gVF184HLDzNZ7nVVv6bcbAinsMPWeWaE=;
        b=Yry9RS/La31X7ZCVnOWP84q8xdpNZsSNlm2a1Dg+TB9NRnwIGIzah5tolV1vuSastq
         JKtUPG9XXof747bM6Xh0NVjhezvR2Bg2EdbkCUafxwEPuk7cXdFiBI43dF1N+a8eQkO3
         Bvd24nH5ujsur8EYPn6OJ1tHSc+u7rwxBPeUZfaT4MqzaKohNXwbj2drFpfAHU6pccBB
         r2l9AhFoh/3anTtYtd5Y4KJOXZfXXrrRiLrELCZvlzXcpCCzt5F3shqsNuTK43gfXYoK
         Kg+k0fZgjQjOlTSNkA931qRFeQENAM/xoFPGhXzNAtYgpMes//GhVT1qqnmFRn4QIgSc
         et6A==
X-Forwarded-Encrypted: i=1; AJvYcCX64XgjVbEAEv7vf5ubBNp+gZcQH6+rlxP0LjuE/QhxArD7prsTtgyHHtZ+Us7nmNsXX3DY0w0/OBugaEl9wb6huQ+KI5uqvtUC0nv9
X-Gm-Message-State: AOJu0YzDnhWbQe1UrEG27EAXnX+rWMA+s+8M6uy99/lUJgqFP8Fb8/oL
	4/6grP1cGeRQSiRaQW3SSqenRubYyo6JtLcqAlu24NRIgbt9ud+U0nm3MrlU
X-Google-Smtp-Source: AGHT+IFVnt9Hd/RMwTyurlDuliRTPKFHlWP7hlE8SBayqVxnYGg6givwoEF6ouh053OUfhn20mgd+w==
X-Received: by 2002:a05:6e02:b4f:b0:36b:1868:fa44 with SMTP id f15-20020a056e020b4f00b0036b1868fa44mr13433964ilu.14.1713360344685;
        Wed, 17 Apr 2024 06:25:44 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id u127-20020a637985000000b005cd8044c6fesm10411263pgc.23.2024.04.17.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:25:44 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] linux/bitops.h: Refactor function fns to reduce branch usage and eliminate external calls
Date: Wed, 17 Apr 2024 21:22:54 +0800
Message-Id: <20240417132252.20773-1-chinchunchen2001@gmail.com>
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
- 	unsigned int bit;
-
-	while (word) {
-		bit = __ffs(word);
-		if (--n == 0)
-			return bit;
-		__clear_bit(bit, &word);
- 	return BITS_PER_LONG;
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
+ 	return BITS_PER_LONG;
 }
-- 
2.40.1


