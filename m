Return-Path: <linux-kernel+bounces-62728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A668524E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769271F22AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AA12A153;
	Tue, 13 Feb 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ympi8fMf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5124A13;
	Tue, 13 Feb 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783832; cv=none; b=gVfMPZzkktqwI9ReqRTY2UDCA+iN+TwM0BOwdShKvfA23t6pBrb7+cqE2yW/86FxQhJK49kf9Vjj2B5tdAq0XVRBynhbl/U2qQ96s2BOrDtdLNYYkI6KGUerVWu8+UVCwZRe6AxkDWp+rbU6EpkjR7tF5j1Wz+BxPHotp5s74NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783832; c=relaxed/simple;
	bh=Ezlrsu8Cpnk9jt6VCc0qt5xWi89GOLhSDzVRUGGBsD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0W7xD4JEQFNWWpoJEir7AOHLbgeGP0Y3vHc/Q1Sd6dwLDhmcx47Hd0XAZ4iTqv48SsIi24glk3/HUAsSJagS/cJmYwpvEaEftYqnvqwqyS77MVd+ikqNS48CBT+CS2ZGQIVEne86hiKZyeRrjg79OfgYLtHvSsN4OcQ/1wA6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ympi8fMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56421C43390;
	Tue, 13 Feb 2024 00:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783832;
	bh=Ezlrsu8Cpnk9jt6VCc0qt5xWi89GOLhSDzVRUGGBsD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ympi8fMfq+vy5zYrXNCESMWCzSLELTGoX7KoSa9ffdOBg3rsILOKc2mqqXVxI1Z87
	 K+vxzFqafTFtKcMsWF/hCC+3hmuSCkQXE9HeRkpAjEq8oVM/ToXL7zSIGayC1Tg2EN
	 hmS7cThc3+MGSaLelUIIIEpGIkD3px+AR8uS6UJHQ244OmZcYot+72zSMTiqLIkNn/
	 yt1DAK2O97eovIj07QoXFTBI1xwh5QnP1dPn34YzYtERbpQ0Wk/FkHjz1aF3n9qbmc
	 HW3VcM1Ox4hAMk6e5rUsaKbQxvhdsddF/0CTh/94qi0yj38hH8oJtR3g1dSslR3++M
	 iOG4BiR4uy+NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/22] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:23:18 -0500
Message-ID: <20240213002331.672583-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 34cf8c657cf0365791cdc658ddbca9cc907726ce ]

Currently, coretemp driver supports only 128 cores per package.
This loses some core temperature information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed
 ...

Enlarge the limitation to 512 because there are platforms with more than
256 cores per package.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20240202092144.71180-4-rui.zhang@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5b2057ce5a59..23b1c4c0452c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
2.43.0


