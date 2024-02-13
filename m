Return-Path: <linux-kernel+bounces-62701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB6852488
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42A81F214CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF847E0E3;
	Tue, 13 Feb 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk+yzv7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6277CF27;
	Tue, 13 Feb 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783778; cv=none; b=aZaYd629SJnSqbTzkJdyN+bNxSQeBUKgtlg9dQ6NkZwAcr06q6QyIrXRC3shNGpmJLgwfwaCSyhVqlZV3NpMQrJOychk2GDGM3bDv3TGFQTKfiLGs2/6//3CSysLcqj8flQxU7gq+c8KPZeBOcH/0trMbZ4YSDyRnuCTHvTnLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783778; c=relaxed/simple;
	bh=WqStDUa9x8lLHvEoGj4h2wLDGFuGHuVmnWtIUoll2w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOVQwsinrdcfO9w2o02K8+odNWUuMMqo9hKJvwYoU8+1nuCdTXP1+bZ18mfvmuP+xJQki7wwq7yQIgjWQvaJPo/4KhR2BAjrX3xvaM7es59ZVLwvIg3LxwZRoJYwXaHtj3oOKw2+HJ3PbbHu7Ikzm15FXOt+hcPJiMKjbVcrZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk+yzv7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74628C433F1;
	Tue, 13 Feb 2024 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783778;
	bh=WqStDUa9x8lLHvEoGj4h2wLDGFuGHuVmnWtIUoll2w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rk+yzv7qb8EEgzWh55TVH77NP6iIwIiGkzOAG3LLIfriDoqb/08WP2nb3VRkj6XAw
	 Mz8Wftxsg2zToanZyshHDni7FEurPWrmv0Yp7ZVMyHRG6hgQZoOJImzVD4hitCrjyJ
	 +BZrZyAVPm6xCf0U6ymPhYfHDhyZgzBEHgqszHab8mIgWOghAp2ZMqKvSEKcMGgidy
	 rowwEHjXcA5OMa/OXwDWYwuFwmEKR4IZiW6DSj00FXHPM9grw57CxjEp7+RLsIwyE8
	 DsuChTmD2n+etbxw9fQCNog4UxQv8M9fVfHvF7IEyWzCZaK55Cd/dXPHP0HTEXZPtG
	 8iF0BvsgluQBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/28] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:22:15 -0500
Message-ID: <20240213002235.671934-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 09aab5859fa7..f05e32581f90 100644
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


