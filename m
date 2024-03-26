Return-Path: <linux-kernel+bounces-119226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4D88C5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC711C6398B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1C13C8F2;
	Tue, 26 Mar 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7s4j7g+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF213C833;
	Tue, 26 Mar 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464769; cv=none; b=gG4w0WwVzHc6oscZgtIBocCgkg/qlO6SvwBzaGM/IvYW8JOUuBxFTQTmpeqe10Sutd3I44P0tPUyscLGnFZMJPoKlWI7G0wm8b6/0RFV1e4oAe+gn3ep+WkmxgbSG8Z9bm0dOyr6mMbXBP5lxE/7XEtNPUE07GRy84rWWxDsJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464769; c=relaxed/simple;
	bh=+QNmHJ+DrxUP3Ae2C2ybzUy3wAJstrkccZk3eUunkcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPA7Ldlyx4KNbmmyRoo2Hcfh7Fj+3Gcvh17DIDGqx5z451j5xmV64XaRG/sNHYBR2hsy84YCY9BVb9bOjx6xaEsNHB9M8JGgZ873nR3gKbngmM0ehRqJyY2PoA4WJZwrf1Z+kJzvX+3Tspxn5/qxeHoRzcdKTF2ojuJqwke7Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7s4j7g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7DC433F1;
	Tue, 26 Mar 2024 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464768;
	bh=+QNmHJ+DrxUP3Ae2C2ybzUy3wAJstrkccZk3eUunkcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7s4j7g+hf00jrCuUCPg5dUwHZQdGcu1Fy2VlNvtZPLtQx55NwqBTGciplojuqlTP
	 Vz7fAq8BYbpKi3Rx1Wt39zbMeeHint8AlIov3mYJnPQaBsbRLCg5oyzT93knxGzDUs
	 b62vy4vxsJRLIJx777mKK/sqiNoT+oIfTeRqIwoG4wv0//tmMCc6IKBH6UlXNGIL1r
	 kIr/jrPIPHVGUm/PP/WEH3CPp7DKTONJ5qWl8+nvgnBUCfmIjEGsaMtGpV8g7CE9GC
	 kh46CJzp83yX/NiabyiQ3Uuj8hHGMKhrtsMiJjp+pqmteinvFcpkZOuyGi8lMRbTTo
	 lD3pcAoEUjMcA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Ben Skeggs <bskeggs@redhat.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 06/12] nouveau: fix function cast warning
Date: Tue, 26 Mar 2024 15:51:31 +0100
Message-Id: <20240326145140.3257163-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
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
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
index 4bf486b57101..0dbcc23305f3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
@@ -66,11 +66,16 @@ of_init(struct nvkm_bios *bios, const char *name)
 	return ERR_PTR(-EINVAL);
 }
 
+static void of_fini(void *p)
+{
+	return kfree(p);
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


