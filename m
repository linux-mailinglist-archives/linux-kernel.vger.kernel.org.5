Return-Path: <linux-kernel+bounces-113366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592568883C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132A1282C40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B46EB56;
	Sun, 24 Mar 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfsHZz+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0F19D1C7;
	Sun, 24 Mar 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320168; cv=none; b=H3D9lhdsbLi/U/UyB6yVYVa2qo1UcdoKD1V7qgMkcljRyhBayLEWZe0Zyfci63D3UEm6NTBbofKABOW68r8Z4dFA99YrAhLlpoDVWnbBFjZzxfjjokp9YjiYBBlrv9EaGep4VgwlYMrpIKhMNLIlOec+tGHr6lYqtgQm1nU3Bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320168; c=relaxed/simple;
	bh=8QWRa1+vjMcnTr35RblFxDEGqdPXm8uDkirWh1Tav+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/2Qg0GzD7A2E7eKGb2FXnA1aWJ4nqehzaCfpSwrCNbbD/Veu8TN/jUWKtB0BlbIe78FOH5SMcsymT4Hr563w6q3peJibBwiXsbCLRMQEDCACK6FRUEQ8Bmif9RspFAWBAuT9VN9U0T6RIqjYhYZnkyr0TFzzmEfjXuya3jc7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfsHZz+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00276C433C7;
	Sun, 24 Mar 2024 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320167;
	bh=8QWRa1+vjMcnTr35RblFxDEGqdPXm8uDkirWh1Tav+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfsHZz+HJILrl9yRz9wjkSY/u9qO8SWbCOqLHusRTI31sLP2ua7Crr1bMnbO3T1IK
	 XdEaqrScpW13OmyEA/lD5E2+/9eigd4HP/14lLa9b0TfDIGlKqw2YAX1T1V8qS+P+f
	 ckExO6dg6DMkSniTVESvILfRtA0zEv59AE8nOb44RN24I4F1Hm8gMjw4DtjwcBcDMq
	 IQVZH+HUiztD+oPW0nSMcLQGHDXCISzfn5BIEXv+nZqgPFi/ghXF4tbzHK9FLA+rpY
	 1CGohahjtVvF5zbM5JDwtuBSmwCh2vsx+j/3un5Qwy9/q+xH+C4W+0eSoHNnPC+VUg
	 anETYYjLtYrHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 475/715] drm/tidss: Fix sync-lost issue with two displays
Date: Sun, 24 Mar 2024 18:30:54 -0400
Message-ID: <20240324223455.1342824-476-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 5f838980c7a11..94f8e3178df58 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -265,6 +265,16 @@ static void tidss_crtc_atomic_disable(struct drm_crtc *crtc,
 
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


