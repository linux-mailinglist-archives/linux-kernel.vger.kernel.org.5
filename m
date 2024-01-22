Return-Path: <linux-kernel+bounces-33339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FE83688E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E9BB283DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609806310C;
	Mon, 22 Jan 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2/MRnur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463662A1B;
	Mon, 22 Jan 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935929; cv=none; b=NeHIe7BPKenggmsgTJYFbTB6HRNEn2Eor9yAJ1L18xUrZprzvF33IF4pvJdda981YZy3gn6ztfDnyNCtruy1PH8CRXa/ccuu0kaAqrndA7FNx2sFQP4bjE6yinMbw11/6mLKyjY1gj+BERVh7u8Guim8JyCoL3/tlRk6ORMK3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935929; c=relaxed/simple;
	bh=OkoXahxCKZCtQw7rAgmq4F3hbTF2k3GCf2mjwrnPQT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca31U/ItoEFxURCUg9dinyfWK8fwTFb7ttkob6X4usrbyVdbX+LBKOa4BVXNyHJW8h5rxF/PU+jYMMQRdbmbaQzFv7ILJ+Teqwj1zwJ4sd91O/ihFW8v+Ue5tjNO0yxOU2j0X9VML8gR0cEriEyrXUCLVuSKpJq3Ud+sjHZGDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2/MRnur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B71BC43399;
	Mon, 22 Jan 2024 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935929;
	bh=OkoXahxCKZCtQw7rAgmq4F3hbTF2k3GCf2mjwrnPQT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2/MRnuryFXlAdc/2OuRSmRwEOwQGF54qZWkO1pxCNa0AhLUSaCc3aEO9QM2VNsFJ
	 /y54oPQNGzL6MqiecdytFY2Bld+7JoNezdHOISo8LIlowNJ/l9oQgcEYyfV14DK9FW
	 JATVZBTkFx9RKD0dY9ZgE05G4UIhTr9efpolSCDOCG5S/EN2f9sOKt58f/W28fE/q7
	 UOCPivZb4ISZPeatg/MCEQNuHB8fNb1Un6EGbhsj/xzANbT/iPXL+rJqf1npAiFpwX
	 opnuPBq0p2l7q8IJnJtfiQhfnId/+bf2ocaWN7kp9YyQqSpq2f1tyi48UFZkCycJDb
	 HwWO+DBvP99fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 18/73] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:01:32 -0500
Message-ID: <20240122150432.992458-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 1d3062fad9c7313fff9970a88e0538a24480ffb8 ]

smatch reports:

drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.

'supported_status' is only set in one code path. I'm not familiar with
the code to say if that path will always be ran in real life, but
whether that is the case or not, I think it is good to initialize
'supported_status' to 0 to silence the warning (and possibly fix a bug).

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-1-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index e692770ef6d3..a7799086017a 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -958,7 +958,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_gem_object *obj;
 	struct drm_memory_stats status = {};
-	enum drm_gem_object_status supported_status;
+	enum drm_gem_object_status supported_status = 0;
 	int id;
 
 	spin_lock(&file->table_lock);
-- 
2.43.0


