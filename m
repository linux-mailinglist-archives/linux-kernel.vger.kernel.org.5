Return-Path: <linux-kernel+bounces-63286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4962852D43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CEA286E76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B2B224E6;
	Tue, 13 Feb 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD68QcUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07D224C6;
	Tue, 13 Feb 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818279; cv=none; b=rTx9pxTsNXN+OtZ/lAvYx7rKmmj8hmtVilO7XvL8FkuqM0ctvGKE/arNaFcRkKbETSnyFV/P+EcP2kDVF2Jmex5H3I3d1C46kOK/PaFvKH4qPrFY8AaeofIbIi+fcb1Th4maVSvYXsyoPwaNZ3PSZm+sw3MRZ3zaklwYylmqv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818279; c=relaxed/simple;
	bh=Glcc2MGW7elmBxt2g9iRaVB3TCJHQ7FpBrYtJp1jN/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meD8I7EQcGs4CGAEcYFJy0reMw1mPI9NX8UHrVt6r/KGep/dpDesYmFRty2I+X/Wjg7T5ijLA2yO70Lge8bpYUeCvSuTHem8LyVO00Bs2MQDSL20cZuxlGf3VVyT5WTPLhQju5YH6cIjnQkTrsIj3kXPUy22svRgae/msKwRW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD68QcUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E178C433F1;
	Tue, 13 Feb 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818279;
	bh=Glcc2MGW7elmBxt2g9iRaVB3TCJHQ7FpBrYtJp1jN/s=;
	h=From:To:Cc:Subject:Date:From;
	b=ZD68QcUv2ZwGhDjFT+aX2PpfQ0DNORu4GNAQoEqkZcUP5+/AKgE8mLG6d5P+Ala/2
	 JgsEzVcOHxTLoiZS/JJa0v+ed59naCZ+hJgCDf/8QvC+C8+QfIXm+SnV1ol1EfdYgU
	 69ueNLZZTxa9OsqmWkri/TRLM7yaydQIeYZDTIMQqGfqV+XiCEQo3nf3oJaYUvwT6D
	 hx92u6Dd/yAG6nP2/dJ5Je9ptkKV4AGtYYCyxqNzOYkLgZReLTChxkUMtJ4dSIszum
	 kUZ0r1tK7DZoezWKznY/o55nG1ArKoFbSH/fWYOxK/rliNgBuPgNX/ech4pFC6lb1Q
	 APD1uBMpOdQmw==
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
Subject: [PATCH] nouveau: fix function cast warnings
Date: Tue, 13 Feb 2024 10:57:37 +0100
Message-Id: <20240213095753.455062-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about casting between incompatible function types:

drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c:161:10: error: cast from 'void (*)(const struct firmware *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  161 |         .fini = (void(*)(void *))release_firmware,

This one was done to use the generic shadow_fw_release() function as a
callback for struct nvbios_source. Change it to use the same prototype
as the other five instances, with a trivial helper function that actually
calls release_firmware.

Fixes: 70c0f263cc2e ("drm/nouveau/bios: pull in basic vbios subdev, more to come later")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
index 19188683c8fc..8c2bf1c16f2a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
@@ -154,11 +154,17 @@ shadow_fw_init(struct nvkm_bios *bios, const char *name)
 	return (void *)fw;
 }
 
+static void
+shadow_fw_release(void *fw)
+{
+	release_firmware(fw);
+}
+
 static const struct nvbios_source
 shadow_fw = {
 	.name = "firmware",
 	.init = shadow_fw_init,
-	.fini = (void(*)(void *))release_firmware,
+	.fini = shadow_fw_release,
 	.read = shadow_fw_read,
 	.rw = false,
 };
-- 
2.39.2


