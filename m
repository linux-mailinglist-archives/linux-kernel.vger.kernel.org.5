Return-Path: <linux-kernel+bounces-146922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C488A6CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FD61C20F68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09253130499;
	Tue, 16 Apr 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hkXWXt8z"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A012F5BE;
	Tue, 16 Apr 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275737; cv=none; b=MGfMo+OMxRPGdWq3afY9NvmuSZ4DZK7j5q5feUIDUm9hKrYbMDaHPEC8TpCDq0DAezNaxCz9ojGkEOZHW5BMY2krKxA/oqgrAOrE+ild1OkTZQ4CzFepNrN368fIh6uMuC44xMhcMi86yUcobqB1IE3syDBkfrHcglSrzxVxiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275737; c=relaxed/simple;
	bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6109bSmeSlVjIROtQcTE0abDhFCuISbgzNnR9uadFemk1WdufU9mnFba/EN+s78FU7BACUJfDm2x2wdOpjHW2ALlN5zmqmgFTA87DGSG63/Giz95pB/0KaqpkEwYT8aG4Wn50LWL8fBZdBf1WsQM7akLDaFKVZSp1PT1fmpFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hkXWXt8z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D24CC1815;
	Tue, 16 Apr 2024 15:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275682;
	bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hkXWXt8zlTAcP0Ct1DT6+v02P1V+2HnzHzikOoMyphOJSENWoq1DknT4O1XkU+FiY
	 juyqtOlK8rtxKkEuu937xsI1lfS4idfHKCXTJmfqV1ajURcR5NP/8vEmq38ZpkLK/f
	 DMPRzjPyie8dnFJoNni9qC10GguOI/P2pF9SSfqU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:09 +0300
Subject: [PATCH v5 06/10] media: subdev: Add v4l2_subdev_is_streaming()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-6-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cRX39UhcoIccSBN5un+izWragJ2sRwImSu+ClyYCk+Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNKY+/f4U++TZ/6q7+Oz34nkh6wfdiaWkDEC
 VXeCH9WQhKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSgAKCRD6PaqMvJYe
 9eHTEACTjp5bxGMWCkP9l3Qkfb0g01SUGrCqYv0cjXYhjcdg2pWQ+BWkGPqwkxujNj10/b89r7+
 +82si6CSZFya4+EbSJ12s+8qydnYwlLjLir3tVsk5BIRh7+/sPulMjn0ehaebJ4avmVMTyTal5n
 lUGcq2Z1mnARVfdTMnrfBC+wihrM/XYlYK+mXyxY130a1AYVEZQ/x1t7K2SNnxRuGJ0h1fTE+nn
 8GPfEDsrPDHSF5WWaK2LyWMM0obIZXNJRC+GUgreJxiwSjxTqx95wySFcreQRQLpovMjHWC7VVG
 2DdXR15jc8R07e34yXiVSKCMGt/vCKrHaRx/70YTrUFvCE81mpgtesAjQjErz8PShYbA8EyqBzr
 LckDF6/cYfQJsZV4pKGy5dmXu7+mnQBUYQv+fM2L1vXgIhq5aG1fdIaK9CSSoUB2KgjcfswSETq
 tyEAo/nUsSO/KyrkjhHk8fJAMsaIieg67uIjOA/MmpGCZLzEXp26vHbfo6BclvBZcM3y0cDRaQs
 Hz/QDl9zOKirrq/dgXsr3sWEx655LHHMoH19v0ki13V1Xz2n/4dJhpf44OO5lXy6vBeCYJ1dv4T
 mOfxmeah5tDYIEqMb5V5z5kDuTMGOgRnADeXE6QHY+ME3HQZGc3KlsDyXFI1VfZEcVvZ3iMQVmy
 5ytH4lr3fm7zYSg==
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


