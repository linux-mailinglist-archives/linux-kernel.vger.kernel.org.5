Return-Path: <linux-kernel+bounces-36909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA383A88B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA753B282DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029751038;
	Wed, 24 Jan 2024 11:51:11 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367E1B5B3;
	Wed, 24 Jan 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097070; cv=none; b=H8t7SYFhumwIFHK13anBHCssh/j6iUDzIC4ZdrhuC4gsC4Imk3GtAzY3510BfoJrdZMlx49tGyay+G5z8/6ylXfqKlasAmXLK4yoNSkB222XReZlfz5a+acCd/ey8G8vmFkrWptNiV8nVlOdrU5aG6hGxlaOErLK6/r8eK2QrSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097070; c=relaxed/simple;
	bh=Te4SOpTmU39voRROhH/VwIq4OO2xqSBz7qUZPRTcJwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4l8C7GKekvOiYA7ZZVAUNZmWRoa63HkKIAmnaPmdl9695mHxI1mgx/NCh15bHtcH418ahOBl8woDP1rgTqHc2OxaMUn5UVoitP0ccK4z4+lHkCE2F4zN4r8Y2Kaq++GIuH9gpygrQJG3vLxLJTOYPObfr+BxdSzKWl1euY2/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40OBnuWq020582;
	Wed, 24 Jan 2024 19:49:56 +0800 (+08)
	(envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TKhs50lLMz2Rmqt8;
	Wed, 24 Jan 2024 19:42:33 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 24 Jan 2024 19:49:54 +0800
From: Di Shen <di.shen@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <zhanglyra@gmail.com>, <orsonzhai@gmail.com>,
        <cindygm567@gmail.com>
Subject: [PATCH] thermal: power_allocator: initialize params->sustainable_power in the bind callback
Date: Wed, 24 Jan 2024 19:49:30 +0800
Message-ID: <20240124114930.12231-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40OBnuWq020582

If we set the PID constants k_* via sysfs before the IPA algorithm is
triggered, the constants would be changed after IPA is triggered which
means the k_* are set fail.

The process is as follow:
set k_* via sysfs
    |
set emul_temp via sysfs(temperature > switch_on_temp)
    |
throttle()
    |
temp > switch_on
    |
allocate_power
    |
pid_controller
    |
get_sustainable_power
    |
if (sustainable_power != params->sustainable_power)
because the params->sustainable_power is not initialized first,
so params->sustainable_power = 0, the condition is true, then
call the estimate_pid_constants().
		|
	estimate_pid_constants
		|
The k_* are overwritten, the k_* we set before are invalid.

For example:
unisoc:/sys/class/thermal/thermal_zone0 # cat policy
power_allocator
unisoc:/sys/class/thermal/thermal_zone0 # cat temp
32722
unisoc:/sys/class/thermal/thermal_zone0 # cat k_po
307
unisoc:/sys/class/thermal/thermal_zone0 # cat k_pu
614
unisoc:/sys/class/thermal/thermal_zone0 # cat k_i
61
unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
0
61
307
614

unisoc:/sys/class/thermal/thermal_zone0 # echo 300 > k_po
unisoc:/sys/class/thermal/thermal_zone0 # echo 600 > k_pu
unisoc:/sys/class/thermal/thermal_zone0 # echo 60 >k_i
unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
0
60
300
600

unisoc:/sys/class/thermal/thermal_zone0 # echo 70001 > emul_temp
unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
0
61
307
614
unisoc:/sys/class/thermal/thermal_zone0 # echo 0 > emul_temp

This patch initializes params->sustainable_power when the governor
binds to thermal zone to avoid overwriting k_*.

The basic function won't be affected, as the k_* still can be estimated
if the sustainable_power is modified.

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


