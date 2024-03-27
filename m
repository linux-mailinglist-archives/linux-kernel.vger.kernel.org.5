Return-Path: <linux-kernel+bounces-121201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169588E3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4F2A23D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236418520D;
	Wed, 27 Mar 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quj1LnWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16312185202;
	Wed, 27 Mar 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542331; cv=none; b=U1ELjM1LF41wBHi1wUdsqb2tDxNoPHtOd7Fc5IMxzv/hyi+YQV7HPKyqZqd1YHOEClDPQpqEJBx8VxigWyYj1f96uiJUsRwI/kQxgRVqAYjiFf+W0RWujFQwlUNlp+x20RRCkNqOXpiB4NX2BcFywjBOR9Q7bKEMKQkz31CCR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542331; c=relaxed/simple;
	bh=ygb/+RjzOtkEwIpryyrNU9odhfP3ylclbuKAA4e6BI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTput9U+wz067pyMqABUu5KMyZQLPFwW1qpktkXgq5RMbAiJH+8E+Ri08iFrym0rGK6UY4OEEhFRr/Z98dn/cUGzaDRePcYBofuHkQ0effUHQnVA/XI6jqXSNb4tzzD7WxaTPwQD6HU/0JJCHtkAT/b6Yc+cwRPkoPHe8uePCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quj1LnWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF1DC433F1;
	Wed, 27 Mar 2024 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542331;
	bh=ygb/+RjzOtkEwIpryyrNU9odhfP3ylclbuKAA4e6BI4=;
	h=From:To:Cc:Subject:Date:From;
	b=quj1LnWoSgGKRLPIEvErZq4I0JA5/HcJk0p2xF4wVygPm/I7C/SXT2Rae8mIdwDaC
	 cS0cAvPXJD6qHJNffvh4zuqUNi6aWI5el1/AdXWawVjpWiMCDFyVR3JQ6ESa8JVtns
	 3WQF/kVjr5p+ZUFmR4chXRJVSbvziQ/O+DbTliMhX7OwefDaLct2AKL7mbduVheDlw
	 crAO+BlBgNZfgNx9mmVldBV6fSMdi74XGVNvKLjc4kCmV7hOwE3gDzU0wR5EVzx+Fw
	 XVET9p/JCQ0BcvkTyvN3It5hZgpdEwEpteYamOBPC8cv7P+f2i9et4ULKQdizpKdJP
	 lY8vZmKbQuQ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	arnd@arndb.de
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "kasan/test: avoid gcc warning for intentional overflow" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:28 -0400
Message-ID: <20240327122528.2840267-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e10aea105e9ed14b62a11844fec6aaa87c6935a3 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Feb 2024 12:15:52 +0100
Subject: [PATCH] kasan/test: avoid gcc warning for intentional overflow

The out-of-bounds test allocates an object that is three bytes too short
in order to validate the bounds checking.  Starting with gcc-14, this
causes a compile-time warning as gcc has grown smart enough to understand
the sizeof() logic:

mm/kasan/kasan_test.c: In function 'kmalloc_oob_16':
mm/kasan/kasan_test.c:443:14: error: allocation of insufficient size '13' for type 'struct <anonymous>' with size '16' [-Werror=alloc-size]
  443 |         ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
      |              ^

Hide the actual computation behind a RELOC_HIDE() that ensures
the compiler misses the intentional bug.

Link: https://lkml.kernel.org/r/20240212111609.869266-1-arnd@kernel.org
Fixes: 3f15801cdc23 ("lib: add kasan test module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/kasan_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 318d9cec111aa..2d8ae4fbe63bb 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -440,7 +440,8 @@ static void kmalloc_oob_16(struct kunit *test)
 	/* This test is specifically crafted for the generic mode. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
-	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	/* RELOC_HIDE to prevent gcc from warning about short alloc */
+	ptr1 = RELOC_HIDE(kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL), 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
-- 
2.43.0





