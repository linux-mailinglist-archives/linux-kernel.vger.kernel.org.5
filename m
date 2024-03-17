Return-Path: <linux-kernel+bounces-105482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16787DF00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7149528107A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B641CD3C;
	Sun, 17 Mar 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4qyS3vM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9551CD1F;
	Sun, 17 Mar 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694414; cv=none; b=ANtsQXQ02g34phGyyeRLuxML3UA9U2c+G2nUa6sHldGT1uiSpp97NLcTZNSGxOONqjDJAGwRqejZ+4vVPiA7LkIwXlGLuP0VneqMDagW6JatXxRo17o8ms+oVX7NUONQf+dlhcGv8XDg1iMO6C9/yPedbAvNhvNIJvrHN6m/O1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694414; c=relaxed/simple;
	bh=NvVEy+UL4F7Ica1lAxSJkcql2WZ1Sh8WJGokKutUW/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GipNgCZ4EyaisDn5iL8Z/4TFf+Q76SgznoU9riMOHc4kfQ0qpoJNy1XX238kUXOffhCUHrkvf9UZeEDPAluWfWcEK/8Waqaf7glQp68mOyemgHqCIJLlSNr36Gc18br83d7zcfU8yyHGBYYGSSt7/H2zgUFOkzRJatxyf03SEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4qyS3vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075D5C433F1;
	Sun, 17 Mar 2024 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710694414;
	bh=NvVEy+UL4F7Ica1lAxSJkcql2WZ1Sh8WJGokKutUW/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4qyS3vMpopBBgAys30XOgNamkiF8DmvS+Igfqh+n75uqSWxq6jYjhm0fVYHgOlAm
	 zMWTbzL4VXeZ9YQ7W34I20Bmd2VdPsXGQYpJPaFXwKltDT7c9EwTHpCzIPzeDNVQY0
	 2mVHADRFWsQUYK9QdwqD+plT6ld6uRkkxkc3ag3W/v8ZDHN9K1U2pE4uoBiyU6EdyW
	 vYnqeFdVnNS21KO/WvJ2KUr7HQGeIS1oOtpSQaO7wUOWo671QLAxJTcISaySy7wKXj
	 4RiCwdvBXAIAD8bfDMymQQUKUKaB+Z4E3nBhhsbfo9+CNqWXzf5WJvV/S+hb6PlYMj
	 D8O4fYjeWq98Q==
Date: Sun, 17 Mar 2024 09:53:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: [RFC PATCH] fstests: test MADV_POPULATE_READ with IO errors
Message-ID: <20240317165333.GF1927156@frogsfrogsfrogs>
References: <20240314161300.382526-1-david@redhat.com>
 <20240317165157.GE1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317165157.GE1927156@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

This is a regression test for "mm/madvise: make
MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly".

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/1835     |   65 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1835.out |    4 +++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/generic/1835
 create mode 100644 tests/generic/1835.out

diff --git a/tests/generic/1835 b/tests/generic/1835
new file mode 100755
index 0000000000..07479ab712
--- /dev/null
+++ b/tests/generic/1835
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 1835
+#
+# This is a regression test for a kernel hang that I saw when creating a memory
+# mapping, injecting EIO errors on the block device, and invoking
+# MADV_POPULATE_READ on the mapping to fault in the pages.
+#
+. ./common/preamble
+_begin_fstest auto rw
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_dmerror_unmount
+	_dmerror_cleanup
+}
+
+# Import common functions.
+. ./common/dmerror
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_xfs_io_command madvise -R
+_require_scratch
+_require_dm_target error
+_require_command "$TIMEOUT_PROG" "timeout"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_dmerror_init
+
+filesz=2m
+
+# Create a file that we'll read, then cycle mount to zap pagecache
+_dmerror_mount
+$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $filesz" "$SCRATCH_MNT/a" >> $seqres.full
+_dmerror_unmount
+_dmerror_mount
+
+# Try to read the file data in a regular fashion just to prove that it works.
+echo read with no errors
+timeout -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a"
+_dmerror_unmount
+_dmerror_mount
+
+# Load file metadata and induce EIO errors on read.  Try to provoke the kernel;
+# kill the process after 10s so we can clean up.
+stat "$SCRATCH_MNT/a" >> $seqres.full
+echo read with IO errors
+_dmerror_load_error_table
+timeout -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a"
+_dmerror_load_working_table
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/1835.out b/tests/generic/1835.out
new file mode 100644
index 0000000000..1b03586e8c
--- /dev/null
+++ b/tests/generic/1835.out
@@ -0,0 +1,4 @@
+QA output created by 1835
+read with no errors
+read with IO errors
+madvise: Bad address

