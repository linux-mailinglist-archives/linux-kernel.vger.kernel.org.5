Return-Path: <linux-kernel+bounces-60811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD88509CC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F40282412
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACD5B5C5;
	Sun, 11 Feb 2024 15:06:30 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02C38DCC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663990; cv=none; b=uBduq8UBcn2Ra7m87Nl7U/X5DNUGOAVpqRS0Tolj3bjrG1r2kkuiheLbIsHX7Gdcm8Jd6nodW175ISm4Spr6ZXbM5d9IUwYLzFDsFspNmJWzmFqr62a7Hkx9HbOZbvFEXC7HrzetisaOMWjylfoQ3ZzoXnTXxjR2Kjr2OrQwQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663990; c=relaxed/simple;
	bh=Ir5CIoqwF8eijYYjiBBP67sbxpfEg7mSHXBnmcSdXBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkoCtk4cIaonP7q0H+GUktt6pnWuKvdA2fD3nZkt/pIASZidvkeHBkoZS2awKAIj48dyYQNv1lBOmVdsRBFRZBj/TKgsLawmgWLs++wccgLEQGRJHfnr7rpWI8jkPpeJp8kIWlM+ZC/puOCeBvMI3WTvSAt4uZldxS3LwwwCYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: David Airlie <airlied@linux.ie>
CC: Daniil Dulov <d.dulov@aladdin.ru>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel
 Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amdgpu/swsmu: Fix if statement in smu_baco_get_state()
Date: Sun, 11 Feb 2024 07:06:13 -0800
Message-ID: <20240211150613.3583-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

In smu_baco_get_state() smu->ppt_funcs->baco_get_state is checked for NULL.
If it is NULL then the pointer is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6c45e480fe23 ("drm/amd/powerplay: clear the swSMU code layer")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ee27970cfff9..0fadb6aacd4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2497,7 +2497,7 @@ bool smu_baco_is_support(struct smu_context *smu)
 
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state)
 {
-	if (smu->ppt_funcs->baco_get_state)
+	if (!smu->ppt_funcs->baco_get_state)
 		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
-- 
2.25.1


