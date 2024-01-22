Return-Path: <linux-kernel+bounces-33300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A7836823
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2831F2757B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28C5F54E;
	Mon, 22 Jan 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dasyUWBS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28D5F545;
	Mon, 22 Jan 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935711; cv=none; b=rnHK8pPgW1RPxeaXHEjAGiQYxvzdjyyyYtmugRaaq2AutiDiiDKPnW2mnS0xhRXOkRCa2oVi+6yiXiRoh1k5G+2xlu/voqNUK5DsAE+UJ2/G4uV/NNyHkrNVqKzyC36IvknRcWUung2yJf/svmdg11jBvQkg3ssL2y3rQPrPLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935711; c=relaxed/simple;
	bh=ZsYhDRSMrBrkpdbxY5l+VFbJSu4rGbvydsbzY2yWMBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl3KUeLxAos/PCkoDujQikv0a08V2O53GdBU1kVGPfmXtxD4vskt1aMbuFiLTjNK4NgSlyk0n450f1YC/gZU86CvAmDlssa/lQJA+pKEDIWI1iQdGJzQSWHRoeF9+YlLembIKxeQ5X+u43DoweoLLSyJvmHzSy2Y5g/NXLgHjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dasyUWBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A31C433A6;
	Mon, 22 Jan 2024 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935710;
	bh=ZsYhDRSMrBrkpdbxY5l+VFbJSu4rGbvydsbzY2yWMBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dasyUWBShZhR7APwOFg8w8yqjG9yLSohFK/DEKbt5owa+ZbXkkZPuelAY5YNHJ1ts
	 4Bf98sQUdoPr/r3OzcBwcveNAFPVcPvYEvm2eOsy7g8F3RSkCMYwl1XpDLP3X767jZ
	 wsaUkmfFKdzpGgZ88+bYdkLpoYwei/mLQQCNgkHGkaWCv38O3yxHHVlE9lnPM/qTaP
	 zlHrCfmYD0aNRe+ew9SvKMaLBkAJvys3HtxEUdyQQE+zG2oniBecJ+CpaWju1KmVTx
	 oeWNM3U12ZmJErYqukUTKSTUMwxAA/PxmgimrUl0/qHh+cvOtp0J6ryB6a2GevZkUl
	 uBq+LM0/eFoAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Stanley.Yang@amd.com,
	kevinyang.wang@amd.com,
	YiPeng.Chai@amd.com,
	asad.kamal@amd.com,
	lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 78/88] drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()
Date: Mon, 22 Jan 2024 09:51:51 -0500
Message-ID: <20240122145608.990137-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit b8d55a90fd55b767c25687747e2b24abd1ef8680 ]

Return invalid error code -EINVAL for invalid block id.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1183 amdgpu_ras_query_error_status_helper() error: we previously assumed 'info' could be null (see line 1176)

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 63fb4cd85e53..4a3726bb6da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1174,6 +1174,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
 
+	if (blk == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
 		return -EINVAL;
 
-- 
2.43.0


