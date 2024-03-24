Return-Path: <linux-kernel+bounces-113875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9888870D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E2829031A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA4152526;
	Sun, 24 Mar 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as2MUAwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D914885B;
	Sun, 24 Mar 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320927; cv=none; b=HTk26Hm+HO1SSSYlUnMxhv9iY8UNKBnkA/TLBIw0TcfccSxfhuLR1Q7QUDySdS+hcFyhqSFw9gi33gl7gAP5dTAD6GJk2I3kDTMShKMM6X18Uq8x0Da6U7W/DA8fyLTpk3PTL3PdH9CSSZ4HnbuRlO4yXmGfXH9PHoIrc2YEfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320927; c=relaxed/simple;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGWNC6eGxJ32r5KrV8L2ckGEMJncy5ustYd663y3YynN3MGr1X/h2hmHPvwKsUPPcz72MUX8Dw8z5ok3514QIzsAZaHZJbnw/1eem3UhT/PP5tvgFM2UaxXqsKU0JmOWClWmh1r+hhLHg3xuz2PzyVpc9KEVYB1uWLuRgld+c/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as2MUAwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D1BC433F1;
	Sun, 24 Mar 2024 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320926;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as2MUAwVzLZn2bLc0AcIUgCT3sihdzF/sPyLqVQ3n3JvWlqiCc/+V4jDjaEmp/02f
	 jHQeXCGKxpMsGP1ZVMzrKK+cwbEKmdLe0pvP28fijzKXpJCajNRPuG28RjvXiXfL0l
	 GbWcBIQGgKuCGM+fhu0wTecHfEklCYVtjZJ8mK1uqLChnGOX4eW9QeqZihhM0JEtMD
	 rZN/apYAvkMupRNr7CI+Pz/v/UtAm9QU0Hse2OD2XylvKJOu7qgsAAXlaHW+nXAtSG
	 kvHCJ26RNB98Fzj4JFXP001jRr8aQavh/z/OKH6bn2gTXOeRAMopH5NtjlTLcARMwL
	 TQKOSHxp8aHGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 490/713] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 18:43:36 -0400
Message-ID: <20240324224720.1345309-491-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 32e5a120a5105bce01561978ee55aee8e40ac0dc ]

Inside tegra_fb_create(), drm_gem_object_lookup() increments ref count of
the found object. But if the following size check fails then the last
found object's ref count should be put there as the unreferencing loop
can't detect this situation.

Found by Linux Verification Center (linuxtesting.org).

Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231215093356.12067-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index a719af1dc9a57..46170753699dc 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -159,6 +159,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


