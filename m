Return-Path: <linux-kernel+bounces-146918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52958A6CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD94283FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1012DD9F;
	Tue, 16 Apr 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OPOI/WQS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6212D1EF;
	Tue, 16 Apr 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275731; cv=none; b=PZu8iIIZc1Mncot4DCZIZCqY63gjA8a0KYrozy+wSZb6wLF/+isUHr6zt6+KAdT64yWG3IDkXxZcbpG+169w6GWc3/fYpgfAxO6Njlm1B/QPLjFmM99uDgAX6jJEnYc1YoU0zpSYrbm45UQhOOJvI/qLD5GepSTOyFT66wVpktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275731; c=relaxed/simple;
	bh=Z0RyfSEDzUrNB+KTFQ++Lirh0TD9nIjn5FaVBuc0a8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2+yBEZdHl9DSZQpYrz/9n1FfLakyXYQ1PpNRp5ujBid0G78lPS1dBWohfjgt6aHlE4+JZhYQMtOoBHtTixPWkKUHJqu71P5Bksq8o9rTOhTDuJvMUlXfBL5FnLUd8BdW8R2ulNfXd67dqO2DJSMz5y22yNpQ6HrAMWLK/u3W1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OPOI/WQS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 328671653;
	Tue, 16 Apr 2024 15:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275680;
	bh=Z0RyfSEDzUrNB+KTFQ++Lirh0TD9nIjn5FaVBuc0a8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPOI/WQShm6Hc783Fx3BCpG3TEMDOk9AU+JnMMCeMKbQsyfr6XxEDwZcn6ksdsNUR
	 JyEtYylsjqiDxtfEfel/Tn0hwGyvvgotrXjf/Y76lFXIUjMzQnHW5C20PBSJpQhXjO
	 muwyflVhPArqwa/YdTPJ7UjzEG0M6YLsSN3dOK1E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:06 +0300
Subject: [PATCH v5 03/10] media: subdev: Add checks for subdev features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-3-bd5fcea49388@ideasonboard.com>
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
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
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNJKFZLenFRr4w8dYUXbgGXSNB1DawZHYwoQ
 ZKeun7oR+mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSQAKCRD6PaqMvJYe
 9WCNEAClmM9DATCx3xKGwjD7/0+7eD36TAZf37HH47tU/a5yr4AWXIn46PdCiA8sHT7LL9O3/6U
 8LJOSKXst6twC9/PVui2CAm/UOlwGD3SSTSKkiV2Qx8p7gR7vDXxO+AKH3xu0FgXjW+s5rotD36
 LqvuUfNBJm8sux2w6Jj8VZxak3ZGP79kJ22QhbhT93vjkMmE3/W010BPvhEBTwuq1/e/iRnVmDm
 b6D2fPeScGbkIytAVu389gZXCTOoGlW/hz2OQwVHm+8HsUmRyEPfBEqhKtmSSkfOiw6cQtQjGjj
 0En4XhdCdnjtC/1NQDWSw0UWPxKk/0sqsdTTkNmaQtFZUgwE4aDnuft8vwO/VAtMOaFPcyj8ans
 gxLWKaTHgsd7PBTi3VWtmXbSk3OyrXQCFqWMa//kn6FcaV6qltVvX1U1+9qaFxIKauDcy8bGB3x
 jZ9qVzaZenqoc/bbv0hptuNBOra3m/zlBwHL+Bzg0k+L4wST/TbbNhbI0+Dv6teb83zUyKqaID4
 ipGRHq2gsVJ8AH6bUOqsg269PGvum8QpF/QhHLkUlH0CdUDQ3Hb9e64MY66RVQGRMAj+S6ZPY75
 tGQEb7Zkp1B7ge4NjfaNBS6t3bTpRYf9K/Tb14u1yLCq+JSihbXSoo6h8ECTgwmMfy3iCA+prRm
 oLMWwfc7PQ7s41A==
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


