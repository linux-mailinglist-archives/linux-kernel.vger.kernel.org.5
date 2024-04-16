Return-Path: <linux-kernel+bounces-146651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEBC8A68C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBE62897C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3C12C462;
	Tue, 16 Apr 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O4NiWO3/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE912BEA4;
	Tue, 16 Apr 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264045; cv=none; b=phf1pUBmZa+UEwHEl184I8M8PcbXnCS1r8WFPIm1w+4hQr01yL8ktQaQi774ql8uD4RE10BrXES/nITp3quOHeleTEoAKbaGGM9G0jZxAvsABbZi3VCVdAHASDLlkKSqvOjpmcKxL+K/+75RMFzP/GicjbA7HQdxTDJysSEwKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264045; c=relaxed/simple;
	bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmGDXb1APD7e/JCw5MleaKLKk3i5o9qnPYEwbI8O79ouaH6e2NqZfZJeqE+RgwM793WZ/Jj7xUlFo8gcpDGcsXQkK2t9qNZ5Z4Y9ZzJlfL928SIflwdhZZdAwkd405pcGAaGpJtH7ZESe44dLfQit4gZ5z+4zrF5ksSOOg/ddnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O4NiWO3/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A35F51653;
	Tue, 16 Apr 2024 12:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263990;
	bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4NiWO3/OLfzbf2vmOoQrI1zmhHI4C7CMpXddAJ5mgZg6OfMXBczz0oJpa87PUVqy
	 jCz20tjcZ+1GkFNSCmE/hbZvn76lw1UQqsOfY9GdXhtgUC0xg1tFghfUnxZYEjRoR/
	 huGJDAt8Wlptd7pbKiVLcS32f2F0gZPTpVe+LgYU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:06 +0300
Subject: [PATCH v4 07/10] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-7-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2Xt7vzkAHQK8ZH9kkym8FF4Sl2cd7jU/rDWfYtxbPXE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWeaGr6cyHEo/rgUE7p8tfeqlUMV2SZ6g2Tl
 SYHKSUcCOOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VngAKCRD6PaqMvJYe
 9f7TD/0UZ/r8/b+fzMMvzj2UuD8gfJPMgZi/LFLlsJAZNDS110+CDuTLKtMYW09gKZotPlX3uAF
 SEcCkuRy7Ct9TVT2CwcQ+ULpziOFyVYdbW87W+tNl1p9BwXjp80BF2HgtJv1pODeu2VijMD2HKx
 OTbpC60ed8q3lYAdr+hz/kN39xblOmybimFBAuEN7tDNO682WSBxoWfLrZa8o0UGtblJeusdm6g
 Z/Ugtng2ENup3d4EhbBE5MJJeQCZz/WnFgv0xiSZ/Ah+c9Jaa9JH008fc4gdih5JCVfERvC5ty8
 cJ/MYHb2s/lhpJxHGknq5r/XQ0XOs9i9kqWNlDS4IyiFrufO2RNdN3BNQ5pCJz0Yi4Cc4I88vWd
 9P4l4FNCWs7gd324whUExFqAPQFu2D1WywkeHfLG1k4nu+H05lpJAaXj7lA8ljzE9WCRQe18zo/
 gOQzMAUMDAE4aZyrBJwqHUMpg8uwWtBIb3e2QYjGhNeyono3ICoVPCN5GK2t24YwiOWfTMjHzdw
 Ua5IhLwCXjb+iAEAWHm5ba8IgFt6NQACEi3A/y7av0ejMaxjWg1pPh41WgGbEPhKRfmzZ8RTohc
 ato3MUXad+Q81yBVOnYJwqOmHz6TZVaJ4CQw8r1lXFUcTdOz7o0NHZdRBMmsYvUIO3Mw0PRTwHz
 ff0pv6Da1elhtEw==
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


