Return-Path: <linux-kernel+bounces-145105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF458A4F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6C1C20F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1A78C72;
	Mon, 15 Apr 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYS3VPhL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E678676;
	Mon, 15 Apr 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185365; cv=none; b=IEgY9owMZBWhOOAvckZ/Poiu29GCwujsddn0I3/CL3hFEUJ8iCPEeD0dmPbd0wSWHEQbzh1Ho3hT2+FW9AMxWnpc7Xnhnh5LnaniaK3MDF4fkmRNskuoDcXTuz1J/DssS2cUImtThD9Soz25qZKXBjXJVsogVspvW7EdE+1XqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185365; c=relaxed/simple;
	bh=6bzgEIhKA6CeQaTfg8ENrNbGmzaOmGDRBZQ5wVFTRJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThZP/tyMV5POAmbfUHH1x9vhOwJb8dRy2dPVLUuHvcyaBvWvi0Hu9MZQwVYrVA7MLox434kShOPIU+6A11EmrNdTp57G/sH+5BhiNCINMVIXDltyibmDeBWF1SBIwbkpsHuTfC/WORnCEH/PU4O1mdUC51V/3xMNzxn3Wu27hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYS3VPhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2542CC3277B;
	Mon, 15 Apr 2024 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185365;
	bh=6bzgEIhKA6CeQaTfg8ENrNbGmzaOmGDRBZQ5wVFTRJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYS3VPhL570YLwluqOiBb5CJhLuWhVjviJje7E5CCIRDp5YvloO3UIwy0pPzdOUX2
	 dRrJxdCUfBh+vV6lpjQc2PoMtKyHucCU8j1GJ9QumcCwzdepwKL0+3NkXwa2gRnZfz
	 hv9NoigpNN2BkSqal0x760bk7vPzSbJJLkYes3Udx4WWyV2OakZjbVUQacwvyhcL/2
	 bjIOWbdh4AtSXJSnQSm3F5HSGdT+ZSiNj0Q4npza9g9p2dSSBUaAii+tYttxa+5ZKm
	 1NLzEsQR+TLzAImVjJlIRpUOLu5DDwKypybfBWniz+SmixooRbKdAymShKcSGw1jr1
	 tzBjj/TB8tPlQ==
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
Subject: [PATCH AUTOSEL 6.8 07/15] scsi: ufs: core: Fix MCQ mode dev command timeout
Date: Mon, 15 Apr 2024 06:02:47 -0400
Message-ID: <20240415100311.3126785-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 2a26a11e9c258b14be6fd98f8a85f20ac1fff66e ]

When a dev command times out in MCQ mode, a successfully cleared command
should cause a retry. However, because we currently return 0, the caller
considers the command a success which causes the following error to be
logged: "Invalid offset 0x0 in descriptor IDN 0x9, length 0x0".

Retry if clearing the command was successful.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20240328111244.3599-1-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 14a6a100fcdb0..4a07a18cf835d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3172,7 +3172,9 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 		/* MCQ mode */
 		if (is_mcq_enabled(hba)) {
-			err = ufshcd_clear_cmd(hba, lrbp->task_tag);
+			/* successfully cleared the command, retry if needed */
+			if (ufshcd_clear_cmd(hba, lrbp->task_tag) == 0)
+				err = -EAGAIN;
 			hba->dev_cmd.complete = NULL;
 			return err;
 		}
-- 
2.43.0


