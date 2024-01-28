Return-Path: <linux-kernel+bounces-41894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B427583F93F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64E51C21474
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594222EB1D;
	Sun, 28 Jan 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IImyyOVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4F2E633;
	Sun, 28 Jan 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706468187; cv=none; b=RZuNKI17lfucpsaS3gkQEvwaqZdWLLJLrFiFsjLCPt0ncpxlAT+SpslWIP7zoGPrKa5b6MGm2SqqRBXlnDSGHOeN0zt6u61sIplKOsqMb5H7dYPIs168E3Kf/7jVVtr7aQTEYqwvJ5LFew/IVwOq6ZoVbI9ARn9UVB2zhkoCS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706468187; c=relaxed/simple;
	bh=NXn49SNNkLuAR3eI0XKBU5ciRsCgriwwJFIZaXxDi98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JePUDrwvJ4pT10aKzRe6ScaP/h0lIaKCNsZ6pjCg/zNPd/8E0k+B12McYLk2oVnENzkZ/2fCmMVXCBTTP21B3lya22BTzDLanhl+zWuGxlrAeef0MS7zPH2b4srtKVUWRf6Fb65hVSvNHqkWQyYdGTjC4GLdK4NODxAkeVtJOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IImyyOVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1261C433C7;
	Sun, 28 Jan 2024 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706468186;
	bh=NXn49SNNkLuAR3eI0XKBU5ciRsCgriwwJFIZaXxDi98=;
	h=From:To:Cc:Subject:Date:From;
	b=IImyyOVKFTeWwUkB4vKyvjtOkxEfLmrw7VQIjvfKp0HqfJX4MvItOQGVnFu1ao43E
	 uD8Xa8w+B5Zj5G8I6eo/xqpOS+uX897dfYEEoL6O64F/izJnnttzZFh71LIWTXWI/h
	 BkZY7mz0hESA7dDIqU1al/HGIq77eD5XW6BBcLWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: naveenkrishna.chatradhi@amd.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Date: Sun, 28 Jan 2024 10:56:22 -0800
Message-ID: <2024012822-exalted-fidgeting-f180@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=NXn49SNNkLuAR3eI0XKBU5ciRsCgriwwJFIZaXxDi98=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnbFoeZmU9oi+OUNf/bHbJJyeztlKc5a8zXabdPePuk2 OVZw7v+jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAbjIR4a5Qo7Ke2w3WD37lVqc GvKIzf3Xlg03GOa7zKp7fW0DM0exxJ/1r6a9kVfIfBkAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The use of devm_*() functions works properly for when the device
structure itself is dynamic, but the hsmp driver is attempting to have a
local, static, struct device and then calls devm_() functions attaching
memory to the device that will never be freed.

The logic of having a static struct device is almost never a wise
choice, but for now, just remove the use of devm_device_add_groups() in
this driver as it obviously is not needed.

Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/amd/hsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index b55d80e29139..49ef0b1d6df0 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -471,7 +471,7 @@ static int hsmp_create_sysfs_interface(void)
 		if (ret)
 			return ret;
 	}
-	return devm_device_add_groups(plat_dev.dev, hsmp_attr_grps);
+	return device_add_groups(plat_dev.dev, hsmp_attr_grps);
 }
 
 static int hsmp_cache_proto_ver(void)
-- 
2.43.0


