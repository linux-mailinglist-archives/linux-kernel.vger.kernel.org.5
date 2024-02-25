Return-Path: <linux-kernel+bounces-79992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07362862966
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1F4B20F98
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F79D267;
	Sun, 25 Feb 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw9EbUxr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78028F5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708842994; cv=none; b=Q0x3RBxlSdra5++T7i1S/UR8zP3Zr8V3tlNrNPEPMBSDULo6JPrnsfulPIuYQ2EaShWPrDYDC2cJofJzRXR0ewNrX66FKVp0SrfIhkgovrHGZCnldpAOpg54IQdi79P7nRQ92TQbqbn+x9sCsTTIEjw/YEcF7FoyVwlJZvcqCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708842994; c=relaxed/simple;
	bh=v3UZ8ds5QU/o7sVmthaXo8YZ5pwg1PKZOFS3pOvns5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6aONmLScXq7hbRYfVGqjspNW2weQSojq07fRebSNg8OyXn8SyeHWYfrZqGMwS94JXVUT0I8780KxRqWoAeNsd3iCrBAcF6wRJ9ntqQxcgP7wPMHXTYm8GYDi63fADgX2VZ8eXa2yFagCIVcfDKrUEgjV5ZArbMXQBS94UBj2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw9EbUxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67450C433F1;
	Sun, 25 Feb 2024 06:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708842993;
	bh=v3UZ8ds5QU/o7sVmthaXo8YZ5pwg1PKZOFS3pOvns5k=;
	h=From:To:Cc:Subject:Date:From;
	b=aw9EbUxrkUgbBFiIFyVNWncZW/uSyV/yL0Ay5BeEwemq4ZzQivP3zkIAAHwq4XQ66
	 XYL3GJufcu6RTH8ylqK+wzo7BnY/LokCIlyZ2uGIdnG8npkEjxJiTsKoPnetgIdSLZ
	 bcWj+f9pI0JUfN1TuBy6RhPtA7OTPXpXRiqaRkIUtRQJidy82YmpDofmAsE72eSeJC
	 Pcerqhkom1CUEt65F5keXkjf322+DDc0xVzKdvd5FFNkgxFaxm2E9s/uanYsNtwnYb
	 ypNoDvq0N9u+lL3qkv8afnncXwGyOUO+4QCUam/hWkhkT2L12kEmJDBcGd9qsBxBJi
	 OJ6fudemjgJfA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
Date: Sun, 25 Feb 2024 14:36:28 +0800
Message-Id: <20240225063628.2086320-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@type in f2fs_allocate_data_block() indicates log header's type, it
can be CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC, rather than
type of data/node, however IS_DATASEG()/IS_NODESEG() only accept later
one, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- use curseg->seg_type instead of se->type due to se is valid only
in atgc allocation context.
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d4f228e6f771..847fe0b7f29f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3538,12 +3538,12 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
-	if (IS_DATASEG(type))
+	if (IS_DATASEG(curseg->seg_type))
 		atomic64_inc(&sbi->allocated_data_blocks);
 
 	up_write(&sit_i->sentry_lock);
 
-	if (page && IS_NODESEG(type)) {
+	if (page && IS_NODESEG(curseg->seg_type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
 		f2fs_inode_chksum_set(sbi, page);
-- 
2.40.1


