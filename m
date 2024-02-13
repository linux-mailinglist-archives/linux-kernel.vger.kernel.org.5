Return-Path: <linux-kernel+bounces-62663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F12852426
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D82835B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BC627FD;
	Tue, 13 Feb 2024 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTXRAIJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EE3C04;
	Tue, 13 Feb 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783699; cv=none; b=IKFmXUvPsylVu1ES9dQ5GzOL1CNt6D6Wmzgz8M5MoKoOGGm3yS+R9gtIjB66iuBX05oxq53mzIHSBKj4Nds3hs6pBkAv54MwZc6UGYqDa+Xg3oVRRD9U9wm0jt6qBvTatwRWmop/jQNibyIKbKNgHqYQvWTWfBZSB5V24EiGJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783699; c=relaxed/simple;
	bh=DYeiIubZ4iv+q7pKdscTLj4mu7XgMjTusGySAbsAPGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUKWqgaV5OBQzDqwHHSlO83UG9MnOKkHTzVezgF90dpkCsKXLd5HXARrxDyA16Z15z1u7Q8ZYCti2JqTs4Yz54+Te2T0+DEmpkn+0XZVIIWXN++/jcd4YAKAvNvPAk6/BkoItM+0WUWH6YC1YR8OZsbvtkJrRnuA0YtGCFe9BR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTXRAIJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C5C433F1;
	Tue, 13 Feb 2024 00:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783699;
	bh=DYeiIubZ4iv+q7pKdscTLj4mu7XgMjTusGySAbsAPGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTXRAIJ0qW00ikhm799ktxCoCag5sEJKcesOyt6bSKcq8TrUI5i5EOSx+K+5yGf40
	 rMm36CpFLGCKXeEkU1bmFXOq0AOa4OYjiPAd0TksSac/oKovwOsDc7thDRoyHGMyqt
	 wRfJ3qhvtQGez/0e+ZNv8hX5l/Ppl8LkkFzvtL37Rf0hbsG7kbsK943BB6CKGy/S00
	 Ka4RDsy3MyAuD+lTM7YCvzAiwZH1a0zdFsA11m1m1Die0YVGhYVeMxrgtgDaqCPnYX
	 sIj3dWNtc5VGSvZo0mogy0CbQFmyRQrW2d2y5TmfQFPqtB32IqvMPE8xyJMWh0v/8R
	 EI84v85vsWwtw==
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
Subject: [PATCH AUTOSEL 6.6 32/51] scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()
Date: Mon, 12 Feb 2024 19:20:09 -0500
Message-ID: <20240213002052.670571-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index f6c83dcff8a8..ee9119b708f0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6253,7 +6253,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_hold(hba);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
-- 
2.43.0


