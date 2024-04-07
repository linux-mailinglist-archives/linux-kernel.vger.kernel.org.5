Return-Path: <linux-kernel+bounces-134154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20389AE52
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573521F225F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C21C10;
	Sun,  7 Apr 2024 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQkMjBv6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903217C9;
	Sun,  7 Apr 2024 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712461151; cv=none; b=LcSU1CXuiwQWwnfjp7xzxtvKoHc2ZE8bWg3fDuaug7Ika9ssKS8GjWG0I8y4bMygBzV86ddddp7oQsSXDnjGjsm0edX/xrOLRtE/pb3IccUdfWyxhsq2D37ivyPY0kxW6k9prkaaOW38f41ycLLCg3EI/CN8KSAbzWzaF1yCP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712461151; c=relaxed/simple;
	bh=6RM4/wxKDJBV9XWCUmXREWdx4pUVr6VlGvGFWBQmqlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTZwesy5+aPvszrEbYG/ps3dYbvH3z2RCtj5HdvQT/TBSKsc52imBTm3Ck0fSG+d3PPJLWik0GY5vjSRNPoOM8ayHWv+O+Tx17EO1JL8NbvXvc1vAu5j9NLrbVXpZkcFG7pp/uzCaykUdhTYwmUYlmjYEXlODHp5RCzKrWG4vkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQkMjBv6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2f2cd61cdso771399a91.1;
        Sat, 06 Apr 2024 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712461149; x=1713065949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HkK+CaE1oLst0JhVLszLXuWHXlJqM2t7bQ0zDVzsYA=;
        b=OQkMjBv6d0rpVUP0ySDDGtl1SkuqPx8ZdEggd+9sbm52kcGDEKDHeiyYuGRWVNJLsF
         yY6H/9n4zeeY5iZ8UAXWb2dJC168WNbfEM0Be3GysUeQNw5C4x1W9zv0+1YYU6laz5+x
         S/XXAjfkz2xx/tjyAenO3518WoS2uz7c6K7zdbQoz/QYpH48h3t5d36i5KVJpKX03uOG
         nIFA7w1UOLFvZJ7SK8uaWts2aSfSjGefEmMvZD3ReriEfqfW6capOp1A3w3ErfTwuYQe
         KvYjI5e/eGnhyQ9BgBE/Ap76brJACgCFQ4ciy9osqiWdleduL3+tQHnjCpOPLR62rrVQ
         CZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712461149; x=1713065949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HkK+CaE1oLst0JhVLszLXuWHXlJqM2t7bQ0zDVzsYA=;
        b=hhmq3zicqjLsUmqvSKsZF75oEjRQZiw7x0oNCI+bGQn0R2xQSOlp+84x+Ij3CsJQfi
         y8BmgwK4hf/JYwIaLaeOEOU1v6kzQkLBTIVpFKvH82s7ol5jGZfXBLMMticZvaOPiv+p
         P3ni1P9cUSE6lRYh+VicrM8ODEiEHT/uqU1NHj69QFV6QiG7c7+UWUFq7KLihw3qso37
         np7wHSQaqo9BWmgaS33W+xSY6nwP3xvExXVnZEDjn4SFGAJpQqTbDoHoKgn+vRa7javK
         SH3iiJoJLtO4B6WlY7wLxY+U8if/wvXyQHsWcMsFGsKY6wFenfXJO8nFpEfNKIEPHXpd
         oimA==
X-Forwarded-Encrypted: i=1; AJvYcCUbBjyDqx594TpJmFVdqpepXEUYgGokcA/xCOOQwEq4i31QZPbTo++ukPkcHafGZ5zCqbxgzNv+2GuxHmPRRG0OpYxJ5Q0OJ89qzJUgZxgSpaLNw21Y003A+e/l6xyNWwBt2EFg9sCbdtAJoNc=
X-Gm-Message-State: AOJu0YwjSpn/zc+1nYstHHXbx0vTVJnd/OXc56gi1EyYeM41oeKkzSQY
	AUPRAf8IoV36GIZfF6oQxqPyBfspNWKjKCJdMrluedAfm50CSPmo
X-Google-Smtp-Source: AGHT+IHERZOt7QqvsRnr96Slvqpdaqq5czpYFr5eSCsRsU2B52vkf1OJHawTXF5U7Hp1Vq1IdGMg7w==
X-Received: by 2002:a05:6a21:6d98:b0:1a7:50b0:6535 with SMTP id wl24-20020a056a216d9800b001a750b06535mr4967100pzb.5.1712461149049;
        Sat, 06 Apr 2024 20:39:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79e46000000b006ed059cdf02sm2985170pfq.116.2024.04.06.20.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 20:39:08 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	jserv@ccns.ncku.edu.tw,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] bcachefs: Optimize eytzinger0_sort() with bottom-up heapsort
Date: Sun,  7 Apr 2024 11:39:04 +0800
Message-Id: <20240407033904.719773-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2vm32rfcbgy4fap77scebqorlrpaihz3angd6bl2lnpslrcp63@kekiknxt5vup>
References: <2vm32rfcbgy4fap77scebqorlrpaihz3angd6bl2lnpslrcp63@kekiknxt5vup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This optimization reduces the average number of comparisons required
from 2*n*log2(n) - 3*n + o(n) to n*log2(n) + 0.37*n + o(n). When n is
sufficiently large, it results in approximately 50% fewer comparisons.

Currently, eytzinger0_sort employs the textbook version of heapsort,
where during the heapify process, each level requires two comparisons
to determine the maximum among three elements. In contrast, the
bottom-up heapsort, during heapify, only compares two children at each
level until reaching a leaf node. Then, it backtracks from the leaf
node to find the correct position. Since heapify typically continues
until very close to the leaf node, the standard heapify requires about
2*log2(n) comparisons, while the bottom-up variant only needs log2(n)
comparisons.

The experimental data presented below is based on an array generated
by get_random_u32().

|   N   | comparisons(old) | comparisons(new) | time(old) | time(new) |
|-------|------------------|------------------|-----------|-----------|
| 10000 |     235381       |     136615       |  25545 us |  20366 us |
| 20000 |     510694       |     293425       |  31336 us |  18312 us |
| 30000 |     800384       |     457412       |  35042 us |  27386 us |
| 40000 |    1101617       |     626831       |  48779 us |  38253 us |
| 50000 |    1409762       |     799637       |  62238 us |  46950 us |
| 60000 |    1721191       |     974521       |  75588 us |  58367 us |
| 70000 |    2038536       |    1152171       |  90823 us |  68778 us |
| 80000 |    2362958       |    1333472       | 104165 us |  78625 us |
| 90000 |    2690900       |    1516065       | 116111 us |  89573 us |
| 100000|    3019413       |    1699879       | 133638 us | 100998 us |

Refs:
  BOTTOM-UP-HEAPSORT, a new variant of HEAPSORT beating, on an average,
  QUICKSORT (if n is not very small)
  Ingo Wegener
  Theoretical Computer Science, 118(1); Pages 81-98, 13 September 1993
  https://doi.org/10.1016/0304-3975(93)90364-Y

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add the testing code to the source code and wrap it with #if 0.

 fs/bcachefs/eytzinger.c | 105 +++++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 17 deletions(-)

diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
index 0f955c3c76a7..2eaffe37b5e7 100644
--- a/fs/bcachefs/eytzinger.c
+++ b/fs/bcachefs/eytzinger.c
@@ -171,7 +171,7 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
 		       swap_r_func_t swap_func,
 		       const void *priv)
 {
-	int i, c, r;
+	int i, j, k;
 
 	/* called from 'sort' without swap function, let's pick the default */
 	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap_func)
@@ -188,17 +188,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
 
 	/* heapify */
 	for (i = n / 2 - 1; i >= 0; --i) {
-		for (r = i; r * 2 + 1 < n; r = c) {
-			c = r * 2 + 1;
+		/* Find the sift-down path all the way to the leaves. */
+		for (j = i; k = j * 2 + 1, k + 1 < n;)
+			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
 
-			if (c + 1 < n &&
-			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
-				c++;
+		/* Special case for the last leaf with no sibling. */
+		if (j * 2 + 2 == n)
+			j = j * 2 + 1;
 
-			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
-				break;
+		/* Backtrack to the correct location. */
+		while (j != i && eytzinger0_do_cmp(base, n, size, cmp_func, priv, i, j) >= 0)
+			j = (j - 1) / 2;
 
-			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		/* Shift the element into its correct place. */
+		for (k = j; j != i;) {
+			j = (j - 1) / 2;
+			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
 		}
 	}
 
@@ -206,17 +211,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
 	for (i = n - 1; i > 0; --i) {
 		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
 
-		for (r = 0; r * 2 + 1 < i; r = c) {
-			c = r * 2 + 1;
+		/* Find the sift-down path all the way to the leaves. */
+		for (j = 0; k = j * 2 + 1, k + 1 < i;)
+			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
 
-			if (c + 1 < i &&
-			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
-				c++;
+		/* Special case for the last leaf with no sibling. */
+		if (j * 2 + 2 == i)
+			j = j * 2 + 1;
 
-			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
-				break;
+		/* Backtrack to the correct location. */
+		while (j && eytzinger0_do_cmp(base, n, size, cmp_func, priv, 0, j) >= 0)
+			j = (j - 1) / 2;
 
-			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		/* Shift the element into its correct place. */
+		for (k = j; j;) {
+			j = (j - 1) / 2;
+			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
 		}
 	}
 }
@@ -232,3 +242,64 @@ void eytzinger0_sort(void *base, size_t n, size_t size,
 
 	return eytzinger0_sort_r(base, n, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
 }
+
+#if 0
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/ktime.h>
+
+static u64 cmp_count;
+
+static int mycmp(const void *a, const void *b)
+{
+	u32 _a = *(u32 *)a;
+	u32 _b = *(u32 *)b;
+
+	cmp_count++;
+	if (_a < _b)
+		return -1;
+	else if (_a > _b)
+		return 1;
+	else
+		return 0;
+}
+
+static int test(void)
+{
+	size_t N, i;
+	ktime_t start, end;
+	s64 delta;
+	u32 *arr;
+
+	for (N = 10000; N <= 100000; N += 10000) {
+		arr = kmalloc_array(N, sizeof(u32), GFP_KERNEL);
+		cmp_count = 0;
+
+		for (i = 0; i < N; i++)
+			arr[i] = get_random_u32();
+
+		start = ktime_get();
+		eytzinger0_sort(arr, N, sizeof(u32), mycmp, NULL);
+		end = ktime_get();
+
+		delta = ktime_us_delta(end, start);
+		printk(KERN_INFO "time: %lld\n", delta);
+		printk(KERN_INFO "comparisons: %lld\n", cmp_count);
+
+		u32 prev = 0;
+
+		eytzinger0_for_each(i, N) {
+			if (prev > arr[i])
+				goto err;
+			prev = arr[i];
+		}
+
+		kfree(arr);
+	}
+	return 0;
+
+err:
+	kfree(arr);
+	return -1;
+}
+#endif
-- 
2.34.1


