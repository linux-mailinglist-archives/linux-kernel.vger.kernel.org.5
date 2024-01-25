Return-Path: <linux-kernel+bounces-38002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52683B988
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55322284FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349010A31;
	Thu, 25 Jan 2024 06:24:14 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3410A12;
	Thu, 25 Jan 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163854; cv=none; b=WnafPK1LsZEzIkJKYc9ZfyxdIUWfCcJF8q9Vr19RI53J2UB7QoJjUvzH2mB3df3nMMY1Gg0W4mh5aqNuO7GU5DaX5+2z//3xNnjuNjg48BdGvkGWMDyY6q6uTwSIvOzBVkUA3l5XeHkpmRlF3LYtWeJdP7E5djr4ZDxEuU+T2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163854; c=relaxed/simple;
	bh=IJnqiJ3su0ULAtCoiKNxfIa4lBJxYdBgJQZXApe+y2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqJV3bUAMVwF7sSDvN7nUgMv2CIUz+o59UxiSKmZCUDAeilO67IsVBH4Aoh2ZvE4NIVEdndPRDEn8hqTc4AcBbjbGXI2Sibm68YafszVWSv6+MObbXcHDJze1cPqrBGGKlpDOoagbSsXAp9Kh14+PngGHnUUi17h/THiR8Tptdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P6NZMG074726;
	Thu, 25 Jan 2024 14:23:35 +0800 (+08)
	(envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL9Z2408Nz2SKBpW;
	Thu, 25 Jan 2024 14:16:10 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 25 Jan 2024 14:23:33 +0800
From: Di Shen <di.shen@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <zhanglyra@gmail.com>, <orsonzhai@gmail.com>,
        <cindygm567@gmail.com>
Subject: [PATCH V2] thermal: power_allocator: Avoid overwriting PID coefficients from setup time
Date: Thu, 25 Jan 2024 14:23:31 +0800
Message-ID: <20240125062331.28943-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1f8914cb-fc66-4068-8f7c-4d13b2454f7d@arm.com>
References: <1f8914cb-fc66-4068-8f7c-4d13b2454f7d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40P6NZMG074726

When the PID coefficients k_* are set via sysfs before the IPA
algorithm is triggered then the coefficients would be overwritten after
IPA throttle() is called. The old configuration values might be
different than the new values estimated by the IPA internal algorithm.

There might be a time delay when this overwriting happens. It
depends on the thermal zone temperature value. The temperature value
needs to cross the first trip point value then IPA algorithms start
operating. Although, the PID coefficients setup time should not be
affected or linked to any later operating phase and values must not be
overwritten.

This patch initializes params->sustainable_power when the governor
binds to thermal zone to avoid overwriting k_*. The basic function won't
be affected, as the k_* still can be estimated if the sustainable_power
is modified.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 81e061f183ad..1b17dc4c219c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -711,6 +711,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	if (!tz->tzp->sustainable_power)
 		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
+	else
+		params->sustainable_power = tz->tzp->sustainable_power;
 
 	estimate_pid_constants(tz, tz->tzp->sustainable_power,
 			       params->trip_switch_on,
-- 
2.17.1


