Return-Path: <linux-kernel+bounces-114584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E3889074
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4627C291B57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A129BEEB;
	Sun, 24 Mar 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1qaoKdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1D1FDB20;
	Sun, 24 Mar 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322236; cv=none; b=fNVhd8P+ZUBHYwstabBC/QHNgLibY8P+KY4WcHBh1sHVDbLtfObJnOgEpUiOLrwnjfc+y8JbgGDOL5mwrTgO+pHXmj16ihb2DN6WQjPwZh+WOL3zUAIZ9wUkc3vosO9zHFt3DcJ+yHwjd1BkfYrSSw1bA57lJUbHyklU91yRqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322236; c=relaxed/simple;
	bh=Gy1sz4Eze5808M416wNc584UKti/F2FjtjnCgy11LHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjRMr5ujZfDiNwqV5F1KFftp72D5oVLBnZYv8vYZ/IF1mT6bVJG0HEuknA6LPo8muSVVhmHiyGt6TPJIeghx6wCZyAwHkmKDd1NnXaGBexCilV1m7n0OD6obSlKLyjZxbzTPuoqbu09kMyShnTU6imAdCMRHDoqo9/EVOr6Xkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1qaoKdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2448C43394;
	Sun, 24 Mar 2024 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322235;
	bh=Gy1sz4Eze5808M416wNc584UKti/F2FjtjnCgy11LHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1qaoKdUMmdYJEUw0Dcf2GTSb7BUoIjnFx+1U+ZQIByt+4s3TIYaUFcM5a+Dt4eHW
	 Wc5Vkx9oWMQhz3afzygWF7edjxPnUmjtEwKW2Ptw0TJ78NXInxfKkgfe/frz+sFAJ+
	 aRmF0UDUAcDGaLZI70+vx0Oi7pN3Hwi2HkpUT8bEkxUU5LhZEx2j4hXeu+/Gcw0Jyn
	 i3Z8k+D8tvQj+3a7iJoR6s/RBDrinT6jttY8pEEec2RGMdCVTABT+01kXRdLUuTQy/
	 ItQXscPFpbIGzvUMoBlPKGQYvSG8A383jOYeRTTm980MtRQd65DyVKSDLzSAQgNezY
	 WFH4Gt1M13kUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 316/451] drm/tidss: Fix sync-lost issue with two displays
Date: Sun, 24 Mar 2024 19:09:52 -0400
Message-ID: <20240324231207.1351418-317-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit c079e2e113f2ec2803ba859bbb442a6ab82c96bd ]

A sync lost issue can be observed with two displays, when moving a plane
from one disabled display to an another disabled display, and then
enabling the display to which the plane was moved to. The exact
requirements for this to trigger are not clear.

It looks like the issue is that the layers are left enabled in the first
display's OVR registers. Even if the corresponding VP is disabled, it
still causes an issue, as if the disabled VP and its OVR would still be
in use, leading to the same VID being used by two OVRs. However, this is
just speculation based on testing the DSS behavior.

Experimentation shows that as a workaround, we can disable all the
layers in the OVR when disabling a VP. There should be no downside to
this, as the OVR is anyway effectively disabled if its VP is disabled,
and it seems to solve the sync lost issue.

However, there may be a bigger issue in play here, related to J721e
erratum i2097 ("DSS: Disabling a Layer Connected to Overlay May Result
in Synclost During the Next Frame"). Experimentation also shows that the
OVR's CHANNELIN field has similar issue. So we may need to revisit this
when we find out more about the core issue.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240213-tidss-fixes-v1-2-d709e8dfa505@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index cb66a425dd200..896a77853ebc5 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -270,6 +270,16 @@ static void tidss_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	reinit_completion(&tcrtc->framedone_completion);
 
+	/*
+	 * If a layer is left enabled when the videoport is disabled, and the
+	 * vid pipeline that was used for the layer is taken into use on
+	 * another videoport, the DSS will report sync lost issues. Disable all
+	 * the layers here as a work-around.
+	 */
+	for (u32 layer = 0; layer < tidss->feat->num_planes; layer++)
+		dispc_ovr_enable_layer(tidss->dispc, tcrtc->hw_videoport, layer,
+				       false);
+
 	dispc_vp_disable(tidss->dispc, tcrtc->hw_videoport);
 
 	if (!wait_for_completion_timeout(&tcrtc->framedone_completion,
-- 
2.43.0


