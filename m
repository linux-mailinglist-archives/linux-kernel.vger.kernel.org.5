Return-Path: <linux-kernel+bounces-33541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8B836BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BE4B2CE22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3414AD19;
	Mon, 22 Jan 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccBy5wq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2B14AD16;
	Mon, 22 Jan 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936666; cv=none; b=I3OCvBescaL+EfS1kMOptMO2Uc1L/RarEBWiMpMY0t8/i6llj8KyEJjKFDu35Z5oDyHQRXSfAxI8wxf8lGQsFHSik4N2ytAHW3fbymknlST0FI5BIt/NCZmLvw6jYQ3gcbEPNn3S0Yi/R478ZiuqpW+w2YvXnNQN+NDHyCuV2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936666; c=relaxed/simple;
	bh=LLazMkk5CzRwb3HJqcr3thbAlhl92pWuQx++QwfcknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzGc/OLW4WY0Yt944F2OmxOibTQ1NH+zQ8cXxZz/Weo8EmxXX+CDCjtaucKJul51xnEeUoc96wuo3UleClYI2hWFdRIy8Ns1g9Dakm6o++75XGzrZcpd2UbGodPDg9YrG+8+Dl+p2aRaYGqRVyn3PQSPH14McCGbMmFolZPRhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccBy5wq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3085C433C7;
	Mon, 22 Jan 2024 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936666;
	bh=LLazMkk5CzRwb3HJqcr3thbAlhl92pWuQx++QwfcknE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccBy5wq9x9me6q1+w/96NTK9OiawepZ/Rzo0l4TAhLpoLNjEuoRFvFkJDQgBHnLBd
	 5Vt47EKoNQ/QgGy8Xj2yZQOJwi2NqS34FQzEYDsWTy8aSdGZxtLQwRglrpHl/+B+RD
	 uWuL3mbrQsmba4DmUYBPQrzOwUQ12FE1AdLVqwnyw12ZoHyX/N040QxOvSE87dUdJz
	 hjYZYAPYh/WNVnVNpqCltJvXREwDitWDR31iPnAcUDPZnrGSm4WCu/7Vg/p14q4dAh
	 FN4VUTOADfEeFLKSbI12NmB8sNgRbvftMM9qqBhIA4CcGEqfijjrnDh+Z1koIYYIDb
	 9Bx9znwuorqZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Clark <robdclark@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	quic_jesszhan@quicinc.com,
	quic_khsieh@quicinc.com,
	quic_vpolimer@quicinc.com,
	quic_parellan@quicinc.com,
	quic_kalyant@quicinc.com,
	dan.carpenter@linaro.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 18/24] drm/msm/dpu: Ratelimit framedone timeout msgs
Date: Mon, 22 Jan 2024 10:16:32 -0500
Message-ID: <20240122151659.997085-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 2b72e50c62de60ad2d6bcd86aa38d4ccbdd633f2 ]

When we start getting these, we get a *lot*.  So ratelimit it to not
flood dmesg.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Patchwork: https://patchwork.freedesktop.org/patch/571584/
Link: https://lore.kernel.org/r/20231211182000.218088-1-robdclark@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 99d449ce4a07..03d671d23bf7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -44,6 +44,9 @@
 		(p) ? ((p)->hw_pp ? (p)->hw_pp->idx - PINGPONG_0 : -1) : -1, \
 		##__VA_ARGS__)
 
+#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("enc%d " fmt,\
+		(e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
+
 /*
  * Two to anticipate panels that can do cmd/vid dynamic switching
  * plan is to create all possible physical encoder types, and switch between
@@ -2151,7 +2154,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 		return;
 	}
 
-	DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
+	DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
 
 	event = DPU_ENCODER_FRAME_EVENT_ERROR;
 	trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 4c889aabdaf9..6a4813505c33 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -50,6 +50,7 @@
 	} while (0)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
+#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
 
 /**
  * ktime_compare_safe - compare two ktime structures
-- 
2.43.0


