Return-Path: <linux-kernel+bounces-62603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3804852388
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824651F22F26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DE53804;
	Tue, 13 Feb 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9DNwrPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A1537E1;
	Tue, 13 Feb 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783563; cv=none; b=tYWMwKldaZdmxrbjjXPr8JCnAFUSV3lQ3726S7Xsggb1e7IqizQoU0h6LXXFeDr6QJoTz+lENZ6AZdadVcSLdln3/P2eevFa/LKBT7A2e3qdqVHIVQC4QYqk0OYVpI9dPZVOLsJuhBoJ4oVUZvQAtuNOe+BNrcZdnRjhSHKOSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783563; c=relaxed/simple;
	bh=PnTP6vNVXkTh7mM9/5zBOhKHyxN1lHKCgKXp0guhjgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAqrT7apBLHe7CXeYm9Ul5T/0YaIbiKWQuskO68ihqoUh2z+mkQW7s19kzp7FOlmr0XkgFh79YtvIdzeMZ3c268fennuHdxlbUtZbPL2jnSHS1LOci77vBU9b7H1IkaxQK6gcNeMiAL5yxmC/3k9cFHYMHFxt2vFNu7KxPm17nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9DNwrPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8082C43390;
	Tue, 13 Feb 2024 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783562;
	bh=PnTP6vNVXkTh7mM9/5zBOhKHyxN1lHKCgKXp0guhjgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9DNwrPpvOpKjipx5FgU6vyFZ+ucICpNR9QHJccCoQLWJ1FO6KLt1dnOxWffg0mhC
	 qcZ9+F+G1plrCNIZV0yuUnE+Do9Vr7iMTzmywpkLdUjKzI0suZtPssNsFoV7fS6qI2
	 nmIpF4lKik+6S8OYt0Idv0K9jiAb8wwC0rtKdU6JzQskfmSHqRG7zKZ1C1tLEBSilt
	 cwdfnpD7Dw6h+xSkHz0HEceUdApoWL9OPDVmrcFIKSNxYPmPaOEYnv9JUnYVck6qD6
	 BU2Bg7W/MBQ/+Mvdi1Tnxr/wnYlPcRCkQO2ZVvh++P59CT10TOD5xhwQXbbYEoYbR9
	 DnaBNS7HKcHcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 34/58] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:17:40 -0500
Message-ID: <20240213001837.668862-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


