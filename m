Return-Path: <linux-kernel+bounces-33326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693C83686A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F1E1F21A17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316A60DD3;
	Mon, 22 Jan 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orbnFPOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EA60DC5;
	Mon, 22 Jan 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935892; cv=none; b=ZbZnFwmgDXTmdZeoewsswiE9wQ8Yb+QYI8bKy5s3nviqMJz20ucNAEW693Owtpm6UMa/K4t2aEan/DHiqzOiRfkwHLznSFGrbZ7llNzOs8kBfRMJdKOhIZbh7LepTrvkr4pdVcD6nLUuKzECp1+tvIsUXQMtja8NJOC/HXgJ0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935892; c=relaxed/simple;
	bh=kEcMDVZw9umOG1L4F2Hk7oigEliQ1NG66qDiXoO2WLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ/CrxYxiu94mdgrN7UTK8qHlphhHmr7fxtu0FcNr7iQm7SsSCqAd4PNw8HeplsToCrEGsfso6VE6hiDG9eK/mldCFcTkQ+wWycdYYzz2yFpruhNq+jvnjsPM/hEvuDXtA7zZbzz1Qx3pKP1tMNFlIW9pzjUSU7thEyBV8SM/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orbnFPOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C71C433B2;
	Mon, 22 Jan 2024 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935892;
	bh=kEcMDVZw9umOG1L4F2Hk7oigEliQ1NG66qDiXoO2WLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orbnFPOoSyQuNGoWw4/bskZBFm6t6IwaCx3WWZsc+wqzdCFH/hA7VfAissuUd53xo
	 40YiN2jWY15WV09GetOrzFVZ6I1m8uxh0fvLphT54DU4ycHNwyFBBdVjG1ELqOX56g
	 Y6NgmrTwnAspw8cLQmfh56hAulmCclDMFTCtlT1dP12O+wFeUH6CEdauN9iJ6DKUFd
	 Oa792lKaYZ6JOkY+/gpkSa3uUXJRTHV6f9qByBfaXrOraxHYgqvQTzcHk4AyjL7e1H
	 2bSsV17TumfeXgFoU4BmQJUjZezVxJm7ti0fIRku7ZhkmHgFznJ7E0Anc+CuWY9Z+l
	 4KbYouPMHsRpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 09/73] drm/panel-edp: Add override_edid_mode quirk for generic edp
Date: Mon, 22 Jan 2024 10:01:23 -0500
Message-ID: <20240122150432.992458-9-sashal@kernel.org>
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

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit 9f7843b515811aea6c56527eb195b622e9c01f12 ]

Generic edp gets mode from edid. However, some panels report incorrect
mode in this way, resulting in glitches on panel. Introduce a new quirk
additional_mode to the generic edid to pick a correct hardcoded mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231117215056.1883314-2-hsinyi@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 48 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 95c8472d878a..87a69293f594 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -203,6 +203,9 @@ struct edp_panel_entry {
 
 	/** @name: Name of this panel (for printing to logs). */
 	const char *name;
+
+	/** @override_edid_mode: Override the mode obtained by edid. */
+	const struct drm_display_mode *override_edid_mode;
 };
 
 struct panel_edp {
@@ -301,6 +304,24 @@ static unsigned int panel_edp_get_display_modes(struct panel_edp *panel,
 	return num;
 }
 
+static int panel_edp_override_edid_mode(struct panel_edp *panel,
+					struct drm_connector *connector,
+					const struct drm_display_mode *override_mode)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, override_mode);
+	if (!mode) {
+		dev_err(panel->base.dev, "failed to add additional mode\n");
+		return 0;
+	}
+
+	mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
 static int panel_edp_get_non_edid_modes(struct panel_edp *panel,
 					struct drm_connector *connector)
 {
@@ -568,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 {
 	struct panel_edp *p = to_panel_edp(panel);
 	int num = 0;
+	bool has_override_edid_mode = p->detected_panel &&
+				      p->detected_panel != ERR_PTR(-EINVAL) &&
+				      p->detected_panel->override_edid_mode;
 
 	/* probe EDID if a DDC bus is available */
 	if (p->ddc) {
@@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 
 		if (!p->edid)
 			p->edid = drm_get_edid(connector, p->ddc);
-
-		if (p->edid)
-			num += drm_add_edid_modes(connector, p->edid);
+		if (p->edid) {
+			if (has_override_edid_mode) {
+				/*
+				 * override_edid_mode is specified. Use
+				 * override_edid_mode instead of from edid.
+				 */
+				num += panel_edp_override_edid_mode(p, connector,
+						p->detected_panel->override_edid_mode);
+			} else {
+				num += drm_add_edid_modes(connector, p->edid);
+			}
+		}
 
 		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
@@ -1828,6 +1861,15 @@ static const struct panel_delay delay_200_500_e200 = {
 	.delay = _delay \
 }
 
+#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
+{ \
+	.name = _name, \
+	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+					     product_id), \
+	.delay = _delay, \
+	.override_edid_mode = _mode \
+}
+
 /*
  * This table is used to figure out power sequencing delays for panels that
  * are detected by EDID. Entries here may point to entries in the
-- 
2.43.0


