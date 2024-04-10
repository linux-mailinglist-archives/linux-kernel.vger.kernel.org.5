Return-Path: <linux-kernel+bounces-138507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B789F266
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26913286A91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0972115DBB9;
	Wed, 10 Apr 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OassZM3m"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856315B990;
	Wed, 10 Apr 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752617; cv=none; b=bjgUX4ioUbk/8PBvbgu+4Rdao4sg2HwJaSljCd8YVJni8v/EFIkXQz8ue1EScGXG9qZNio06Yp5kKcHf1OfWCUHEJh0m/xnFvrKb+N6FJTtqzXjFMNZrHTL/yw1dVghN/qcjGTaaFWwd/nR47UZc6XawU6mH4yMtY51CY+OabNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752617; c=relaxed/simple;
	bh=PIKaSKIrL14+cT0YwZSzOzP7fwNqRc3dWyIMQBcnsdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ND1UaUvPy0WQm/su3Dqhp6diMr+Ys1moJnFy0XTwxKsyPqaoHiQv6831E9oz84NuJW0jo6hk22d60lWR1IZZw4a6er/apiWdx1up8Gng8I0GThJPMGGedMYDTlLNVGYfxn4O0qgGb/mXFbjUygZAQbxr/ro3cX/1ntq13javsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OassZM3m; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14832BD1;
	Wed, 10 Apr 2024 14:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752569;
	bh=PIKaSKIrL14+cT0YwZSzOzP7fwNqRc3dWyIMQBcnsdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OassZM3msmzoMCuZ3q0y6x2nwPWB0Cm5mVYkb7OXNu18aT3lyY9VrePhPTc4vOeNF
	 FEoRZiW1vplY9qJeVB9ltFZGxrIs+hpZhqV8yPWgmYcepPMkSPtsZ09ODo3wVzCG9a
	 3HErywfgjdMPVX7+TRRLgHOZW5VwfxQRR8PB3CyI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:49 +0300
Subject: [PATCH v3 2/9] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-2-e5e7a5da7420@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PIKaSKIrL14+cT0YwZSzOzP7fwNqRc3dWyIMQBcnsdU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofe6DFtY8373avyY5sSM3N06UyAbApTjpJg4
 P5EgU40fdqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH3gAKCRD6PaqMvJYe
 9e1ZD/wM6HRBNvozCkMRZ94pXuBR/ZK++ubSj1Tj2wpED87gpdMTtvt3sqP3ZoQx6vKLtHtZqHg
 iUTN4Ffabg1D9AtnoJ/2Lyxa/uEWqNGtEmSG6U2GIzfBAr3F1BdQQvcwg1ByibrXoOUJ1tkM4N5
 ZukGiqa3XczAlfm0VHiM6A+j3+/7PPMMa++c1Z668SwqN/W3dqqWYu8uEN6cF3Z9cR7LPeTHWWD
 ZYsPeAmAccxAxpmoMJ9DJ7eyIBYuo1NnEB0uJlPGjkGPJBmQkijrotKhZPiqQ1QiK/nwIw2TG5s
 JxkMIqE/zmnXqlySRRaws1buBjNWL6jmkL8bU/7PGPrvQO+tAkge+pZ8MKhn2hK0UM6p+CrAjUF
 YjcWxP3gmhf0W5U34xbAdpgNlm2AhLaYnriQaw23LaI/Q6q3vk+HHVYnpol1zi5g1V5xZzS7OP+
 WHiJNU01wv/p3nE+e7dupic18rxUTeXfHUDxMH9+fR9a/g7LSvw6hGxpGyMb8KHLN0aXTO70Ui8
 XXo/ZuTVPHdYs8MalHm9NwFgAg5CzLp6O4pKQXx4TnrcHnksewHWMg6LrAaeubvwSB4CklcSMS9
 sPPlm3D3Gh2GAfs8EaIZqxWd3gF/x8kThoftd0ICKSXAW/oUTAppNm6CyF84516QerXLnXaESjM
 GfEo1KCIbCEI03A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams().

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


