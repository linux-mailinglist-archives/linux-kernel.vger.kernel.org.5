Return-Path: <linux-kernel+bounces-167065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BD8BA3FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F2E281FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9E47A7C;
	Thu,  2 May 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiZIuSs1"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF5433CF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692735; cv=none; b=M+3nYad19exjfwYHhHJMzLBu1iZaOW47zLGAsMHKTnK0c0NNW3Ir9xlwqyGXEJYKbRQ2OkBp0AD4DNJmRSh6bmYQu8NZ9/hg83N+mjb3iH0Ip5h5iXdCPQp9UbpKbFyQj74cZM6Him9Y6IHspkh8OEhTKgWm1u4+Bh5+Q6ado2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692735; c=relaxed/simple;
	bh=YpKQ29iVm/00wlNh7i525FynJteEBIE69FNB58UBFw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pryRt6yQfmsgrFFfXkf9w2mD0pCMv93Yuc4ECsxBGBfvUlCCxlpqJn3Bbm0AgxD6CG+lPOXQVZPCbn/jkGLHaMUJtbI7DNP3tba+fjXazWQN9Ocp0GjGdMjTsvoLheZDfi4ZZE5aaPHOOrmdq9r39qKqvqCMUhYkJ171coSI2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiZIuSs1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6150670d372so72612327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692733; x=1715297533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz+WU4hPA1taz/uX+9jMD3l6e25brCZmsg2ndtmnoJ8=;
        b=AiZIuSs1aldkY53bh7NAE0FKEBb2vPe8vc7FLYShAa+uVs20nXIpxgqVBhllqc7lHp
         peU/H73mtq+Q3kTUHY4pw5lbphmvMAeTk7izzsR+WNMx9KaaQ+arjB62AB5yeQq16MkC
         +k4azmGqSdETba3pD6/sAnSqqdS+VTEN/vMz/v4sbtC/FQnCYe+B0EeNegyrFCyAlyld
         UF+TSTKUpoLYGAJ1zMbB5EUpXcRQnlhwB65/e59YIoYOF55WWkBxCrDXCwEXePS0bcdB
         xI5Hh0HDhBg7WlzYd6XtF6kqRYi8umeTBDCTTDvoxK0Rz9wIHiTII3++CczjkYbQENd8
         SjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692733; x=1715297533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz+WU4hPA1taz/uX+9jMD3l6e25brCZmsg2ndtmnoJ8=;
        b=AzJG3k2nXMax9ydTkBgkCXAcQoki/ii4AAqYM0voalzcNDdzaf8LGE9GALCDnO2+nY
         clbhjb/CUfUz2et6qKRFCKJg492p2xaUYJOcXlxjgGYEc1CmM2fEdpLzlQXBnmmd9PxC
         dHGIzH2dKTyUuyNdjneafd9pMEDORByY+1Wwur+T/FSPftZiF6Y0bI1LY2ctr43x939z
         mZIHZYvpWDj5nRn90XtW3YIsF+jgMU7Gz072tme6+MRnycjEwT2U9Pdk2kvaovOGIvBq
         yYensZ1H5y0I8wZ2bMyxbto7cbDZwsUNQrL2e//wxZx/H49YJGIUSAeIrXthzTryvhOn
         EPnw==
X-Gm-Message-State: AOJu0Yw2HD1sVOxvRTqBphBDo1jno65KRuEoZsWUzka7oHAUwR95/dcd
	K6WsKJ0BtLDstJ5HiVI4WfjyVSjO2H5P3AO9fVstNkvtL2t+mCw69Ob0VA==
X-Google-Smtp-Source: AGHT+IG3RRdpWMQIhYOUX+rJ1wV69r7PLNWhZhd134y5VWy4XsO8zgu0Csr0D+x/IcixBUrGsYvmlQ==
X-Received: by 2002:a0d:d40e:0:b0:615:1dc3:9596 with SMTP id w14-20020a0dd40e000000b006151dc39596mr1108749ywd.28.1714692733374;
        Thu, 02 May 2024 16:32:13 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id s3-20020a817703000000b0061beb26a082sm425303ywc.112.2024.05.02.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:32:13 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/4] bitmap: relax find_nth_bit() limitation on return value
Date: Thu,  2 May 2024 16:32:02 -0700
Message-Id: <20240502233204.2255158-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502233204.2255158-1-yury.norov@gmail.com>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function claims to return the bitmap size if Nth bit doesn't exist.
This rule is violated in inline case because the fns() that is used
there doesn't know anything about size of the bitmap.

So, relax this requirement to '>= size', and make the outline
implementation a bit cheaper.

All in-tree kernel users of find_nth_bit() are safe against that.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Closes: https://lore.kernel.org/all/Zi50cAgR8nZvgLa3@yury-ThinkPad/T/#m6da806a0525e74dcc91f35e5f20766ed4e853e8a
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 2 +-
 lib/find_bit.c       | 2 +-
 lib/test_bitmap.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index c69598e383c1..02751e43d448 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -220,7 +220,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
  *	 idx = find_first_bit(addr, size);
  *
  * Returns the bit number of the N'th set bit.
- * If no such, returns @size.
+ * If no such, returns >= @size.
  */
 static inline
 unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..0bddfc3ff248 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -87,7 +87,7 @@ out:										\
 	if (sz % BITS_PER_LONG)							\
 		tmp = (FETCH) & BITMAP_LAST_WORD_MASK(sz);			\
 found:										\
-	sz = min(idx * BITS_PER_LONG + fns(tmp, nr), sz);			\
+	sz = idx * BITS_PER_LONG + fns(tmp, nr);				\
 out:										\
 	sz;									\
 })
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b2b33579f56..088838f829c9 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -244,7 +244,7 @@ static void __init test_find_nth_bit(void)
 	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3, 5));
 	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3, 6));
 	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3, 7));
-	expect_eq_uint(64 * 3, find_nth_bit(bmap, 64 * 3, 8));
+	expect_eq_uint(0,   !!(find_nth_bit(bmap, 64 * 3, 8) < 64 * 3));
 
 	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3 - 1, 0));
 	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3 - 1, 1));
@@ -254,7 +254,7 @@ static void __init test_find_nth_bit(void)
 	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3 - 1, 5));
 	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3 - 1, 6));
 	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3 - 1, 7));
-	expect_eq_uint(64 * 3 - 1, find_nth_bit(bmap, 64 * 3 - 1, 8));
+	expect_eq_uint(0,   !!(find_nth_bit(bmap, 64 * 3 - 1, 8) < 64 * 3 - 1));
 
 	for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
 		b = find_nth_bit(exp1, EXP1_IN_BITS, cnt++);
-- 
2.40.1


