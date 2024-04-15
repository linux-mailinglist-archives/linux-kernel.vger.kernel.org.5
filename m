Return-Path: <linux-kernel+bounces-145128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682638A4FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228C5283F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176686657;
	Mon, 15 Apr 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxSSIfss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE527745F0;
	Mon, 15 Apr 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185410; cv=none; b=mghpIWIbC2QSBShLeIiBHumn89CNBVb5ydBTSbPK9ePT4nG5ubvyByFOaOY6JJwBVx4h7+qVlZzBYrfdc9AqcmFERco8bfDuDnYcRsVT2Wsmw2U/DKbzBIuDNsNBFGNmxIJUO3JhfLjVrC/GhyDzuQk6OI9Q/t9HYkUtY5i97yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185410; c=relaxed/simple;
	bh=ZJeH9mmRkzVeKciQNcI/iGRPUWnIOGpgJPuEVgETO3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQm5jxi2FCdmIEPowLXh2e8uFZ9SwOY52b1YS0LbEBi7Wl+sd0lckXXnhu2lle14ogQt8zXkbklrudf/AjqCZZ3+OjyTlXZgx54jifOvf+EZvRWhdN5zC92UEWRqQWCNoDk7oYPqCDQxfbmwi5hRtDqTFkQ7theVLCh0Stcm9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxSSIfss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C81C3277B;
	Mon, 15 Apr 2024 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185410;
	bh=ZJeH9mmRkzVeKciQNcI/iGRPUWnIOGpgJPuEVgETO3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxSSIfssIn4IdHKRU5fl+rFn04fO49FP64K01XBnX192z1aK78P2TeOF+fmWx0gmr
	 AlR7X7/KKxuM+ueGGYdu7SaCEpTyDLPlUoWcQcfV4Ry2GHNnhdXI1vN+lI1j3VjEjS
	 YkhQd4n2WBrcpa/l94ySRkWeyaUqDY+THuDrCxZpRYcWZFQjy3/vwFKqo3dmRPteJJ
	 ddwYevbxCR1BO1cuDTQHf/T0yHQVY24KuTqjK6PK1IGRy6PU7aCSmPMMU+GgAeAhis
	 aVAkEZxR80kk8gVGcWkeZDdHcSmRjMmAsiuEUXPBkvpO3n1oCxi/oq/M80SSyOP7q2
	 wu/75liXeGu+g==
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
Subject: [PATCH AUTOSEL 6.6 06/12] scsi: ufs: core: Fix MCQ mode dev command timeout
Date: Mon, 15 Apr 2024 06:03:41 -0400
Message-ID: <20240415100358.3127162-6-sashal@kernel.org>
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
index 8005373e20bae..344806330be16 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3064,7 +3064,9 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
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


