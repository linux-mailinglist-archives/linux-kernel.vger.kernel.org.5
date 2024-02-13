Return-Path: <linux-kernel+bounces-63278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56809852D27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A86328C861
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570323774;
	Tue, 13 Feb 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuUCDrw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8D224D2;
	Tue, 13 Feb 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818161; cv=none; b=qh4nAlF+iqNqz5ezn7uD8cbt0L1iFf4li0kL0ZHJ4B5xveQZ7VNlj+OE5bQMQWN8vD9tOieFhofHqGbWH7mecumok6lRcU2k0otJnslYKXs4ta4NQz8L9NnqXyePVziYB1vbbyNcmwpmjwksGNwqliU8H+lMgspso0NA+x9/Nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818161; c=relaxed/simple;
	bh=L//fSfhtwMkztN2frNmXVbSJ3+AwEgWGJ086titugr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQBWR0SVmUQdBc2WLUUTSsFN06tEdpBa+SzJgvaN2k3iwlzqB9qHl1gFPU2N7Oieo8CcZRnJj3C3T57IWWnUFhy1afwzrYbyDGY9SNjFaYbMaLMsDbKvxtUgmFtITy6SuHFucHZ8TH3UnNYj7tz47e2F8PtngUxRkQMe12HY8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuUCDrw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4699CC433C7;
	Tue, 13 Feb 2024 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818159;
	bh=L//fSfhtwMkztN2frNmXVbSJ3+AwEgWGJ086titugr8=;
	h=From:To:Cc:Subject:Date:From;
	b=KuUCDrw5mlnhuvQruHhj6QQxVHa4rVUJpR7fAdfQsmYgn9aXJJLIHrgbjUUvritVt
	 U7oWQz6PaEI4hvs8okzxdevmIvlbggQQVzNveYVpO4beI7IK4kEwPHjf/E1+rV/4lJ
	 dhfWC4qp8qPxUv91mmr2AYCEycIp/q181RuDOOwFe0SRMeCoNLUCa7i156DS1/yb24
	 LlqUccoIDuz5EohPwdqRSVsedl5QULdJtd8dRTzBOsbqXI/bDZ4y33LLxDvMJi/orD
	 gdpRfA449uZv0fiuuwa42QUSNzd58INuPAmY2nA/syLxZEOWza1mjaWDCjkWS/OOSi
	 lmaDyzlGKxSTg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where needed
Date: Tue, 13 Feb 2024 10:55:51 +0100
Message-Id: <20240213095555.454392-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Drivers that call v4l2_async_nf_init() need to select the corresponding
Kconfig symbol:

ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
ERROR: modpost: "__v4l2_async_nf_add_i2c" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
ERROR: modpost: "v4l2_async_nf_unregister" [drivers/media/platform/marvell/mcam-core.ko] undefined!
ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/mmp_camera.ko] undefined!
ERROR: modpost: "__v4l2_async_nf_add_fwnode_remote" [drivers/media/platform/marvell/mmp_camera.ko] undefined!

I checked all v4l2 drivers to see if anything else has the same
bug, but these two appear to be the only ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/marvell/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
index d6499ffe30e8..d31f4730f2a3 100644
--- a/drivers/media/platform/marvell/Kconfig
+++ b/drivers/media/platform/marvell/Kconfig
@@ -7,6 +7,7 @@ config VIDEO_CAFE_CCIC
 	depends on V4L_PLATFORM_DRIVERS
 	depends on PCI && I2C && VIDEO_DEV
 	depends on COMMON_CLK
+	select V4L2_ASYNC
 	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
@@ -24,6 +25,7 @@ config VIDEO_MMP_CAMERA
 	depends on COMMON_CLK
 	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select I2C_GPIO
+	select V4L2_ASYNC
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_DMA_SG
-- 
2.39.2


