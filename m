Return-Path: <linux-kernel+bounces-147835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F288A7A44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998131F22214
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E44C90;
	Wed, 17 Apr 2024 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQkwxEkx"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC04690
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318907; cv=none; b=KS9hFpcKK332isSg9aiJwF9ZaXsWplZ6oNSw05SrIXJIK63HYTi+Rsn9J//p/AWvIG7kTkNYCHsONLCeP/BeAoW+APl/91dOf7QF6JJUuqdjU3UQ7SSRgg3aphu7/VDgJ29/HQ/FyV3WF/evMZGW4BujGJlm622Wl/zvAlvlKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318907; c=relaxed/simple;
	bh=Wv6lCOo1+OGIlkZsf1D8muIr2irjbTaXE+kqboMajQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BdR5dd8KnV+HZQB6UaJGHj7EsXTNl+xAihBr7gQExY0gIr/Rc/tBNfb/EpdWWArtllhGC/l05D1CLowcChH6zmEghsgWYeALmJ6P/BU8AzzNm6smtKpMVxEbLOTM4GhBeuMJztT7ZuWdPBGAXsGpWFXMgcQLIFdHeZgm/vt5VZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQkwxEkx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713318903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HgOZ2fSjs/N1ggGZNktiuDnktJI/mqa7RRNdF5NRUdY=;
	b=pQkwxEkxPhXqBVhY00+zyOR4hFCIFrn+xCUj1oPew/Ekr6Sjt0x1Sq3HJQOxK1zHIlNQgc
	WW2bWsWparhmiF5L9F+NNgNeKMaLNs1m+wdlYjnBiuEhueKOnzvU4ugPCy3r+l+lXiynhe
	aiy0CT9IuVlGv+s4kseoMuJ7+1oF6Mg=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Align the display format of `btrees/inodes/keys`
Date: Wed, 17 Apr 2024 09:54:48 +0800
Message-Id: <20240417015448.84294-1-youling.tang@linux.dev>
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
```

After patch:
```
 #cat btrees/inodes/keys
 u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
   mode=40755
   flags= (16300000)
```

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/bkey_methods.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/bkey_methods.c b/fs/bcachefs/bkey_methods.c
index db336a43fc08..03c755f65430 100644
--- a/fs/bcachefs/bkey_methods.c
+++ b/fs/bcachefs/bkey_methods.c
@@ -306,7 +306,8 @@ void bch2_bkey_val_to_text(struct printbuf *out, struct bch_fs *c,
 	bch2_bkey_to_text(out, k.k);
 
 	if (bkey_val_bytes(k.k)) {
-		prt_printf(out, ": ");
+		prt_printf(out, ":");
+		prt_newline(out);
 		bch2_val_to_text(out, c, k);
 	}
 }
-- 
2.34.1


