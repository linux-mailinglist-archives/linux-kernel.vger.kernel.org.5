Return-Path: <linux-kernel+bounces-33566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1397836C43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82C2B30B13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07858AAE;
	Mon, 22 Jan 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiBVQ6FO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5258AB0;
	Mon, 22 Jan 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936746; cv=none; b=DxmchjzMHzjJ7D7lmcxfA+dILnJVZl1+xP9JjMqNDHPsP7aQ4YUu/hRJ//NNUQGycCRqUBDgyPNRdHYI0VcFOeg50ZYLl0AfOZIGGDppAV3FKmSAj+c67NNqS9EMPkabhR+bIDFAe07weN1XO2nmQkbrUbtpXiPIWynwa/gR4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936746; c=relaxed/simple;
	bh=c/H47Ofj/5vGDHzyz087pRB/v2+Keic3Q/4IFnV6G30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCWGzuhvVfH9eIxfmLl6MRfXOPsbBc4/e/7C6SbcGfi6ACzl/FFBTxZEF/nvFUzA2zXgZX8RaodDqRviXLGWRe3Dlf2HXjeAzSDeO5cVBO0e2ulNRp8whK/T4/gF5zAdxZ2LxaQoEBasry4VOTNf14DpaLWfGGjbzfagV6uHjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiBVQ6FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FCC433C7;
	Mon, 22 Jan 2024 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936746;
	bh=c/H47Ofj/5vGDHzyz087pRB/v2+Keic3Q/4IFnV6G30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiBVQ6FOYvbMzdWvTj59UP9brwkLKCr2Yn+Rz1ncQ+ulVDLkpjkQcwUiST+fxIQM6
	 KzJhGnmW0Zzw6Tgp52mF2i/pSDGMT4G6LWniAr7QNcBhUMZdmgzygoNzBol28xONBo
	 VNMBJbdzcOd7I9f7Cz0SRBik6QyUraI51mR0jGaefzZESv80+8GktO58ydK/PsT+vM
	 p7W1UfdeLlJQYsieJKRw3J7u2O1YnQ4RmkQpk0ztACCOX+8StyZDudn0128KsyGD9p
	 m5vgVQXKwX3iIL7xKHURO+Y9QLVet98QpU3t+Thfs88xl4mq63n+aHmSEvoWyH4iCP
	 eLeNK2BaDSwpQ==
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
Subject: [PATCH AUTOSEL 4.19 17/23] drm/msm/dpu: Ratelimit framedone timeout msgs
Date: Mon, 22 Jan 2024 10:17:57 -0500
Message-ID: <20240122151823.997644-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 19e2753ffe07..a411cfe76998 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -53,6 +53,9 @@
 		(p) ? ((p)->hw_pp ? (p)->hw_pp->idx - PINGPONG_0 : -1) : -1, \
 		##__VA_ARGS__)
 
+#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("enc%d " fmt,\
+		(e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
+
 /*
  * Two to anticipate panels that can do cmd/vid dynamic switching
  * plan is to create all possible physical encoder types, and switch between
@@ -2326,7 +2329,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 		return;
 	}
 
-	DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
+	DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
 
 	event = DPU_ENCODER_FRAME_EVENT_ERROR;
 	trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 66d466628e2b..56ae888e18fc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -61,6 +61,7 @@
 	} while (0)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
+#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
 
 /**
  * ktime_compare_safe - compare two ktime structures
-- 
2.43.0


