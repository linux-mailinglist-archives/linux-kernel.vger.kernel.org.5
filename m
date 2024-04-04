Return-Path: <linux-kernel+bounces-131262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58089856D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0804B1C261D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FB8528B;
	Thu,  4 Apr 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VhMFlkk6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099680049;
	Thu,  4 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227829; cv=none; b=WlyTm0aJvbrlSdJ1O+zizwU0y/oqFSgUdgdnXgjKnn8HyWNN9WM7o5Lo7wxwySpEPlUShBOhyOgkdxbQMATCJ0aXondKrhcMQKF0X6SQMsL//muUrKJthZIb0Fm1ckscXFs/m19/lsruycsi5g2OpjIll3HBMXmvEDKDn1aLG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227829; c=relaxed/simple;
	bh=NEDsCxZIlpnO7rRc8IyLQGQLGkbh0uyi1WhbgqXQfFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMC+OSH1VIf7VIB7eOsQeblT/6Fy7IWAaJzSBua0G0ZukIjC7S6OZGahhcTzMsOS5sldqFX8SlaTPvVD8LQrPFK7fQ9w3VajbDDBhefDz4l2bnCay7TC7r2aVWkEihgVv+ffmyf7V6IJc14/hC+bKfLabuMVYsthFe4L7Ugp77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VhMFlkk6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8DDF1DD9;
	Thu,  4 Apr 2024 12:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712227783;
	bh=NEDsCxZIlpnO7rRc8IyLQGQLGkbh0uyi1WhbgqXQfFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VhMFlkk6pEcu3tuxF+3fDunD2xwm7M0D6CWtUE5oHCw2KBUzWqxKWgkBI1OTFo6IK
	 Pye//Wcm8AmRIm4JaXaB7uBqi+hKpZbX35pEiIJHXR0PF7ioDPrcmMJx6VXhDANOaB
	 r+7vxfnF5E+T6jB8/xofQAQm18ca669ChR5tnTMs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 04 Apr 2024 13:50:03 +0300
Subject: [PATCH 4/4] media: subdev: Support enable/disable_streams for
 non-streams subdevs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-enable-streams-impro-v1-4-1017a35bbe07@ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
In-Reply-To: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5337;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NEDsCxZIlpnO7rRc8IyLQGQLGkbh0uyi1WhbgqXQfFU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmDoXqFohVFpUULWBUlLIViIKk91Jfv6PhrsZkZ
 fMmw/XvZmqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg6F6gAKCRD6PaqMvJYe
 9Z+fD/9KOrPVPah8SEwDmaDK1l2KIzbllSd+JkpeTiqTQIO2TyV10TuAMp68mbjmYmNF38u+MhL
 R00MsxGzbAQB7QOnYtwK3x2L1LGNXE0d3vgOVDxvp0F7qw/LmB7gWDZ+IRo76URaynfI1VuXDaU
 r2yBktXURUK4XCHSkVbZdIrcb82aCSjlMA8+odLXXI3MrD1mioCNvqLKmBce2HWsnEhDwe5FnM8
 gLcmpwcq4ikLmP0JMaBgq5dlXqPNJHEzpRDtEVyp/V5d45//XYvrwwYaf+8e0Cl+gijhmHpPjmr
 kmyoXADA3vxtXOr2P8zE/a8trcQUZjCMNC1ABTRzkYaOGcLfHZhI/Bc0gCWMi65T9Io2/joqJuP
 3oJE43cJOs5kpfNLd6R6WPNRZyHrZhHsq/qK7IdPHXdOdMfJ/ox3KuqWo8THiG0jVDTRW7Pt+Lu
 jb68A0rgbl0OEROulg9jJwvazcIKwfsV9UB1crTMqW40BlU1RAA9Z2UoMlmdbs0zN64FwC2sGor
 zRjnnN6T7a9GeHd19xCexMklaLyfglK+mr0Z2ZxbJHvOe29WLYfJg4Xs6HGP1R8UeiIWPAfWzI3
 6r7vKjn7SEJYHZX2Gy4g1xjmtRMFAq5kygIwexpse6XMgjEF2KHQ5eZhfRlX2dAuSZR6OP91Zld
 3diEj4ToaQDF7Pg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Currently a subdevice without streams support (V4L2_SUBDEV_FL_STREAMS),
e.g. a sensor subdevice with a single source pad, must use the
v4l2_subdev_video_ops.s_stream op, instead of
v4l2_subdev_pad_ops.enable/disable_streams. This is because the
enable/disable_streams machinery requires a routing table which a subdev
cannot have with a single pad.

Implement enable/disable_streams support for subdevs without streams
support. As they don't support multiple streams, each pad must contain a
single stream, with stream ID 0, and rather than tracking enabled
streams, we can track enabled pads similarly to the
enable/disable_streams_fallback by using the sd->enabled_pads field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 86 +++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 91298bb84e6b..d86f930be2c4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2158,21 +2158,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already enabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
+			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+				continue;
 
-		found_streams |= BIT_ULL(cfg->stream);
+			found_streams |= BIT_ULL(cfg->stream);
 
-		if (cfg->enabled) {
-			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
+			if (cfg->enabled) {
+				dev_dbg(dev, "stream %u already enabled on %s:%u\n",
+					cfg->stream, sd->entity.name, pad);
+				ret = -EALREADY;
+				goto done;
+			}
+		}
+	} else {
+		if (sd->enabled_pads & BIT_ULL(pad)) {
+			dev_dbg(dev, "stream 0 already enabled on %s:%u\n",
+				sd->entity.name, pad);
 			ret = -EALREADY;
 			goto done;
 		}
+
+		found_streams = BIT_ULL(0);
 	}
 
 	if (found_streams != streams_mask) {
@@ -2194,12 +2205,16 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 	/* Mark the streams as enabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = true;
+			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+				cfg->enabled = true;
+		}
+	} else {
+		sd->enabled_pads |= BIT_ULL(pad);
 	}
 
 done:
@@ -2281,21 +2296,32 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already disabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
+			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+				continue;
 
-		found_streams |= BIT_ULL(cfg->stream);
+			found_streams |= BIT_ULL(cfg->stream);
 
-		if (!cfg->enabled) {
-			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
+			if (!cfg->enabled) {
+				dev_dbg(dev, "stream %u already disabled on %s:%u\n",
+					cfg->stream, sd->entity.name, pad);
+				ret = -EALREADY;
+				goto done;
+			}
+		}
+	} else {
+		if (!(sd->enabled_pads & BIT_ULL(pad))) {
+			dev_dbg(dev, "stream 0 already disabled on %s:%u\n",
+				sd->entity.name, pad);
 			ret = -EALREADY;
 			goto done;
 		}
+
+		found_streams = BIT_ULL(0);
 	}
 
 	if (found_streams != streams_mask) {
@@ -2317,12 +2343,16 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 	/* Mark the streams as disabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = false;
+			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+				cfg->enabled = false;
+		}
+	} else {
+		sd->enabled_pads &= ~BIT_ULL(pad);
 	}
 
 done:

-- 
2.34.1


