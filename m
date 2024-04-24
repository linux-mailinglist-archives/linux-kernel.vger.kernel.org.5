Return-Path: <linux-kernel+bounces-157219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43C8B0EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A47228EF81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616122339;
	Wed, 24 Apr 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dAqep8IX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15D16130A;
	Wed, 24 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973186; cv=none; b=G5gv6IPPOk/pVjZKLrL7opSBXzYLGefLy/4VgNiLTf3j4tdHE2CjonUXvVF4MfZwLVEwqW/iMAQRZxL69A/F3Cd7u9CiQPJc4zTN3NJIcQdCaD27GWfB6Q8Ba4R+/Wzxya1HlDW8PPkgh9MElNVWNpv5m9OOHfSu/E0BQl02yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973186; c=relaxed/simple;
	bh=RJfbMLL/yKyWu/90gD0XpUO0Mc8MFKIN0wtjUrMDl/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqrAMauxF9RJlX2JZVXwimkvJtqlH0TAjZZ4RoyL5NCLrawId2mruJ19tWym4G4pFf2+XvAwGXjCaEgpB9ENT48PbGR6HgcmZosNsAOAWCU+ZnGOV8NNMBD2bFev0ujhA0rYwK/8qDyWFYvavU0Ac3D9Bgw0sEEgtModwSH85AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dAqep8IX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4108CEA5;
	Wed, 24 Apr 2024 17:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973129;
	bh=RJfbMLL/yKyWu/90gD0XpUO0Mc8MFKIN0wtjUrMDl/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dAqep8IXLyLA9pGiwtl77R9tFIduLr3OudELiBluViwBksM1gkSlpRpRjmXLTLK56
	 v3D7Q1T6TvXf+wqRzRBkZUiThP9C9uvQOhH6tgcb6dTF2rqQ9sMWsU50QvC9f9/paz
	 gZiJtZAVOboUtyZqMECQibKRRCSRtkoBfOij7cEc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:05 +0300
Subject: [PATCH v6 02/11] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-2-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=RJfbMLL/yKyWu/90gD0XpUO0Mc8MFKIN0wtjUrMDl/A=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe4euivBY7SGfPRQf5UQ+RUMJP2n/tRx7nIT
 tvNKQYBeKiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuAAKCRD6PaqMvJYe
 9UGBEACTUlzu+/VSUo8SQ+reD00zp+/GrmbCO9iW5lW5apJdQq/odX5pcgxqews8LaMLwBQ3HkZ
 8Jgqjjm0zQtC0NyPN8CGJ+3HFPTEFMDj3JElVDTlt/bIkcp5dElW8BljFlYAerddErdaASt78Ea
 pqRoKs2CaK8LJ4EcxSWOxdT6d0WgwVNMIW93bdjSLgbXr/H8sf1WHTf89yztgkCI5QkrD83OFB3
 5ckkRLaRfG6lnrnAX3NfueM92LpUw152hkmMx9MQlLNPfMfXyKWClolHfgVXG8WzHfQA7jqXaku
 aGcV/s2SKTziBI4QYoTsvw5uDwtGSJjhVmTHM9bCxEjJTL0N77YTocWp1NM9dH2jTDT1IO/TZCS
 utz+ifIkZyiOg7J1R7rRKHKiUvBxrjHKi2D6OJjqEZ7Zr1NqCO6YxAnEX9UvTRc7wSl8P1seNqu
 FvUSz2npzwjyUUwPxb2YbJkQgJM5WGzS+bw6pnpnXZr6rAuYAhZ07JoVQdxuEwwZvxyE4Uj2ygb
 mpLjOqH0rq6RlWpRj1l9RPlloFXh+2Wfzx+nIf3ZHM8KRS/J9QbMuwigcR8qC2T9LEr1JaSVOmo
 u1mzAetjmWZcDCF7EpsiWACQRF+EaOgFpDb40mFDjUOIjeb763ql+k5f578Kb3AXuuqg2uzvtT2
 Va5nGM/ULJABsGA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams() instead
of open coding the same.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index b4f0b89412eb..2c5a9b0029dc 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2168,7 +2168,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .enable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
 		return v4l2_subdev_enable_streams_fallback(sd, pad,
 							   streams_mask);
 
@@ -2285,7 +2285,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		return 0;
 
 	/* Fallback on .s_stream() if .disable_streams() isn't available. */
-	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
+	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
 		return v4l2_subdev_disable_streams_fallback(sd, pad,
 							    streams_mask);
 

-- 
2.34.1


