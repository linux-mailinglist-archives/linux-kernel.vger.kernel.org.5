Return-Path: <linux-kernel+bounces-131259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8A898567
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37AE1C260C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451A083A07;
	Thu,  4 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ihy3tg0d"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB282860;
	Thu,  4 Apr 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227826; cv=none; b=Av0/favNXtxwelYp6n2Xm4X035g1YuAsk45OwRVrcix4+1z4k6qxiYzd9Z7yY1Uszxup9kQAuZ0Ppjt7H0x/ieA21LnT4KACWa5UrDJVmah/ryIxeQ1Z/LGqPCgMlMaq9FOI/0fzxJwwfqlx6BuBzimxhchV9ZWtlYBB4YERDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227826; c=relaxed/simple;
	bh=GfjARRmYhZQQsiUkYR1m3t1+Io8a3x14bSPuokN30zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH4ht/x9htuMRNJmngKc6+p+k+1qm6PYS9o/x6iLm78JmC8tK4tOa0IbBeKNc/rPWPBBw3lmoYvoULekIACanUFDIC5w41R4xIf6uYSVzWjJuQ2+12igxtIR4imiGlkPJfC3mnQHo3JVxXLg3SyJtE4OOWRzCvApYtIHDn3QJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ihy3tg0d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A366ACB;
	Thu,  4 Apr 2024 12:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712227782;
	bh=GfjARRmYhZQQsiUkYR1m3t1+Io8a3x14bSPuokN30zY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ihy3tg0dZPV6Bt3xYK0eZe+cdWAMU2MUm8LiS+WK+ijSXZ34YoVVMXfT2sItMqrPB
	 ysHpbWTqMuUq9Qo4Elm5IYP3hmguxOYvJnfnNM7+Ee+5CaBf5ds8107QEcuRYts2Mz
	 CdcQ+Ez9Ra1tgEMpunyasgscjVcS8IG7d1g0n7p0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 04 Apr 2024 13:50:01 +0300
Subject: [PATCH 2/4] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-enable-streams-impro-v1-2-1017a35bbe07@ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
In-Reply-To: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=GfjARRmYhZQQsiUkYR1m3t1+Io8a3x14bSPuokN30zY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmDoXpLG4W/viQuMN8fixmJX02jfyMjPk5nfhuP
 w2V72zWN9yJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg6F6QAKCRD6PaqMvJYe
 9fCgEACId0SnI01QKLidTGMOuwL/WsE0olMUSEllLGkgkw37UZOMWlgpHaapDDrUZgLyXSJruSd
 nOJHB25TptA7MxtAh6W5bicCgOzoCHg9nxDqZ1xzNwUVRxfEq6Ao/D9Wj3pTNPZlIA5EFtcTbMs
 NVlUtyR5pwxZfvORcqkxwTVSpOWNXPb95OLjUI1sKRc9HliQcgj/oAOkP1XVinh+aMzKFW7JsrW
 ZwNHUEjqxwq/TZaMQvBX87g4vgB5IMYZFMY1aaivQtZNy01SppftmfbRzMXil2qY056qlz7Rt25
 uNv8xOPkiDQdd6zdgqn56OKFiIYHEmyEhheCbHYx4xobcza4T2QpYwKXTXOKaeIpjPjvNYS/pYy
 kGt9YuHjfUuOo1AUBnuMUfHKFT5TUB5UFTf5NehKYKpX99GIBa30GnIequ57Vx5TE42di8qtX+n
 8tKnDSGeX9tcmecFwl6lbgqYSTrAKUSobho/RGvv/GTBMZGb0v7mo56wVl59DbZn9r8p+vBr/w3
 KKL1srryl1w53p2h8oMlLaKq+BpRBggZvDHJE3ChFdsAjXilNcaQnsCHzMH8nVkgRUn6mkqSe0w
 yYSNCCFRx1/F2AiO2ChA3stWN68aNjWRJO5Sg0uT/t7w6Dh5wpnt+eJkmjQ2ByKmYn7KLQSvA1m
 hOTET1CCsgn+XBw==
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

Fix this by adding a new field, 'streaming_enabled', for
call_s_stream().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
 include/media/v4l2-subdev.h           | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index b90b5185e87f..3b3310bce5d4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -404,12 +404,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	 * The .s_stream() operation must never be called to start or stop an
 	 * already started or stopped subdev. Catch offenders but don't return
 	 * an error yet to avoid regressions.
-	 *
-	 * As .s_stream() is mutually exclusive with the .enable_streams() and
-	 * .disable_streams() operation, we can use the enabled_streams field
-	 * to store the subdev streaming state.
 	 */
-	if (WARN_ON(!!sd->enabled_streams == !!enable))
+	if (WARN_ON(!!sd->streaming_enabled == !!enable))
 		return 0;
 
 #if IS_REACHABLE(CONFIG_LEDS_CLASS)
@@ -429,7 +425,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (!ret)
-		sd->enabled_streams = enable ? BIT(0) : 0;
+		sd->streaming_enabled = !!enable;
 
 	return ret;
 }
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..8bd1e3c96d2b 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1043,6 +1043,7 @@ struct v4l2_subdev_platform_data {
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
  *		     cases.
+ * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1091,6 +1092,7 @@ struct v4l2_subdev {
 	 */
 	struct v4l2_subdev_state *active_state;
 	u64 enabled_streams;
+	bool streaming_enabled;
 };
 
 

-- 
2.34.1


