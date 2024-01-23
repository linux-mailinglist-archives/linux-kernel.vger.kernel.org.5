Return-Path: <linux-kernel+bounces-35111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84A838C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EE21F273D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570405C8EB;
	Tue, 23 Jan 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="k+Dhaxbr"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29459B64;
	Tue, 23 Jan 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006595; cv=none; b=CaK3Y9lseJfDWVNjO/wIzlfBHowPy8L+ihH1oeWrCQc+rI7gYjecQMb9sn5dMMUBUx6AE8AkNzheI+lwdsSltMw+0E091cQBs+GKUC6FMjtjWys3s5S34XvjBSygvQOJ92YZC1hy2I3ZwFFx84rbWNiPH2Uq1yRNMsDtciaNxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006595; c=relaxed/simple;
	bh=jYQ6Xv2AW3WuEU9RW+PvztluEcow2glWwD06WlcJ0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDnzSG6k4TfkGOKKerrTBEM3v8fYaoUzMkk4rv8Wt1GLYy0yH+qwUkt4YNtnZ+rl2qKLKSgOEtrl7noRiYXFT4ubCClA/F1A+FImRPECE5x1w0Rq+4ji5N+8u97kwmBzWpGNSxrNC74nJF9V0VA4EUPV7LZymlBfWXxLk4LavZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=k+Dhaxbr; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706006591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q53mcc9cShf3bZyxlCnOlEd1xHk0CToCbzGmhqgBkTs=;
	b=k+Dhaxbrow+HPm91RqOGceg7kIrlMFfxc5gyN247fQ4SSo2bZ3HdW13bxv1DqAXWXOF6pu
	AJxODZpFDOnIVA6dG8WsztojPxfIXqb8UZLnoUTvEVEwRwNOOI+o7P7VMyybAm/ce3l3OI
	25VAHK7iXB6gK80K721a5ZNAEmPges0=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] Revert "iio: add modifiers for A and B ultraviolet light"
Date: Tue, 23 Jan 2024 11:43:05 +0100
Message-ID: <20240123104305.10881-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

This reverts
b89710bd215e ("iio: add modifiers for A and B ultraviolet light")

Enum iio_modifer is *ABI*, you can't just decide to change all the
values from one version to another, otherwise you break userspace.
The new entries should have been added to the end of the enum.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 ++-----
 drivers/iio/industrialio-core.c         | 2 --
 include/uapi/linux/iio/types.h          | 2 --
 tools/iio/iio_event_monitor.c           | 2 --
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e6d5ebfd3c7..7937bb4a4a68 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1587,8 +1587,6 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
-What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
-What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
 What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
@@ -1597,9 +1595,8 @@ Description:
 		that measurements contain visible and infrared light
 		components or just infrared light, respectively. Modifier
 		uv indicates that measurements contain ultraviolet light
-		components. Modifiers uva, uvb and duv indicate that
-		measurements contain A, B or deep (C) ultraviolet light
-		components respectively.
+		components. Modifier duv indicates that measurements
+		contain deep ultraviolet light components.
 
 What:		/sys/.../iio:deviceX/in_uvindex_input
 KernelVersion:	4.6
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9a85752124dd..bce09d325142 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -117,8 +117,6 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
-	[IIO_MOD_LIGHT_UVA] = "uva",
-	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 5060963707b1..9c2ffdcd6623 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -91,8 +91,6 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
-	IIO_MOD_LIGHT_UVA,
-	IIO_MOD_LIGHT_UVB,
 	IIO_MOD_LIGHT_DUV,
 	IIO_MOD_PM1,
 	IIO_MOD_PM2P5,
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8073c9e4fe46..2eaaa7123b04 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -105,8 +105,6 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
-	[IIO_MOD_LIGHT_UVA] = "uva",
-	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
-- 
2.43.0


