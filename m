Return-Path: <linux-kernel+bounces-29090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8C830853
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67C51F2529E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ABE208CA;
	Wed, 17 Jan 2024 14:44:54 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5C208B0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502694; cv=none; b=CGuGoGZSzk078jYUn5uaNIYe3oQZ5EHwQTQRg91L/UAr7XPoebSAxLCJdEuX4s9deLAfzui+exJSVTolB7E4OyPXpnS+3tA87SuIh+BjqXlByOtKcfK3pPdC1/2z6nCzSZRfeu1qOxPePVHWqaroRSuwngS2pr6p5vsMlbVfmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502694; c=relaxed/simple;
	bh=Q6lvD0eHMTY+UT6LhoSiXbVdelB/wpceNmG16NLyWkA=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy; b=treWmRit0/ePnHyQfQYtcs/iuCEUnxDSX+2rvQPtC4Zj4VJlvf6WwUZxXu7EUNl/Ozw3/RwlPJIUSnhkV0umEg20KVcXP/d29zW+xucoDTaP6+7syKq5UZMUSDtWQzLmmTvegR/IwXtxQgA6E2Kec2y51/pLPW7mXaBLSLYM3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 17 Jan
 2024 17:44:39 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 17 Jan
 2024 17:44:39 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/radeon: remove dead code in ni_mc_load_microcode()
Date: Wed, 17 Jan 2024 06:44:36 -0800
Message-ID: <20240117144436.10930-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Inside the if block with (running == 0), the checks for 'running'
possibly being non-zero are redundant. Remove them altogether.

This change is similar to the one authored by Heinrich Schuchardt
<xypron.glpk@gmx.de> in commit
ddbbd3be9679 ("drm/radeon: remove dead code, si_mc_load_microcode (v2)")

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool Svace.

Fixes: 0af62b016804 ("drm/radeon/kms: add ucode loader for NI")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/ni.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 927e5f42e97d..8eac8c090433 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -624,7 +624,7 @@ static const u32 cayman_io_mc_regs[BTC_IO_MC_REGS_SIZE][2] = {
 int ni_mc_load_microcode(struct radeon_device *rdev)
 {
 	const __be32 *fw_data;
-	u32 mem_type, running, blackout = 0;
+	u32 mem_type, running;
 	u32 *io_mc_regs;
 	int i, ucode_size, regs_size;
 
@@ -659,11 +659,6 @@ int ni_mc_load_microcode(struct radeon_device *rdev)
 	running = RREG32(MC_SEQ_SUP_CNTL) & RUN_MASK;
 
 	if ((mem_type == MC_SEQ_MISC0_GDDR5_VALUE) && (running == 0)) {
-		if (running) {
-			blackout = RREG32(MC_SHARED_BLACKOUT_CNTL);
-			WREG32(MC_SHARED_BLACKOUT_CNTL, 1);
-		}
-
 		/* reset the engine and set to writable */
 		WREG32(MC_SEQ_SUP_CNTL, 0x00000008);
 		WREG32(MC_SEQ_SUP_CNTL, 0x00000010);
@@ -689,9 +684,6 @@ int ni_mc_load_microcode(struct radeon_device *rdev)
 				break;
 			udelay(1);
 		}
-
-		if (running)
-			WREG32(MC_SHARED_BLACKOUT_CNTL, blackout);
 	}
 
 	return 0;

