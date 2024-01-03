Return-Path: <linux-kernel+bounces-15721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B28230E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36E51C23A72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03341B28C;
	Wed,  3 Jan 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC9XfGE4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657B1B278;
	Wed,  3 Jan 2024 15:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C07CC433C8;
	Wed,  3 Jan 2024 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297496;
	bh=J2qaYb0QE6L9hh7qWv/hsZPbsaA0YA/s6WmiwcLhg+I=;
	h=From:To:Cc:Subject:Date:From;
	b=hC9XfGE4Jdh6LZPKOYde0goTfU05v7ml4qMHhPK1JsZlgVX9lFgWnQoBb54cmCcvO
	 fWAxCFFoyPCut7bYJQENSoOD8xeMc853F/osl62eFQbMbZivRSmvIc6nzG3RfUD3jn
	 DnRTp6T4xkFhk6t9kZzAkq8jWJxJWOVpqzvdVbO9cTPByRegaMiTFkbh4lKEW0rjDA
	 wEk5R3QANRO/rMRysBdINuOFtNpol1wjYW/Mn9Y/IEQ3cGLHlDFKDe6IVH5PLDk6w+
	 Iw0nWMBkApUXjyc1Z55IPa4iQVzC4jcRNBWJAC2c7g2Kmkgwjmml/9JF5D5Q/lK9wz
	 KOrYhvlEATRIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: thp7312: select CONFIG_FW_LOADER
Date: Wed,  3 Jan 2024 16:58:05 +0100
Message-Id: <20240103155811.4092035-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The recently added driver uses the firmware loader mechanism but causes
a link failure when that is in a loadable module while thp7312 itself
is built-in:

arm-linux-gnueabi-ld: drivers/media/i2c/thp7312.o: in function `thp7312_probe':
thp7312.c:(.text+0x4164): undefined reference to `firmware_upload_register'

Select the required Kconfig symbol. Note that the driver specifically
needs the firmware upload interface that is controlled by CONFIG_FW_UPLOAD,
but there is no link failure when that is disabled because the interfaces
are stubbed out here.

Fixes: 7a52ab415b43 ("media: i2c: Add driver for THine THP7312")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 78a87331686e..4c3435921f19 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -674,6 +674,7 @@ menu "Camera ISPs"
 config VIDEO_THP7312
 	tristate "THine THP7312 support"
 	depends on I2C
+	select FW_LOADER
 	select MEDIA_CONTROLLER
 	select V4L2_CCI_I2C
 	select V4L2_FWNODE
-- 
2.39.2


