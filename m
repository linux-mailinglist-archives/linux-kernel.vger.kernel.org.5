Return-Path: <linux-kernel+bounces-93354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52072872E72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1D28361C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F901B947;
	Wed,  6 Mar 2024 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dtxR7PHC"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AE18E27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703230; cv=none; b=KgPG2mYRAhd0udNRgQd0jtxvo5MiN08N7P7JvaFr+0uDNd0R2dnFUl3FfH9awDwe/uqStYJn8vKiqkvSI228bmZ5GCJVqhS+iCgtW0dYTREEOKCEIU41U4iY+27oVB6bCwBL55tcLS3t6tEz6Dj/44by3SFEJCh7Vd2H1YOWfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703230; c=relaxed/simple;
	bh=84IwcSpV1S63Qa+MDtGLZqKo6Jg+nu9My8ASXSMbwbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Olw0O4kkj1iLB2pHDCy4I2y3tdtqJNVaZASXobkHzYb+2v4gUBzVe2YRMF3tudxCg4Rnlg4hA/jUmjYJFyuju2Noylt/BW214YKfiCgu+ROhfchimoqMf/pYfDKrFkCMwRlXBAHPwfZQANHatGyskk9bobJG0XCNRsTDw1JxcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dtxR7PHC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709703219; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cv/b8QEJHpK26e3vniBXfBcOQGyvHRwEXLa8qoipZkk=;
	b=dtxR7PHCAIhpnugXzw9TXIKQ5NkU0MOo2S1IOPaBCgqeq84svXwwkRME1jvLeedj3qUpHxsVj9LQUH+XL8VoNf75bhaFNX5qADZQQiGil3+jpikpGrDG3xRzYFlmoyqQXwQCTUUFKYybv4iAkrA93jxg9H0vZ4VzEm7hV47kOEE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1wGvSw_1709703213;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1wGvSw_1709703213)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 13:33:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: apply proper VMA alignment for memory mapped files on THP
Date: Wed,  6 Mar 2024 13:31:38 +0800
Message-Id: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are mainly two reasons that thp_get_unmapped_area() should be
used for EROFS as other filesystems:

 - It's needed to enable PMD mappings as a FSDAX filesystem, see
   commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
   mappings");

 - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
   THPs for read-only mmapped files (e.g. shared libraries) even without
   FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
   for non-DAX").

Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb2..3d9721b3faa8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
-- 
2.39.3


