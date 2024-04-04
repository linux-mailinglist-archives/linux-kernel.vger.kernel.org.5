Return-Path: <linux-kernel+bounces-131257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890C898562
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C351C22DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072288062E;
	Thu,  4 Apr 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fcKmiabG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F679F3;
	Thu,  4 Apr 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227822; cv=none; b=cOGmKO74kNNVbOySDA3KnjqJpSlwCTk+9h6dgKAz47tVWSputRVmiGWG5tcRxrgbJNATx22xACuxN+obJ+JQnHmlMTLASGTh5zAfgw59Oiey2QZGM2ELaAXcTg6O6O2uncABVoDSt8noyELN/Bv7RTkCMYUqAycZtuBQcwhTvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227822; c=relaxed/simple;
	bh=6MPyMFi8PEkTF0LORiU6bIKAuxNszgSZ4Mw8zoeGXxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h6PJiZApd9zTFHCHPu48lz68UQp4JJa1y8iWryaBvurwhGOxHpKrsceF7txvmFUpmtV7mTNFlm9kM2D4KjfVkADmxlIAEuKGLnMhbmOvj+vcyHD5uz4o57+EmaVMSjwgka9I32klgoGMLCoYwZNehyJJvXtlyqR8hYY5qBk7zBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fcKmiabG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 614F71A2;
	Thu,  4 Apr 2024 12:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712227781;
	bh=6MPyMFi8PEkTF0LORiU6bIKAuxNszgSZ4Mw8zoeGXxY=;
	h=From:Subject:Date:To:Cc:From;
	b=fcKmiabGxH2EJcWByKh+8eC4qkjWUq4bfy8nrdGCg+kmsvRwSaICMap83o0EtJZl5
	 jIWRwgKeU4VLjWM+FBlolZ0wpZLZnQtZpj8GinIjnOcaAsSYY6wCOcgfwTY9i50uWh
	 DKylIZF57Mk/ohOLkRf3IjoXwked9J7b83xvf0F8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/4] media: subdev: Improve stream enable/disable machinery
Date: Thu, 04 Apr 2024 13:49:59 +0300
Message-Id: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANiFDmYC/x2MQQqAMAzAviI9W5giOP2KeNhc1YKb0ooI4t8dk
 lMOyQNKwqTQFw8IXay8pyxVWcC0urQQcsgOtakbk0FKzm+Eegq5qMjxkB2Dt34KtrNNW0FOD6G
 Z7387jO/7AXzV8AdmAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=6MPyMFi8PEkTF0LORiU6bIKAuxNszgSZ4Mw8zoeGXxY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmDoXlAeUFEp1qf2B2zYlaxI85/sUWHFRTQEF4r
 uteGaZ4PDKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg6F5QAKCRD6PaqMvJYe
 9QEDEACYP36ic1YRePhp4SSKHzRAM+uycBwaKaAOFt9kWZm+wE9/jCBatW1GifFegelpsvIEyBO
 W4GGNnRfLKgUGYs3dc3CrVNGblH/n6a0SkVuNP498Gmt0WziXoMs2lo6cVsWydwCY6+5oX+SAym
 fsF0QgvGmV7+znb3m+Ln2s17dgaucLVjOZnT7GudncVv2QOpeuaPWmXLjjbcNsqiHiriSIFU4Mp
 S19c0HZNsbUS/6qKNbzp+fE4uqPtGd7mWS2ONzpMwmyXs0F6UJHhngIDByCoBWj1lt0gpTuJ671
 2OfhF58JBH526ikTzKljRSABhQcNwX/y4UDA3CcjoOMmW5htCiPaYSSwTHfKUx9IsLCXkz+12V4
 fx/yAO9zL4eMlSGz10d+iCn32aRO7qHRgBBI35GxLrCLONyhtQ+uPq11icT1NGX5/dtjpuVGlXc
 F9E5kwjNeMG/onoapTJPbeXDNDDojDij0zikq4YzupRr+I69yxCBsfSumxr5H57SRX3FaIE23nI
 VXmxWyso+IhR90qK67aF1lT68CjsELgJWmxmkmYhSNRaEC1nQr967j0m7mkQ0YW+L4KD27jCugR
 S+6w/sUU23bn5vfWs2dl8bC8ty58gR3e/XxTxy64SvmFxMaPlYq01XXnRaOp275JxJq4ATCF9B+
 DRNNCxKDL7b1BhA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This series works on the .s_stream, .enable_streams, .disable_streams
related code:

"media: subdev: Add checks for subdev features" adds check to verify
that the subdevs implement the proper mix of the above ops.

"media: subdev: Fix use of sd->enabled_streams in call_s_stream()" fixes
somewhat questionable use of sd->enabled_streams in call_s_stream().

"media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback"
drops the restriction of supporting only a single source pads, and
prepares the way for the following patch.

"media: subdev: Support enable/disable_streams for non-streams subdevs"
makes it possible for non-streams subdevs to use .enable_streams and
disable_streams, deprecating the earlier patch "[PATCH] media:
v4l2-subdev: Support enable/disable_streams for single-pad subdevs".

I have tested this on RPi5 with multiple streams, but I still need to
figure out ways to test the other scenarios.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (4):
      media: subdev: Add checks for subdev features
      media: subdev: Fix use of sd->enabled_streams in call_s_stream()
      media: subdev: Improve v4l2_subdev_enable/disable_streams_fallback
      media: subdev: Support enable/disable_streams for non-streams subdevs

 drivers/media/v4l2-core/v4l2-subdev.c | 189 +++++++++++++++++++++++-----------
 include/media/v4l2-subdev.h           |  11 +-
 2 files changed, 133 insertions(+), 67 deletions(-)
---
base-commit: b82779648dfd3814df4e381f086326ec70fd791f
change-id: 20240404-enable-streams-impro-db8bcd898471

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


