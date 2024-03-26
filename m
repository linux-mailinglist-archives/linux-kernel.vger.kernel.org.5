Return-Path: <linux-kernel+bounces-118885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66E88C0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA571C3916D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68BA54905;
	Tue, 26 Mar 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie04r/wN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B986548F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452533; cv=none; b=C2wV9arEvX10ZF9K+fcB6lWmaLz0mwXrh1tsLPRd7XV4IuQ6mORNiDsL/XiA2WFt7yxt/lD7KmxwDU38eHTYycAUXKh07DUTjE1gwSaJiOGT+ubjhCD/2JELeAX+v1EYzFSd0Kj2+qImPPzpUNhrgMPHWg+lReVIttQV13Qz3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452533; c=relaxed/simple;
	bh=z0+/Jl8NKB183NMMyQeNKTgaIJ6S9uSiw9hjXJ2acAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnLIWmUJ6oOmxdz18X1OOSbsEJ0x8d1vozw2kMXAnZTNnbOunRp+YjfcTDvDNxemOoJVm4/BMk3XcIhbFo6dM+8S+eRLCh7U6DDN6LwZbPAEYkaDbUFh8AgpQl1vaDrnTbI8kTFBQGAg3+u628l336c87Y9ZnzDRH4LbUHbr/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie04r/wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132C0C433F1;
	Tue, 26 Mar 2024 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452532;
	bh=z0+/Jl8NKB183NMMyQeNKTgaIJ6S9uSiw9hjXJ2acAc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ie04r/wNhqrRkb12Z5yWvEIf4RJSHZ9itxikPcyOGWGKEqhpG2cn1ScKT0cwrlgDR
	 m8AdWvR3DvOrEDBhzAw7aT1U4M8Qc5giqD6SFOJzt+6KZKdNJ98cbSVZTcuClxLgiG
	 P+BQl1ZaMDApVhBK6Yt2Oz/Mz7Gs/R+omLmPqTdhPnm+1/u+Jw99L7BcUFUtFW1Vco
	 pG2uhOfc/tHrHIeD0NVRF1cQNwGBoiqTsygqm0FdVu7qdjopsHv2v8ZVcoCumIJxCV
	 /fl7HUBYLH8ccF+EBX+4ly7+gVuQG9VbWHMI7SzTu5otg3kDvkeFAXiWfHxmcvR1FQ
	 5TwASqHmgKkrg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to wait on page writeback in __clone_blkaddrs()
Date: Tue, 26 Mar 2024 19:28:45 +0800
Message-Id: <20240326112845.1576111-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In below race condition, dst page may become writeback status
in __clone_blkaddrs(), it needs to wait writeback before update,
fix it.

Thread A				GC Thread
- f2fs_move_file_range
  - filemap_write_and_wait_range(dst)
					- gc_data_segment
					 - f2fs_down_write(dst)
					 - move_data_page
					  - set_page_writeback(dst_page)
					  - f2fs_submit_page_write
					 - f2fs_up_write(dst)
  - f2fs_down_write(dst)
  - __exchange_data_block
   - __clone_blkaddrs
    - f2fs_get_new_data_page
    - memcpy_page

Fixes: 0a2aa8fbb969 ("f2fs: refactor __exchange_data_block for speed up")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f6edc2fdaafe..911b074f808c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1328,6 +1328,9 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
+
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
+
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			set_page_private_gcing(pdst);
-- 
2.40.1


