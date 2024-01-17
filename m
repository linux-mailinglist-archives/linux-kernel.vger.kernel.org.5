Return-Path: <linux-kernel+bounces-29091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B2830856
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DF01C20A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42116208D0;
	Wed, 17 Jan 2024 14:45:24 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4B13FFF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502723; cv=none; b=J1rzQc3Rp9+SEY9y6WWekVhx/rT5So91gIAzpFSn4TB3SeicNm0yoZ9gIBU1lFDNps2Bn4XBJsP4kXoGB6j0+5juoMCYn/OhqTI4Ywbl9jhjK9sXiVwGuNAhKXF8r2wlI+CxRyUcMerZyZRFz7zvTB28zKjZ7fCNo5Q3JF/MEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502723; c=relaxed/simple;
	bh=pVtzEC06dXxKFlIy01Eu9vNzdWCG7elETsLk71Q3Otk=;
	h=Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy; b=t9KxAWI5w0H4GxDa5Zjm0fmpGTLqTB7+HN/fXeAzSWYk1EduCQXICEKUAyUXYIzTJHOOWhCWMMU8ve9tQKItXnC2B5PoB0R1o3ch9bzSKZW66Q5yKYlsO7peVC8PzMIkFHG2BPR6qd+Qu7E/9jWALg0XrrS8sD1qpa1/agAi9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 17 Jan
 2024 17:45:18 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 17 Jan
 2024 17:45:18 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/radeon/ni_dpm: remove redundant NULL check
Date: Wed, 17 Jan 2024 06:45:14 -0800
Message-ID: <20240117144514.11007-1-n.zhandarovich@fintech.ru>
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

'leakage_table' will always be successfully initialized as a pointer
to '&rdev->pm.dpm.dyn_state.cac_leakage_table'.

Remove unnecessary check if only to silence static checkers.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool Svace.

Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/ni_dpm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index 3e1c1a392fb7..e08559c44a5c 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -3103,9 +3103,6 @@ static int ni_init_simplified_leakage_table(struct radeon_device *rdev,
 	u32 smc_leakage, max_leakage = 0;
 	u32 scaling_factor;
 
-	if (!leakage_table)
-		return -EINVAL;
-
 	table_size = leakage_table->count;
 
 	if (eg_pi->vddc_voltage_table.count != table_size)

