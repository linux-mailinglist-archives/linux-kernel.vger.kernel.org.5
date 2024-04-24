Return-Path: <linux-kernel+bounces-157224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6B8B0ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22A62839B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CCA16D9A2;
	Wed, 24 Apr 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qH2WZs4C"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE316D33D;
	Wed, 24 Apr 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973192; cv=none; b=M9dbtJ0J06Q3kGKkD5tF/QEbT2xXUDeOA4lDGcHox3N+X6tC06r0KFIr3GuVG0IXOZWUZA+errIhFy3V2zQM4mhvE9wU+yY47lDlcabCugRb43nlgKK0Rm0ybAiaOIfpe+L++8JO3V1lzXdx91rNPsQc3vWXex7Duq9wDyBVA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973192; c=relaxed/simple;
	bh=IbgxalRH2aEt5+CNdN2EX6VC5JVtrkI/ABbL9thJcYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wl7rF2i9I5qHrzeb7/YA9QNpQwkVzchuAbefevgw3ZTAmwgDx65URc2rehZ2Ur6DBGjBMhgXWAZSxHSahnDjZDD572LK40XOAu6SYiGod4l6OojJQTzxe+U88PJOEFTZI9MFwrC64Yf2RALnbZ02wKr32kM8jsm/2KZIRVyrehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qH2WZs4C; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC16F674;
	Wed, 24 Apr 2024 17:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973132;
	bh=IbgxalRH2aEt5+CNdN2EX6VC5JVtrkI/ABbL9thJcYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qH2WZs4CfcddMW2bmH4ocU6luHYV7W7GfY3p2+NZ8WGKmPSeqzNiED8lwEwALDbHo
	 oJikQScRegfnifVFzEFh8DbJQ4WN/U/BLWtLYb/25mOKoaBM4GsCuFco6J+o0M4L74
	 tM/IYBnBqqdCf+Tp+LFXe+Rlf0J5w/VlBIHkXBB0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:10 +0300
Subject: [PATCH v6 07/11] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-7-5fb14c20147d@ideasonboard.com>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
In-Reply-To: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=IbgxalRH2aEt5+CNdN2EX6VC5JVtrkI/ABbL9thJcYE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe5xSH6Hsr5N6TnHgduziiXK6oY5fcNjtQmB
 TWVl2G8XGeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuQAKCRD6PaqMvJYe
 9Th6D/0dPo0hYOUn/R7lRuxs29cSzr+VXkOc+mIbITeGAASfFo3AEOUhiWYWYixzIl9gy2C+jvA
 gLbhLVLnVhCkbxfZLBzXx5rQmfKfBGVRajeYRzUErsLk+ZjqjY/QJWW32IYHuWKIlt/ghOt+LqN
 OLN15RwIgKsGjXldA0UtgGRnu7PANxYMYMNZs6UpCWy7dOAsV9Yd0zTNXWjRjRMYjVDYv06BdHd
 jHP1TVbEhmQEUaCbIa9uoGt4FoITLhsxEIf3G643Bk3xucgMI9NcuzxpNkyDwSvK0RCnImqPQX5
 h1OiJGEpW6Vsb6ikY26svjY+3nfRJIl6hFR7VsQhX+1RVI9VbL4b/oj8vsNe8LdlLP1cePBtroB
 mtGdhWWkKV7HXaLhU0ExS68j3j1rVthaCcgMCrF0fB00YdWlXdn/RbNPeaNRO3PT424R4dvihBD
 nFnk8IXN9OBke92RWDplndV1+Wpl8tfTRbKCDbHUUUBkR5UfO3BxrzXV73RY2bvVY2LQDLFkt6g
 OZmzwmBtyU4ZG/xdQCQg/scaUhnC4mCDsQ6+MGiZ+4B0u4YjwLK7BkLiO536C3Tq6ozdVV9p7Gc
 arPwuqIR+FZGYm/nfnFA45evHZmH6I9rofc8YQZgaCWAZlyL7aKIyTk1zFSaeU2UTrv7t8fgm/v
 J/XwlVl2dgMBfHA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

We support camera privacy leds with the .s_stream() operation, in
call_s_stream(), but we don't have that support when the subdevice
implements .enable/disable_streams() operations.

Add the support by enabling the led when the first stream for a
subdevice is enabled, and disabling the led then the last stream is
disabled.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index c877646047d1..7d0343e8480b 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2185,6 +2185,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
+	bool already_streaming;
 	u64 found_streams = 0;
 	unsigned int i;
 	int ret;
@@ -2233,6 +2234,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
 
+	already_streaming = v4l2_subdev_is_streaming(sd);
+
 	/* Call the .enable_streams() operation. */
 	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
 			       streams_mask);
@@ -2251,6 +2254,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 			cfg->enabled = true;
 	}
 
+	if (!already_streaming)
+		v4l2_subdev_enable_privacy_led(sd);
+
 done:
 	v4l2_subdev_unlock_state(state);
 
@@ -2375,6 +2381,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 done:
+	if (!v4l2_subdev_is_streaming(sd))
+		v4l2_subdev_disable_privacy_led(sd);
+
 	v4l2_subdev_unlock_state(state);
 
 	return ret;

-- 
2.34.1


