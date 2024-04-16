Return-Path: <linux-kernel+bounces-146650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038088A68C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272711C20BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762D12BF30;
	Tue, 16 Apr 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pOMciXaG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C712BE9D;
	Tue, 16 Apr 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264044; cv=none; b=Q1Udb4xLgKG0vMD6U8Jnce/UtvdrZsCVwrAglLhSN+V5p6ny359w/bqnJ2xMfLVzwMIlBZ2ky1p5mM8PPil83t2RzZejTl9955hDGO9SoG4VRsBBAgs6SMVUzgBYLhWxkA5hNqqEvyd7aiYn1X+CxfuQh8hyZ/bfMlUgl/tY9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264044; c=relaxed/simple;
	bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgUxcFremw1sChBnRVAMuSBDYRypj1TJnvXbTj6+NiZlAnt+A+OjFr9e0TG94DzsYCcxJrR4B9s0/t6hRFVJH/24nDSatTvRFnjSFr2lEfShw/kJHisf1t+s2vnALpVNL5gdVGUYiXVfZp2ywNRhjWLtvkHy528NOujpRx17LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pOMciXaG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20DB3161B;
	Tue, 16 Apr 2024 12:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263989;
	bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pOMciXaGl5oggMRyuy7Tj9JkWTJQJIYc8uBddCuGU94yhUmCpjuD18SY4An+FCvUM
	 iaHC6d1ls4KtO39ejTV78De3uFo0dcPbWVm/EeXjSk8rxALu3aA985nDVY5bs3z/rn
	 Tk02Up1TGgLGHqIVL4S5shoVA4sLuVB722D2qGQI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:05 +0300
Subject: [PATCH v4 06/10] media: subdev: Add v4l2_subdev_is_streaming()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-6-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWdseU1u4Li7mA1LDngERmXrEF9+dLG7o/av
 GUgK2wtpYyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnQAKCRD6PaqMvJYe
 9dWAD/sEmuZrk2hyE7S5LztAMjdkjkKXyYssWbJH6UR2QaYv+LvXZlc0HP3/6JGj8qQm9epFnia
 LGn55OXUtsgzUfNfJcInrWkd+U3/90BlhWWcSeUVnRWlPMNqwk+2UdfM/RnPPb1wReO+kN+LJn9
 dKlF0Ce7BYHDmyhCNjMllr2JHa+KhpqOj6NgMXF9lzx3osFYJy/ojAAxMAUokpTRgEjZmrMe8ld
 4vF2esJwfBTfy8v8T2DCbKsB95ZgAIBPKNIj7Rco7sz9UX9TZYba9gyrL2LFRsZqk8cy2xcr03V
 n6Jx+978CHyyGkWU4BmpMv7hwEgKFORf0JpFFcfEYTBw8Owg95Jbbge2c1dzuVATPf2ol0bS5Ft
 pd3nzQlj4pCo9PNww3gsCGeGJF1Cp6lvPc3PoVqqzRZx5qEqMS5sIIgGCoLgXB+uj2UAxa7iIwG
 SSgGl8GVGqu0NKv477iiQXryHy9wHrgwQvqHaks+AxnS2Cz+iBmQjr+ep069RCCzM6sNgncd6Eh
 ZwDknrxM9mhDQnLoxkST0kdntIXdgu/K9sRqC9a8RKpacaNEj9wUUtQJFeIN7EgwcMN5wDCBL4/
 xAOpPwmGUfwUX1YWg0If88EgwL1Vp37cj3C9MZ49otR0WlvJrFI20h4PhxEaDNAscMEyRkbW53H
 8CtP3mqBadXE6FQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add a helper function which returns whether the subdevice is streaming,
i.e. if .s_stream or .enable_streams has been called successfully.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 3824159bbe79..06f87b15dadb 100644
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
+		return sd->s_stream_enabled;
+
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+		return !!sd->enabled_pads;
+
+	state = v4l2_subdev_get_locked_active_state(sd);
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
index ddf22d7e5b9d..dabe1b5dfe4a 100644
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


