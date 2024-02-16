Return-Path: <linux-kernel+bounces-69364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADA8587F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2179B28278A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEB1419BF;
	Fri, 16 Feb 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAkv1vKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A6146003
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118692; cv=none; b=CDOkZRtjo2lfeMvvVLDLMuJZzKuyW/KFIQC4kFk8Jsrng1ysyCDkO3wL5eNDf6TNJD6z2FjDcs/sYtZmIMqg9xfowcoQMyRN7q7QNFte01UPC5N7Pe83tnrY5r9ZtvKd+7akTWet+rNDydVriJS8TX4Wgt/AEbNbmO1uNuSqsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118692; c=relaxed/simple;
	bh=1i+pVhlJw8ZeK4z5/rWVxY4m52zCv0TCoSsszJOhmhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BB26VqhgziP1xV8JQjbKKI1J59vEpge1lkLZlL33X9mIGFU5A4iDnoDCzC+idHUboH12QzW2KSm1y0DyCCoLo1/DMBPynorz4ztTjPjUXaa8dBUQX3bD1jz1pGbCP6kRYEffIBM9nkfqnaxBq+EVqO/AVSP5yHmRw2fEMb7S9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAkv1vKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1906C433F1;
	Fri, 16 Feb 2024 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708118691;
	bh=1i+pVhlJw8ZeK4z5/rWVxY4m52zCv0TCoSsszJOhmhM=;
	h=From:To:Cc:Subject:Date:From;
	b=OAkv1vKlJ8174j6KWIriPqCu4xUhlEMrQY5j5RML+usHREDTOS7T9766wI/+8lafH
	 nA7hTqmMcdl+MUEX50CftxdNsbRCKnT/k2ncxCxzv0InZMOHAz07l+SbukuXn2HCek
	 ubNgjoro7Bog802NVnIkUUzeOk1E3KFQJq6cyMMvTZ+bseWip6niSkR3PRlJ2kHvDh
	 YECZr089G2MNp1c7u8GsU+wtqXJ5fKrMY2h2c+upsYJmvA2AGwgzzGrYSU4S2qIoUp
	 CH/kytN5PQkLNmyTMkcr3g7xMwVzprgNW493xTaVIxTpv7lM4JzbhdsMCH+eE9ISfw
	 UsOJA6LDkm2Xw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix write pointers all the time
Date: Fri, 16 Feb 2024 13:24:50 -0800
Message-ID: <20240216212450.31162-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if the roll forward recovery stopped due to any error, we have to fix
the write pointers in order to mount the disk from the previous checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b3baec666afe..8bbecb5f9323 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
+	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
 		if (!err)
-- 
2.44.0.rc0.258.g7320e95886-goog


