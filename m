Return-Path: <linux-kernel+bounces-123607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F393890BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71AB1C2FC09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977813BC26;
	Thu, 28 Mar 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdWyUkjt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF313AA5C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658432; cv=none; b=LQ1gVDddmaPlAFXjVdpyZzT/kprm8L9hsghRsuCghA/BuBDpRUZLvogBAE4ZLfln2r07KiNzVOzrNalGihmCeDfTo4zYmIyitV4PbS0T5Ql+7EjZL77TNBlzLEWAzmUGZFbCclVwOIn5xYH8oGRf0Wmm39FChUsgfrSUAJZBXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658432; c=relaxed/simple;
	bh=FebcY8GW4qSxZjt6PKBKn/4SmoqAJZOlJIPy8dlvqF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCWUFfI++UP8zdC6a2aHCyPvnIcLE+jH3bM0dyM8coDK5JDjcLSyRqsXfoOCYCTt+g1ssApYNr9nb1DBRwU2HMBoLpbWAuoamNYb/i1NuJUshVJBHoolSyMidzBKdUPbq9R8kjGOhbM6kjL5WMQ5qibXpmyieIargvUxUTXEim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdWyUkjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu/r5NDd0Gy6+JgiI/0jpbuTZcHkzRRhPWBk6MBfw3I=;
	b=UdWyUkjtTW4WJ+RlAv9g7tPDWYOSZ+yZwYTfwWcoSlGQ5pFTITWIftlrrIDM/Sihe2sFq0
	lChbQSjhJXVVnom4KZNIxozBFLTBI8fvmOcOCCWM7J8Oj2SJyrdQEGk8afTn9dzb1Tm3Xj
	KNJizN43ptSomckYlstOlkImtXa8nJY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-IncmixdjM7iaA-qSd38v7g-1; Thu,
 28 Mar 2024 16:40:26 -0400
X-MC-Unique: IncmixdjM7iaA-qSd38v7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E2142802267;
	Thu, 28 Mar 2024 20:40:26 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5233FC1576F;
	Thu, 28 Mar 2024 20:40:25 +0000 (UTC)
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
Subject: [RFC 7/9] selftests: block_seek_hole: add dm-linear test
Date: Thu, 28 Mar 2024 16:39:08 -0400
Message-ID: <20240328203910.2370087-8-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The dm-linear linear target passes through SEEK_HOLE/SEEK_DATA. Extend
the test case to check that the same holes/data are reported as for the
underlying file.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/testing/selftests/block_seek_hole/test.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/block_seek_hole/test.py b/tools/testing/selftests/block_seek_hole/test.py
index 4f7c2d01ab3d3..6360b72aee338 100755
--- a/tools/testing/selftests/block_seek_hole/test.py
+++ b/tools/testing/selftests/block_seek_hole/test.py
@@ -45,6 +45,20 @@ def loop_device(file_path):
     finally:
         run(['losetup', '-d', loop_path])
 
+@contextmanager
+def dm_linear(file_path):
+    file_size = os.path.getsize(file_path)
+
+    with loop_device(file_path) as loop_path:
+        dm_name = f'test-{os.getpid()}'
+        run(['dmsetup', 'create', dm_name, '--table',
+             f'0 {file_size // 512} linear {loop_path} 0'])
+
+        try:
+            yield f'/dev/mapper/{dm_name}'
+        finally:
+            run(['dmsetup', 'remove', dm_name])
+
 def test(layout, dev_context_manager):
     with test_file(layout) as file_path, dev_context_manager(file_path) as dev_path:
         cmd = run(['./map_holes.py', file_path])
@@ -99,5 +113,5 @@ if __name__ == '__main__':
                holes_at_beginning_and_end,
                no_holes,
                empty_file]
-    dev_context_managers = [loop_device]
+    dev_context_managers = [loop_device, dm_linear]
     test_all(layouts, dev_context_managers)
-- 
2.44.0


