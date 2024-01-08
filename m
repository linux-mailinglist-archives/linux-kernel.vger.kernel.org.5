Return-Path: <linux-kernel+bounces-19508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320E826E08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2709AB224FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF140C11;
	Mon,  8 Jan 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy9/q2L4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584840C05;
	Mon,  8 Jan 2024 12:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4795C433C8;
	Mon,  8 Jan 2024 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716925;
	bh=tij3zoxBMK+MBVN+7nMEI60sbQV6NDv5rjGx+xkKnhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy9/q2L4G1iTSF7sVMeTCQKGdE0wdl07eYAO/TOZd5wqxSHzDlj56ljqesaafP56j
	 Wf6SwNRtFHoiYMjoKRi3sDzCzLCIAM3+kOmvb2buGZJfQaWKSDC60FwECR9HHMhTGQ
	 dT3bgGYhFxzMvvk1X1S4JE9Nk/xqk/tZ5O2OJMOcgkFzdIlys5SfbuHSSHJbuThGiX
	 uzGZ0CW70eRvxUeCVJRvmh80w9Gapp4Ww7wY30SPf8XyGioVe9vQMpRot90oFZUhCe
	 t1iXL+ZpO1+yEX/voQDbsyokCtlthBDXiFQh5G/UzU5NSHt61brQ1077hL40ljS0OW
	 OtC0wzEhJksfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@gmail.com>,
	Dave Airlie <airlied@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	daniel@ffwll.ch,
	bskeggs@redhat.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 5/5] nouveau: fix disp disabling with GSP
Date: Mon,  8 Jan 2024 07:28:16 -0500
Message-ID: <20240108122823.2090312-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122823.2090312-1-sashal@kernel.org>
References: <20240108122823.2090312-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.71
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@gmail.com>

[ Upstream commit 7854ea0e408d7f2e8faaada1773f3ddf9cb538f5 ]

This func ptr here is normally static allocation, but gsp r535
uses a dynamic pointer, so we need to handle that better.

This fixes a crash with GSP when you use config=disp=0 to avoid
disp problems.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222043308.3090089-4-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
index 65c99d948b686..ae47eabd5d0bd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
@@ -359,7 +359,7 @@ nvkm_disp_oneinit(struct nvkm_engine *engine)
 	if (ret)
 		return ret;
 
-	if (disp->func->oneinit) {
+	if (disp->func && disp->func->oneinit) {
 		ret = disp->func->oneinit(disp);
 		if (ret)
 			return ret;
@@ -461,8 +461,10 @@ nvkm_disp_new_(const struct nvkm_disp_func *func, struct nvkm_device *device,
 	spin_lock_init(&disp->client.lock);
 
 	ret = nvkm_engine_ctor(&nvkm_disp, device, type, inst, true, &disp->engine);
-	if (ret)
+	if (ret) {
+		disp->func = NULL;
 		return ret;
+	}
 
 	if (func->super) {
 		disp->super.wq = create_singlethread_workqueue("nvkm-disp");
-- 
2.43.0


