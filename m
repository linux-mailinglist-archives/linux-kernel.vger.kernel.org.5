Return-Path: <linux-kernel+bounces-138512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF189F271
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB0B233FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A015EFD0;
	Wed, 10 Apr 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sfcDrSAC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A215ECF6;
	Wed, 10 Apr 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752624; cv=none; b=u36TFF0Dnq7WQVCe/YI6ZnGNYsku596obVUMIVrTjLfk9P58hCUBR1Bauv5DHiKM19Y7zYPl2URDx9UdmGSjLmq74NLxxxM3IHT+HUC2boi8ExYgz+SmKrzEv0vHY56s7VZADMkxLHgGZuz2/m8/eYE39nEL/6D9l6pF6EdS89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752624; c=relaxed/simple;
	bh=hRB6xu4Gvrssh3hd8DJ5x+z0vwvdgTm2jJp20gCrEQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsSJQlxWGGYRRpTL+gfMCGkOgPI4Ppy1vYPBB1hLPRtvr1525/2Lj/vMMlh7nCJHRGEU7rwsiZa9TJWRleJbpNArQTdviJGGzkkiH/2vfO02qvCZXJQH3xyLNEl5F5p576iamAck4r0WzU4BDEmMYvMOsDqqlh3kMGNNUZKwd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sfcDrSAC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EBFC714B0;
	Wed, 10 Apr 2024 14:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752572;
	bh=hRB6xu4Gvrssh3hd8DJ5x+z0vwvdgTm2jJp20gCrEQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sfcDrSACz0htDyjgcxa2NuVtPM0+z3Umjmp2aC/NESaVoAi5v05mz1ypnzA1R61D0
	 efnOgMpXM8jGb/k1UJxfzkQ63TagxPCaqqdxIImFsD7uvJb61Y4AWJ+Q+QrOmg9DRJ
	 JWMhb4qN9jtr0vA28cGtUcPZI0WHa7MqNIUiYa6c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:54 +0300
Subject: [PATCH v3 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=hRB6xu4Gvrssh3hd8DJ5x+z0vwvdgTm2jJp20gCrEQE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofgJyrv6yCOEWpoR3A9i+WJn9yQs39dAJLN9
 KdT4u143kaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH4AAKCRD6PaqMvJYe
 9RMvD/9Ta8NNCGdrq4kkHx3nHJxgf7X/LGGWZGaEskyUklwvSkpvQjoUoheMtLyhkAfy/R/SgfH
 kn+OVqlpZP9cjfQ5nl56yzuYrwVRofxwg9Jm0snqsTgsGIhRlc3QDObyVbzsyI+xnUqKRXodEvb
 koQ/WglskmJ2uUawJThfxOAWZATA2NVLhZh7EgazbeWThgAb0WKGiGnI76K1cC7E68ZF0l+ye1O
 FcaU8LMhBqXuAwiYbH4G4qHEWB/hVnb3j2iVNmmtxhm6z80IPJBpM/uQhzXIknvdiSXqAjNvIVz
 Gkd8ZeGV5Kc5n3kIho3LVc7pyGTfUFf5i1oEPhr7op8cCqxnRSEWxDud/aYMOVg6a75QlF6Jz/3
 GJuCvToxj2HGcS/JF5Jz1sahgm8bmf4O11JLrRIXpEdU+8a3dLCFE4DOiKrCQBSQwKl4spTw8JU
 Juf0YA9Dga7yyrstGMz6POGDSpieYuYy3lriHFVkohBXTAD193oKR3/T8Re7IWanNQKFEXGkhA/
 v8xduF2xXQWL+gQhfzR97J0M69hEbbbqMOVk+YN63fVfURY2z2r3E6Q2Dkfrnh2dzGWr+VAo/Ky
 Y5NYWV8yRyqYBJeZz29XdooRpm8+iKsZjiKVT97v7+32pzrADO0xuVUI7yiuZcf7GSoeF4Nv8vS
 lZ7EQVzGzdtf3xg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

We support camera privacy leds with the .s_stream, in call_s_stream, but
we don't have that support when the subdevice implements
enable/disable_streams.

Add the support by enabling the led when the first stream for a
subdevice is enabled, and disabling the led then the last stream is
disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 20b5a00cbeeb..f44aaa4e1fab 100644
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


