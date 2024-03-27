Return-Path: <linux-kernel+bounces-121771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662D88ED92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC30B2B9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA4152524;
	Wed, 27 Mar 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJLaRwV+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280E12EBEF;
	Wed, 27 Mar 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562208; cv=none; b=aWc5xVEThrHR6YEA7D2HBehsU9yiiWMvLsw+FxWn9ft65Zc/aE3empMP+xiAEjRbgEnuBEOG2UkT/MZBVo60P6sb6U26QGgyg1COJLVmg9o1A/e/GZsGA0l05gBgWgA0hioLLJe4l1bbIbJ6TRfmsSufJ+Xu1sWZyHkGa8LraQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562208; c=relaxed/simple;
	bh=pKuISH9h1n83BoSbEk6oIRQvBztb2uVAQCVjoqJHhUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7otQ+NIqLMqs4Zd24SAqFDUARbPXr1C9ImdrSIUnome0glmVym+q7jgIQyg4jBkILxO131zD20C3zD97liT9viM+yeI8uxq0YCW3CrJBpRzs6mN1AjNhVM4dLj04RsnLVRoxeW/Lx0v148yi/T3NaAvagYoRXC4iRUUtrKX6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJLaRwV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B8DC433C7;
	Wed, 27 Mar 2024 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562208;
	bh=pKuISH9h1n83BoSbEk6oIRQvBztb2uVAQCVjoqJHhUw=;
	h=From:To:Cc:Subject:Date:From;
	b=oJLaRwV+CJsu2Yrg5VZootPUJY7AFWOEkOAzEDE2SL1OA52sYTmuQOHAfLhSaqRt6
	 yusGg0Ou/c7wyIYWgoBR0mpsEeu5v7DZTINWbk1K7I6jEkagUTx4228++Eh9q6rlcS
	 YHoNiJlhcF/ukHA0WGak2jy44J5O7zCArnXPeEW2Jzf+rdzuKHS2+Twe433TrbNtzg
	 q8mYAkpcY0uT2EBAo1wtbCpr/c934Up7uVIUe6WoWgIDplJbm3j/w4JueLmA+FXTnu
	 xWWYXh6H3An2kqJIVP6QNYrwHMs9T2MYZ4Tq2VRXlCbO9IsT5oBhGg5OGUmjzZHthm
	 X3aIhw7ejkFyQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alon Levy <alevy@redhat.com>,
	Frediano Ziglio <fziglio@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
Date: Wed, 27 Mar 2024 18:55:55 +0100
Message-ID: <20240327175556.233126-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang 14 in an (essentially) defconfig loongarch64 build for next-20240326
reports [1]:

    drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
    but not used [-Werror,-Wunused-but-set-variable]

The variable is already unused in the version that got into the tree.

Thus remove the unused variable.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Given there is a loop going on here, it would be good to double-check whether
this variable was supposed to be used for something useful or if it was just a
remnant of a version previous to v1.4.

 drivers/gpu/drm/qxl/qxl_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 281edab518cd..d6ea01f3797b 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 {
 	uint32_t handle;
 	int idr_ret;
-	int count = 0;
 again:
 	idr_preload(GFP_ATOMIC);
 	spin_lock(&qdev->surf_id_idr_lock);
@@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 	handle = idr_ret;

 	if (handle >= qdev->rom->n_surfaces) {
-		count++;
 		spin_lock(&qdev->surf_id_idr_lock);
 		idr_remove(&qdev->surf_id_idr, handle);
 		spin_unlock(&qdev->surf_id_idr_lock);

base-commit: 26074e1be23143b2388cacb36166766c235feb7c
--
2.44.0

