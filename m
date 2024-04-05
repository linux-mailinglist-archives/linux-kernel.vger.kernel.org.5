Return-Path: <linux-kernel+bounces-132712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E23899933
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AEF2834EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D4160881;
	Fri,  5 Apr 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="I1M8DpC7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1116078F;
	Fri,  5 Apr 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308488; cv=none; b=Iw0jI1+3PoXJsPrthmye28Z0osWLglNrKBqTLDI9eg07IqKs5hX+BmV5GCEKhi4JnETOoJYdP25tu8W2XCSYfL1EmsQtzKrwEjSxBF8Z7DsonFrRjEk7T+jZJl+thGu9p5BKt40ZSe5JTJUhW++uNFzyzKB3+a1hx6BJgK5GpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308488; c=relaxed/simple;
	bh=ELI8oewYYbbwnpIW88NGWIlncp1y6aSu9PXgBDCA0Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vih7QPfZ38zRAzGlQIsw8dxS0UPrS11CHmaJylts4RI8YJ2pZ1i95Q4C07cyCOXHbhJ/pR9pVDHYJPkLJVNBB/bQLFSgp7L/f9MwIP9kb790tfUpCjvN6wd+8/jgnVvvL8SQbqXQaX8QB/3KeR1mGejaNy/wiQ8fywEJ/kVLR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=I1M8DpC7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB2D6F0A;
	Fri,  5 Apr 2024 11:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308444;
	bh=ELI8oewYYbbwnpIW88NGWIlncp1y6aSu9PXgBDCA0Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I1M8DpC741zgAa/IiVDMkphQWFwmbsOXnNcUpNvUWHi3P1qOXIKWAbqKgyp1lG+Jz
	 9uYr2X7Spm5XxU3hGsZLb7weBBd6v019vko38XEnPWOk55uWpXQ/udd3H63quP+Kbb
	 LN9JRKdtzLUiTN//8IhxSqYeyK0viBS+QfN+CBZ8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:21 +0300
Subject: [PATCH v2 3/9] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-3-22bca967665d@ideasonboard.com>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
In-Reply-To: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
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
 bh=ELI8oewYYbbwnpIW88NGWIlncp1y6aSu9PXgBDCA0Ko=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D9YP56b5dScuJlvsojhKUzK6fiKF3/cSCKQ
 GEGoiQHDnmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/QAKCRD6PaqMvJYe
 9VTlD/9d0TZn2qXB95p/F5QJl/0QbXM6BS+xUH/BLnTkj+mPTo7YLfM6lE8fDiBp5UnKVWVfV1H
 WIKmjhOMAuDXo+AyN+I48TuIN6+SSBQn31ZqlYuF+8KsZVwI4ndY0TkmF/o2I8K4N1st5xsP+1B
 Xq75XMw6NSqZ1wW3hqMF/RBX0cz0jUQwy3WQsagruBhR5K0jYHdR75Bu2wlHmOE/twYYjc/Ilmk
 DigjghXTvyk9bqySBI7QlErJUK4B/+1OVrpBmos5iKGHybx9/AEJLTOJesrN45eyV3VrPbEZ6uR
 v+9F3O7SgWru666pZAVyzh+Gk9jKsuWdWG751A6UffKBW/Z/vtiGe9n/wI8CwjBWDJpte1/haaY
 9nWjlbKiT2gzYpE1dwYUNnuIAjDndycKI5JidbGPwYU9zAMINsucRso97Dd6JMPxkBFQSltrWro
 CbAEMfrWcM0Na+Q4yEOBL81e3eq/FqCukxd+t80CHWk2lIaM9WS4iT/tXDLRwHoXO/X7YQL1Vpm
 lt8n0c42lgtBBroIgjAmHyyGfSps6Ai8wA9xMIdA1Yr26/qKTWjlqvToSvMf6ocwiDYJARxy+Vp
 RuIw8Io/BYiWZxHyRG6a7RT6wQiwB2HoVQP9LyXmoFC0IqMN1trxIxZGpgetdYnAAaTiJ+Z97oP
 T6GlZq3P3RwGttg==
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
index c8124919b92c..a15a41576918 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1532,6 +1532,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
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


