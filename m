Return-Path: <linux-kernel+bounces-123602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60735890B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836071C2DED4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7413A3F5;
	Thu, 28 Mar 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icZCihKX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4E13A3FF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658405; cv=none; b=PJGvRvkmCjvH1xDyipXO7Oc3HDp5c825ntovBWqTRpewAEXkx0jtfXSgEk3Qd7Vi/ThrfvbXGHTblasa58vwy0AY/h2rI25sK4xLgYxH6TJo/THP9JL1b4XddUaZhGSSVyMMgIroADWMtFAo8p09odaSCIdkkiD3+YPQPVVMaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658405; c=relaxed/simple;
	bh=Rp9w8RwSy/4Z0Y7bMy5x7qlp6KJE9aJoHoyuWIitvzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfh05CcoVf4xSiI6uNiXEEcXLHfeSnzdvFb96uMLigQi9ATL/xzf9wRLDrILXdrjX+zPe9y7LOssKmKb4+xQLT3XRmBmQKdBmsqcOpL1+hJsDebi7516y8B3cO3gpKACeEryEU3uVEPxRvIPBXBlzu4yrTkWjsnRlLu+FWITyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icZCihKX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjBz1KrK98sVajIv7PgdUWh+8H9rTGPZ9ES9DnhFZf8=;
	b=icZCihKXUCLbOBK7p5WjkaN6kskc/xrNuHxkWnRA6QTVaClRo2xyadpRAFKv0vQAHmnGqH
	3jrcmJ+Hskquzo4Y+xPbDF1yK62emEt0cFGZw/gUtgdBDWk+hz+h24gnaQYmh7AYBOEsh7
	wX2AvpddsDIFO4CTZe0cvRCEWUrlDBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-wEWhjZfMPkOYk_YV6Rw3gw-1; Thu, 28 Mar 2024 16:39:59 -0400
X-MC-Unique: wEWhjZfMPkOYk_YV6Rw3gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4D0085A58B;
	Thu, 28 Mar 2024 20:39:58 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C2C792166B35;
	Thu, 28 Mar 2024 20:39:57 +0000 (UTC)
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
Subject: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Date: Thu, 28 Mar 2024 16:39:04 -0400
Message-ID: <20240328203910.2370087-4-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Run the tests with:

  $ make TARGETS=block_seek_hole -C tools/selftests run_tests

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/block_seek_hole/Makefile        |  17 +++
 .../testing/selftests/block_seek_hole/config  |   1 +
 .../selftests/block_seek_hole/map_holes.py    |  37 +++++++
 .../testing/selftests/block_seek_hole/test.py | 103 ++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
 create mode 100644 tools/testing/selftests/block_seek_hole/config
 create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
 create mode 100755 tools/testing/selftests/block_seek_hole/test.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654db..8a21d6031b940 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -2,6 +2,7 @@
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
+TARGETS += block_seek_hole
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += cachestat
diff --git a/tools/testing/selftests/block_seek_hole/Makefile b/tools/testing/selftests/block_seek_hole/Makefile
new file mode 100644
index 0000000000000..3f4bbd52db29f
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+PY3 = $(shell which python3 2>/dev/null)
+
+ifneq ($(PY3),)
+
+TEST_PROGS := test.py
+
+include ../lib.mk
+
+else
+
+all: no_py3_warning
+
+no_py3_warning:
+	@echo "Missing python3. This test will be skipped."
+
+endif
diff --git a/tools/testing/selftests/block_seek_hole/config b/tools/testing/selftests/block_seek_hole/config
new file mode 100644
index 0000000000000..72437e0c0fc1c
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/config
@@ -0,0 +1 @@
+CONFIG_BLK_DEV_LOOP=m
diff --git a/tools/testing/selftests/block_seek_hole/map_holes.py b/tools/testing/selftests/block_seek_hole/map_holes.py
new file mode 100755
index 0000000000000..9477ec5d69d3a
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/map_holes.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# map_holes.py <filename>
+#
+# Print the holes and data ranges in a file.
+
+import errno
+import os
+import sys
+
+def map_holes(fd):
+    end = os.lseek(fd, 0, os.SEEK_END)
+    offset = 0
+
+    print('TYPE START END SIZE')
+
+    while offset < end:
+        contents = 'DATA'
+        new_offset = os.lseek(fd, offset, os.SEEK_HOLE)
+        if new_offset == offset:
+            contents = 'HOLE'
+            try:
+              new_offset = os.lseek(fd, offset, os.SEEK_DATA)
+            except OSError as err:
+                if err.errno == errno.ENXIO:
+                    new_offset = end
+                else:
+                    raise err
+            assert new_offset != offset
+        print(f'{contents} {offset} {new_offset} {new_offset - offset}')
+        offset = new_offset
+
+if __name__ == '__main__':
+    with open(sys.argv[1], 'rb') as f:
+        fd = f.fileno()
+        map_holes(fd)
diff --git a/tools/testing/selftests/block_seek_hole/test.py b/tools/testing/selftests/block_seek_hole/test.py
new file mode 100755
index 0000000000000..4f7c2d01ab3d3
--- /dev/null
+++ b/tools/testing/selftests/block_seek_hole/test.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# test.py
+#
+# Test SEEK_HOLE/SEEK_DATA support in block drivers
+
+import os
+import subprocess
+import sys
+from contextlib import contextmanager
+
+KB = 1024
+MB = 1024 * KB
+
+def run(args):
+    try:
+        cmd = subprocess.run(args, check=True, capture_output=True)
+    except subprocess.CalledProcessError as e:
+        print(e)
+        print(e.stderr.decode('utf-8').strip())
+        sys.exit(1)
+    return cmd
+
+@contextmanager
+def test_file(layout_fn, prefix='test'):
+    '''A context manager that creates a test file and produces its path'''
+    path = f'{prefix}-{os.getpid()}'
+    with open(path, 'w+b') as f:
+        layout_fn(f)
+
+    try:
+        yield path
+    finally:
+        os.unlink(path)
+
+@contextmanager
+def loop_device(file_path):
+    '''A context manager that attaches a loop device for a given file and produces the path of the loop device'''
+    cmd = run(['losetup', '--show', '-f', file_path])
+    loop_path = os.fsdecode(cmd.stdout.strip())
+
+    try:
+        yield loop_path
+    finally:
+        run(['losetup', '-d', loop_path])
+
+def test(layout, dev_context_manager):
+    with test_file(layout) as file_path, dev_context_manager(file_path) as dev_path:
+        cmd = run(['./map_holes.py', file_path])
+        file_output = cmd.stdout.decode('utf-8').strip()
+
+        cmd = run(['./map_holes.py', dev_path])
+        dev_output = cmd.stdout.decode('utf-8').strip()
+
+        if file_output != dev_output:
+            print(f'FAIL {dev_context_manager.__name__} {layout.__name__}')
+            print('File output:')
+            print(file_output)
+            print('Does not match device output:')
+            print(dev_output)
+            sys.exit(1)
+
+def test_all(layouts, dev_context_managers):
+    for dev_context_manager in dev_context_managers:
+        for layout in layouts:
+            test(layout, dev_context_manager)
+
+# Different data layouts to test
+
+def data_at_beginning_and_end(f):
+    f.write(b'A' * 4 * KB)
+    f.seek(256 * MB)
+
+    f.write(b'B' * 64 * KB)
+
+    f.seek(1024 * MB - KB)
+    f.write(b'C' * KB)
+
+def holes_at_beginning_and_end(f):
+    f.seek(128 * MB)
+    f.write(b'A' * 4 * KB)
+
+    f.seek(512 * MB)
+    f.write(b'B' * 64 * KB)
+
+    f.truncate(1024 * MB)
+
+def no_holes(f):
+    # Just 1 MB so test file generation is quick
+    mb = b'A' * MB
+    f.write(mb)
+
+def empty_file(f):
+    f.truncate(1024 * MB)
+
+if __name__ == '__main__':
+    layouts = [data_at_beginning_and_end,
+               holes_at_beginning_and_end,
+               no_holes,
+               empty_file]
+    dev_context_managers = [loop_device]
+    test_all(layouts, dev_context_managers)
-- 
2.44.0


