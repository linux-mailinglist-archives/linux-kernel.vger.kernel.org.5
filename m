Return-Path: <linux-kernel+bounces-113308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF1688834A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1824328283C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEE1926FA;
	Sun, 24 Mar 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5o47Y+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC1191795;
	Sun, 24 Mar 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320109; cv=none; b=N3BvWMLMq65Y5bfxjwuDQOT+S4z5G6pGXe8dD+KCuJWv4sl9Z4uF2uDTImH/fAIDzE8QZ4zR3ZVCA6Cv8pKt8jxVNZ/EiynWTVJhX6L27G1GAh1RNdg5ySJ/GfSlvDTTVZSe7cW24TSnoMraCTcdbcB3j0kq6+oJnaFlrOq2+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320109; c=relaxed/simple;
	bh=6WY7ATvRwoBVf7iibZPOgJ+dLj4kLyAawF09E4LUFW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy4eOsSKQ9mqVwT1uSSnogX76MdfU8ghwjUNC3wydr4Je1sCqxwUz3W1k5fYbnfz2ZMi+p8OImjOiedLFBRK21nIDtQL+z3s7c2iQu9fQ1wOrjPltuExHCB6cq4hK4fXnCyHtXlFlK26UJtVONvfkZ9z/1Ut8jBlgTI9OvhTg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5o47Y+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07ACC43390;
	Sun, 24 Mar 2024 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320109;
	bh=6WY7ATvRwoBVf7iibZPOgJ+dLj4kLyAawF09E4LUFW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5o47Y+z8M6sxq3KD4Z66TGSvBDF9Jt2C1wJWgpMxOAcwuQzrs2la3Et0/g7+zk60
	 U7crnWE4OQXHx9zPAGOiu78l8cuFPmuoW9FIzOhXp9mjwBXLcyUEpGZgWGNXBQ1dO5
	 SD+3XEztgVLlUJPlt36pyv+PVZb6VWxo2eVG5P5CT9ar6hPX0upEzky5+EEly/bm+T
	 l/oWwyMDbYJcZ2pQ1FanuN2vS5smw1bW+7q7XhVIReWan+VYacmTK6oL3SlVFV/y5Y
	 MzOmPCgbS/+zusJFh2RqTezxyQMiUrD19/q+SbLy7e5Vp411xGuC2zmX0sVaEucDQp
	 bYG/6f+DQtxuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 417/715] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
Date: Sun, 24 Mar 2024 18:29:56 -0400
Message-ID: <20240324223455.1342824-418-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 8932f38a41b2d..aca689314ccea 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1860,7 +1860,9 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
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


