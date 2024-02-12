Return-Path: <linux-kernel+bounces-61659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2685150D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CE28B02F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EC53370;
	Mon, 12 Feb 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui7XWkL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0953391;
	Mon, 12 Feb 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743705; cv=none; b=A/1UGZ4N+5jvlvhF1COMoNnhVs0LEgmOmBpFj7OheCRPQUUT7MiPfI0+bYFXvuKsL/0yhEY2/r6NRIuC+U0LFs3pISTuB7VP+wenrF6QCuSPdxtrHt8UOK51xNvChNcLaDqia5s7nbqCT2tAfLFcaWvWu/isExSY9CvHWm0o/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743705; c=relaxed/simple;
	bh=pVOwlxGRG4Yx77sVCEVDWc/W+8/UbYOVd7SBFXh+HU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQwoK0Weypo4ca/fUgw655Wcrm7ACdIOarXKmGSgDs3R0i3QAhR0ZGs1cPxVAHx+syV0OuHqUf7P/0xYI3/5q0IJOxGlIOHTuWHrN4kAhMzS00yJrccEXAX8xTx6fgJKxRUJeDqRmjz2vBQZqHFiiiYZsf4eUpXW6MN290p5AOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui7XWkL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376E2C433F1;
	Mon, 12 Feb 2024 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743705;
	bh=pVOwlxGRG4Yx77sVCEVDWc/W+8/UbYOVd7SBFXh+HU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ui7XWkL0oI5fI+U4c+5RDww7fbXJ7n6ga02OInJjaLdlqpnx0TXzXuSEOommzRzZO
	 Pb9VW5WGRbqJMPszuaD+NxwHwTtJdNZjyySJG5gStr+o/hP+0yAbK6AT3oiU9YdD/m
	 jK79GfBaYCpvE/tIcoA8NnYab0E3Fm8vPb6K3+gvvR78pFSCCZcV1nqs/maIOOk/6c
	 GO74aHFo4IB5M8DbqRzwCZOATCyKLTgfqrLTdWoB7x8yNrf07LOOVdJkmSKKEXrRgA
	 XzVidhy4Dzkx+6BGuDSLHJ3ONUDcP8kzPrvO8qixDrDD4mGWwQ9rPNeQi89idxPRwE
	 H7onuj7vJK9XA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:17 +0100
Subject: [PATCH v6 34/36] drm/sun4i: hdmi: Switch to container_of_const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-34-f4bcdc979e6f@kernel.org>
References: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, Sui Jingfeng <sui.jingfeng@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pVOwlxGRG4Yx77sVCEVDWc/W+8/UbYOVd7SBFXh+HU4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJEvizUo8N/gt2Ch6I6iqf8P9PsXAzoS0a4uuKtfuE
 eOcwz+5o5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABN5vZ6R4bbnj3Uzs7lj/x8K
 fB2SeWCtiqn/eudNSxn6J3WuTf29v5Dhn0nnhvf51TaRJ5WYt9Q0Bh10X/N5tr4VB0eBxWFfO41
 GPgA=
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
2.43.0


