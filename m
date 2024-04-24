Return-Path: <linux-kernel+bounces-157221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A38B0EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C068C28F19F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FCA16C86D;
	Wed, 24 Apr 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="my6h65mM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98602168B0D;
	Wed, 24 Apr 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973189; cv=none; b=MYZquPfO3x8EI4zOsR0xdGeJa1cBomVKFwIVgyp/zuL3ap/kZq696h35ITipWLyZXO9ZLjeM6H0kVg2czGnRQLD8ozwHEe1l33Vl/CC9kwznyTqpGNRXpHyXUDWj5WdE1fNNXQTeSL/arluGW8EjHz83RrXtJeNdjx0gGuJ2l1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973189; c=relaxed/simple;
	bh=2lIFxBLgwCJzX5JrJ3/dXenO++e9t4kzGOzXSqGAN/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCCBX5zYVG0mbXTUnhY3Ri4je4+gRui0MIykO36xsB6uHcFoEUTuqHFo8soxHVwqCXhCUYpA4bWRQSUI+KPkGXzG7GkWnz5JVZAzlCnaRFQK+yRe7cWMOsuj6igtiY/x2mgdRHNS6Sqfcr0udNPDdKbTMARtf70l106pIJBiiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=my6h65mM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 539EF114D;
	Wed, 24 Apr 2024 17:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973130;
	bh=2lIFxBLgwCJzX5JrJ3/dXenO++e9t4kzGOzXSqGAN/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=my6h65mM4YVeZ9DcZm4YoLe3/YS+PeBmoNi6UXiO3u8YvtCjcLwTyxA3JFPp2mXBo
	 hcqYZBr0lP+8PV/HnT5P+GsqdKLTIhNLbd2FioSrTv4kVoPj7JhV/TCfuR/IlXxL/0
	 k+zk2AnMhMS0BEoUqh13GsQSYhHOtTxbRUDUVlYQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:07 +0300
Subject: [PATCH v6 04/11] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-4-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2lIFxBLgwCJzX5JrJ3/dXenO++e9t4kzGOzXSqGAN/o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe4sc8wfidWhB2GG2M6RILegC+TQevaNNhab
 dQZRlGNKcaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuAAKCRD6PaqMvJYe
 9aLCEACRi/seeMGW9AvVX9LT8jHeKozD4kCJw21DoEjh1WWjy8JgvbeiAW1wGV5jA1S3a5oC642
 wZ0WaF20j23YGoC/ZF3CRsDLKnQZAZPzwjHbudmvzD6Tl5HDoydjQsfyLLOmi4Qi+H/Ej5muUKc
 CHwrxZPjHrdfE2GuMvo7QoKhOmZde3H0VSKt3v3AuXGasf59JLe7dA17AOyRdpAKCjyVRuhDYM9
 0iGOmnxTpUpFCQ43SUk30hSB7Fm6l8g1qTfMxVzsVVxhT/aDB0K5c+9w6ngADuebmeJcvh4eqy4
 uDsnJUzm3jIlWwWvT4VMYWFgPISZlFnmFeo4Oj2VDR8r06E7BaHq2UDZedAtx4d1qjZHyo3WuE7
 Aeqiu7svtawo4hLQPN8ZZ3WExMxkBmYSCefHx3fNrtqfu26PzkjFyC8U3ok/gVOl/Drs5N+UgvN
 JAYzCP0I+dmC84rB/W/Ve311uLv3zhfDdc2WTL3TEPcNGS+4s4urYUDF6pQLLq0mTclieUT4m/N
 dBFdzueVPBkPP8Z2HkXqAIB2X/Cn0BFmEH7grERP4M95MqjoBGxGvcIwBDwXLIcu7EMC9YTDg9j
 I1XZhuY04Ht5xVnT8PQ+Wf0kJ6q92j5zXVUQqdQ8zXMSY/O2RysFevIo/enVoiUM/aWTfiaqhtz
 H2T2EazNaCpkwmw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

call_s_stream() uses sd->enabled_streams to track whether streaming has
already been enabled. However,
v4l2_subdev_enable/disable_streams_fallback(), which was the original
user of this field, already uses it, and
v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().

This leads to a conflict as both functions set the field. Afaics, both
functions set the field to the same value, so it won't cause a runtime
bug, but it's still wrong and if we, e.g., change how
v4l2_subdev_enable/disable_streams_fallback() operates we might easily
cause bugs.

Fix this by adding a new field, 's_stream_enabled', for
call_s_stream().

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
 include/media/v4l2-subdev.h           | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index b67456944ae1..6bc983973d3b 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -451,12 +451,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	 * The .s_stream() operation must never be called to start or stop an
 	 * already started or stopped subdev. Catch offenders but don't return
 	 * an error yet to avoid regressions.
-	 *
-	 * As .s_stream() is mutually exclusive with the .enable_streams() and
-	 * .disable_streams() operation, we can use the enabled_streams field
-	 * to store the subdev streaming state.
 	 */
-	if (WARN_ON(!!sd->enabled_streams == !!enable))
+	if (WARN_ON(sd->s_stream_enabled == !!enable))
 		return 0;
 
 	ret = sd->ops->video->s_stream(sd, enable);
@@ -467,7 +463,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (!ret) {
-		sd->enabled_streams = enable ? BIT(0) : 0;
+		sd->s_stream_enabled = enable;
 
 		if (enable)
 			v4l2_subdev_enable_privacy_led(sd);
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 1af16b16f0bf..dccf693c680e 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
  *		     cases.
+ * @s_stream_enabled: Tracks whether streaming has been enabled with s_stream.
+ *                    This is only for call_s_stream() internal use.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1091,6 +1093,7 @@ struct v4l2_subdev {
 	 */
 	struct v4l2_subdev_state *active_state;
 	u64 enabled_streams;
+	bool s_stream_enabled;
 };
 
 

-- 
2.34.1


