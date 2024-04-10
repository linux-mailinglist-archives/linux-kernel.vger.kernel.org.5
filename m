Return-Path: <linux-kernel+bounces-138511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3F89F26F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACFC1F23C68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FA15E1E3;
	Wed, 10 Apr 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ufK+Hltk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9690158DA7;
	Wed, 10 Apr 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752623; cv=none; b=Nd1efu/S0qhNsqHZcrJO4iUahbFdgfWHeTZN3c5qTYlWUrFEjvB1QYCaUtxe8egARyry67ycVDnvQigWpzZ/qJI36gpNqZJOb5AilaZ7eLUQBC9RB+EP3M/Uazo0dxwUGCpi5AZAzMNrfm0GAqy2zIkrmaXWvo8i2Jewg3INKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752623; c=relaxed/simple;
	bh=Z3y+DXom2sYBr8/nzth539braLdHBd1S/1ycd5blWaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mqxnx7lGEDQmDbarE2Mmx/DseScCtThrQjE09Xrr5Whq8QHQVEbTnanyux6LargqIf8LDrslFzalu2bE0M5CnVEJuwp8rlZmmVE3aY3/u36wIJrw9F+4rRwOwhDj7d7+g79tvHpviQqQSSKWGCqb08/Gxhb4qA+T+9uZJqu+3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ufK+Hltk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5154814A1;
	Wed, 10 Apr 2024 14:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752571;
	bh=Z3y+DXom2sYBr8/nzth539braLdHBd1S/1ycd5blWaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ufK+HltkNk0cfi9zcJ27bHL+aSkmYUT6URrXgh/OAGR0FUVlbamuVaCuJGqNQDa2C
	 VhaJfK+O1DJ0ldB3Evb/dipOtLQ8CHH4ykwfWUJeyA0mVokU71dUqHJVfvDB/9Zdo6
	 02LUp2JuLrjwB54rE4snqJ4S9jMhoqGwM1s1xgTw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:53 +0300
Subject: [PATCH v3 6/9] media: subdev: Add v4l2_subdev_is_streaming()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-6-e5e7a5da7420@ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Z3y+DXom2sYBr8/nzth539braLdHBd1S/1ycd5blWaU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofg25H4C/H696g20oiaJQWCJc7JycaFyTqTj
 voa/VWNsSKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH4AAKCRD6PaqMvJYe
 9Vw3D/9E33yQbqpZIEwhEi09si+Vo9tW//xdtzWPmqjDkCCpifeXjx1a5PlGLTev+WM04zRAI7Y
 WfW+Go15aMUCRZYbtdCXTZyLGB/JKozH+71w4rijSxg9aw3tohZ8eIfxeyezkmdqPQgc70NMdow
 vZRi6NQy29XVEZInkwZ1TnglRTaT4ZVy/FU7r6tEwsbMXpzg9eUrgmKuS6jeG8BTTYk0JgqQDcj
 AoXsR29LOcp4aUzdS7mbL1OJe/m/fta0J5iuXM7kDgidy10SnW9hmqGBrqkrn3y2BiRhMnl0SmY
 ra/d+dv3hRxQkZfluGhvJ8/KlDNmGnWuLwiPnTQrzh5x8QFIjul6xBKz8IV31ANk99QHUf/0gaR
 C0NPeZxnVWernqMmM8nuaUqIg9nS2PzQRAP9vKDYCoX7Ldu10oS60C69pV7o172YhfxPFKCdSh6
 ev3NjpYFBL1gWwH1FGmVA+8uilCT+kehNlVcCCWTlNPMVZJUsKruIm2dReEu8VHuxw+ZJVBBKkJ
 LQxtOMdTdhNtjPSDUcCM7UT7IImoNK6/9W/EYzFG9yG0s6eEWf400MKnpt2J7EAKne+gs9vZ7op
 05EAHR9EtZYP23lF8A2PDe28mW2jHRlVGZR9CzvVB9vY5OFaF90uoRw16O+I2iUa9WcZzOpDums
 Bk+ilIQZWjOwSlA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add a helper function which returns whether the subdevice is streaming,
i.e. if .s_stream or .enable_streams has been called successfully.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 3d2c9c224b8f..20b5a00cbeeb 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2419,6 +2419,31 @@ void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_notify_event);
 
+bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd)
+{
+	struct v4l2_subdev_state *state;
+
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
+		return sd->streaming_enabled;
+
+	state = v4l2_subdev_get_locked_active_state(sd);
+
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+		return !!sd->enabled_pads;
+
+	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
+		const struct v4l2_subdev_stream_config *cfg;
+
+		cfg = &state->stream_configs.configs[i];
+
+		if (cfg->enabled)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_is_streaming);
+
 int v4l2_subdev_get_privacy_led(struct v4l2_subdev *sd)
 {
 #if IS_REACHABLE(CONFIG_LEDS_CLASS)
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index d6867511e9cf..270a4dfa5663 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1914,4 +1914,17 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
 void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
 			      const struct v4l2_event *ev);
 
+/**
+ * v4l2_subdev_is_streaming() - Returns if the subdevice is streaming
+ * @sd: The subdevice
+ *
+ * v4l2_subdev_is_streaming() tells if the subdevice is currently streaming.
+ * "Streaming" here means whether .s_stream() or .enable_streams() has been
+ * successfully called, and the streaming has not yet been disabled.
+ *
+ * If the subdevice implements .enable_streams() this function must be called
+ * while holding the active state lock.
+ */
+bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd);
+
 #endif /* _V4L2_SUBDEV_H */

-- 
2.34.1


