Return-Path: <linux-kernel+bounces-123605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C00890BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A8A1F28121
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AD13BAD8;
	Thu, 28 Mar 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClZMK0PA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401313BACD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658417; cv=none; b=T2q335UT8hWLSsbUGmmUd6pnud1jhmG6GIT2chqcexz077Fv+dw2tyOPMqiWlfYP8qAyoGBSfadOPGr4nVhlZ94sRyMbw+mw3DNfClgpG4oG+D56LsgfratpTMwKFcQxDyn9YalAeMdwCvApnOoWXLi9a/rMaW2YwqiHBckDhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658417; c=relaxed/simple;
	bh=FlivA4yfGfFdJLo5ECHK0IC8x6gx23qUTsMI8w0FX6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6PRpQh1h+kREnrlOaIFF6mnkHBnw5uaPcp7pTLFO8MlRmaegys4GNtn6/hDR5lCMYC3dH/RwHXVT+2XEw22gWMEJxLWf2B3h3CDzHstgtg+nTzU+uhPb5I4S8inPHndaIwnAKdRxAOTzHVK6MBHTygL0RrU30KJiUjiLW1gL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClZMK0PA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLyw7KMUSkZphXtYRA9aQyoROjVXRJ0JkZ6RNSfd43U=;
	b=ClZMK0PAwuA0OWNVZAu/ay0gLTkQJZvG/eiyl+82THLwl9qO6trcv9geC0wrlBzo3c5KWt
	VvfXp6qPS7cXb0h3Nv20CcyqMUSCyThwPxH/Be2BbUounlp4meBBQtAaVt51ffwAy+Pif9
	VQWS6gQI9mcO0MZFFymDVoOoRHjG6e0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-01rxHV2tPM2OivYrAooexw-1; Thu, 28 Mar 2024 16:40:13 -0400
X-MC-Unique: 01rxHV2tPM2OivYrAooexw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB8B788905A;
	Thu, 28 Mar 2024 20:40:12 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C87C7492BC8;
	Thu, 28 Mar 2024 20:40:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	eblake@redhat.com,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Joe Thornber <ejt@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 5/9] selftests: block_seek_hole: add dm-zero test
Date: Thu, 28 Mar 2024 16:39:06 -0400
Message-ID: <20240328203910.2370087-6-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .../selftests/block_seek_hole/Makefile        |  2 +-
 .../testing/selftests/block_seek_hole/config  |  2 ++
 .../selftests/block_seek_hole/dm_zero.sh      | 31 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/block_seek_hole/dm_zero.sh

diff --git a/tools/testing/selftests/block_seek_hole/Makefile b/tools/testing/selftests/block_seek_hole/Makefile
index 3f4bbd52db29f..1bd9e748b2acc 100644
--- a/tools/testing/selftests/block_seek_hole/Makefile
+++ b/tools/testing/selftests/block_seek_hole/Makefile
@@ -3,7 +3,7 @@ PY3 = $(shell which python3 2>/dev/null)
 
 ifneq ($(PY3),)
 
-TEST_PROGS := test.py
+TEST_PROGS := test.py dm_zero.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/block_seek_hole/config b/tools/testing/selftests/block_seek_hole/config
index 72437e0c0fc1c..bfd59f1d98769 100644
--- a/tools/testing/selftests/block_seek_hole/config
+++ b/tools/testing/selftests/block_seek_hole/config
@@ -1 +1,3 @@
 CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_DM=m
+CONFIG_DM_ZERO=m
diff --git a/tools/testing/selftests/block_seek_hole/dm_zero.sh b/tools/testing/selftests/block_seek_hole/dm_zero.sh
new file mode 100755
index 0000000000000..20836a566fcc8
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/dm_zero.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dm_zero.sh
+#
+# Test that dm-zero reports data because it does not have a custom
+# SEEK_HOLE/SEEK_DATA implementation.
+
+set -e
+
+dev_name=test-$$
+size=$((1024 * 1024 * 1024 / 512)) # 1 GB
+
+cleanup() {
+	dmsetup remove $dev_name
+}
+trap cleanup EXIT
+
+dmsetup create $dev_name --table "0 $size zero"
+
+output=$(./map_holes.py /dev/mapper/$dev_name)
+expected='TYPE START END SIZE
+DATA 0 1073741824 1073741824'
+
+if [ "$output" != "$expected" ]; then
+	echo 'FAIL expected:'
+	echo "$expected"
+	echo 'Does not match device output:'
+	echo "$output"
+	exit 1
+fi
-- 
2.44.0


