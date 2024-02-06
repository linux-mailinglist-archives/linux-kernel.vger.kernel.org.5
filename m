Return-Path: <linux-kernel+bounces-54250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517684ACD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2468E1F226FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37285745C0;
	Tue,  6 Feb 2024 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acy3YkND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1A7428A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189923; cv=none; b=njTD3Ts4/JjEo8rhdlS3HtUpieJPwYzbpj3AhGfb5JD7yeki28K3KQ/BhgWXhiPcmSPUkn4fC9vuw2TX1RGsddarUN4YiI2wI3Ynk3tB49fgbLvLTdTE1h96PwBEjAl2mg0PdBM8xI4fu1siX5x8gwLZgACVN5I4+926tNXPWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189923; c=relaxed/simple;
	bh=uWUoGxk1soKi48WeLbyMNDv0+uwWzfBe0kdt6djUZXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv7yBTM9fr0kGoYfDviNZwv1JxMQJgkX79ai2BHzRwuZe+85uQ+KqyzlrwESzNil04XlADDjg3U7oKCRTTbHnkn7LkRDnaK46c2geaWT8XaFoLTGbf2wovCJxuHCS3eS31aZsHpDRuAa2/1s/pKg8oA14NASaeYVICNU4V1BB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acy3YkND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3B1C433C7;
	Tue,  6 Feb 2024 03:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707189922;
	bh=uWUoGxk1soKi48WeLbyMNDv0+uwWzfBe0kdt6djUZXk=;
	h=From:To:Cc:Subject:Date:From;
	b=Acy3YkNDuxj0k6ZMio91/8HBDLFbZMAD77t8Vpoye+CQ4GnJrqzKOxmFrvIQXXKo+
	 b6TDErA8CiwanzVyrVxTqYftQ6tpTjb3xi690zFFU2r884vKRdihQEiv94iNP2Nzyc
	 Mw53ZHehZoEGncbAsIXn4WiIzSX+2ZtoK161ZDgAiy8WsjrZ2HgUgJnkdhwwoHIcpW
	 y6HlkQsxvEDbn7iZe2hjMRxrbCSp8DtUnaRr61m1C1WNzW/4MuOLPTfIM42thFgHDl
	 OesCfYKU+YnXJZQ8jtnfWmxNnlhXTJy9h3BxgAflQMNgDpZ003vHSUDzr3Mxs8n0zx
	 t4KBvflZ1v2SA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to return EIO when reading after device removal
Date: Tue,  6 Feb 2024 11:25:13 +0800
Message-Id: <20240206032513.2495025-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
    --- tests/generic/730.out	2023-08-07 01:39:51.055568499 +0000
    +++ /media/fstests/results//generic/730.out.bad	2024-02-06 02:26:43.000000000 +0000
    @@ -1,2 +1 @@
     QA output created by 730
    -cat: -: Input/output error
    ...
    (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
Ran: generic/730
Failures: generic/730
Failed 1 of 1 tests

This patch adds a check condition in f2fs_file_read_iter() to
detect cp_error status after device removal, and retrurn -EIO
for such case.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 45b7e3610b0f..9e4386d4144c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	const loff_t pos = iocb->ki_pos;
 	ssize_t ret;
 
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+		return -EIO;
+
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-- 
2.40.1


