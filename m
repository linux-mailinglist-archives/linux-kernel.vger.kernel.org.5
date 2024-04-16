Return-Path: <linux-kernel+bounces-146926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC58A6D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B2F1F21FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02761311AE;
	Tue, 16 Apr 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lv/w8geP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BA130E54;
	Tue, 16 Apr 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275743; cv=none; b=h+y+0pEv7nA50fFwM4BfzAp8jEnrXmy7bV+9U9fG07zAcySGqg/7BCORXCqgLMuHdaf+l4YU0489AnrdLixhcjpbjSyx7tM6S9kK8WtbBcaK2pz0PkXOTK3I8jnpHFcOSfB5Zpq+hIqwyhCGgfyFaqAhWJTW5ZiW5ce5kIT2+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275743; c=relaxed/simple;
	bh=1wu/BK+2ztMZUnU+g/BX76ZgWTlvg5EcPsauJIsorW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAuTD3wpjJIQmcMC5tP/4eZX6igRej7f9rmOF7H0A7Q7KRSJ3PIwWuIMA3PzbmuWH5I/YQyGtyX6g8KE5jHgnoBkJkLiMEtWcfdME0iH+SwWvRLKLZyNy1POX4QPxn6t42jMPh6XxgieswTYLFqoy5shcZjvRmjma2zt54V75TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Lv/w8geP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07CDB18A1;
	Tue, 16 Apr 2024 15:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275684;
	bh=1wu/BK+2ztMZUnU+g/BX76ZgWTlvg5EcPsauJIsorW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lv/w8gePurxhHhlv7SKb/4d8A71LsgLchQn4nD+nZmTT+nnsX1CnMmJiaQ+rYlONI
	 Pq7n2etPjwEScyL3degXb9S7w5cIc2BPeLV2ftxJAO61Lc+yzOApQkN9lT2tABpR1o
	 /iJh9JLlqPQHrhkKcl6Sx3IUu3pvssZzwUczAdGI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:13 +0300
Subject: [PATCH v5 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-10-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1wu/BK+2ztMZUnU+g/BX76ZgWTlvg5EcPsauJIsorW4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNMiihKFDcdIAi4MVBaivGWYkMLuW4PLytqP
 NKJ4mhvfUqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DTAAKCRD6PaqMvJYe
 9RXID/9+bo7Oknnxx9zbRab4/UaVin5kFEwMDbUvrtznOu77IyduVJ1Y6/LvBisRF9TpiH5pPe1
 sYcG8nH57Tbg8+1fq0SA4OkupzvJSIF6UmrPLLLp4UFq4AJVTuzJVWTZqP0wevi221MoZvJi9Z2
 +NWWqQn7APRa1XkUlKYLPvf/xLxjvI2hrJH+Q2kX+vY6tGVcQWpqFE9Pv+0EhAyaj8lzr2M2deh
 DUu/mHAtnwmpu59DGtrvbSTsd30XfXSgd8jpg+98GuRqiuH/qH1EW1kPsw2CutiOhveTcHt4SBH
 vVJKryuNKACwQlr1Xy3SeJci1CBtzzsYBr4vaiFFdttnn3tNTNOlkAhFv7aakn9bdFgQGhXwHcg
 81VnRS62sRWA0HhBstjBrWJ9OMmHY/NC2Af7Ss4QaA0RL4wxk5DmkwLs3QLjPWyP5plMPk+2mgB
 AB+j3u81iyED5p4l2NJNc9mz8QL+Ry1k0wjzoE5CiNhXiA+XUefqh70QEARNDrg2qgb4uSil1Ts
 kMf4v+cFarv2dAxBcgcNf7gIF++O8uxxLbPIupM11XA8BShm+RMxVuHMAo6RYAdd3yBRdjYX7sU
 9ZWuLfvKERv4SjvMTA+LPKI/51XOqjDXBJLiD22Q93u7/GC3Qx4tFl4PcdyKLEcgCXGi7noAtN8
 KaWDqd+5ba+BCyA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

At the moment v4l2_subdev_s_stream_helper() only works for subdevices
that support routing. As enable/disable_streams now also works for
subdevices without routing, improve v4l2_subdev_s_stream_helper() to do
the same.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 10406acfb9d0..64f52376ca7b 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2360,15 +2360,24 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
 	if (WARN_ON(pad_index == -1))
 		return -EINVAL;
 
-	/*
-	 * As there's a single source pad, just collect all the source streams.
-	 */
-	state = v4l2_subdev_lock_and_get_active_state(sd);
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
+		/*
+		 * As there's a single source pad, just collect all the source
+		 * streams.
+		 */
+		state = v4l2_subdev_lock_and_get_active_state(sd);
 
-	for_each_active_route(&state->routing, route)
-		source_mask |= BIT_ULL(route->source_stream);
+		for_each_active_route(&state->routing, route)
+			source_mask |= BIT_ULL(route->source_stream);
 
-	v4l2_subdev_unlock_state(state);
+		v4l2_subdev_unlock_state(state);
+	} else {
+		/*
+		 * For non-streams subdevices, there's a single implicit stream
+		 * per pad.
+		 */
+		source_mask = BIT_ULL(0);
+	}
 
 	if (enable)
 		return v4l2_subdev_enable_streams(sd, pad_index, source_mask);

-- 
2.34.1


