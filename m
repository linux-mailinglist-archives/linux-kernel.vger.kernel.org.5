Return-Path: <linux-kernel+bounces-77114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A774686015E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5801D2829C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8814EFDF;
	Thu, 22 Feb 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmup7ZtY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8B14EFC6;
	Thu, 22 Feb 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625763; cv=none; b=DqyQzVmeWwZ4C3L66Xaw1QNwmf4GvhX1IoWbY3Bw3mkEQ3jELAnmRcIMZHfko0a/8EH272mA2AzBA8/d0FxdjkV5cfS9o5NVvJQLA6wwIZlDA4Tyzpewvi2XAQC8iNLpx81QEvYxxLZQgrGU0mMX0uWY0ZzR4KCwmZO2laKueZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625763; c=relaxed/simple;
	bh=BTZIvRqcuCTEKcvLPQKN0PrMjRjf9kk4vsMhE/kOVtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhqH7PUrvqAwTWtButs8uHMIRr46q4LobAIwdXiOrI+TY2MAB95OzKDiWErPy59tAPW6QIoh2NOwPtt/OXxJZUQ8NpGFcp+xxbMLrY1Dy50hf+VvArHhhJO+UBCMxZRDfqk3L9M+x2mFjTQDTSDqAezUfYHxf3PiLxcfpHHlcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmup7ZtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42413C43399;
	Thu, 22 Feb 2024 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625763;
	bh=BTZIvRqcuCTEKcvLPQKN0PrMjRjf9kk4vsMhE/kOVtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jmup7ZtY0PC+Ppu5C9ix3hOqqK5wEZ+noUiy7APcEAVG25bVpcSHzOT3QYUEWPg38
	 vnn4IWUvYJxk0rsjc/ulwqwwMM0SUuBWZ+W51mnhum9GoapU+0A2X1HB7caJRJ/CVd
	 6QxUKYzJujnEoj4nY906EdIxGaCGNjVSe8yjduq3cOcR3Z9T2stK4Zqv9eUyWu/Erq
	 i0GfhITXuFwGCFBn8Q7XeAhLGwpl3V/zfHEVZblpqKzKKuR9UwiEckxcrnQSde6Ue3
	 JXjHWcBEN+d556PrpEKnPaRksE9yZKPSvQcNDURhngA6f66MCIzVFCG4n1PMSj83vS
	 f0fzYZ4fejIrw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:14:20 +0100
Subject: [PATCH v7 34/36] drm/sun4i: hdmi: Switch to container_of_const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-34-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BTZIvRqcuCTEKcvLPQKN0PrMjRjf9kk4vsMhE/kOVtY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnX+/69f2n8caKoQub+F69/+e2KY3v54bKK+SHvnykL9
 me/4wzt6ihlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEOOwYGW5MTL44peuu6wL+
 f5aCIedmyan++RhyZeIKdiFl2Znn9vYz/A+ak310c+ZsyZfhR0Ul1TeK2r3+57NoRdPiCzFbJp7
 xucAOAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

container_of_const() allows to preserve the pointer constness and is
thus more flexible than inline functions.

Let's switch all our instances of container_of() to container_of_const().

Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index bae69d696765..c276d984da6b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -30,19 +30,11 @@
 #include "sun4i_drv.h"
 #include "sun4i_hdmi.h"
 
-static inline struct sun4i_hdmi *
-drm_encoder_to_sun4i_hdmi(struct drm_encoder *encoder)
-{
-	return container_of(encoder, struct sun4i_hdmi,
-			    encoder);
-}
+#define drm_encoder_to_sun4i_hdmi(e)		\
+	container_of_const(e, struct sun4i_hdmi, encoder)
 
-static inline struct sun4i_hdmi *
-drm_connector_to_sun4i_hdmi(struct drm_connector *connector)
-{
-	return container_of(connector, struct sun4i_hdmi,
-			    connector);
-}
+#define drm_connector_to_sun4i_hdmi(c)		\
+	container_of_const(c, struct sun4i_hdmi, connector)
 
 static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
 					   struct drm_display_mode *mode)

-- 
2.43.2


