Return-Path: <linux-kernel+bounces-33464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46BB8369FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F79A1F23E23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577D130E39;
	Mon, 22 Jan 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj/oHkqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA130E25;
	Mon, 22 Jan 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936404; cv=none; b=BtOt80T73+NWDuox8yN01sQSPsrixM74L28HZAI1HGvgblMCKTknSjuxxGiOLEXbNxf94nZBXkg6YabDVD6czHT0utXzaAIjyxw+IHrs1fmgIcKj9egLUe0IJvhJLoU6y1+tZLLJXYAOA7TwhnsE1HLI/eMmtDmLhKrMvS/irug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936404; c=relaxed/simple;
	bh=Hrod67hh4LkwO/pTdv/A52E6Qb1RnNmgHSwfUZ/J2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG358hYqhDUvRwyyvG7qj6OZ2YJflXlw/mZOGapCUWLHYaWF1euNrI9ElpEVNLhut4HMJ2i5ezC309OfSfsSgZeVfQ8/ejJUyjxgxO+SzdXaXvZpMbDRgU9/sz7WEU84/Is+hCS5ynG4iyTPGXx4eNnwQb7DWZJglOagAxuKSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj/oHkqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F01C433C7;
	Mon, 22 Jan 2024 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936404;
	bh=Hrod67hh4LkwO/pTdv/A52E6Qb1RnNmgHSwfUZ/J2JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qj/oHkqfGMRTQaNTqUj74hc3ml7xSgyR8qSfF3HAsgWqMoX325lOdazj8j26xFR4K
	 X3x5tD6VYUBGc/MAH/vBQ4N5pWzFC51Tsa2/PlfHZfzyVITEoN+ZIIReP63AAs8qFd
	 SzZF2PiBYxdsuQML7NWzAWQg3c64YPuRIKtAsRbnO/gBBvFs/6KEvLHmDen+1draPB
	 FrElM8NjaZck0igOLIQ8Cz9jMoEvsGnHhq3x1ITTd6Ed3Tb71WMbI8f68UONIT75du
	 e9RQEyTsB320x4ZYC9ZXheCINl7fjTyzJ+vLr1p7vSEBn6mNAaj45zjsIj7L14Aqsj
	 c33+PiO+GH2+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Sasha Levin <sashal@kernel.org>,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 08/35] f2fs: fix write pointers on zoned device after roll forward
Date: Mon, 22 Jan 2024 10:12:05 -0500
Message-ID: <20240122151302.995456-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 9dad4d964291295ef48243d4e03972b85138bc9f ]

1. do roll forward recovery
2. update current segments pointers
3. fix the entire zones' write pointers
4. do checkpoint

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index da0801aa4118..f07ae58d266d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -871,6 +871,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0


