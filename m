Return-Path: <linux-kernel+bounces-86742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C986CA11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C945F1F2384E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922677E118;
	Thu, 29 Feb 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Fi5mGeks"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF797E10B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212778; cv=none; b=f9s+7t9vgrqVF3BNVV9upQSfFnk92gSpf8hkatQrDhCF9xnL4d++urQDo0l/HabIUvS27BD/i1ukiJcQ93+/7vzMw92CMD61r1faHAerLSfQgviDH4pXIUd4PAs4MlXKC1gEX/4iAfPhTD2rrtWIsfn7V0gYjt7txb5Yh2rosaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212778; c=relaxed/simple;
	bh=dRCSejW2kzJ3xySBJGPqpUgKdSkvijfiyJXAlXGgd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Omyqni+DKawpMdehRrRPP1zdfGhKqCdgOUAK13sfEj+ZM7jQCZ6uRLRc1l7+IWQyPwP7xin+CJHLqQKUMwtO96WhkF1wCIrBuhoNzPlq8lOJeOMlqMd8AXI7XH7LwTpbmx/wBVvUm39L6AkH5i5n7HTuc6T2IPIJyrp6c4Jza5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Fi5mGeks; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id A1E991C0E74
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:10:42 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1709212242; x=
	1710076243; bh=dRCSejW2kzJ3xySBJGPqpUgKdSkvijfiyJXAlXGgd3E=; b=F
	i5mGeksyN0m1+xAorznCpcY5+pNJC12/Kf9nqXJTCyeYyEuLijZLLay/bWgtmYwz
	7KqUV9VRU5loSUNryWLmXwc4Vklo+jXc/8YmSXLfMXRUx7OQNAW16ddaA16CyT1H
	YWWFDgLNX07bpQiJqRoXUAozo0BL4QF78Spuv9Cz0Q=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2CSd_yPFfNRy for <linux-kernel@vger.kernel.org>;
	Thu, 29 Feb 2024 16:10:42 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 02F0A1C05FF;
	Thu, 29 Feb 2024 16:10:37 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Karol Herbst <kherbst@redhat.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 3/3] drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c: BUFFER_OVERFLOW
Date: Thu, 29 Feb 2024 16:10:24 +0300
Message-Id: <20240229131024.636527-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mxms_structlen function returns u16 (2 bytes).
Therefore it reads 2 bytes beyond the mxms array.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
Found by Linux Verification Center (linuxtesting.org) with SVACE.
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
index c1acfe642da3..efd0c874742e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
@@ -47,7 +47,7 @@ mxm_shadow_rom(struct nvkm_mxm *mxm, u8 version)
 	struct nvkm_bios *bios = device->bios;
 	struct nvkm_i2c *i2c = device->i2c;
 	struct nvkm_i2c_bus *bus = NULL;
-	u8 i2cidx, mxms[6], addr, size;
+	u8 i2cidx, mxms[8], addr, size;
 
 	i2cidx = mxm_ddc_map(bios, 1 /* LVDS_DDC */) & 0x0f;
 	if (i2cidx < 0x0f)
-- 
2.30.2


