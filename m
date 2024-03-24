Return-Path: <linux-kernel+bounces-113855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F298886FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87886285829
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E30137759;
	Sun, 24 Mar 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia+sKFsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A611D6840;
	Sun, 24 Mar 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320916; cv=none; b=PkcNdrwHK6ds92cPuQ4iTlmYO1nnygcH40xVDzuE9L5VcxCnGm3YmTQMBVtYd5rSjuBzuhmrX3x3hF81vUTJlrthA7EaaAS+mRSnxC7eaxX4NAGLdFUvwVufJnHQkEw2+QiPkD8baRD5ag619jgz6Oug/mtL3Xi9ABChtSqBagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320916; c=relaxed/simple;
	bh=95CPx9HrRfWrp5uEMaV8rR1GScFadCJmOfAb/CH3ZXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M84xncUP9K+MvhnOUN9f1eWBlWuY2goCqOsP3NC2J7GJ3oVLwvFbcFbcwYyw8IicTV5UtspYbALCg8pgEzGHIymYnwWv9yOpajASfw0q5pMGH9wCJaesI9uG/wi+4to0N3zGh+HIR1qR0P6Fi6gLia4vnzgykGmbI7z5JmqgfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia+sKFsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17685C43390;
	Sun, 24 Mar 2024 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320914;
	bh=95CPx9HrRfWrp5uEMaV8rR1GScFadCJmOfAb/CH3ZXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ia+sKFsnnMA1lcytcBQ+9SYbe/iM2ZKxD2xfVTzLTeyomGKu/8UCey2dTmX2tqLPr
	 alm7BoS+AlPK3bBDdibVg8h9GBQjQMVut67NSutF6k205Aa81yxrNyzzJx9TRN75fp
	 7MAW4U15XQAlCa4sz05EO1O84drSyZxDSwrFUrssGDcf4hg7G90TU8J432CT2C85WL
	 iu2PlCfUxo3obq9E2Uyu2gFhFqvU0vo21cOSU8tNpRsj5b0W8wkG7HM8fu6Mo4391A
	 mVd/sqJKdloUSWcBu/xYhNnUHwAAAiDVjLXfaC3JiV/tB+vGTJFrECbSKIv6FyWQOp
	 UAfB9Yp8DR1Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 478/713] drm/msm/dpu: finalise global state object
Date: Sun, 24 Mar 2024 18:43:24 -0400
Message-ID: <20240324224720.1345309-479-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 49e27d3c9cd67fd5851f8b5518645b9bf3d2c6c0 ]

Add calls to finalise global state object and corresponding lock.

Fixes: de3916c70a24 ("drm/msm/dpu: Track resources in global state")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/570175/
Link: https://lore.kernel.org/r/20231203000532.1290480-3-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 797099e5e53d9..81acbebaceadb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -385,6 +385,12 @@ static int dpu_kms_global_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static void dpu_kms_global_obj_fini(struct dpu_kms *dpu_kms)
+{
+	drm_atomic_private_obj_fini(&dpu_kms->global_state);
+	drm_modeset_lock_fini(&dpu_kms->global_state_lock);
+}
+
 static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
 {
 	struct icc_path *path0;
@@ -822,6 +828,8 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 		}
 	}
 
+	dpu_kms_global_obj_fini(dpu_kms);
+
 	dpu_kms->catalog = NULL;
 
 	dpu_kms->hw_mdp = NULL;
-- 
2.43.0


