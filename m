Return-Path: <linux-kernel+bounces-114560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4248888B91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322EBB2AC29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1D296BDD;
	Sun, 24 Mar 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXSzL7VE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0054725;
	Sun, 24 Mar 2024 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322201; cv=none; b=RMRn0DkzgLh88BcgK4fYw8WFZM4EGCB4IONzZxYkTv3sIVODountr4wzZ7RgGsDj+bJ5xPGkONbOpg4kqVNAAoi2vghpRlw7KkhrFWf4+nzBy75CjyoX2Sst1DxjQtAZ/mdTpgfecWkj4INc4EAsxNYamDWg9WJV+EEA4Y+Hh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322201; c=relaxed/simple;
	bh=+ViMB1xwBnGP47Rzl089a3Kxnes9ANAMHekwXP/wl+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2ZBPgt2lkw56kv7I0TRYbpH9FX3wwZ2wpyjDz5yYORlqNTlkI3XF2PJEjSYvzk8sZV+07USfjiq6kzu+SJ3KDMhsczMON+pqQJwaA+xNR4CVyDEt4/5Wmel7N99Dqi7QYNkaxctRaM1GLVoTai5uoZM/t2lbYIHs5qsJckEqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXSzL7VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F914C43399;
	Sun, 24 Mar 2024 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322200;
	bh=+ViMB1xwBnGP47Rzl089a3Kxnes9ANAMHekwXP/wl+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXSzL7VEHVDl4LQ9p9B8yCR/wd73ErTu3BbhpU8clxI7YnAt4CCLwvSOsK4Q4yVCB
	 YNgaqCGkw0EELdI4ddue95+7onSBkfOwfg70sWruWB41Ls1YYtRc31BAuQSDFNCXOB
	 LVDJs+dXyn97IvTO/5Lhrhz0mCnGOxNJSnuU3z+MqF4XxFY8Ca1i2znVmDk4PYzotM
	 UM5hBxWhR6P8mWs91EgPQ0kqHBWWdr9TM4rdHgwqUTn1GBrIckqv+GWZWcTlPRnziJ
	 Xx9ivpALeVvP/PNOA9ulUl+hOvubF2WCSgI+3ZCxtASVTPj+Da01TlSRTWc4Cg29C9
	 byP3O2e4LtD7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 280/451] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
Date: Sun, 24 Mar 2024 19:09:16 -0400
Message-ID: <20240324231207.1351418-281-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 06267d22f9ee6fd34150b6dcdb2fa6983e1a85bc ]

When the topology calls for two interfaces on the current fixed topology
of 2 DSC blocks, or uses 1 DSC block for a single interface (e.g. SC7280
with only one DSC block), there should be no merging of DSC output.

This is already represented by the return value of
dpu_encoder_use_dsc_merge(), but not yet used to correctly configure
this flag.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/577067/
Link: https://lore.kernel.org/r/20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 4bdde5cb23aae..3632f0768aa9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1871,7 +1871,9 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	dsc_common_mode = 0;
 	pic_width = dsc->pic_width;
 
-	dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
+	dsc_common_mode = DSC_MODE_SPLIT_PANEL;
+	if (dpu_encoder_use_dsc_merge(enc_master->parent))
+		dsc_common_mode |= DSC_MODE_MULTIPLEX;
 	if (enc_master->intf_mode == INTF_MODE_VIDEO)
 		dsc_common_mode |= DSC_MODE_VIDEO;
 
-- 
2.43.0


