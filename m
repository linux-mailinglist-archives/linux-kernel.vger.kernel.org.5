Return-Path: <linux-kernel+bounces-146647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141768A68C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A5B2216B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEB12A175;
	Tue, 16 Apr 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dRFq/lmw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3E1292FB;
	Tue, 16 Apr 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264039; cv=none; b=jMKX71PZNk3y6LDBQQWjxnjirpE9Kk+8++8PeYhN5D9DW1yL1L/90SSprSEGvqknWmjJTWLGEVTbDQkeR9qTIuITBnJhKgOtsj1MlEbcr6kwC0EYNV1jTlR+H8D2BmHGi7JEdvTFAYdklUnXh4NFl9E935cS1HsUdAx4w83pg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264039; c=relaxed/simple;
	bh=Z0RyfSEDzUrNB+KTFQ++Lirh0TD9nIjn5FaVBuc0a8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJAOsOnXwTNV8RWoCEtm73/sCCD5vKM1SZWE7kW8ygwpZ/T6Q2fS2UttQ/vWWVRN52yVGxnOSXBylg92uAVKcnvM+W7EJiAq4V6qMKGi5vPvZaHIsVQYdxy/LYduvtYY+SVoQyNojzkG3SJi0UgmR1L6IWtv4vveId9c2AuE7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dRFq/lmw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7DB1EDFB;
	Tue, 16 Apr 2024 12:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263987;
	bh=Z0RyfSEDzUrNB+KTFQ++Lirh0TD9nIjn5FaVBuc0a8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dRFq/lmwkYuEJr0hgJmz8pLXj5dZW73qnyQEZZHYJy6nwbQ03mNv3TP2V/4sqQhuG
	 3N0DzLk/jo6TJqBvQVzqpqOb2JMJeab8psw20Mz05gd1LP03ccAfSAQvavHVIfShcg
	 FZcaF2ji4okO5gGUgVLoSAeK2z02UpJWMgUmDWkg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:02 +0300
Subject: [PATCH v4 03/10] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-3-1d370c9c2b6d@ideasonboard.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2250;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Z0RyfSEDzUrNB+KTFQ++Lirh0TD9nIjn5FaVBuc0a8A=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWczp0NVOXeX7PWRhsOYe9eSxPpZupNvdBoE
 oY7C/WF7tSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnAAKCRD6PaqMvJYe
 9WO0D/0Us/wOh4WFnUkSRkZR+1R7scfpyMLbCJNRInths96aUjRlsRE73QpkA6akOtmU4TZ8Yek
 eGI04oA8TTk1T/4gOHyH6uncwqqruP1FGkgiai2+NjvPVxp8BFqTzqva55QnRc51vIgViyLt9lg
 3lVqE96DOnXjyyF6o8c/BV4+qrbAlOwMqK6Fh1G8raLZOAN0xXkCA7wodhBDDt5qdyM45WFCvEl
 QGpowpZP00XkLZsw1Xx1VLGi6irqDg0BNbCpC4NmBQmU0lPDOtW35GTa08gWupzAkfHp7aBg7Sw
 5WtgWcZxFPjSWnbfyw7j1JgRYWX1MWC04cu0rnwzd/d7V6n9D8ODkzjoSd+hj7pIugPWxTY+CbN
 ikDQxREjxMmBuHrMQ378GkMxVejXah/QndhMiFWFeKYuNuMjJ2HsmxtMW7a6Oz/7QO2CVtr2p/D
 C1KtDhH3t38lU3TQO0+O9tzx1eFDCGN1cgcBHMumosFqCKq0iFFMYrh/m5EN5A8cmhw9sf0zkPg
 +FPO2C8U02uqD9QyaazKj20Q85kZdAfWhtFaUmBmUCHaQoVVKBO+gaM3LueeplyFk1ETjmwRAjN
 EFOHKcUJEFQhdoBJP/tmipyieZKMuQiDlX6OKzbVGJPl/rvmLrkl5RbF7Jy1j+keOE97jSLshUs
 Oy3bU/q2+r7FzZw==
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

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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


