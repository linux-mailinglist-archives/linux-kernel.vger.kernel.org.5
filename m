Return-Path: <linux-kernel+bounces-138508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7D89F268
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFCF2869F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628515E5CD;
	Wed, 10 Apr 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nbh5FgLR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F15B98E;
	Wed, 10 Apr 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752618; cv=none; b=EydZ04+S2864K1conbfbEYRKWLODJWDQ7kSv8DfwLcXScB1n3uWfCncv1NuFiil8G8kEFuufED8gQTR/IDhVSkAnL7BJtc72tj0pjcc5Tu/6vpuxj01ylAQqS5jY+6cUL9ICJXf0cxxMmJO7TMueCOBrc27nfUGWhx3qJbHjulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752618; c=relaxed/simple;
	bh=zlbes/C+mMf8GVzxf6IqNj9dh4TQOHZqYOjhpSbRxJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUq7/tBntvokTmEvjd6HYHRG7J+CanPtJ3EMJrh4BldnR62gQPQnyLGmkCItVysuhzZeprCpnnnPIqdMzpsaimI4KSpTh24M/48bAaUoafbrTMLPAUk8DmhxYIIBk5zn3ZOcik+jIgrCVLGS3gZzJc3MT8MUMql8RyGeGXYI0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nbh5FgLR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97AE0EF2;
	Wed, 10 Apr 2024 14:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752570;
	bh=zlbes/C+mMf8GVzxf6IqNj9dh4TQOHZqYOjhpSbRxJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nbh5FgLRr9QgO529JPOx8bcbulDPKSVrCfYqsTb+ZZG+sdDP/mLgNDoYC2f7dBdiH
	 SbPSFclUn7YVJrW71n9t4XYh4S0n3Z5QYBoZ688jD1iicY4T6TZ4MfH05mj7m8Irol
	 rAi3yXkxZxBtn9ePNa+wIZIavXZLqgbqdGQlbmNw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:50 +0300
Subject: [PATCH v3 3/9] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=zlbes/C+mMf8GVzxf6IqNj9dh4TQOHZqYOjhpSbRxJU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFoff/kjTBbtOZhZkZ3momcOP54yqy22hpg5Hv
 TYksusK13iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH3wAKCRD6PaqMvJYe
 9VxSD/9zspXhDGeS1SdhDaYQWjDLce1/O61zShRpW1xFDP0C6tVczRWN5t+gUblnTeObzZPVi4D
 /b0ZZjxs4hdzbR68eNIdjco6gYasupjRKt30N4NGi0pa5DKfCr2QLGPisKQOXB1fuRMZDzF05K4
 RJCpdlUsZCidhnTsn7z5e04tVisGPGsRtu4OZyp5fNgOyGW/8Ey2lJ4mhsf43+KmNwtSabB2fwF
 bASHhaOZ6j2vcwE/SC7QA1g5Jph9/9gkr4QZWPv88whKj+3gY9CV6DoPAt9diA9Xa11hJdmtN5E
 vp7zJaTkxez0Vk/FzFZIUjWMVukZ0A5RIxpjpbeOCmPwC1FFUDRnqAqGVefdbUkINDHatjoS4MV
 50OfBVEvY938855szvySdgNiAw+jpa4nnz/+AAVb2t1NKNgFXUQi3CarnBcD4phquIlHQ2QMbxV
 +2+behqbVRw6IYN5AJ3OfOiODd3vhbDrNnCwBxVEfry33Y5qr0KSyDMcRgJRoij/bcNR14Ldxjz
 Y6lh0/vTWzP2wxboWuP+KzJe+s/inLPfC/w60dWRDC+zYXT4SHONf+XjzqZfepnFlxdTa0wcZF0
 1FcxaOBiDkSzcgUP8EnYZ7zCQOleWrnT2Zjad8b6FSmPQdP3vLa28CxsO7mPZTeCTCVdpAr6q7z
 Z/q1nGDdr8CfDTA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add some checks to verify that the subdev driver implements required
features.

A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
of the following:

- Implement neither .enable/disable_streams() nor .s_stream(), if the
  subdev is part of a video driver that uses an internal method to
  enable the subdev.
- Implement only .enable/disable_streams(), if support for legacy
  sink-side subdevices is not needed.
- Implement .enable/disable_streams() and .s_stream(), if support for
  legacy sink-side subdevices is needed.

At the moment the framework doesn't check this requirement. Add the
check.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4a531c2b16c4..606a909cd778 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1533,6 +1533,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
 				struct lock_class_key *key)
 {
 	struct v4l2_subdev_state *state;
+	struct device *dev = sd->dev;
+	bool has_disable_streams;
+	bool has_enable_streams;
+	bool has_s_stream;
+
+	/* Check that the subdevice implements the required features */
+
+	has_s_stream = v4l2_subdev_has_op(sd, video, s_stream);
+	has_enable_streams = v4l2_subdev_has_op(sd, pad, enable_streams);
+	has_disable_streams = v4l2_subdev_has_op(sd, pad, disable_streams);
+
+	if (has_enable_streams != has_disable_streams) {
+		dev_err(dev,
+			"subdev '%s' must implement both or neither of .enable_streams() and .disable_streams()\n",
+			sd->name);
+		return -EINVAL;
+	}
+
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		if (has_s_stream && !has_enable_streams) {
+			dev_err(dev,
+				"subdev '%s' must implement .enable/disable_streams()\n",
+				sd->name);
+
+			return -EINVAL;
+		}
+	}
 
 	state = __v4l2_subdev_state_alloc(sd, name, key);
 	if (IS_ERR(state))

-- 
2.34.1


