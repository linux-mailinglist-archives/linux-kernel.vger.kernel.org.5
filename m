Return-Path: <linux-kernel+bounces-146923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE868A6D03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4E31C21E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C251304B7;
	Tue, 16 Apr 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pfLDiZ1x"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B812FB0D;
	Tue, 16 Apr 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275737; cv=none; b=f+JaSrvzWapxTo6RWAc/yZCTXjAj9gIVOFw1buj+JzdLQEIWBDFBf4JK9mUQtG/8mULiosM8cYEFVhKIGoGsD2GKWiDY59xz7wI64Xyh3u2gng1rkVF/6h2s9qK3rQKoAhESomacyUv7hja92T1Rs/otlsJDlTCtjQdMUdezGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275737; c=relaxed/simple;
	bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4+4dcBAN9uo9RF4FFdOsbNLyHZOkGw6dVxKZBwVosL6QsAOJ/S85W2ChYXBA+RbEkJK3Gm6/sJ9vWAiwYzUWD1wfzQnAbN2J7kCoN9PjuYqSGnbmpCRiU1iCT+B14USyHSMgnCHVgqw6RGNJ/U5pZplq+qnBDBhee/wSa8McGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pfLDiZ1x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63D55182C;
	Tue, 16 Apr 2024 15:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275682;
	bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pfLDiZ1xeS2l7ZzFos01HA+KcpPn24S2E40qXoQ27tKpIoDCm6Ei+WNDXAVA0C9lM
	 NL9dyZfEaQ5qDiOpI/3plrnMS2Koi/0/pTqiTe9HyfTwzj+R6919laHZXxmsJTXQPo
	 9ywk6rfwNuA3jpNwcr0kImmU3GMQcIqW4+rC1RZo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:10 +0300
Subject: [PATCH v5 07/10] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-7-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNLsOPDzuFpeh5ek3IJvpM3cY/ZP5oOJgV48
 dD49YzsuYaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSwAKCRD6PaqMvJYe
 9RsAD/9tiZRNwDIVZ3csZFK2PaVl/OKV+Vbwps3JrVhrxh+B5GA2qLUTjUxdlbYWDtRtDMjGw0c
 Uo80BDp8Ee/eJlXjc7jm5ML9heR8+Nb2f0qz2q3q6/QMBfG4mTZuJJc60fCVPtDojpN4mZT5187
 vQderY70wevn0FD84QvBvMjT0RHNnDxoWqobvkbpAD6OnF2+IOIT3aHwPVMPCfkjQosN6C3qhap
 nmTMUaFMtDe+7U+f6KOm+puFoLtp0OMuuxvL4b01mWK8gnZce8cKHw7yAw94I9DvIlrEWlNCjyC
 RDTfvToFsy+LJ1n+I+5rXHQG0nwywk/E91GC0lGPwxQC/hHDn7SQ6orslVQqV097FFdELTDn5pD
 lEgROWgSiRhx7OV9xgj2sywvYSNvStNhICao7Z0+FZaPn1TqkzGzqDHfzFnvmT1FUAj+va/BbD1
 txlV3snEqsUS359UOzElfXM48bqlXOeYcBYgZSJBKWgq5MA3IsFn24h5xluHwkSKlSHod6i4+1E
 ABgltG0hxVFzzNMnp67T6ToXqJRHgFC7vU/6Pm8qDz3nlKmIqUYYm92DONhNTJ7j6Y/olJNUFvn
 cP0Hl1mkUzz6wSQrjYEJmj2yzIKkwI/ks/BcZMSObavMpzyr2BMf4ZuVtE+9AuHxCR/T6obtyKS
 tgzPkZZ9Zo6RQsg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

We support camera privacy leds with the .s_stream() operation, in
call_s_stream(), but we don't have that support when the subdevice
implements .enable/disable_streams() operations.

Add the support by enabling the led when the first stream for a
subdevice is enabled, and disabling the led then the last stream is
disabled.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 06f87b15dadb..38388b223564 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2150,6 +2150,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
+	bool already_streaming;
 	u64 found_streams = 0;
 	unsigned int i;
 	int ret;
@@ -2198,6 +2199,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
 
+	already_streaming = v4l2_subdev_is_streaming(sd);
+
 	/* Call the .enable_streams() operation. */
 	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
 			       streams_mask);
@@ -2216,6 +2219,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 			cfg->enabled = true;
 	}
 
+	if (!already_streaming)
+		v4l2_subdev_enable_privacy_led(sd);
+
 done:
 	v4l2_subdev_unlock_state(state);
 
@@ -2340,6 +2346,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 done:
+	if (!v4l2_subdev_is_streaming(sd))
+		v4l2_subdev_disable_privacy_led(sd);
+
 	v4l2_subdev_unlock_state(state);
 
 	return ret;

-- 
2.34.1


