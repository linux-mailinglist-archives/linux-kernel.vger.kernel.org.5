Return-Path: <linux-kernel+bounces-62660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75B85241C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB60C281DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28626216E;
	Tue, 13 Feb 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyAFaJlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2286168D;
	Tue, 13 Feb 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783690; cv=none; b=J2HrC5TRNN7kOnxrL0dFbfjGWf8fc+lw/Vm/ri9S2rAspm0ptsOJnou+I30rqgq56e7NzVME5BTjIIkt1iKONIf1MkraKPWhe0r3wQEf4elwg9ZBCTw85leLoiQuiUqNQSTcMCq8b0uwdocOZ/l4nmaeJpnGq+eTjfBbg3Nj7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783690; c=relaxed/simple;
	bh=PnTP6vNVXkTh7mM9/5zBOhKHyxN1lHKCgKXp0guhjgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPmYHU8XNL9cAH8dOxDQ1dPbuqKsxw6i3cORvS6+wJh4c8Ju929DTu6g5qjmlbzW5jlvqmQui9I7sTlJFfBz4eH+nVUhPGeu5YQ9R8afyYAFNKgAEMEI3nwEc4YpWVp7a3lR+filIfDK+hqTd4xx/1LDuzCDoXu7JeIpOymavVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyAFaJlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B741C433F1;
	Tue, 13 Feb 2024 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783690;
	bh=PnTP6vNVXkTh7mM9/5zBOhKHyxN1lHKCgKXp0guhjgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyAFaJlHPybkkmHtA/oNbjLcFXoRlWeWI61mitidI2QKyidZUJUl9yckqjEIggJll
	 KyfX+yTgJLYnY5SVzp+08O7xDQcemsHm6jcip5a+EejG98SXN1VgLBc5hfBIqKBm69
	 5f5hGTskuCOSVOdsvZDTEWILvJSo78JCx1dfA4mqhGbCHwebjd+svgfcvy7rDh9qOQ
	 ltDmbYLHUDg1gln48w22aT3uTi3s1rU+atNEYJhxgxUR3w/0I/aOk0Yef5wNbUnV43
	 ELoJYC0EkRhHfEMQYeqklor4UUxnrK55JAzjfx0WiCmU4sQUQAON2kE6Ms4gFxHmSA
	 XEIIK3ccnpVRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 29/51] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:20:06 -0500
Message-ID: <20240213002052.670571-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index ba82d1e79c13..0b81b1268c9f 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
2.43.0


