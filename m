Return-Path: <linux-kernel+bounces-123089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40F8901FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E1291FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475012F37B;
	Thu, 28 Mar 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie6NRmEG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8312EBC0;
	Thu, 28 Mar 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636527; cv=none; b=ZcOU9rvVTMpVZnu40/Sj2GgD0oP7URbsVKXM7mKmxNizcOQkPV8ab8u6hGa1TQZS1GmwbK14IPzLghyOjuTO/y2r5SoKBIyQvnpjkS6tGMzsT+pBCir3mvOdfGknhmGqSYSbVl6B4KpHqxqHzyMl95tvyVYN616Kg/cI4diviDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636527; c=relaxed/simple;
	bh=VF6qqnFq5BR0GgjD3EzNG17qE4d7jjvmtipCQSDt8JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpqN2kqVRsvnyHr+0u/ZnAmGZ14f51ofZlxX7gvnhR76vfdkSKiKswaahaChpHEGp+Qbaz0px9NczNmf+mGqSyEGiO2UI41S04KijqZYgTuMub4k/98OAZP17r2R27v8Ydz5ykujt5ScZ7drz97LoY/QzNWhNW47p4yOF5LC89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie6NRmEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E2C433C7;
	Thu, 28 Mar 2024 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636527;
	bh=VF6qqnFq5BR0GgjD3EzNG17qE4d7jjvmtipCQSDt8JY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ie6NRmEG59AI/18DQPSh9EoEpD3gZOMKi26pfGroY35u1I831Lu8dcOZhZ+SrjquX
	 y330QF+18cNIO8QvfMeNVS50Zo0XvV5PTad/v20jgG05pa/YHtBxixGyHXyipEMIrJ
	 a+QQIzbW+5MgvgMUigDexS3EoSSs0NbZ4SKY1HbgnHc+VwOj6YErpk0oGD5WvTJNi/
	 wW4w8X5LXENyGExLZKLdSdHS1WP0fnVFEQPEIPj/a11APY6/h9suhBX8m6J2zeVLBG
	 AulNT62Cs17FT/tvXYH41tLhEsKd5C0j08yqW3DeErnql9finCYmdHobEeiLHrWcEg
	 smRcPUZQwiQ+A==
From: Bjorn Andersson <andersson@kernel.org>
Date: Thu, 28 Mar 2024 07:40:03 -0700
Subject: [PATCH v2 4/6] drm/msm/dp: Use function arguments for aux writes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-msm-dp-cleanup-v2-4-a5aed9798d32@quicinc.com>
References: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
In-Reply-To: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=mq3wvIgbvXj+jyFNC/yTvgdFWh8L1FA5V9blMx00Wnk=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmBYFIcfyzuKuAQVKDPK/ZL8Bf4YLVO329x9//h
 mqe86z7Ky+JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgWBSBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXIWw/8CFvExRkEmP4w9XHBNS/NPfMbAIuPdsxr+s4FKId
 17MBXbj9xbTahkFLuYTNFtWZWipsIupGcIGDqC6xez2JMyKOOQUS3xsJUce+RNS2qFuqZa6VRQ6
 2foqex5wz2Yi0HoETqQ1LvhW8g2cFdiAj6ggJ3V2838PF0e0iCm6SFbcZiUj9yEqSkpGJhKgqYu
 MWNYcd7pgn1wKqWiONUTamVMfvhI5pahdIqhpXntIhfWfm4pDZOgGOrKB2GcBh0YwLAfM+7loOW
 5s0HUtQ4xhd+qAImZVm3Po6hlyl3+CpIkxhJNMyCYF3oZ1EXfQCsPXvwHnbBtPqNNEn4LQj6ipT
 /jezgR7KB+25OObMuaMEYNowj9mC8LlNhrPhxZNva1fJ5pjO+nFXSTr1B5klfW8uck4Fb4QdjCR
 MkDRElPxPMrL0cdiCOanjVV5Wq+ShS1+M7b+9LsBOe9F1tEVyblRiUP2VvKGrlcuQgdwfexWObY
 vEmnxAiv+hzHb9hcPZU6A1O+fKXqQgnu93qD3Cihn2dvpDjkwE4LHgTQZ6BoItH8q/pTuoQ2hLu
 IEHDbBub0Ad8RGTFBPIEWEKHVrpIHq6/nitCbcxC73t7UePfgIARqxMmCqx0Zh1aZ5zqLmBb3OO
 Mlp3DMryMnfoTyVeel2XdlUdWS1iud/8lVL0E4VD+kZE=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The dp_aux write operations takes the data to be operated on through a
member of struct dp_catalog, rather than as an argument to the function.

No state is maintained other than across the calling of the functions,
so replace this member with a function argument.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     | 9 +++------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 8 ++++----
 drivers/gpu/drm/msm/dp/dp_catalog.h | 5 ++---
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index adbd5a367395..2c8bcc60692a 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -87,8 +87,7 @@ static ssize_t dp_aux_write(struct dp_aux_private *aux,
 		/* index = 0, write */
 		if (i == 0)
 			reg |= DP_AUX_DATA_INDEX_WRITE;
-		aux->catalog->aux_data = reg;
-		dp_catalog_aux_write_data(aux->catalog);
+		dp_catalog_aux_write_data(aux->catalog, reg);
 	}
 
 	dp_catalog_aux_clear_trans(aux->catalog, false);
@@ -106,8 +105,7 @@ static ssize_t dp_aux_write(struct dp_aux_private *aux,
 	}
 
 	reg |= DP_AUX_TRANS_CTRL_GO;
-	aux->catalog->aux_data = reg;
-	dp_catalog_aux_write_trans(aux->catalog);
+	dp_catalog_aux_write_trans(aux->catalog, reg);
 
 	return len;
 }
@@ -145,8 +143,7 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
 	data = DP_AUX_DATA_INDEX_WRITE; /* INDEX_WRITE */
 	data |= DP_AUX_DATA_READ;  /* read */
 
-	aux->catalog->aux_data = data;
-	dp_catalog_aux_write_data(aux->catalog);
+	dp_catalog_aux_write_data(aux->catalog, data);
 
 	dp = msg->buffer;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 55114a6aba7e..295bd4cb72cc 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -169,21 +169,21 @@ u32 dp_catalog_aux_read_data(struct dp_catalog *dp_catalog)
 	return dp_read_aux(catalog, REG_DP_AUX_DATA);
 }
 
-int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog)
+int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog, u32 data)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	dp_write_aux(catalog, REG_DP_AUX_DATA, dp_catalog->aux_data);
+	dp_write_aux(catalog, REG_DP_AUX_DATA, data);
 	return 0;
 }
 
-int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog)
+int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog, u32 data)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	dp_write_aux(catalog, REG_DP_AUX_TRANS_CTRL, dp_catalog->aux_data);
+	dp_write_aux(catalog, REG_DP_AUX_TRANS_CTRL, data);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 2c2dbeee7634..290ef8180c12 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -48,7 +48,6 @@ enum dp_catalog_audio_header_type {
 };
 
 struct dp_catalog {
-	u32 aux_data;
 	u32 total;
 	u32 sync_start;
 	u32 width_blanking;
@@ -64,8 +63,8 @@ void dp_catalog_snapshot(struct dp_catalog *dp_catalog, struct msm_disp_state *d
 
 /* AUX APIs */
 u32 dp_catalog_aux_read_data(struct dp_catalog *dp_catalog);
-int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog);
-int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog);
+int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog, u32 data);
+int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog, u32 data);
 int dp_catalog_aux_clear_trans(struct dp_catalog *dp_catalog, bool read);
 int dp_catalog_aux_clear_hw_interrupts(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_reset(struct dp_catalog *dp_catalog);

-- 
2.43.0


