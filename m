Return-Path: <linux-kernel+bounces-125972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DACB892EC2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1EC1C20C05
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B636FD5;
	Sun, 31 Mar 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="k0FTnHnY"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339A79CF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867577; cv=none; b=botBRkid5ZZ+Cvn/ZfdR283S+2FFpqCE6OEKksJe7L7DYXJeB2coZSZ7EuGUEd1y5v7UEc6yjgmVKUDFXuhdKWfdPyJ/biZLMcnPsGi16GnjdNQXiwCmELb1OK22m11+Cgj/QhIy0048YfZYNt/LQT1m9xBLnJm24Kcyzxow2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867577; c=relaxed/simple;
	bh=YBKGUG6xwLwd/efnk+1ZzvtR165fqMeCotqx2Uv9AM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5I2lJ8Kf07q+6+oj3uBtPtf5b0Thjls8tBg176d/alSNV3hmmrjr9pKZJyAFz7fK3DxzxN9jLR0Ur+nNOGfBLK8SSAFJqK4YQoEsKoC+1dC5+f2p9DKKwwP2VuL0QMGAkHENn8mQsIVWPdiuA82zycnVeMenaXXncud6VK4wjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=k0FTnHnY; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [46.138.86.221])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5F9F140755D8;
	Sun, 31 Mar 2024 06:46:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5F9F140755D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711867563;
	bh=Um1OeF+YjMXHeUez/kZLspj1wOkVZEI9a9MFeGLZNZo=;
	h=From:To:Cc:Subject:Date:From;
	b=k0FTnHnYTdvZURFzBOOYPMVCPYR5A2omqFTQlaRaFzwnHARsJT5Fj5QwrdRktR9J4
	 jfced4TYeae7QRKyV7KkJAxZ6BKdeu6N9q/CkaJifFd002w0QdMN212n6YwWnY9sMl
	 MUPYvIcBMG5fcxw/67QvuSkNbhV2WhInMT96d9dI=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Karol Herbst <kherbst@redhat.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	Francisco Jerez <currojerez@riseup.net>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] drm: nv04: Add check to avoid out of bounds access
Date: Sun, 31 Mar 2024 09:45:51 +0300
Message-ID: <20240331064552.6112-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Output Resource (dcb->or) value is not guaranteed to be non-zero (i.e.
in drivers/gpu/drm/nouveau/nouveau_bios.c, in 'fabricate_dcb_encoder_table()'
'dcb->or' is assigned value '0' in call to 'fabricate_dcb_output()').

Add check to validate 'dcb->or' before it's used.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for iMac G4")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c b/drivers/gpu/drm/nouveau/dispnv04/dac.c
index d6b8e0cce2ac..0c8d4fc95ff3 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
@@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder *encoder, bool enable)
 	struct drm_device *dev = encoder->dev;
 	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
 
-	if (nv_gf4_disp_arch(dev)) {
+	if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
 		uint32_t *dac_users = &nv04_display(dev)->dac_users[ffs(dcb->or) - 1];
 		int dacclk_off = NV_PRAMDAC_DACCLK + nv04_dac_output_offset(encoder);
 		uint32_t dacclk = NVReadRAMDAC(dev, 0, dacclk_off);
@@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder *encoder)
 	struct drm_device *dev = encoder->dev;
 	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
 
-	return nv_gf4_disp_arch(encoder->dev) &&
+	return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
 		(nv04_display(dev)->dac_users[ffs(dcb->or) - 1] & ~(1 << dcb->index));
 }
 
-- 
2.44.0


