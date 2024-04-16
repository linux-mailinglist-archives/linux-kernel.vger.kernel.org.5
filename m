Return-Path: <linux-kernel+bounces-146919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DA8A6CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE6AB228F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036F12DDBC;
	Tue, 16 Apr 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Sm9JEdJA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691D12D1F4;
	Tue, 16 Apr 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275731; cv=none; b=pE07URz5Mmqy9Xi85pGVPVT0v1CRC7YB+YTGzASD4A5OAn9pJ9KBS4FKxlW832HqFMyoUXTnpJvnS9AnkclihkYGa0cp7n5OT20P94bdeywdiIK79Rj2gCyz4lNaN3s1DmClxp/TAi8dXEYbg69usSrYe93J+ve8UdTYVLBdOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275731; c=relaxed/simple;
	bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoM3/BZnAsh67SguEMvjPXqVu8BWZR0znx1EGywzhCxjbAEQLt4VjspcyjNsT1pFEuuwOwNz//WLCB6YduM0fHMXpOqC1YOk1Ym5UV7CNkzb0jy+JQ10wjyqHPmrhhyD7wYLlGduSdgs7JHNz2CoCvJQ4wJE5mlt/DR0Xdbn6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Sm9JEdJA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3A58161B;
	Tue, 16 Apr 2024 15:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275680;
	bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sm9JEdJAnUcpKa/S0/SJbUkvr/ofPHJm38EfFABmw0eMaqwyeRm/J7htX5wC+ngUY
	 NXXW9/I1gv25pcSXXbBakfiwwanzqFtaRcjioy+HPxozA48Cb+Dj+Qg2Amc+/+Tqss
	 OUJyeDBqa2nVXau5uOU0kC3kwUwd2BhrNlQyaMNY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:05 +0300
Subject: [PATCH v5 02/10] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-2-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=upwohULj/Oms0C2fpFjxKliuZKRIVz3n+cZk2HiI8Fw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNJR06bdREDrMnRdSGsw8YD2ijhAjZk3Yxls
 svGIbgOq/2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSQAKCRD6PaqMvJYe
 9Ur/D/4/6mjhKSHmgdwiMAA1sGprHBWPdYOfMcq+xPrKLGYegOWArat2B7o6OJ3spWVaoqKUIdG
 CPN6FrMzLwMyCQOgPP/q8MnaoGWcCR+jw68CSzc7IIrr9eSyYEJ05QlqdG/lCicmL6giVQKBBAn
 NaJzjzYjBrgyWgpxD88wrtmkUi7KtCcsYt8KV4UoUkzxdgyh/1SuM+cTu5Hy9qVEFmR5LL/ANca
 8zOz++/eXkflXIRQDmsg3sDbMVyQxcThVgcon/h9ZQc6dDgxzvw18BTw8fMWnUiR+hiIjUC+nFf
 w/fE+bHsnKwT+rBfQG41Z0yjEIUNpTmel25iT8OnyWbTvMbWhs9SnkS4S4feTHa8u9IId5rg+DN
 vI1dggVvHbO+/HkjuZqDKVBXINHHeZextV4XpbWeg6RH5bZsfM57QEP4ySX8uX+vu0knu9Jkl39
 Wra02tc6BW1FuDV0aoedykvZkp5A/Azf4OXAB3CFhk8Cv+aPzM6fabWdSwViobNycseoUmZm0Me
 1KVnUlX2NJacbFyjh6yvnSjmeuOFDC3hf2YA3oxodrL4e0YfmSE0K9gf9SU7pun+iqxh6qg8RYl
 zPdMiyGlp9ykbqIvd5zzszr918+Xd2Y4U0N9cr1SQhaf3U6FN2/7aWb0ir1NN/oFyOvf3TGEtQQ
 EkvV0PjHmjvbY8w==
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


