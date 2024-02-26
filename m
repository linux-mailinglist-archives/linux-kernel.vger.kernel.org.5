Return-Path: <linux-kernel+bounces-80679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEB866B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5481A1F21E38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA91EB27;
	Mon, 26 Feb 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ajVGpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8B1DA24
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932948; cv=none; b=Fi7Bm3z5mCRI2E94mKuvdY+004Y2W2TNMORrIuXa60z63Sp4DyzOGmIaFpqC8vHzh9VHwKPXPVlO59QMC/5APybSnBN97EMcQIZmzlDetKKDpMYaK0kEmv+3OT2g/zQu6zN5FzBrEpaB9wMso6RLesoqVok2KnCRfBAG/YfjJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932948; c=relaxed/simple;
	bh=DM7lCeAQkkrdeMDm7IxgfNbaFgZdno2MS54NUJmA8dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MA4IjdnrKKBEJupmZ1CE0cNPh+piKpSr6CH8F23zk5VagBmJUSmaJRbJOBfEeWB6g99BDo4yrSS0oXiZ+s04RoRs7D4Ef2gR3aC3KTbyipD7apY3ZTt0XLYa94G2yQAUsMWVMb0EE/fbSX7+fvkW+6oc5uLexcbYLeKJuhwqD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3ajVGpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C106C433B2;
	Mon, 26 Feb 2024 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932947;
	bh=DM7lCeAQkkrdeMDm7IxgfNbaFgZdno2MS54NUJmA8dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3ajVGpgQc6l7+OU17u75YYhHNroOTJz8hHJTRRGAnv31ib+bQX+ozAzTBiBlyody
	 2trvL2ADY8ta0KNNzk6otf5eBw74LSiUdxJURZJgqTmT8SckTYPAwS1AO+ykCMImQy
	 2L74/p3AcflUs0sYfV6OVwSsN6l78h659dpZsrI6uciQzUVioiuGLSxXRuG9+99DJX
	 Zt6L4BprJAHNjZJx+BjVzuOtUIlubCWPyXKRfmZUSfOqZdTfirUQuZ32PMcuuEnUvC
	 /3OV5svysGVXzPXYeF5YwxKHZpa8twJqYPGmkPfShE9aHNaDRDwEjs8RrDAmAutWnC
	 nZRx0aWJ7IAqA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: ro: don't start discard thread for readonly image
Date: Mon, 26 Feb 2024 15:35:39 +0800
Message-Id: <20240226073539.2509926-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226073539.2509926-1-chao@kernel.org>
References: <20240226073539.2509926-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ 9299.893835] F2FS-fs (vdd): Allow to mount readonly mode only
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
root@qemu:/ ps -ef|grep f2fs
root          94       2  0 03:46 ?        00:00:00 [kworker/u17:0-f2fs_post_read_wq]
root        6282       2  0 06:21 ?        00:00:00 [f2fs_discard-253:48]

There will be no deletion in readonly image, let's skip starting
discard thread to save system resources.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b486fe4485f9..cc27c5440188 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2253,6 +2253,12 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	int err = 0;
 
+	if (f2fs_sb_has_readonly(sbi)) {
+		f2fs_info(sbi,
+			"Skip to start discard thread for readonly image");
+		return 0;
+	}
+
 	if (!f2fs_realtime_discard_enable(sbi))
 		return 0;
 
-- 
2.40.1


