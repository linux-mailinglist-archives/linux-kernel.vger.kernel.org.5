Return-Path: <linux-kernel+bounces-146646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68D8A68BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BF288821
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E312A158;
	Tue, 16 Apr 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y4FNa0Vr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00A1292E1;
	Tue, 16 Apr 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264038; cv=none; b=af9IhzqrHTDKJw2qJKwU4SxFooGDzRyEg+YiA2/C20bMIIT+KK5S9XaXEllac2qQ/g+9fPhoDrhtTYk+4cqUGOne0juQmS7U+NaY2Qc/aM/uzEhiblw0KIXw+6gGUn3jmC1sv9Lxi+5+TndWpAeM1t50tLjDIl3f+tew5i60PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264038; c=relaxed/simple;
	bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amSoiuiLmdd0FFhchGpn9TbOtVFw3RThE3N4Fen4gHptNG8s9vJ76KvLS45gQ6AdI2caodZgsT0QJP8HtY18TXeYqKOZWBfuNZf+54lbnWmvwvSHV7iseOWc3IzVKT2CfACrIEuACmaMghGlnEof0KOGlvN+a6/xY6yOoVd7+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Y4FNa0Vr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EFE559A8;
	Tue, 16 Apr 2024 12:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263987;
	bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y4FNa0VrhfHnChqt5xBQp0qQ0lCW0EAxQYen4M8xsKQjqJ1w/PA+40UTMhDQr3T4K
	 /TADJxobu2APzMPN0bofZVwpyA/rzwzlO9iK+jNM6IUpZLqLVzuv45Bm3DrV3si/2z
	 2sTjqmo/BtV5IWhNZ2hIv9VxMhwgn2ji3ASo/ewE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:01 +0300
Subject: [PATCH v4 02/10] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-2-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWcrXh9RytYRmyYC9WgDwVahPJP3rl7YgnVU
 LweDlMeYWiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnAAKCRD6PaqMvJYe
 9Xq1EACYQKb0R/YVkx2Xn1fg/n2Z4oLrRYoJGN9WyyVx5c9CwPr8GIBqOYgzjN6lpuNZUmFmMsj
 azzEMrcmI4+pfPT7WPv+nyJO+kjHD8lXh0ofQmvgNvKj9BGfzhRUSsiMZNDKDNoa+Qf2zK/UV47
 qBF5s5AmP40zNVxUc+sFehkrUY9jl47GAUZEXo/3EkMXBa3qR/+l7/CB3LwiRdeDeMNVKrc2ZW7
 Fnveio2ZQXf5rWsD3x5J8aO0jJ6SdZlaGe7msSRB2apDOOOMjuZ6w8jsZ9kOQPqe9ArCszxViQo
 wLXArjPi1ZTf9te7nErrr/lONXZ6bY/8jAQXKrl9tgDhzWxhgu5mbchlH/gnDfdG2KKr5/BHj2B
 /ZTMl01LU6rt1mbG/Je59k4O8uAsny2Ry9Xq4MEDueltkcdh6cGHeJFLpsu0m38/e0LbHe+MslT
 g1YpS71af8PaL4yLNhAihYv6ysMYbG7qQcQA+OtcpztkuVbvreE0ewRR8dESapOAH6TnAc1yXiB
 qvu41ihm81kotQ+r6o2P9yP43OixCNgt4mf2l0N0VIM+mcr6x8Fc2+TS2Y2mPRRow/ELI5zhfv9
 AF03UPOU3y5WNWuYOp9qCuBiJJ0FRAhoxUDNQDLg4YloIlz+veH6nuUTXj6Ly+5evdko+T5z1xf
 qOMnZS3X8zeKuUw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams() instead
of open coding the same.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 13957543d153..4a531c2b16c4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2133,7 +2133,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .enable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
 		return v4l2_subdev_enable_streams_fallback(sd, pad,
 							   streams_mask);
 
@@ -2250,7 +2250,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .disable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
 		return v4l2_subdev_disable_streams_fallback(sd, pad,
 							    streams_mask);
 

-- 
2.34.1


