Return-Path: <linux-kernel+bounces-146654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81488A68CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45F7B235C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15912CD81;
	Tue, 16 Apr 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NjpCdpFi"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F612C52E;
	Tue, 16 Apr 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264050; cv=none; b=O9hKL/Cg5iOO1nRaYkzHQIE9R2t9e9OYrNacHsObLLXx7qeab0AOxI7vLCHIiW/y/euY7AOxMtdk3143x4WwlFyfU7lPslSQFJ+Drx0qg09vHZN/uwyv7I37hk3mpYaU8OrjeVAH9ED+KP9ugBN1Ou018xD1atxuII0EWUK1AM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264050; c=relaxed/simple;
	bh=QUIXIag+hvRWU9wlTolKXQYXe77jOaP6Mj5YCsZs9Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIyAQD6CXRoJDNa9/L6eJ3PEIEdElQPCkYIXpxlzPa6cacnd9qmeaIXGt+7VRL1tjOc8ZGpmXifQOA9+B2qhNapGVRVNjaugA2C2Y2JoQmzPWC8nj51/jG7yErlTRihYk1MGnehJhWcRdYi3r/CRetJ+MbHC3tjwSl/R4eOfc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NjpCdpFi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B5A6182C;
	Tue, 16 Apr 2024 12:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263991;
	bh=QUIXIag+hvRWU9wlTolKXQYXe77jOaP6Mj5YCsZs9Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NjpCdpFiMwS0gNFsuxj//3lohX3iXQVfDZesK4TsEzTw7sBjOEXSieLOurtpAVJdL
	 GgOxdBO6lrXj4cSnbuXmxaeaLd4Ns5JbBn9WoyFSLEmZetB6DzDaVcNC2NjY0eYUS5
	 tsFppbQOt4n+ggmWVJf+plcFMymtFgWDz6NUeq1Q=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:09 +0300
Subject: [PATCH v4 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-10-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=QUIXIag+hvRWU9wlTolKXQYXe77jOaP6Mj5YCsZs9Zc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWfylPU98r1DfMzWnp5XPdsM7x3jcGm55fmu
 3WFK1ZKWJyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnwAKCRD6PaqMvJYe
 9StoD/4jhv+3mq5r5K6QD+xjUDEJLRdnOyPw6IzIk19CNTR3GEvBlSFVprQVe4sUED4TcWLHAKn
 89mk0Y7Tw3vwuJv0iqwjcwELpLhiLjaKuSQdxImu+0EootKR2SYfAXQ++vQPiNvibNXv2En6AUQ
 V7MwvxCNp8oVVF7hen4GeKH8NBBoo1wQRcneau1f8L3wBHk+0KEaAITdvsrt6GuJqJ5AEL9qTEj
 xWoEdV2gZRftWcxVaX8YfUStSrt0+fA/JedtstbIGOme/MmX4TXrCUcfGYYZyz4GUHSU37LZtrF
 TpSnsEfv7Ly8uPpkcEMd8pviLKWSB2ccBZjaAIcmYwCcLB2FWMNGQsvPAFesWXT+UDmvtcjRYfs
 Du8k0auZ7od4ykI2uymA3iYUzRvyLr/a8+5FKSJeFMzje8Eo0jzm1mzZhZv3kPO/NBWKZsLxLlo
 Bb36lW5zfWYsrx27Qn0wHgET+sdqw2dTdQInhVMvYU/6JaWXtyMQ67qpmhbUMeuutDbe8lW4nrH
 RUXE0DYvirvG836FzqU9SiqCOutsPp+oPZ+VU62oYBwaTljm5maEMJbs87YAlyyYqd0SYsegruV
 9h9bTKwjKz8e2TWZgYhmx07YJ6YQXa03vsPrblGUTz85m2+KKSQBJltoiF3xmT7aITBT0Op/Zhy
 FDZcHF8DPSH/Utg==
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
index 1c6b305839a1..83ebcde54a34 100644
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
+		source_mask = BIT_ULL(1);
+	}
 
 	if (enable)
 		return v4l2_subdev_enable_streams(sd, pad_index, source_mask);

-- 
2.34.1


