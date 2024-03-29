Return-Path: <linux-kernel+bounces-124887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C75891D75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9033D2840E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615621EB77;
	Fri, 29 Mar 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCKpqXMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF814AD30;
	Fri, 29 Mar 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716370; cv=none; b=nrxzy0Rl3XQnBTyToHXNDYCADRYVdhcoz8OisgqcfRxJ5hqr7lGdK6RMY+5FNAYZEv39lep1egP0EFEFswwzTVofjiw8mqGqGvtJfP00tAcNRZBxn8VSG8DeruGDCN4BIGx+pB/NlBqdr6fbiBuzKHmdbEbSh7/O5CvKNqv5hS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716370; c=relaxed/simple;
	bh=unAcMRuAE1vIWssF2K6cGs00MZFhLexNVVz7+k7K4PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSkF894yEggUvoonvLY80bQ5KeuSqj1J/yrV5D8r++6Wlq6Z2JZlMu6h1EC3aewpRbqqPEUyZgfbONoid8WqZVNvgFuEdxI39nf+1JMUP9WyaqOHCVgS9UXx89467hfl1a8K63PyCx7V0r/jbwpPk8up826hFJR3I7jalXs8tpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCKpqXMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C1C43390;
	Fri, 29 Mar 2024 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716370;
	bh=unAcMRuAE1vIWssF2K6cGs00MZFhLexNVVz7+k7K4PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCKpqXMGpu4fPQQKpbINyHs/dv7JK8FKorN6YRbCzWdpcsxEQopWYBhA6zu1TV8ab
	 fIZuMPbEzjnT15TdRKr+LhqxpY1ORcqKolxJS19Zudbn5L8/Xzl82awiR/BF0IIqos
	 pTdhhAHoasqGVJvPn6cJBmyJGt8IfFSlYzABNvgqK41E3h0qmhJEV4cW0/5gO6w3h8
	 GPbARRbt9+oetvLTu8Vyv8CqhEsJVo4dEUFtY9vqBjOnTcuo9cCMyZqlxKSXx0/dfe
	 B3+vNoffYeFhu6NAJCkZ/qExESXklnvAVPydQOs+6+b/vfQV0k16co0pI1huX81J6t
	 9O8nR20iQJhTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 03/52] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
Date: Fri, 29 Mar 2024 08:44:57 -0400
Message-ID: <20240329124605.3091273-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Samuel Dionne-Riel <samuel@dionne-riel.com>

[ Upstream commit 2f862fdc0fd802e728b6ca96bc78ec3f01bf161e ]

This adds a DMI orientation quirk for the GPD Win Mini panel.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222030149.3740815-2-samuel@dionne-riel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c15292ae937..3fe5e6439c401 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -117,6 +117,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
+	.width = 1080,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -279,6 +285,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* GPD Win Mini */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = (void *)&lcd1080x1920_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.43.0


