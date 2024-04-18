Return-Path: <linux-kernel+bounces-149723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7B8A9502
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AACE1B2216D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62135155320;
	Thu, 18 Apr 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mC8IP2j9"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0F154BF1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429100; cv=none; b=DKrmXiPP3w16bBpdfQSNx4HwQKvCU/o9/9iGUf6F0ShTp0qteU3lVkyE1zXXa2OFJVsgDW6MaKaegAQJDdxfbEDgD8jJwNFwsNGBcv4HaY5EmOR+urWwwVPIxoDhci2BJmnDmduqs3tUyAhWs9vOPjyjXAwyVDtpz5su0Ekd+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429100; c=relaxed/simple;
	bh=rDD9ARKShht4L3vBCw1rywnguUbqzkmjdey8LEnbKRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJg7eBc6lBZRLXkIpHZfIT7psUaPn3lM3ZBaDAuMPCwBZePL6BEAJPNTeTb4ARqw14B82KBr2PYzyUMKxrgTA997Tqw+qSkxJKM3lO8bsgIqgPA939piADq3iySy7HBPB0ugKHu++YDFhqfREmDpOdIQh1HhszOwKWpFWvXlLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mC8IP2j9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713429095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=suc4EKre9DSVRyuJ6maS6siQgvj0GzEmZCFUNtsaiH8=;
	b=mC8IP2j9pYZBEeYg0dN2pSRgSC1T2KH/J76DFpc0ThfCJByScsS9FM1WnEw5rZcRp/O/38
	xevG+e18vOYlgKuhyq4XJxepetn7XXKnvRudqQOSlZpKqNMGvR1IvLBwmFgL1Jm4ZSRY7t
	US0pwEp9d4F6tBhvjclJACrWaphGJG8=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Fix missing spaces in journal_entry_dev_usage_to_text
Date: Thu, 18 Apr 2024 16:31:03 +0800
Message-Id: <20240418083103.66703-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Fixed missing spaces displayed in journal_entry_dev_usage_to_text
while adjusting the display format to improve readability.

before:
```
 # bcachefs list_journal -a -t alloc:1:0 /dev/sdb
 ...
     dev_usage: dev=0free: buckets=233180 sectors=0 fragmented=0sb: buckets=13 sectors=6152 fragmented=504journal: buckets=1847 sectors=945664 fragmented=0btree: buckets=20 sectors=10240 fragmented=0user: buckets=1419 sectors=726513 fragmented=15cached: buckets=0 sectors=0 fragmented=0parity: buckets=0 sectors=0 fragmented=0stripe: buckets=0 sectors=0 fragmented=0need_gc_gens: buckets=0 sectors=0 fragmented=0need_discard: buckets=1 sectors=0 fragmented=0
```

after:
```
 # bcachefs list_journal -a -t alloc:1:0 /dev/sdb
 ...
     dev_usage: dev=0
       free: buckets=233180 sectors=0 fragmented=0
       sb: buckets=13 sectors=6152 fragmented=504
       journal: buckets=1847 sectors=945664 fragmented=0
       btree: buckets=20 sectors=10240 fragmented=0
       user: buckets=1419 sectors=726513 fragmented=15
       cached: buckets=0 sectors=0 fragmented=0
       parity: buckets=0 sectors=0 fragmented=0
       stripe: buckets=0 sectors=0 fragmented=0
       need_gc_gens: buckets=0 sectors=0 fragmented=0
       need_discard: buckets=1 sectors=0 fragmented=0
```
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
- Note: Test only by modifying bcachefs-tools.

 fs/bcachefs/journal_io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index e726d9f560a0..58501ef758b3 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -706,13 +706,16 @@ static void journal_entry_dev_usage_to_text(struct printbuf *out, struct bch_fs
 
 	prt_printf(out, "dev=%u", le32_to_cpu(u->dev));
 
+	printbuf_indent_add(out, 2);
 	for (i = 0; i < nr_types; i++) {
+		prt_newline(out);
 		bch2_prt_data_type(out, i);
 		prt_printf(out, ": buckets=%llu sectors=%llu fragmented=%llu",
 		       le64_to_cpu(u->d[i].buckets),
 		       le64_to_cpu(u->d[i].sectors),
 		       le64_to_cpu(u->d[i].fragmented));
 	}
+	printbuf_indent_sub(out, 2);
 }
 
 static int journal_entry_log_validate(struct bch_fs *c,
-- 
2.34.1


