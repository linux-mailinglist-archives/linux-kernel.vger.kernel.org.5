Return-Path: <linux-kernel+bounces-145144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F48A5018
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1958C1F224D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968C12C47D;
	Mon, 15 Apr 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0SD7SWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBB12C488;
	Mon, 15 Apr 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185430; cv=none; b=ArRpKhoJ42hyZtDXjUWBV9B6qNpAtKmfbb0PeqCIkAECTdfnHQyKpyl0VNTZ/STVl/Wz2GrWm4fXk5RbpcDc9AWkjpG4EgOaH300ra4u+mifScXUgDVKS4pfxgbEIvzrl1EYtc3KXENkYgY5vRxqBtXjl86XCPcJLSGhvmBX3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185430; c=relaxed/simple;
	bh=bICUhdhTI38MAzCw4mVv4RoCssKzD+vHemV7hYPVRqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7QSIxLnqt1w87W/A3CzbN5VPbT7ula7fN8QRmfNDOe0lIRVH5V2ZHl77OObKQfkV4t4TfH4omqU8X6GKiljwQDBecFXTv2Ms6zchzloYGcU9WpwOwcLTJCD1bTV36Pxlp9vJ97YYn8NdrnnL4E7R4y/kb63SKCoH1FIKNFyYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0SD7SWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102D4C32783;
	Mon, 15 Apr 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185430;
	bh=bICUhdhTI38MAzCw4mVv4RoCssKzD+vHemV7hYPVRqM=;
	h=From:To:Cc:Subject:Date:From;
	b=W0SD7SWzocBNOOmI+ckB3Bhw59lSHtrPA+W96l+o1XUFrjIPOJ9K9G9llNOEDJ2Pc
	 6R0jK8UD4fvXpkyBOHo9QLRPeLjanmixK8BzzdPJeTpA+8qDjJfZbXarQb03DPdLgL
	 yYmPTQaV1FL/EhdCEUS8mxRWoY+3kjIYucLvX6pb7ENQlq++goxUKptPsoGGXZ/D5k
	 UMp/rRjjquwhWvQdaBzrYoXiGqTFEsOptf6gfal2TbY2EBnd7zvczBMBO8qiZPMzao
	 iLctHeBT+Tcrlw/c0ri/3k9BYAJehh3Gyt7ggvzHsIk8XoLeufjQMXAWmgi6eR8VV3
	 LiTen96vItGCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	quic_cang@quicinc.com,
	avri.altman@wdc.com,
	quic_nguyenb@quicinc.com,
	manivannan.sadhasivam@linaro.org,
	beanhuo@micron.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 1/6] scsi: ufs: core: WLUN suspend dev/link state error recovery
Date: Mon, 15 Apr 2024 06:04:22 -0400
Message-ID: <20240415100433.3127434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.86
Content-Transfer-Encoding: 8bit

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 6bc5e70b1c792b31b497e48b4668a9a2909aca0d ]

When wl suspend error occurs, for example BKOP or SSU timeout, the host
triggers an error handler and returns -EBUSY to break the wl suspend
process.  However, it is possible for the runtime PM to enter wl suspend
again before the error handler has finished, and return -EINVAL because the
device is in an error state. To address this, ensure that the rumtime PM
waits for the error handler to finish, or trigger the error handler in such
cases, because returning -EINVAL can cause the I/O to hang.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20240329015036.15707-1-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f3c25467e571f..948449a13247c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9044,7 +9044,10 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* UFS device & link must be active before we enter in this function */
 	if (!ufshcd_is_ufs_dev_active(hba) || !ufshcd_is_link_active(hba)) {
-		ret = -EINVAL;
+		/*  Wait err handler finish or trigger err recovery */
+		if (!ufshcd_eh_in_progress(hba))
+			ufshcd_force_error_recovery(hba);
+		ret = -EBUSY;
 		goto enable_scaling;
 	}
 
-- 
2.43.0


