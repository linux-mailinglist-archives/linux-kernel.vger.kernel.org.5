Return-Path: <linux-kernel+bounces-123609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7DF890BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6B129C461
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89013A400;
	Thu, 28 Mar 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkeU1nLy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036C13A271
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658462; cv=none; b=QYBo8QZ+kEVS59EWQEbLRmGesO3Bb0xojrj3fLKFwjaqbBCWE0SMkF/vEf6ErDsw5kbcc3MwugPkSXkrciO7zHPaFT34Nb0fKHf9+K+pRJJaoUwCeCA8xxV8qVGMXFxFQYi6ZCOpnrqkTf/asuHPneXPwuQfDBMoXycyM8F2Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658462; c=relaxed/simple;
	bh=4LVr4XIyTxfxImYgjXFnrBvXpjmjemBkyYv51+FUVj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpNaNNmB666R6KCDXV2xfEv54R94VfYmlnYj6tOgR5rwoGRXXBlh7XYItz4y0g/ncBe2E5FZnYiiFkX27C89WKYeBwtIY1o8yO2TYUQbiiP+SGlV1uQgN/WbYny0v6/TyWelT3MfgrdG/2JNIKY/twC2eex4z57ADy4fvQ0B4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkeU1nLy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4QwQ4LobXpOZeMcmZtW4ftxyW2t074qf+BN+wufuQA=;
	b=WkeU1nLyZwpjusMGdTH8N7QNbPk1F7C7Q9lF2HmqjBKle6zFMIuGpfG/1ps70H/eFr6uOz
	cjOCQLV3z2z+OSYacIsIfXRSwCuldg0QareOS8jaQK5kl8xWBobFEfqJ/aDV8tID7+K8eo
	Jq/nMox66h5/LImMEl9UyXMlSyTdKe8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-FGHnscCFOt2rRDtvRy7V4Q-1; Thu, 28 Mar 2024 16:40:56 -0400
X-MC-Unique: FGHnscCFOt2rRDtvRy7V4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C74A8007A7;
	Thu, 28 Mar 2024 20:40:56 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0F5B3C54;
	Thu, 28 Mar 2024 20:40:54 +0000 (UTC)
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
Subject: [RFC 9/9] selftests: block_seek_hole: add dm-thin test
Date: Thu, 28 Mar 2024 16:39:10 -0400
Message-ID: <20240328203910.2370087-10-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .../selftests/block_seek_hole/Makefile        |  2 +-
 .../selftests/block_seek_hole/dm_thin.sh      | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/block_seek_hole/dm_thin.sh

diff --git a/tools/testing/selftests/block_seek_hole/Makefile b/tools/testing/selftests/block_seek_hole/Makefile
index 1bd9e748b2acc..3b4ee1b1fb6e7 100644
--- a/tools/testing/selftests/block_seek_hole/Makefile
+++ b/tools/testing/selftests/block_seek_hole/Makefile
@@ -3,7 +3,7 @@ PY3 = $(shell which python3 2>/dev/null)
 
 ifneq ($(PY3),)
 
-TEST_PROGS := test.py dm_zero.sh
+TEST_PROGS := test.py dm_zero.sh dm_thin.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/block_seek_hole/dm_thin.sh b/tools/testing/selftests/block_seek_hole/dm_thin.sh
new file mode 100755
index 0000000000000..a379b7c875f28
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/dm_thin.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dm_thin.sh
+#
+# Test that dm-thin supports SEEK_HOLE/SEEK_DATA.
+
+set -e
+
+# check <actual> <expected>
+# Check that the actual output matches the expected output.
+check() {
+	if [ "$1" != "$2" ]; then
+		echo 'FAIL expected:'
+		echo "$2"
+		echo 'Does not match device output:'
+		echo "$1"
+		exit 1
+	fi
+}
+
+cleanup() {
+	if [ -n "$thin_name" ]; then
+		dmsetup remove $thin_name
+	fi
+	if [ -n "$pool_name" ]; then
+		dmsetup remove $pool_name
+	fi
+	if [ -n "$metadata_path" ]; then
+		losetup --detach "$metadata_path"
+	fi
+	if [ -n "$data_path" ]; then
+		losetup --detach "$data_path"
+	fi
+	rm -f pool-metadata pool-data
+}
+trap cleanup EXIT
+
+rm -f pool-metadata pool-data
+truncate -s 256M pool-metadata
+truncate -s 1G pool-data
+
+size_sectors=$((1024 * 1024 * 1024 / 512)) # 1 GB
+metadata_path=$(losetup --show --find pool-metadata)
+data_path=$(losetup --show --find pool-data)
+pool_name=pool-$$
+thin_name=thin-$$
+
+dmsetup create $pool_name \
+	--table "0 $size_sectors thin-pool $metadata_path $data_path 128 $size_sectors"
+dmsetup message /dev/mapper/$pool_name 0 'create_thin 0'
+dmsetup create $thin_name --table "0 $size_sectors thin /dev/mapper/$pool_name 0"
+
+# Verify that the device is empty
+check "$(./map_holes.py /dev/mapper/$thin_name)" 'TYPE START END SIZE
+HOLE 0 1073741824 1073741824'
+
+# Write 4k at offset 128M but dm-thin will actually map an entire 64k block
+dd if=/dev/urandom of=/dev/mapper/$thin_name bs=4k count=1 seek=32768 status=none
+check "$(./map_holes.py /dev/mapper/$thin_name)" 'TYPE START END SIZE
+HOLE 0 134217728 134217728
+DATA 134217728 134283264 65536
+HOLE 134283264 1073741824 939458560'
+
+# Write at the beginning of the device
+dd if=/dev/urandom of=/dev/mapper/$thin_name bs=4k count=1 status=none
+check "$(./map_holes.py /dev/mapper/$thin_name)" 'TYPE START END SIZE
+DATA 0 65536 65536
+HOLE 65536 134217728 134152192
+DATA 134217728 134283264 65536
+HOLE 134283264 1073741824 939458560'
+
+# Write at the end of the device
+dd if=/dev/urandom of=/dev/mapper/$thin_name bs=4k count=1 seek=262143 status=none
+check "$(./map_holes.py /dev/mapper/$thin_name)" 'TYPE START END SIZE
+DATA 0 65536 65536
+HOLE 65536 134217728 134152192
+DATA 134217728 134283264 65536
+HOLE 134283264 1073676288 939393024
+DATA 1073676288 1073741824 65536'
-- 
2.44.0


