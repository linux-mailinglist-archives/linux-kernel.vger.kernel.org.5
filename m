Return-Path: <linux-kernel+bounces-145125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032718A4FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E73281961
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5A85938;
	Mon, 15 Apr 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDqXy1zH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07285293;
	Mon, 15 Apr 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185402; cv=none; b=NCjNaD2hosqc19+P0cRdmdHA9Cum9wrFxxCvJvDvKfjhHytaLtBFcADRd5/YyQHtcEm+B3JkIYUOZWge1o8ktuMa4VK1INsUTM1tl6m040Ae/3fGd1HZsCusGIggAM8vfMPrgIzpSwqRoQa9QeDZdFGIDNEbs5R95m/e+muTuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185402; c=relaxed/simple;
	bh=s47cdW7+juh03SCq6QFN4+wAqadPWwm5ERPpWRoCDow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCyFLBu9odNQWbhmZYcnrrkJIMTGqbfaBExbjdYmS91rjYJnydxGCFXRlC6Jc5XtJrilnk/cr8omQChQTiikIggIfVYvsguHgpu0c31vnYHtWM2bUj2bTC2alUXhoDZSX5taSerlSjTfoS0nuiX9+uQMCeoOTnIYjk5aEr1lWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDqXy1zH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336E8C2BD10;
	Mon, 15 Apr 2024 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185402;
	bh=s47cdW7+juh03SCq6QFN4+wAqadPWwm5ERPpWRoCDow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDqXy1zH3ScAofun5w60bVZ1JEkvdqHtTvq1klFOiCR8oX5HfbfwUJ0fpMBbnqn6T
	 6PHryPT3952Q/iZW6JEhuRSMDZvKHsa93gxvFddsgONlFyIkOjEG2DP3JelbhDyNhG
	 eQ8P2OrAxrOZbJfaVsFNn0E6QtdK6VamD/eqvcC/66t8msJNM9jSRDqnGbim0fyh7z
	 WyOfzROFCYVoZlJCWM0q4MRhpkbVygnMyFgw6uWfo2kbm6G9D+hWD8BqRV2DQRt/ok
	 /S4kE0WztAN0R6Lm6LNkGT7FvN37MKKueBaYDziacs+6/MgQkMClwJOs6aNXrkagWe
	 vzildnL2MToZw==
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
	beanhuo@micron.com,
	manivannan.sadhasivam@linaro.org,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 04/12] scsi: ufs: core: WLUN suspend dev/link state error recovery
Date: Mon, 15 Apr 2024 06:03:39 -0400
Message-ID: <20240415100358.3127162-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
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
index ee9119b708f01..8005373e20bae 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9547,7 +9547,10 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
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


