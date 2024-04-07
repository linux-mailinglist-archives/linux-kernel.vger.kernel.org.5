Return-Path: <linux-kernel+bounces-134431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71589B166
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420A4B21C97
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF99A3B785;
	Sun,  7 Apr 2024 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uft8BOVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3D3B78E;
	Sun,  7 Apr 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495532; cv=none; b=TdyGjfF7ONYTdJk71mC3TnIyz+T0YgjtGBGes57v4hr04nh9P2fyMucLLlnngZElQzXvT1HUFetVgfhN3oRpCLvrK2+SabnErjW0eQY+k4AIh0O+bwXX1LcFHCP0vxXJ3p8UbLgieeCsp1ZXP8JYrR+cisY2CkmZZuZtBHxD1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495532; c=relaxed/simple;
	bh=6zzbWAyna2YyQAnGbGIAMsDqYnksI8cYUqLblgad2V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDT0JE4Glx+tAqUGFWxjDzi7cI/J68BpOOEPk2Ex4CUNKx4LP84cITXcWmU7+CbCSlaFvRvCXwOmJF274sCkjQXNilhrWzFnf6aIWDsvpt0SjcYWzb+dpeqwNmlrc1APRj46HDwACk0aawVylsEBN+tX/k7lHTVD6mvMKWA8cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uft8BOVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28269C433F1;
	Sun,  7 Apr 2024 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495531;
	bh=6zzbWAyna2YyQAnGbGIAMsDqYnksI8cYUqLblgad2V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uft8BOVTnOyYmSXjAYbxepZXL12TuFL5NKUdLaJ5D4isZxSaISHG4OjVraHlSenHr
	 DD+wuHWreF6HTf97R5iDFEsdPL/pIXouhrarEfgxMJVO7+mEhYrpzGgk0BvOUYJvFU
	 97bYxUslbUe7/uxctx1arNa/v1M6yOyVv4QsJsGKRJHRA/UI0YqYBQc/FUQ6WF5C7J
	 KV4UPYg9ZH9l6hHlIF+0PEl7gl2VdIrb3CQJ+215HfL7s2LkdSWuNfuxXnKvQr8n/8
	 VrfFBh2RwR7MAUHOLrHUVYn69epKRiwydV70la33M6Q/h4t2vNkm/gHPPpbQfpDKL8
	 grdKpy6SUP3Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peyton Lee <peytolee@amd.com>,
	Lang Yu <lang.yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Lang.Yu@amd.com,
	yifan1.zhang@amd.com,
	lijo.lazar@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 21/25] drm/amdgpu/vpe: power on vpe when hw_init
Date: Sun,  7 Apr 2024 09:11:09 -0400
Message-ID: <20240407131130.1050321-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Peyton Lee <peytolee@amd.com>

[ Upstream commit eed14eb48ee176fe0144c6a999d00c855d0b199b ]

To fix mode2 reset failure.
Should power on VPE when hw_init.

Signed-off-by: Peyton Lee <peytolee@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index b9a15d51eb5c3..ad44012cc01e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -390,6 +390,12 @@ static int vpe_hw_init(void *handle)
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	int ret;
 
+	/* Power on VPE */
+	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						     AMD_PG_STATE_UNGATE);
+	if (ret)
+		return ret;
+
 	ret = vpe_load_microcode(vpe);
 	if (ret)
 		return ret;
-- 
2.43.0


