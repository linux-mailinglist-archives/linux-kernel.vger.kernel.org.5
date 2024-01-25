Return-Path: <linux-kernel+bounces-38850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C383C73E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1282925F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5374E17;
	Thu, 25 Jan 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OX2EIbgj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570D73175;
	Thu, 25 Jan 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197770; cv=none; b=I2ctgmaeoXK/clEroAKvS3C/GbJXcoNiLjW8Mp4ApN9D9+qcKf69TWKeDZOMF1ZXMMzTiTqwgaeJSGUVIhV2tzLQfyiq3OiE+UJSRrRR02CttacAQIhHgJfI+r0VxTb25OVG4YEB80hT8AzmChGWg7KTWnW29r0doQtOY1g9Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197770; c=relaxed/simple;
	bh=E0w/XiH4qT+OHnPrSm3O8kwqTF6mJdF3nkwwq5HY+/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efiCUXT6bYrkWo4dLfQU21C9/TkGj986eCGDN5ZKr88uTJEnmIJC19i7hkbXmaFCDyZBOOZIy1wmOXJ9GuI2R2wt5Pd1wQh36NhWxlgBEn+PckWakUR4dGW1NVNTwPf0ajWlNcwxcf3m4P0jQwkJn5xOBU/tT+j6mYdoRBELev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OX2EIbgj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.175])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 584BD552;
	Thu, 25 Jan 2024 16:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706197686;
	bh=E0w/XiH4qT+OHnPrSm3O8kwqTF6mJdF3nkwwq5HY+/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OX2EIbgjw5kG/6+UCF8+6bBs/CwYgBG8P3F77beraH1q4fP0S6DyCCiH+1oB9knp2
	 HVvt0x4mVNLGIGH1QGFyPjlAmO7jk8W9TH7W99jghJ5fXcnD2ZXAnPqBLNKOckn4TE
	 551IS3UwEoPB8VM19ek3mYYOyQosQVs+s5SvoU8M=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/4] media: i2c: imx335: Drop setting of 0x3a00 register
Date: Thu, 25 Jan 2024 21:19:05 +0530
Message-ID: <20240125154908.465191-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125154908.465191-1-umang.jain@ideasonboard.com>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register 0x3a00 is a reserved field as per the IMX335 datasheet,
hence shouldn't be set by the driver.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 5cca8d637952..0df9ea189fff 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -249,7 +249,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3794, 0x7a},
 	{0x3796, 0xa1},
 	{0x37b0, 0x36},
-	{0x3a00, 0x01},
 };
 
 static const struct imx335_reg raw10_framefmt_regs[] = {
-- 
2.41.0


