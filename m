Return-Path: <linux-kernel+bounces-62703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446E85248F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39F31C20F82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3618225AF;
	Tue, 13 Feb 2024 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdM08RQJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727C80605;
	Tue, 13 Feb 2024 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783783; cv=none; b=K5nzTYfOjFGKD5dCM5xyRu23UGBlvL8rFduIE+nrDKCM6p8Un2/rImpD303L4vJ3uDeJWt5IOacANSbbuY7vBnxn+LfhhQv4lNrCfHJMJ50tPk04iOpABcEFshrKqPS5/g8ecfNjz0+p1kGKVOtMzcO71LxRql71WbXprCu1cFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783783; c=relaxed/simple;
	bh=q+t0V9d7gNiB+i/TmSleGgvCD2dhJL3P0vFB8LWHu5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+4JCOinDCRjPPlIuGOsjbxo3S1wTAdmRtaX4dcE6zZAh6nZi2gsBzeckrSuzzUkmTOtL/c/T72LL9CI+lMGKCLlD7O1tcAyjF3smF3dIm0f1lxyHFQdRos0SMGi2z8bUwx2aunPHqqCZ0r93xASG4Gp5ndegpYixpVJ0kQ8lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdM08RQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71D1C43390;
	Tue, 13 Feb 2024 00:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783783;
	bh=q+t0V9d7gNiB+i/TmSleGgvCD2dhJL3P0vFB8LWHu5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdM08RQJOxboVkzD/RUlJB8dCmaNbMQzlzXyZscHv+s8cgoLRG2o8uh1NxolqLUbA
	 twqB4U0qRVM1b001sG7MCp3c7AJqJN2bJoFypaRIzXbPq0wdn6joAjmj9w1Vk+ma85
	 48iIDM3TA4XcOu8m5YeuzDhd0P8GmdKf/rm7d99o4JYHpoXH3ecHNnyH+8EJjtDuNp
	 yGFYbdvNsaa8xGk8UvuXNzTuDnvufI/UfQTUW2ePPFdS2KoDsD7qlkfW0GzWp46pn6
	 n4RCj5o7sMfhLQG68L0JYVvKZA8nF/pDgvA5pspk257EI0OY175ur3bknZwV2zDpSe
	 pH6Ck5a7nRXCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SEO HOYOUNG <hy50.seo@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <quic_cang@quicinc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	stanley.chu@mediatek.com,
	avri.altman@wdc.com,
	quic_nguyenb@quicinc.com,
	peter.wang@mediatek.com,
	beanhuo@micron.com,
	manivannan.sadhasivam@linaro.org,
	quic_ziqichen@quicinc.com,
	athierry@redhat.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/28] scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()
Date: Mon, 12 Feb 2024 19:22:17 -0500
Message-ID: <20240213002235.671934-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: SEO HOYOUNG <hy50.seo@samsung.com>

[ Upstream commit 17e94b2585417e04dabc2f13bc03b4665ae687f3 ]

If ufshcd_err_handler() is called in a suspend/resume situation,
ufs_release() can be called twice and active_reqs end up going negative.
This is because ufshcd_err_handling_prepare() and
ufshcd_err_handling_unprepare() both call ufshcd_release().

Remove superfluous call to ufshcd_release().

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
Link: https://lore.kernel.org/r/20240122083324.11797-1-hy50.seo@samsung.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9fd4e9ed93b8..f3c25467e571 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6159,7 +6159,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_hold(hba, false);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
-- 
2.43.0


