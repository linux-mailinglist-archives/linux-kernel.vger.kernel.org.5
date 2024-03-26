Return-Path: <linux-kernel+bounces-120000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30D88CFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB21323443
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B013D624;
	Tue, 26 Mar 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzRttCev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87C1E51D;
	Tue, 26 Mar 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488257; cv=none; b=O/rkC3hm84+CCuZ/aZBsa43PCZYSScpd365uinw0ovph6xm/BN75Ad0Xc/95JmqbJCnUGq14E4IBun4KnYtrYb2sQFTzCOCW6/t04UMhWlZ5ahgjDUXxy8t5WsaU91TyJjckTThzWtyrecv7j25gwd0kfNe70ro0GbdmGuT3ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488257; c=relaxed/simple;
	bh=+7ou0Blb4yyxWLvmEh9Tg2cpMYZrBSmbjUxmYsUapVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suCa5hgyAnRMJPHEN5YfdqXOrCH3D9hRBZtql9a3JKqRcCeMzJjSa4JY89rmvu71jIuK3N9YK2GAzG1BvLPjIpQt+opRJBKs3tbWZqP6/pXLY8yaKk/LxcWRZQ0mLaqOUlP9mxmrinPmWfXM3w559dqNG9OjhEBOJFAgTpY9t+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzRttCev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8DC433F1;
	Tue, 26 Mar 2024 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711488256;
	bh=+7ou0Blb4yyxWLvmEh9Tg2cpMYZrBSmbjUxmYsUapVE=;
	h=From:To:Cc:Subject:Date:From;
	b=XzRttCevpZEKstiOQ+YK4/hwjYstMTsuRPwxTysqoRAmoq4dMwcf5Ov5iwsWX+X/O
	 XqqLGzSPQMMg32OYHOmtKduB6TQsW+GZEZcjh04ucDlonial/B2V8HG7CVIM6iwFP/
	 qEd19z5B9PRwBWZc6KZlt5R4jLYm5R2ARrfEtcgqRtCzVC5xlanxWtbL5IZaCFFiKb
	 2ddfiDjcEbrCF8noSD5NCMZIU36EGK8Q+R/KZELFXUdlEDprDGBKtGvYL6oxLF3WfN
	 668helCzuab4DYqUNqeWok1l3OcRF/GoRTxjtAwdu1nvlipBW38xBYjlhKQy5t3nS6
	 MiB3Y1GEUs5OA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Connor Abbott <cwabbott0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: fix the `CRASHDUMP_READ` target of `a6xx_get_shader_block()`
Date: Tue, 26 Mar 2024 22:23:24 +0100
Message-ID: <20240326212324.185832-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang 14 in an (essentially) defconfig arm64 build for next-20240326
reports [1]:

    drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
    variable 'out' set but not used [-Werror,-Wunused-but-set-variable]

The variable `out` in these functions is meant to compute the `target` of
`CRASHDUMP_READ()`, but in this case only the initial value (`dumper->iova
+ A6XX_CD_DATA_OFFSET`) was being passed.

Thus use `out` as it was intended by Connor [2].

There was an alternative patch at [3] that removed the variable
altogether, but that would only use the initial value.

Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/lkml/CACu1E7HhCKMJd6fixZSPiNAz6ekoZnkMTHTcLFVmbZ-9VoLxKg@mail.gmail.com/ [2]
Link: https://lore.kernel.org/lkml/20240307093727.1978126-1-colin.i.king@gmail.com/ [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 1f5245fc2cdc..a847a0f7a73c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -852,7 +852,7 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
 			(block->type << 8) | i);
 
 		in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
-			block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
+			block->size, out);
 
 		out += block->size * sizeof(u32);
 	}

base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
-- 
2.44.0


