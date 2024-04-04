Return-Path: <linux-kernel+bounces-131258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E9898564
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EA02835A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD381AC6;
	Thu,  4 Apr 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OLh9z78u"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D7763EE;
	Thu,  4 Apr 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227823; cv=none; b=R/Kto6UkNegD+jxzLnZhpORoq4YoQ4dx9ppEWIQFvNYvcvJWuTw0fli+XntboWDyqoMTysZdZjKJJvbQvEobGIEdWlKm6fBvaocP8CVACYhxGVYcwRAN7QYaKFweLDxBHuzjx0F7ecN81f6hyssiamIy7C8Hke4sfM/dF+pBCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227823; c=relaxed/simple;
	bh=7+2nXWnaOTSsKOVrfNaX7gAxdvGAJKcw65XNN4PJTwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfO+GYIJi9VCbB9WvBKhnDt8E9aHxXNKH0hQ4qLFfTI6Kwy4ko4zuMY+Od5wZgClXD53RYa5X9WP4/LQ1hSEyOrNKzoxR8G/TuEvSdEdydTAfrvwNXD4UcP1dJXYwCX07FqkfYW0J13aC1D4iyUEBr86m4e+lBL4TX2mTEBzhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OLh9z78u; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E98F0497;
	Thu,  4 Apr 2024 12:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712227782;
	bh=7+2nXWnaOTSsKOVrfNaX7gAxdvGAJKcw65XNN4PJTwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OLh9z78uq4/6oxcxx8HUKvN1cVGnWoTJd+O7pSlZyHtGgRsXXjptHt94pT1wMO9O2
	 IrE2lc2rp90y6SxkK26LFN5T48by6xG6QF99FFQwpu/LTo5xEaLBQVUhYYZNdK58Kn
	 UOg46PcSPjWsqct/APPTy85f4n+sMBeHZ+taZ/Ds=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 04 Apr 2024 13:50:00 +0300
Subject: [PATCH 1/4] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-enable-streams-impro-v1-1-1017a35bbe07@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=7+2nXWnaOTSsKOVrfNaX7gAxdvGAJKcw65XNN4PJTwE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmDoXp9Ioox00px095fK3OkdCk2nenPvIPOBdo9
 yS5VNab3nKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg6F6QAKCRD6PaqMvJYe
 9dIrD/4ihVQivaoXNrP5+biyesLF18AwDelyQtwSl9Bv28mUwz2yiTbVSbKqe99MJcH1rGqDdMa
 sqTQflMpXgTffa0J5oaXnYN6Dz6dsu4Hz0xpjRtD5NlGemmVUfC5DbhrX1hMlZR97j8k0zAX/67
 xzg+I+5HcvpN9tLG30hoSRawtF5nwWTKWFg/ktP6E78eqYcObuC+FBTJ9mzZp+I+1DAgnSlD8M7
 52hFg+CzzJSCVOYw67dzk8fKMFfIBXyBZzxnnJvV64kXtK9w6S1vrHOaJSR1V3hW04Qc3dD3KjA
 ECJtGGYLLwTPCChhynw6SKMwgkkGvinzEjwE0e7sER8RzhYsaeqW/v6DGBS4Z7UFrYQ0pe099/p
 s5NJV71C24y4vbvWo6k6ZoUTvPM8RcW/y/xxu+p3jSWVBTCU9YQvUrkbh/KNxTyZn5yeEsUqxzO
 Y96DXVZHWJBwEJ/FGWieGnB4bub4l7aecID4m6+eWfntPPBKfwDwwM3BGxiSZuJGRAHRwoT8+Fr
 xE5Y2COyl8ILnKxdZqoBFNOEo5T6o2dJ+uLx9K2LJx3bvEjWnnw+o6NYILwC7M5q/8DC90XoSCz
 DI1Ik++/ZPEz5dzOZbkUuSJVDslzvbEfbjGVci385wj1wWvtfjckaWIxPi9gBrFZJWkzS2exDyJ
 WrcZ8ZyfGB+/S/A==
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
index 4c6198c48dd6..b90b5185e87f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1519,6 +1519,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
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
+	has_s_stream = sd->ops && sd->ops->video && sd->ops->video->s_stream;
+	has_enable_streams = sd->ops && sd->ops->pad && sd->ops->pad->enable_streams;
+	has_disable_streams = sd->ops && sd->ops->pad && sd->ops->pad->disable_streams;
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


