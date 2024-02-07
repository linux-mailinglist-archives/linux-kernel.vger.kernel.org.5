Return-Path: <linux-kernel+bounces-55837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC884C242
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3511F28209
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867FDDA9;
	Wed,  7 Feb 2024 02:09:51 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F4FBE5;
	Wed,  7 Feb 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271790; cv=none; b=MHz/wKw9PErxmM8helxaBEypJ8YiTEBzSQZBrZOyyv7KdX7RaQkm5bK8HH049Sy49MUTLhbdJ3gBCK0ca7BGHpYRATk0XD7wRXCUIAjKazMRYgXINd1+3keLUjSrzOxdFKr0tTzqXLaN2WEkVpD7Bz3t2bCw8WrBECUo+iCSeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271790; c=relaxed/simple;
	bh=nTXU8U898NWajyMP5BJwpco2rbN3R6w4FOQtYKp+DMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhuayEMu2NNMBz0/AfTTPd21iVAy1awjojxtbESHyPDYI+Oq2Ecr1Arl2wXnzAQ1gaJ6htA6WQEtnTrVwA9BUg+LosIJWPiI1UdIUnyKey7XDs1x7/jqasItKHo/IER6SkiB76FDDeYgaz6f7U3YfLi6RkNDwcrPcq+eGFQF4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41729UAA090594;
	Wed, 7 Feb 2024 10:09:30 +0800 (+08)
	(envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TV3TH0pWyz2K25NR;
	Wed,  7 Feb 2024 10:09:23 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Feb 2024 10:09:28 +0800
From: Di Shen <di.shen@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <zhanglyra@gmail.com>, <orsonzhai@gmail.com>,
        <cindygm567@gmail.com>
Subject: [RESEND][PATCH V2] thermal: power_allocator: Avoid overwriting PID coefficients from setup time
Date: Wed, 7 Feb 2024 10:09:23 +0800
Message-ID: <20240207020923.4720-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41729UAA090594

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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
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


