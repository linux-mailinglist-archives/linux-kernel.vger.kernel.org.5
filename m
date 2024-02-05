Return-Path: <linux-kernel+bounces-52995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B9849F46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6181F21F76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A435884;
	Mon,  5 Feb 2024 16:09:39 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957832C92
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149379; cv=none; b=KL6Nki+ZZuxlBj4TRX6MdE32ZhnsyLgn5DdbDAZkSIkSZ2jd9Efb2Ih/FbX5NgKFkF0SJeiBlm4UecUxM8lvhVeaMqnGC+yGp2km2Vh3/Kv6rxRgJJGB5AoTA5Lec4FFjr2d88lJQYt7iD6hjns6zyBev23I3M5j+IZLvG3D1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149379; c=relaxed/simple;
	bh=wyqz9ZIh5WfUt9K06s+ZxPVmOGIUQiL/1Sv3pL9U2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDywDA1gEXmRrOfgw/CgUFaPmD/CgDI+9peA4TmCO/n0TPcaopiM/so3UA7niUN8agXtxleV1NwZkoM4foJlG8WKK+qEIbJSKLXe5SI02XQvWZxxqBi1UgrM8PfpnKOt9is1d6vXvlXqcVshYe6Ki49j6HE0jHylYDXgwqkvLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 87D0C102394;
	Mon,  5 Feb 2024 19:09:32 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 81C9C102399;
	Mon,  5 Feb 2024 19:08:42 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 415G8f2q012090;
	Mon, 5 Feb 2024 19:08:41 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH v2] drm/amd/pm: check return value of amdgpu_irq_add_id()
Date: Mon,  5 Feb 2024 19:05:24 +0300
Message-Id: <20240205160525.84638-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ac1c1709-8bb0-6713-132e-d9b149063169@ispras.ru>
References: 
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
v2: Free the source as Alexey Khoroshilov <khoroshilov@ispras.ru> suggested.
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..109df1039d5c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -647,28 +647,41 @@ int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr)
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
+		goto err;
+
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_H2L,
 			source);
+	if (ret)
+		goto err;
 
 	/* Register CTF(GPIO_19) interrupt */
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_ROM_SMUIO,
 			SMUIO_9_0__SRCID__SMUIO_GPIO19,
 			source);
+	if (ret)
+		goto err;
 
 	return 0;
+
+err:
+	kfree(source);
+
+	return ret;
 }
 
 void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size,
-- 
2.39.2


