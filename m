Return-Path: <linux-kernel+bounces-134121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB889ADE2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AD1C21B63
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409FA95E;
	Sun,  7 Apr 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtUkg+Fq"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A28F4A;
	Sun,  7 Apr 2024 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453638; cv=none; b=lYIzwp991LxcPE6JmUEW+iEebOLjSxzLW2hgxfrRb4xBav9XnRka2Sz71CVU6qA+kFNJo7bnxFIrxldR6f6IykfzycugHDnt1wLzPQ+N7ImkUxD0lI02oqZygT4/Yx3Jb2C4rnXjWlCHTEsX3c9szruMtgLFij0ZeMRzxe75OCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453638; c=relaxed/simple;
	bh=u67NXfWVwBO73JYMzpYtATDrpyrfImDO8QWteBmwEII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rM00mKFuUsPD0J5DQK7cVRZ484GCq0URYNQNFAr24lojwNaQWWyBtm4xlVTPq0lUo0XZvovveM3/g3KgYPOFItsca5z8rUABX9v/Jt7vMg1rDYUw9XKrqtK4q68+eZ7jLyjbo08BqzzIj/X13tFXIfEx3th18Sv4aUhjZ+SzmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtUkg+Fq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a2bcc0c075so899888a91.0;
        Sat, 06 Apr 2024 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712453636; x=1713058436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+vSeLkYhk2/3KtEp6S7LMbdJT6cWt66rs7YNQZORA8=;
        b=UtUkg+FqmlDpLKB3/R/3X33FJhYGs73fzron1Np5WUaV8uBmIybQcnuq/XEchwgqEa
         qBldMjH4xK6HKDNRmiE0Ufi9DlgOPNKXuJKnQHvI02sDzUgwhpqmC7TlPkhYyg7KkSfq
         aocrGx0AXv54Y9jbbDhUe8vVDpi1OI89UtPjVTqnqfI3Inw+NIBRW1TvZv0SAK7RKU8y
         pw9CmHzav7PH82WWG3OIiLwMfnbzY96QAZXJU0oJ2C8bJ9JZt3wt0w+szi+bDJTj96nM
         k3wG4/L4kfjEUF+UWs8097hmd1gw7wOAh7iU/xqcvGZKh93OFuT0PPpojjyvJiA9OjaN
         IQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712453636; x=1713058436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+vSeLkYhk2/3KtEp6S7LMbdJT6cWt66rs7YNQZORA8=;
        b=JUKtRagDJ5QfzQpUNHdYCnzwIZJNktsbSL7typLfz91iwS6CfcbQZWBScii+zP+GjZ
         M+N3osV3L1R2dKxpStaxHwaofzW5imm7vqk85QZ+uQs3RkfnuIYtH+i0Cp/LHTzV8777
         +Oe02F3YQgs8JK2zIa/OsWzicb05BX91+fNqAG8gVXMl3A5E71t6c5oHRVUMF05wZD2Z
         Uikh+O+oXCDisgYQkl73qJbIBclNojJC2Oawrj0fGWJGNQqehYoavmmK/lyve4V+dNu6
         OPC9uKAlczD+jofMK/4qoInu18mNdub0kbVrIvutN6obeSScnwr523frh/0uxgMk/eFE
         otMw==
X-Forwarded-Encrypted: i=1; AJvYcCUiNQoPXMedaOAszQXZ4qMvj60qLAkLVnXx3mmgSXkE8rTa3hK5cEHD6YT/ucMp0dgf6YF2P8xTs6AFd887o1fKMS9pBHDnxQDz0dUs7AiK1rw1AKJXyb2+MNn3Tf48sFtrD6Fo/CEqBwP0WKw=
X-Gm-Message-State: AOJu0Yz3kkBW2w27SBBcwuyKSIK0d6QCBKHc3Pyv4xxfTxL4+dSzXUqZ
	RZySSeStcy2pV0Zg13ru2aWoogLdhFs3wzDaTSIasoUyZ/uQ+RIy
X-Google-Smtp-Source: AGHT+IFeLFIZz/odm2p75x7I15WeRC4JSp3NFnHs9Az9D0uZxFyWIRLRGDIMh1Cp7LDZ10LhIwv9Dw==
X-Received: by 2002:a17:903:2351:b0:1e0:c887:f938 with SMTP id c17-20020a170903235100b001e0c887f938mr6731003plh.3.1712453635772;
        Sat, 06 Apr 2024 18:33:55 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001e2a4663179sm4035903plc.258.2024.04.06.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 18:33:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	jserv@ccns.ncku.edu.tw,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] bcachefs: Optimize eytzinger0_sort() with bottom-up heapsort
Date: Sun,  7 Apr 2024 09:33:49 +0800
Message-Id: <20240407013349.672667-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is the same as the patch I submitted previously [1]. Since we
decided not to move eytzinger.h to generic library code, I resubmitted
this patch.

This patch has undergone unit testing and micro benchmarking using the
following code [2].

[1]: https://lore.kernel.org/lkml/20240121153649.2733274-2-visitorckw@gmail.com/
[2]:
static u64 cmp_count = 0;

static int mycmp(const void *a, const void *b)
{
	u32 _a = *(u32 *)a;
	u32 _b = *(u32 *)b;

	cmp_count++;
	if (_a < _b)
		return -1;
	else if (_a > _b)
		return 1;
	else
		return 0;
}

static int test(void)
{
	size_t N, i, L, R;
	ktime_t start, end;
	s64 delta;
	u32 *arr;

	for (N = 10000; N <= 100000; N += 10000) {
		arr = kmalloc_array(N, sizeof(u32), GFP_KERNEL);
		cmp_count = 0;

		for (i = 0; i < N; i++)
			arr[i] = get_random_u32();
		
		start = ktime_get();
		eytzinger0_sort(arr, N, sizeof(u32), mycmp, NULL);
		end = ktime_get();

		delta = ktime_us_delta(end, start);
		printk(KERN_INFO "time: %lld\n", delta);
		printk(KERN_INFO "comparisons: %lld\n", cmp_count);

		for (int i = 0; i < N; i++) {
			L = 2 * i + 1;
			R = 2 * i + 2;
			if (L < N && arr[i] < arr[L])
				goto err;
			if (R < N && arr[i] > arr[R])
				goto err;
		}

		kfree(arr);
	}
	return 0;

err:
	kfree(arr);
	return -1;
}

 fs/bcachefs/eytzinger.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
index 0f955c3c76a7..9a99a1410d12 100644
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
-
-			if (c + 1 < n &&
-			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
-				c++;
-
-			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
-				break;
-
-			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		/* Find the sift-down path all the way to the leaves. */
+		for (j = i; k = j * 2 + 1, k + 1 < n;)
+			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
+
+		/* Special case for the last leaf with no sibling. */
+		if (j * 2 + 2 == n)
+			j = j * 2 + 1;
+
+		/* Backtrack to the correct location. */
+		while (j != i && eytzinger0_do_cmp(base, n, size, cmp_func, priv, i, j) >= 0)
+			j = (j - 1) / 2;
+
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
-- 
2.34.1


