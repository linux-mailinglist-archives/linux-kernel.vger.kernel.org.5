Return-Path: <linux-kernel+bounces-52610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E06849A67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290351F214F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E15C20DFF;
	Mon,  5 Feb 2024 12:34:47 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927D20B3D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136487; cv=none; b=nRQRmcXvq164B1m0Q+U8brafiPrNvVqJcsX9n/CC/cQ0rO1pgEs5rf33n1l8glwZJzcIDga6/jI+k+UvPWg6aRB0HfJS9z3uAbWDUHF4A7F246DfxI3jlFuujyk8GtheJPrcRX8OCSllGhCpNiupiXS87k6pPT8H/nnHE+s4BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136487; c=relaxed/simple;
	bh=dS3HpbKD4NGluML4EFZa848D/RGOa7cvAlE/YdZgOpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhumlnEITAD9mPim8kqUsOAhfo/yBdLEwzNBOWy/dpw6Z1vqicW3cnidSKcEEseCCmg4Y7iF27ztGxdn6U/7tPKxbOsR42nPApFpkht6KxQQrl+l94e5wfTKRbkx8E4hC/yg4nfuWo9Uv70ykrQZNT7PtLGmWu4j8klaiQ/YRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id D6021102399;
	Mon,  5 Feb 2024 15:29:02 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id CEF09102394;
	Mon,  5 Feb 2024 15:28:12 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 415CS8Dw005304;
	Mon, 5 Feb 2024 15:28:08 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] drm/amd/pm: check return value of amdgpu_irq_add_id()
Date: Mon,  5 Feb 2024 15:25:21 +0300
Message-Id: <20240205122522.81627-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20240205 notchecked
X-AV-Checked: ClamAV using ClamSMTP

amdgpu_irq_ad_id() may fail and the irq handlers will not be registered.
This patch adds error code check.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..9cb965479dd8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -647,26 +647,34 @@ int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_irq_src *source =
 		kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
+	int ret;
 
 	if (!source)
 		return -ENOMEM;
 
 	source->funcs = &smu9_irq_funcs;
 
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_L2H,
 			source);
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	if (ret)
+		return ret;
+
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_H2L,
 			source);
+	if (ret)
+		return ret;
 
 	/* Register CTF(GPIO_19) interrupt */
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_ROM_SMUIO,
 			SMUIO_9_0__SRCID__SMUIO_GPIO19,
 			source);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.39.2


