Return-Path: <linux-kernel+bounces-76465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0985F78D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3CF1F22A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1868481B3;
	Thu, 22 Feb 2024 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KkD3StkC"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA2208A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602834; cv=none; b=Eo3r6f26f9R7NUeoqZbuVt/COjOrfo25Tck132rqzsb0NaN5qUJOgYV9FyYcuptEBgOnhFRaNB9emNS6bWrWadwDK76wCU+Y9m5I4K1hYMNgGKmS5yzbzMbQFWNgV4a62hKdTZrO6wbVzEpYopEA9Jm5XIhBPiSc3COMZAT4uh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602834; c=relaxed/simple;
	bh=0KgFO67Y6WxclwJDn2crqA+5H0FuWWpsVC82Nr7HA2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sz4vQO+wgMOPwVV886xs3vhrn0AhsUX2tw9dKpTNlp+aUAkgbpgUeOldYrbD2XvWZHKj0v3HB6hF1EcVwRGOmkf0iOl+5DSKS7EDvDUB2RHLsoDqJ3JMQQobxiz3Fw5lyzBkZhohQ4oG1fGISxcWNOVjLIEtGlQq1gOg8QWrLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KkD3StkC; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708602828; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jRGUipf9sjRgAhn1TLOVo6LsSXfi8+r33WymnSOzv7s=;
	b=KkD3StkC2FtFlfNHMecMM3vDnaD6Je72j/iML4BM4X/4gejbAbe6f/IYxA12DljgHrE8O0v6dT/FS3OZqvgY4VzcKiJRLQrCQvJunTCtpdBAv2OR7wpOgJqt4S8UycL4m/J7yqFOsp9XnHsUMmhjYMJXYu7HXODSc2iYOzsiuBw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W10vJn7_1708602815;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W10vJn7_1708602815)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 19:53:47 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	liusong@linux.alibaba.com
Subject: [PATCH] mm, thp: display [never] for defrag when THP is set to never
Date: Thu, 22 Feb 2024 19:53:23 +0800
Message-Id: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transparent_hugepage is set to never by cmdline or echo, defrag
still show what it used to be and can be modified which makes user
confusing whether defrag would take effect.

Actually if transparent_hugepage is set to never, defrag will not take
effect. Just Display never and remain unchangeable to for defrag when
transparent_hugepage is set to never.

Suggested-by: Liu Song <liusong@linux.alibaba.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 mm/huge_memory.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..03cd22a87b93 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -349,21 +349,25 @@ static ssize_t defrag_show(struct kobject *kobj,
 {
 	const char *output;
 
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
-		     &transparent_hugepage_flags))
-		output = "[always] defer defer+madvise madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always [defer] defer+madvise madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always defer [defer+madvise] madvise never";
-	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
-			  &transparent_hugepage_flags))
-		output = "always defer defer+madvise [madvise] never";
-	else
+	if (!test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags) &&
+	    !test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
 		output = "always defer defer+madvise madvise [never]";
-
+	else {
+		if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
+			&transparent_hugepage_flags))
+			output = "[always] defer defer+madvise madvise never";
+		else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
+				&transparent_hugepage_flags))
+			output = "always [defer] defer+madvise madvise never";
+		else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
+				&transparent_hugepage_flags))
+			output = "always defer [defer+madvise] madvise never";
+		else if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
+				&transparent_hugepage_flags))
+			output = "always defer defer+madvise [madvise] never";
+		else
+			output = "always defer defer+madvise madvise [never]";
+	}
 	return sysfs_emit(buf, "%s\n", output);
 }
 
@@ -371,6 +375,12 @@ static ssize_t defrag_store(struct kobject *kobj,
 			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
+	if (!test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags) &&
+	    !test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags)) {
+		pr_warn("transparent_hugepage not enabled, defrag takes no effect\n");
+		return -EINVAL;
+	}
+
 	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
-- 
2.39.3


