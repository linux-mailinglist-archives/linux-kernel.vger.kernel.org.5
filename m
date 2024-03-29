Return-Path: <linux-kernel+bounces-124717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCE891BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C5C1C23EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98515145FFA;
	Fri, 29 Mar 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxNPQxE3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CB145B3B;
	Fri, 29 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715976; cv=none; b=BnveuIl1UFwQkyzUXguRmSBrD3XC4FlUhfrY0srEeomhSkDG6HFkX/taAuLQVnAFRHL2OueISdntrYhmHek1u3vIWvBsDA21YduTanZ/XKaIQyCpoaASn6ptU11yFzKZ5DPCofB8gMmt99rhiKz/xqcHWpV+PTapqW+nqtmNa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715976; c=relaxed/simple;
	bh=DL9ydJy4+MkNqRrWlZjVU5Jee/u9kzyIN7uk54AxvzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ9TcatsQOSDo2aY95+LiBf5jixXFsdrdnZCnlUE0j3RJgA9ASiJofO3eOqV8xKv/qelimn7TTmlL/shsAbxRNPIboR3VRzVDG11mz79G/s0sOoL1axgvrPgYzTnZRlFpYnFMglC5eBX6T+t8p+F3oMHY4Dse4WTT8ORSNf/k7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxNPQxE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBF9C433A6;
	Fri, 29 Mar 2024 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715976;
	bh=DL9ydJy4+MkNqRrWlZjVU5Jee/u9kzyIN7uk54AxvzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxNPQxE3WPZFxGcBYxJehh6SdHsRctFLDB5fmmEHfayAd1FTDpZJ6pYAoqHxVHeWF
	 gshvJzud6ViWykQ3wHznT6kJSPL9GZ5PGLw9Qimyf9dN4ePK20b6SzkguKiAP4VUsZ
	 dpnjuzc4rUqajoXDEck89oiyEXfltjvgk+Vl67lIAgG2dvlULrYNXbS5pSwwhMBjyG
	 WphDMTNAub8qTihcY5FlZSaxkAthgCSNAd1bq69yeMzVRiRZ05IpM1rsHTCDjTjGsV
	 ZIaabMeaRP7L5M7cxAirV6egvjCTKtgMCeS55q+kc8ONZ2N4NBCU3L8lXadJ4QZe9U
	 sVPFlVFLucyYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Chanudet <echanude@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	jejb@linux.ibm.com,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/98] scsi: ufs: qcom: Avoid re-init quirk when gears match
Date: Fri, 29 Mar 2024 08:36:39 -0400
Message-ID: <20240329123919.3087149-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Eric Chanudet <echanude@redhat.com>

[ Upstream commit 10a39667a117daf0c1baaebcbe589715ee79178b ]

On sa8775p-ride, probing the HBA will go through the
UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info is
the same during the second init.

The REINIT quirk only applies starting with controller v4. For these,
ufs_qcom_get_hs_gear() reads the highest supported gear when setting the
host_params. After the negotiation, if the host and device are on the same
gear, it is the highest gear supported between the two. Skip REINIT to save
some time.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Link: https://lore.kernel.org/r/20240123192854.1724905-4-echanude@redhat.com
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufs-qcom.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa5..f7dba7236c6e5 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -738,8 +738,17 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		 * the second init can program the optimal PHY settings. This allows one to start
 		 * the first init with either the minimum or the maximum support gear.
 		 */
-		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
-			host->phy_gear = dev_req_params->gear_tx;
+		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
+			/*
+			 * Skip REINIT if the negotiated gear matches with the
+			 * initial phy_gear. Otherwise, update the phy_gear to
+			 * program the optimal gear setting during REINIT.
+			 */
+			if (host->phy_gear == dev_req_params->gear_tx)
+				hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+			else
+				host->phy_gear = dev_req_params->gear_tx;
+		}
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
-- 
2.43.0


