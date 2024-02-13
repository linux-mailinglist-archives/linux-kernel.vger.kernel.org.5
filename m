Return-Path: <linux-kernel+bounces-63087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582C2852AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB181C21D14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941722F0A;
	Tue, 13 Feb 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Nujxj16x"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E95225AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812233; cv=none; b=VMg/tx5mujkuEyVL2K5U2St+KY16H2XpxNKQ5/YROkC3kf/8Dt+8jte4ZjfFgCEz2nqj/SjZ/ubBSKwwbVAVchjhC/3HbkIBpXh+m+RpU7xOSoTF1wS2oYUfJ/At2NcH42V1J/VnkTcp7hhhVhexgNQ98Ou9dzAxMCzkZlrsRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812233; c=relaxed/simple;
	bh=9m5KGOCuoxEboIm7ISn1H7ymbfhZyzGAdsVPUFGEUFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czYvmR5Tn7KPD2brIEvZHLr7K1I/5m6+6bZz4ffvutxYsK92b4+valITZLQpFUYzb2mzm9H/7EmunlNEdYBGjL1eq8Vy0k9uaWqsHKZVI6JlTUVEGZzKnSlcmObQ8emhz1wGJtNXmD7HEgJ5RTV2SsGjQ2kC+oAEpDXIliaWMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Nujxj16x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5678515C2;
	Tue, 13 Feb 2024 09:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707812225;
	bh=9m5KGOCuoxEboIm7ISn1H7ymbfhZyzGAdsVPUFGEUFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nujxj16x/71Mipo+7k7H6Vb52scs2D3vAx3kUESeoecn1+92JHEmcALH3XF+93qYm
	 5ygRBB6ivJ3U0qQrK0VrkyCCZ7WGYXgofo0Zn4Tu0kLwP76BQt1+lQBbJftyqLIlw9
	 H4fRLItjWH+lJE8LQgNuu6+An5CqbaGbl0fBhZFw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 13 Feb 2024 10:16:37 +0200
Subject: [PATCH 2/2] drm/tidss: Fix sync-lost issue with two displays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-tidss-fixes-v1-2-d709e8dfa505@ideasonboard.com>
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
In-Reply-To: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9m5KGOCuoxEboIm7ISn1H7ymbfhZyzGAdsVPUFGEUFs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlyyV/PKaDqj8BU7nZv3kGkUVewpGZevzHN23SW
 21DZri8+PGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZcslfwAKCRD6PaqMvJYe
 9URzEACrf0IrNFIbW2TM83jy0NHz052ksxO6HTVcgqRmRkG+cetyU72kmxhmeabSNtJ4ApQCT6L
 9RC+qRxx+as4n/sbvTGHLzQhmcwvcZQoM3H6aGJRIijiDNAjg/EMS0oYoZuVDDgrBjrr4fm7aS3
 XyK5qR8skhHz4WVi+iBXOhiWEgsXWUbyhyNxfUYFIHBvvglS0GgY6a8gBKSsWjvpN2k/+XWGkDH
 JypW3RqRa91dFbhMCDy1ButhP9eE4RUrhRI7lEAj0RUAZxXMp6bDj1cSUlPs3ZIlWMhQtgK2b/e
 vLncLDjlX4kfx00JHVHLHPenMq0yyMiz5XY5NDQdKD32af/2TLL44/V/xwRLogg6RN9jEZt8Cpn
 3ZkaDFd8xDhk58bRA327qg2e5p3OPE2ipr5PETUMZ1QnN4wI8Lsq1Rhc/O6xIUoQOJldUNycGUz
 a7CFjKUKiQ21YA5y9kJ1j6w/dBNXAsq9LzmjtO82oRz5tHxXkRn3+tcsfyqVUXp99fs/x7ICpKh
 FMi//zkTr4MYqpWJw5Th2xqA8oXI21C85c6fu/JNUEU3m07r/8ClGL625lnIkSbtMSFJXKSpxHE
 7HV9FCzJNQVIAInytwvwLgq76aj/d1wW9UtvWN4HX/4/EZtYOGVtp5BW1+QfRzIzdIkhqHyTQyA
 Bgr+FC6Vr1c+BOg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 5f838980c7a1..94f8e3178df5 100644
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
2.34.1


