Return-Path: <linux-kernel+bounces-159880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E58B356C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375F11C217A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA113F44F;
	Fri, 26 Apr 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eytmQ4oQ"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE51E877;
	Fri, 26 Apr 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128000; cv=none; b=fsJmJ3MOm2FKPGUlQiuU3X7Px0yhqn60izr6VjWJLQ722Xo2uruw+mdYTwBIpZfBqFAnwnC4lrVOfesl0m6keouBFuOAe4b8V315qa1yXWMGe4A7ZilBtmPGg88LPQjZCrhuhIxRd4W5TzJZ9ekLvHFARyf5DLcjQ9aYG3ImbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128000; c=relaxed/simple;
	bh=UQcaRiCSJspg2olyfffBCz8/gfvZUnul2zGBfTUZ3vs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=t4If7/fCm+7DB1F+X/NWrgF1aQQ8r6FS4ul826gXhoGzWddgyAAT7AjgXeo9YQBMEGblMED4KqTKlj8imTRJTo/AOzqGOYeMjcJOzRPV15LkBOblhrNb5xHu5vmX5ys42nj/S72+vgm/nVsFXgsTfFJLFwhNqwT8dI/bgeYzYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eytmQ4oQ; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714127688; bh=YaSU9M5opPOL0ZuAUzC5OKbwbd83LKiNUAukNIWA6AI=;
	h=From:To:Cc:Subject:Date;
	b=eytmQ4oQvlQimhkQ+gpVq8tbkvCbliKHBhP4t2pGTRhjWsKbazHK7cxAVpwevO4Ps
	 Ds6f06Lu6KrT7sc6dETvoto/VcMpdR8DnsJKRfEGBdeaUrnjrVGOCX7VmGPfD4oYoN
	 U+l5FYU8YnLBz8B6DTm2E8PeRyIwVFEPok5/8Dgo=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 8AE048E5; Fri, 26 Apr 2024 18:34:46 +0800
X-QQ-mid: xmsmtpt1714127686thx4nk91c
Message-ID: <tencent_0B517C25E519D3D002194E8445E86C04AD0A@qq.com>
X-QQ-XMAILINFO: Mv8oRO7AAqEFYV3Cjn4yCL78Ulh553OpkZiIPiaBTvXhd77YcXyVgbIeusUCT9
	 AqV6cO8EynyjXxlvX+BIRueV6xD2XAGrel2JReVImDY/ZdTHnh6mRdr+zM63vYSTKLlsZj16MeYh
	 yICPoJvV5sa5vXeFkRYoR39G6Cn5NwwzI4wi1JTWT2eRjA8aN7jgT71HpkfW8M9AstnEksgZ3B7i
	 ZfqFk9l8I2wFAtIk9B7GH1uwLikfeYIL9w9C9CvTjp2iJfzqLVWy+iCycX6NZvul6r1r3WM62qXc
	 5O9kipN0are4xNW9mb5+rWa8Fki1psa78dM5tBYQPLhe1BQbQKMpgiVq9pDZQzs0f9R6xE3FyGuT
	 sUheD0NarEwrt8uuPpaVLumC08uvixswVf+Jy/5TWQanDq7+rrnVWh7v3dwb0Zp4eaDc+ojGkNVQ
	 tignwhXkllHOhT9NkhA4OhgOdbspd+5/YsHTHQakqWX+knGyp6phceURpp0nq7bMOQaW6Jw1bavf
	 3og9CEewpXlVi8KhvIBFa/x2m9GK2SFkUN7BIruhgGjQqbYPJ7AZG0g4HkQhOf/RzbDx0M6dYnWg
	 oCGUnDdZcM2Gvzreng6wlKdetna2EWDbhhiCGuMfDshS6YWMNUV1GR1DPUanNCO9AA7KYvNuJwxs
	 +5nGF66eqT9MFpHW7LJ8mBMjMQcWAaGrrCHmpvN1hCMob+hNV0SWiRy6M9JhsA/5s5vskbghjTS6
	 pxqJCVMA1I+VU8/14jvT2X1OxOm68XzYuuEl66bvrWW9xwAkGRdeoagvUzhpzKNepG6TW/oaSFOZ
	 l92/9qEvxElxvmSrdZNYDOtKH+SjtXUDrO2zeXqcsSlmfJbYsDTL3TJLzs2fJQCNSWQhtbQCtwag
	 KPYgDPF1xJZX1M06aD+eQg2vh/qKxs77ToNPWvcLCSI5hSQdCvMArF+yAt6G9upHif2UOQeZdZ6A
	 XeLXzOvZ5JSm+OeTNrXEcWlNI91UanlGDjrP+3FmpveAUAarlVhWr+y0diDfG7mGnhUhETLLbgZk
	 ql7mVj2swvIuK39HTZ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: use READ_ONCE to access map->word
Date: Fri, 26 Apr 2024 18:34:44 +0800
X-OQ-MSGID: <20240426103444.19386-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __sbitmap_queue_get_batch(), map->word is read several times, and
update atomically using atomic_long_try_cmpxchg(). But the first two read
of map->word is not protected.

This patch moves the statement val = READ_ONCE(map->word) forward,
eliminating unprotected accesses to map->word within the function.
It is aimed at reducing the number of benign races reported by KCSAN in
order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 lib/sbitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 92c6b1fd8989..1e453f825c05 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -494,18 +494,18 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		struct sbitmap_word *map = &sb->map[index];
 		unsigned long get_mask;
 		unsigned int map_depth = __map_depth(sb, index);
+		unsigned long val;
 
 		sbitmap_deferred_clear(map);
-		if (map->word == (1UL << (map_depth - 1)) - 1)
+		val = READ_ONCE(map->word);
+		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
 
-		nr = find_first_zero_bit(&map->word, map_depth);
+		nr = find_first_zero_bit(&val, map_depth);
 		if (nr + nr_tags <= map_depth) {
 			atomic_long_t *ptr = (atomic_long_t *) &map->word;
-			unsigned long val;
 
 			get_mask = ((1UL << nr_tags) - 1) << nr;
-			val = READ_ONCE(map->word);
 			while (!atomic_long_try_cmpxchg(ptr, &val,
 							  get_mask | val))
 				;
-- 
2.39.3 (Apple Git-146)



