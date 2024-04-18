Return-Path: <linux-kernel+bounces-149369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D88A902D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2528C1C2187F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1553AC;
	Thu, 18 Apr 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2XVpF4e"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DB5231
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401475; cv=none; b=W7pB9r0hcMvYDre5/sfb9j9TLbxJFTUJVSPV4sGrzP7op+Jb1MvRWTPVGF7A2aaAvUM7/ECzi1yUgvTuZcBveAie84hhwsC8m8wjRWE+r+/zNgw/O4APxMoCB1exR/gSXUPTRbK3p8ku5YnUfCxy9Re+S4+Ye/jkbpUUkTWXH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401475; c=relaxed/simple;
	bh=07ffA8kkXrVvn46Tku4SoiLPrhU77jqOGLiZCbjdHrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkPQNGTbnDFJm9aN/11TshZzAR8fUw5OpMqUWM/4K8jhgs5wZufROSP10AS/puBteKbq/1h05kycGQDxgRLYv3avCHCpzVb2DBLm5MU5wN0a5cAksyyIcFUVd8a/Wh24b8xk1BC34XcTT2eiesUWbEg3Loyd5a3ls0RoU7BgYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2XVpF4e; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713401471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhIN91+VDRSgFAPqx1f6TgLIdjqG8AF5Ss9VnxYQdN0=;
	b=d2XVpF4eZJNBfbcmhditqQUyAqA4RtZGFCXPszP1rbJnng+99LaY+UXD7dz/qxuZm/UwAd
	ZYnpQyIZ1a1VgHHWBSnstVXlC/x+U/O1PZxhPQdBIqTYLN1OpkDWrgsyMWa0uQxe0aFzWc
	iI8i08361Flbft+Ed2qiaeTwGszZl+0=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hongbo Li <lihongbo22@huawei.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2] bcachefs: Align the display format of `btrees/inodes/keys`
Date: Thu, 18 Apr 2024 08:50:55 +0800
Message-Id: <20240418005055.45482-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Before patch:
```
 #cat btrees/inodes/keys
 u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
   flags= (16300000)
   bi_size=0
```

After patch:
```
 #cat btrees/inodes/keys
 u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
   mode=40755
   flags=(16300000)
   bi_size=0
```

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
v2:
- Adjust where to add new lines of code.
- Remove flags ` ` by Hongbo suggestion.

 fs/bcachefs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index f0da2b0048cc..5c9ee41baa72 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -534,12 +534,13 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct bkey_s_c k,
 static void __bch2_inode_unpacked_to_text(struct printbuf *out,
 					  struct bch_inode_unpacked *inode)
 {
+	prt_printf(out, "\n");
 	printbuf_indent_add(out, 2);
 	prt_printf(out, "mode=%o\n", inode->bi_mode);
 
 	prt_str(out, "flags=");
 	prt_bitflags(out, bch2_inode_flag_strs, inode->bi_flags & ((1U << 20) - 1));
-	prt_printf(out, " (%x)\n", inode->bi_flags);
+	prt_printf(out, "(%x)\n", inode->bi_flags);
 
 	prt_printf(out, "journal_seq=%llu\n",	inode->bi_journal_seq);
 	prt_printf(out, "bi_size=%llu\n",	inode->bi_size);
-- 
2.34.1


