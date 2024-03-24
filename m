Return-Path: <linux-kernel+bounces-115504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B3889BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DB41F3159E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E642365A2;
	Mon, 25 Mar 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMbuhpnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976F1EC62E;
	Sun, 24 Mar 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320944; cv=none; b=rYTK6cKtQUS742cIYpsOZfSd7hWJ8ndIZvLXBoA/kZE2e8DEIoaswrpRRLLElBW1mlany9poBBNYbtF1WmIeyJDCH/g8oXbvm5GZaGXBH4CbuDU9ZUkqidU2XclOGcMH20iIv1j+Y52vTkRMw+/6AV5/9ORqigWFypcxIFW4aQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320944; c=relaxed/simple;
	bh=R0o9mtiY+b9wcMRZccfj/l4j7rw/QnFthxmzKd6U52Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jcq8NG4kRFxDTkdO1IElCPLhWbm7bLq4qgLPYReuhcyy6H22q+iWxrm8O1D2ECwPf2KwdxtFCbZG0gxxS3HuRiBsfu1Zmyzq0naAHzDEKFR5eZ9tO1YHuDS2n66XQ1M1l5oDRYq4hw2XI3jCZFSFQvIZPEwyMeoZzoEyfo4Dod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMbuhpnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B8C43394;
	Sun, 24 Mar 2024 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320943;
	bh=R0o9mtiY+b9wcMRZccfj/l4j7rw/QnFthxmzKd6U52Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMbuhpnf/CDWGWhcdXwaN2ppQ/eujmnzhi8IzMMJMe+71rFRpCA35zCQsyjqk6zZt
	 JxTbUlAkOo7XwFDymcJhwneEgEkcksUrxJRYI4myn2rhBVTTNTC140Wi50pvRkFByV
	 nXvQExkHIIM3ZkCHzQ+pReUdUDvVl/iU1VCzzo45260458tZm9ShxZipWkkVBE2COT
	 aZt4EvuIBK2zhop3BQsdYxo0JeEV1BccXoDKR5byMchgT1a8LiI48bFBw/LiV0N9Vz
	 a9oNd4pZSDPfiXuGKS++C8CYv0HNl2xN0WpZkLOUc+fiwp+Ex4iCXto67ZRK3AChRe
	 9tT6cYvaWR4zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 506/713] drm/tidss: Fix sync-lost issue with two displays
Date: Sun, 24 Mar 2024 18:43:52 -0400
Message-ID: <20240324224720.1345309-507-sashal@kernel.org>
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
index 7c78c074e3a2e..1baa4ace12e15 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -269,6 +269,16 @@ static void tidss_crtc_atomic_disable(struct drm_crtc *crtc,
 
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


