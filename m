Return-Path: <linux-kernel+bounces-157227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E68B0ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9046B1F288E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152E16DEDE;
	Wed, 24 Apr 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qC0uEe/J"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6516DEB4;
	Wed, 24 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973197; cv=none; b=V6i1D6qipDqEXGQ1GpRaxdIbLyQlabDsTMShG1Vua+t3syDWvjgxoRtr9W1jPf6UvheRKX2+jEZOOJtTB1MxsARQaN45XCrXybPJU4UuwtRcozBKal/Us9oyit+mkug2ZoeJUrNszgriyz/QgOMSlVFyWtbWgvxlTxgy3mNdk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973197; c=relaxed/simple;
	bh=5DKjJyyR0OoaCs/8PCRwa3HDhSGZM6mtxvJpyyRJgCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frPGmn5VGD1vxHFTB5qiOvRKy2uCI+XVtcFSJ+YDZ5FtyVqbrEO+MXAco5GJdmw1XC6dfZhWN5HDYzlY3/4RmuiKVthxypNOphXGpVZg5ilMp70VnSqzOkc1lliHz8z3HyE8KigW3kunf/PpuocEsLNKx27aE5i/kiGaF/IG8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qC0uEe/J; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CC4019A6;
	Wed, 24 Apr 2024 17:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973133;
	bh=5DKjJyyR0OoaCs/8PCRwa3HDhSGZM6mtxvJpyyRJgCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qC0uEe/JGyWd8Byx+e4HHemoiXipetI7Eak47eSvV748UUW6y7RsVIAlYvAmeyxoO
	 ny1IwB1l62d2r1Num6vzmt9lknF0NUwTmMbHJZ+MN8cgcC2PuIfpvGUZE4eYLA220r
	 5n5FTnz8dNTmPDRJk2zcF4kzD2lZuPpVT1M+rl2Y=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:13 +0300
Subject: [PATCH v6 10/11] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-10-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=5DKjJyyR0OoaCs/8PCRwa3HDhSGZM6mtxvJpyyRJgCQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe7f3XINYH15cBKkGtiF2+EuMuX58KWA0gcw
 qpbFQnYvbKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuwAKCRD6PaqMvJYe
 9WKHD/9J//5kHLUPZPHMsS8OJ8YPINRTfsoih5h6PuPBzrYjYnzTEVFqAL8gTBtYci5RfNTNQcE
 jYHVSWk5bRYh5LXH/HXrlhNsKfoW3T4v5ulaUMmVB8+U3+M6z/cIZGONsNW8ld+WkNDs3LZHIdz
 adIcAT+SCL/922dW797eryHl/q8C3bMQ9PEkhmTVL8lCulozKgEJUvOaCM0XzTxxGe8wqHSlvNv
 dfpvfeBFJEDecv6r1PgBdaltpv5/feByEg3gtaS13Gcm8JMiLtTzv4PpC9UEEpjYN4UtkLVAU/Z
 imjPq+/0N3g3yigDWi+N6IvwdyLdYWlFfLfe/dEeXzLcqOsIwfZO4zR2U5fIM6sSVmeSV1slRoY
 NCTNIGNPfHfiGZXWvSaOz1Cr7Sw8BH/ZqXNT4Bmjkr0KSIcydBV0+bFq7a63ySI/W1yTXpU0NOS
 35vQaMlmQE2QT9MBzi+zfn03nwSzgSdVMxxRWKlX85k6/fC+QR54zGEs1lLtgZW6DBgVaemwgZQ
 O8oa5Wa1OxuhX0ZWfiWgmVM3jkLbBsI1eiUeW2DfYFEIfaoqn6w5mzj7CifPW97XjboiT8oTQfn
 CKFelE73TdDpvPpyUpnhFm4sVFCw9gkadl/xWfgm95RiIubkj8g6rWPyVQLkoWjmo3tWd56pgsO
 UTvsUfFX5PRXVYg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

At the moment v4l2_subdev_s_stream_helper() only works for subdevices
that support routing. As enable/disable_streams now also works for
subdevices without routing, improve v4l2_subdev_s_stream_helper() to do
the same.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 72085027e213..88cfa5e0157a 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2402,15 +2402,24 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
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


