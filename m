Return-Path: <linux-kernel+bounces-108254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4088086E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105302839CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E729A9;
	Wed, 20 Mar 2024 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsU3hV32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079028EF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893686; cv=none; b=jTejdR0v7Q+cxomfu4t9muQdqrqpUXsn/8vnHrEdqXmqwPHOaClF6fAUVNUcMp/WN8Dh8KR9rmnQtkg4vzPHXcxL3D0w0zi5gufkhfVaRAebjA8ck9/MupYuDp4juZ11Drt36v0SH+3su6XHCI8lt+35t6ibyO0ZCA8a1E4orCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893686; c=relaxed/simple;
	bh=RgQ+4D5jOVCbEgkz3y6+dLvAKuKFyxUUXvKEfz/0awU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZ9qZ1oqvWBIjGAggAyR2ogsDK+YvV9Ac2mIXu6bimRtNocGYzGU4PKsBas6Gzzmz/FmIIVKtSce4FunBG2MS8GBErLN01y+gYzr5Uj2XsvXRIzeQxVqx/PftmnWd4/blkOCYG573ScKkTAXgbpurkO/KZcaP5iO60iXP0CWOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsU3hV32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2A0C433C7;
	Wed, 20 Mar 2024 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710893686;
	bh=RgQ+4D5jOVCbEgkz3y6+dLvAKuKFyxUUXvKEfz/0awU=;
	h=From:To:Cc:Subject:Date:From;
	b=bsU3hV32fVAcAl6rtVKfChcygYOsmBVQkod/kzYF9frS2qxQKvIFVfFxAzg5sZtM6
	 /p7D1RUOT27w+IutQ6WYIMKCYNjK9UTdLM8ZkGBCjQVgqThw1hCe3bfXDzbGfo/Nuy
	 Hi2IMUO8O+wcyTbOrcKxxiXHjVkQ15br4c4CHX64nMdWAJ4q13X9pw9o53gpxyYjX0
	 DCaoG7XuHSboL+6E7/EwGmxLMLhGJaTw7qgUUDjcb8vWGk1sZqaWqLrOkHiE/eWeDy
	 TuCfGV/aUo8rVeA4fwwhuIwZLIZUpehTONVaUMqauDmAbT3DiBeNnQrBPFAIZnCJmv
	 Dtioqj9D6J3Xg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
Date: Tue, 19 Mar 2024 17:14:42 -0700
Message-ID: <20240320001442.497813-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
 - mnt_want_write_file()
   - sb_start_write(SB_FREEZE_WRITE)
                                             - sb_start_intwrite(SB_FREEZE_FS);
 - f2fs_stop_checkpoint(sbi, false,            : waiting
    STOP_CP_REASON_SHUTDOWN);
 - f2fs_stop_discard_thread(sbi);
   - kthread_stop()
     : waiting

 - mnt_drop_write_file(filp);

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..088b8c48cffa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1923,7 +1923,9 @@ static int issue_discard_thread(void *data)
 			continue;
 		}
 
-		sb_start_intwrite(sbi->sb);
+		/* Avoid the deadlock from F2FS_GOING_DOWN_NOSYNC. */
+		if (!sb_start_intwrite_trylock(sbi->sb))
+			continue;
 
 		issued = __issue_discard_cmd(sbi, &dpolicy);
 		if (issued > 0) {
-- 
2.44.0.291.gc1ea87d7ee-goog


