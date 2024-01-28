Return-Path: <linux-kernel+bounces-41747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF4A83F747
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A8F1C223E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0734446D2;
	Sun, 28 Jan 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb/kzU7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6565BD8;
	Sun, 28 Jan 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458440; cv=none; b=bejKgTOgM9/EFg6Us8Giqa7dVpFY7HoKDiozqoKIZ8UiF3xXe31xvzQWWTdp6rKYR5L2oEluS/INsgquVuAAsf/8C96gADGqPMsQzDIyXNdMFfH82A5kNBx5I4g+SBPBDy4hcItaoWKx6dZnGOQIGFAes7q7C3tjCGPt15nU8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458440; c=relaxed/simple;
	bh=azj0o16XNmiPoWegTfpJ3DfekAM5KM8ILmUwFJKxRGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxkuOxgLPEErzzAhfUOjzibs4FwCpzYu3z4diS8wOpk6BvMVYIRFlsBkcVWoDL/xnZI+aEBmhRG8ZCDGAqb8nEXlv6scl6I5JarCihFGiO4fMAKIiJbT3OeOLy7BjO803mWa8xd+c6/xcugn/qvy+GY2Srn2X2ilXbtKJKQb288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb/kzU7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7EBC433F1;
	Sun, 28 Jan 2024 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458439;
	bh=azj0o16XNmiPoWegTfpJ3DfekAM5KM8ILmUwFJKxRGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb/kzU7BYafSVjcFWnn673KnlxOJZYL9f2PYZ50zux7IDbNcraqPNBa7qx9u2eurA
	 zR/+WTSwBQ4e0laV3MQfcUSrqkmhGs6NXB8XViTIh9YP8sfi5NmjepIiK0VN4P/xK5
	 ua3raibRDmV4PfLXrLVYyElyIgo7Nk5vsXaqzLxXtatd0/Zaeib+uvATpitflDcoQU
	 clrlRUOhyQZJBYTH+YFRd7EhACGUxekePbwRFfyMvK5XGEROdHXHJzcL5yexDZVND2
	 lNzI+3MqGAWRE1bJIrIz5MkYqUqWaeDe+yDkDH0skN9SYQE/icqpxirAtPlPMPgPvd
	 gpcDpJLSBEeOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	ruanjinjie@huawei.com,
	lijo.lazar@amd.com,
	alexious@zju.edu.cn,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 26/31] drm/amdgpu: fix avg vs input power reporting on smu7
Date: Sun, 28 Jan 2024 11:12:56 -0500
Message-ID: <20240128161315.201999-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 25852d4b97572ff62ffee574cb8bb4bc551af23a ]

Hawaii, Bonaire, Fiji, and Tonga support average power, the others
support current power.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 11372fcc59c8..a2c7b2e111fa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3995,6 +3995,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	uint32_t sclk, mclk, activity_percent;
 	uint32_t offset, val_vid;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	/* size must be at least 4 bytes for all sensors */
 	if (*size < 4)
@@ -4038,7 +4039,21 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		return 0;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-		return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		else
+			return -EOPNOTSUPP;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return -EOPNOTSUPP;
+		else
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		if ((data->vr_config & VRCONF_VDDGFX_MASK) ==
 		    (VR_SVI2_PLANE_2 << VRCONF_VDDGFX_SHIFT))
-- 
2.43.0


