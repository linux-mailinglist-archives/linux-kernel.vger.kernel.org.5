Return-Path: <linux-kernel+bounces-131781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF2898BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DA51F2208C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014312AAE0;
	Thu,  4 Apr 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgFs24i1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1612A16E;
	Thu,  4 Apr 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246563; cv=none; b=k5rmHsnVYXbyjg1WTudxWVucRfy22zxnmkFGXDVhy0R++QgQIWov7tQb9gacW70U/MFzFWr+2N79+reXcEPjPnOkv+5QHR+5i3/N2P3cwtsDlt0ITIIzVJE5jQPqcagyHNGguP+xI3gX/NA/9AEbP3kV7XMfz2SM4JpsC2NQpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246563; c=relaxed/simple;
	bh=S4vqLtLutHujkNQz1zATc4vO4U4vMe9CCrbAwlFtjfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GBxocxOKiU1t9v5pnkCGs+vVYWpZn/7+2b+soF0L+jaw+GMDMFk9RTlxSFBn+pGWbMc0QmVCes62F1aNEoB+PcAMv520JPwJlNU5KPvi2/uRx++39MvqH2d3OBme9X37aElRYovBa0i4uWARP6pzrH66GHsJQc9jFx0igHu3kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgFs24i1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32065C433F1;
	Thu,  4 Apr 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246561;
	bh=S4vqLtLutHujkNQz1zATc4vO4U4vMe9CCrbAwlFtjfc=;
	h=From:To:Cc:Subject:Date:From;
	b=NgFs24i1FPcjYF68S5NJ9C21Ke4TUmFGvAX1/+vC0iO+QYM2cVVBwdW4/gC9ga5iz
	 1EbkSBzsz4FJ4HIl4B8dFru62IQQ3rvRVS8aQo/SLwv6JVC7xaKo4JthyK1frNi5/r
	 KoaUO2F9tnFat+D80UoCAg/6V3s246/rM2qv5igXMCHl+uY+/xmMGlzTNMkkhg/bxw
	 doNgsU5apn6jndjpCWURmP0DkVT1Xhhej75+baqkyQIRZfybxkKzb4Vjl4NI16w3IY
	 N7r/pyXWblz3wwCyx3PruJVus+rxyQTtD6aG8W5EPMSkANhaotH8R7HFaCL1v/IjjE
	 eG7H1tVDs8z6g==
From: Arnd Bergmann <arnd@kernel.org>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [v2] nouveau: fix function cast warning
Date: Thu,  4 Apr 2024 18:02:25 +0200
Message-Id: <20240404160234.2923554-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling a function through an incompatible pointer type causes breaks
kcfi, so clang warns about the assignment:

drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c:73:10: error: cast from 'void (*)(const void *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   73 |         .fini = (void(*)(void *))kfree,

Avoid this with a trivial wrapper.

Fixes: c39f472e9f14 ("drm/nouveau: remove symlinks, move core/ to nvkm/ (no code changes)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: avoid 'return kfree()' expression returning a void
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
index 4bf486b57101..cb05f7f48a98 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
@@ -66,11 +66,16 @@ of_init(struct nvkm_bios *bios, const char *name)
 	return ERR_PTR(-EINVAL);
 }
 
+static void of_fini(void *p)
+{
+	kfree(p);
+}
+
 const struct nvbios_source
 nvbios_of = {
 	.name = "OpenFirmware",
 	.init = of_init,
-	.fini = (void(*)(void *))kfree,
+	.fini = of_fini,
 	.read = of_read,
 	.size = of_size,
 	.rw = false,
-- 
2.39.2


