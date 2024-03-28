Return-Path: <linux-kernel+bounces-123597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A60890B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE978B2231F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07E7F7EE;
	Thu, 28 Mar 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtCMU/M2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A1131753
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658387; cv=none; b=dww8tWFEIctdXjvvZ3v9vXsLHRftKWbj3FoQs8mfSO8l0JF1CYF2ZcT5k1Ik5RsJKrTuOXv3J9D27IpH/BIpq/Ldvlyqki3hBUGHKjBdwDgChjttvzkVQMCofwbgt1/QQGCfluvAtZWouU1DpGUK3uI4IoWOSbbpquijZe4wDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658387; c=relaxed/simple;
	bh=lXGFcFdD1Kcm9StDfu0izakmypdYPF3vm0IPPNm4XaU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HSOIy+h6xNn5r5tXWDVU5cv/7cCwV6XTdfKAgNVF3Ta+4033BbH7bVW+uH5is5641Ki//41WQXT08TMpcJidZl+1elkXNdy3+dCwNjbnIZJ43JEGI8KYMSC+SQRZ1IU6oDj9viBjAfmwnxql7wO38jKlGNMfRDIwtkZaBYHXPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtCMU/M2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5vfcYk2jZnAGyxhaB+e+t1Q53KrJbiqmZU4cP69fS0=;
	b=WtCMU/M28NIbhmcykCQp1ElOuuoJ8F8f1rwHSdtla242PCB3TuXFBEEkuk7edDusJN+xGM
	OT/pR4YHXow5d6RXCn5EOTy55iDbQ2EGtg1a8RGwhutRoOEs4t51rnOhMtSW32BGA3TQ6e
	uUTnU46N2YiWQ3KGDcOKucy/v0Dg6SA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-0Lqjmpa2ME-gtI6DndQJKQ-1; Thu, 28 Mar 2024 16:39:39 -0400
X-MC-Unique: 0Lqjmpa2ME-gtI6DndQJKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED7E6872811;
	Thu, 28 Mar 2024 20:39:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAA4B3C85;
	Thu, 28 Mar 2024 20:39:37 +0000 (UTC)
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
Subject: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Date: Thu, 28 Mar 2024 16:39:01 -0400
Message-ID: <20240328203910.2370087-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

cp(1) and backup tools use llseek(SEEK_HOLE/SEEK_DATA) to skip holes in files.
This can speed up the process by reducing the amount of data read and it
preserves sparseness when writing to the output file.

This patch series is an initial attempt at implementing
llseek(SEEK_HOLE/SEEK_DATA) for block devices. I'm looking for feedback on this
approach and suggestions for resolving the open issues.

In the block device world there are similar concepts to holes:
- SCSI has Logical Block Provisioning where the "mapped" state would be
  considered data and other states would be considered holes.
- NBD has NBD_CMD_BLOCK_STATUS for querying whether blocks are present.
- Linux loop block devices and dm-linear targets can pass through queries to
  the backing file.
- dm-thin targets can query metadata to find holes.
- ...and you may be able to think of more examples.

Therefore it is possible to offer this functionality in block drivers.

In my use case a QEMU process in userspace copies the contents of a dm-thin
target. QEMU already uses SEEK_HOLE but that doesn't work on dm-thin targets
without this patch series.

Others have also wished for block device support for SEEK_HOLE. Here is an open
issue from the BorgBackup project:
https://github.com/borgbackup/borg/issues/5609

With these patches userspace can identify holes in loop, dm-linear, and dm-thin
devices. This is done by adding a seek_hole_data() callback to struct
block_device_operations. When the callback is NULL the entire device is
considered data. Device-mapper is extended along the same lines so that targets
can provide seek_hole_data() callbacks.

I'm unfamiliar with much of this code and have probably missed locking
requirements. Since llseek() executes synchronously like ioctl() and is not an
asynchronous I/O request it's possible that my changes to the loop block driver
and dm-thin are broken (e.g. what if the loop device fd is changed during
llseek()?).

To run the tests:

  # make TARGETS=block_seek_hole -C tools/testing/selftests run_tests

The code is also available here:
https://gitlab.com/stefanha/linux/-/tree/block-seek-hole

Please take a look and let me know your thoughts. Thanks!

Stefan Hajnoczi (9):
  block: add llseek(SEEK_HOLE/SEEK_DATA) support
  loop: add llseek(SEEK_HOLE/SEEK_DATA) support
  selftests: block_seek_hole: add loop block driver tests
  dm: add llseek(SEEK_HOLE/SEEK_DATA) support
  selftests: block_seek_hole: add dm-zero test
  dm-linear: add llseek(SEEK_HOLE/SEEK_DATA) support
  selftests: block_seek_hole: add dm-linear test
  dm thin: add llseek(SEEK_HOLE/SEEK_DATA) support
  selftests: block_seek_hole: add dm-thin test

 tools/testing/selftests/Makefile              |   1 +
 .../selftests/block_seek_hole/Makefile        |  17 +++
 include/linux/blkdev.h                        |   7 ++
 include/linux/device-mapper.h                 |   5 +
 block/fops.c                                  |  43 ++++++-
 drivers/block/loop.c                          |  36 +++++-
 drivers/md/dm-linear.c                        |  25 ++++
 drivers/md/dm-thin.c                          |  77 ++++++++++++
 drivers/md/dm.c                               |  68 ++++++++++
 .../testing/selftests/block_seek_hole/config  |   3 +
 .../selftests/block_seek_hole/dm_thin.sh      |  80 ++++++++++++
 .../selftests/block_seek_hole/dm_zero.sh      |  31 +++++
 .../selftests/block_seek_hole/map_holes.py    |  37 ++++++
 .../testing/selftests/block_seek_hole/test.py | 117 ++++++++++++++++++
 14 files changed, 540 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
 create mode 100644 tools/testing/selftests/block_seek_hole/config
 create mode 100755 tools/testing/selftests/block_seek_hole/dm_thin.sh
 create mode 100755 tools/testing/selftests/block_seek_hole/dm_zero.sh
 create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
 create mode 100755 tools/testing/selftests/block_seek_hole/test.py

-- 
2.44.0


