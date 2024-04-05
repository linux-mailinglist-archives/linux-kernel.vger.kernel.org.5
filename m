Return-Path: <linux-kernel+bounces-133303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097489A201
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088EA282AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEA171064;
	Fri,  5 Apr 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ZMNBmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF716F27B;
	Fri,  5 Apr 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332741; cv=none; b=HmKI7LIk9ZaEp+RMEQqc/PBYWVtOd7mblPcBU/kDudLBnEZQZ1Pdy4wVhoc+nSmEvCsfuQq5Tfs0HdP4BJEGo3TzeTiE2UdAaa9ducDKv+UoprqJ/rspxCl/VAvPMSXVYfXksL7JtvJ4mFYDYBwhm9c7af3U4yEOdiYFL/+9iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332741; c=relaxed/simple;
	bh=WPpqs+ByS572N6lsI54xqQu7Rf2BIKVicZBECmGPvak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAKRZ8RKqSO+dqzIps7ZrSKq4G7uqEulH82JmwIl0+Y/pOouVMlZKlF8M/rdBHk2nNhVMY+aAaTe/gOf0kYCWlISzGYCmByhN7w9q7C87718ASGxthn57k5GIXJMkjbKisQMG2xq+genSeks6DX1IVUOrWWQHrW3m24zGuQ8gMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ZMNBmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22394C433C7;
	Fri,  5 Apr 2024 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332741;
	bh=WPpqs+ByS572N6lsI54xqQu7Rf2BIKVicZBECmGPvak=;
	h=From:To:Cc:Subject:Date:From;
	b=Y3ZMNBmzeHVJJHI1+iwK2hE3R3lpt4x5GaXibepBvNo39F/hFCewUbtyRAsJC71IH
	 JQFwfVmCI2egKtMeAQ48cdb+BxPVhjsvj8LBmuqUZF2QaXHio4LAYybXDgREOglifj
	 8IZQHcmSdxogkivig662xG9IHSxZaX/NbrP+44qGbvP3gp2B9PdkE1Xs75LR5lQDEc
	 +ob229m0F4mH8hC4hOhdDWWUQzm71ri3ZywuO2THfMXXDwI5sOPdTxQBGmYkOYoRhV
	 D0xsEJLnk8h1i1ea29a2zt7g/1bK/J+jKZjR7MmxY0F8bAAX9E/80KBuiqzBYb+cgj
	 qdpMvl7sK2YuQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Connor Abbott <cwabbott0@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: remove an unused-but-set variable
Date: Fri,  5 Apr 2024 17:58:42 +0200
Message-Id: <20240405155855.3672853-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The modification to a6xx_get_shader_block() had no effect other
than causing a warning:

drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable 'out' set but not used [-Werror,-Wunused-but-set-variable]
        u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;

Revert this part of the previous patch.

Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 1f5245fc2cdc..d4e1ebfcb021 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -840,7 +840,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
 		struct a6xx_crashdumper *dumper)
 {
 	u64 *in = dumper->ptr;
-	u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
 	size_t datasize = block->size * A6XX_NUM_SHADER_BANKS * sizeof(u32);
 	int i;
 
@@ -853,8 +852,6 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
 
 		in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
 			block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
-
-		out += block->size * sizeof(u32);
 	}
 
 	CRASHDUMP_FINI(in);
-- 
2.39.2


