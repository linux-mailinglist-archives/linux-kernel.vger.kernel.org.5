Return-Path: <linux-kernel+bounces-62607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E26852393
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E812E1C21AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61254BF7;
	Tue, 13 Feb 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSURMXSi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219054BC7;
	Tue, 13 Feb 2024 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783580; cv=none; b=qSafMW4WV0rNWGICZ8KKJZ2f/8LPkMmHJ0wo3E+thbr0/W1YdrK9ssmEvNSe3QC0vHr5wj+pQqd4KmoWpRkoa5QY28TZkAvSbNCj7awLJ5I2Hh8opyEyMFAWI8S9qBoLsnHOeLi0c6CqlLnFbMtFfGEKJC/gmacp9gjcs7n8K8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783580; c=relaxed/simple;
	bh=2cvX/WXXZ2QmzcgZI0xcb0Mn8DR1XX/ElQnCO4G8wYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsT8fhPGJZHYrky9JSER9vaJPRQiWV2OOk7PrTmwkLqThN8FMNwkSDg6CdJBOmrke12K1dansJTwisj01m08gW5x9xGLjI7PiXVTeSURBvqvagmLj462C+Vd3QP9lvfwUxAt307CuQV13OAsWxZyKx3CaaIHWt665YqUcGH27Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSURMXSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1114C433F1;
	Tue, 13 Feb 2024 00:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783579;
	bh=2cvX/WXXZ2QmzcgZI0xcb0Mn8DR1XX/ElQnCO4G8wYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSURMXSiVdIchc4IeQPPPXu/rfpXgc9JwtfVYuEld0tFMBzK8RYfeV6S7gXXoKXZR
	 laJUKmZtz4D09ox0klqIBPvRNwAqsiY2g8wZQQrmRzE9RaoruWX6jVkmT8XoVCHQZx
	 Kgt2Uh/rblZ6lWwmlZ9Qcu1O4NQCvXgRUvHxTec0jGrmZDqxg6Ua1nLOXSsLVxo2Ik
	 zSHejRdVfyesgRu2pV762WaSz3rICytLTp7QaNgGSEL5T0WF5bjPy1p1g8/qA/qJnw
	 7897sTzbptbukEGoDeW6xqIrwKJg2+av2qHTGtWykyf2opK32op1OPDLBsOlZ1l3+i
	 e0uEGqYaProEg==
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
	manivannan.sadhasivam@linaro.org,
	beanhuo@micron.com,
	quic_ziqichen@quicinc.com,
	athierry@redhat.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 38/58] scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()
Date: Mon, 12 Feb 2024 19:17:44 -0500
Message-ID: <20240213001837.668862-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 6f7cfecacd27..e197b9828c3c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6350,7 +6350,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_hold(hba);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
-- 
2.43.0


