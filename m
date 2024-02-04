Return-Path: <linux-kernel+bounces-51690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB03848E46
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBF7B2171A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46F225AC;
	Sun,  4 Feb 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="poT+QR7r"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7B21340;
	Sun,  4 Feb 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055829; cv=none; b=RKyUOENnXLhFNyTwJplPk/MR9huiVRapEWuUIjdAcdaQrkRr/SnQZD+2kiCBYHHwk+5eTc51IhPmQN3S/ktdzihBEJ1FOER3JmeIHmtNRvU8LK7l42fVZdw3dt2aKIZb/+6whnQGwcUEaOfJOgWBlpVlkYLhHIkpQfIzTwMz0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055829; c=relaxed/simple;
	bh=cQod2kec5dLebpdvuIBrZKKCbKGaPXzQDdYDSwb8Ggg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYyLslrl1CVzA8//WVqg5COwiNQXz7B1r0jEscrQzYwSLfHvbTXy/ZnPYA5NNjh3tsHxsgseUhisPl05qCEiUxWTLGWO46MCf6p2XNM8K462eEt6oHyIdswsDZ6DNNqKDQZC6/4+sTas8BzEoVR75igs34m63rnkNvpga8dTGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=poT+QR7r; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8jCHz
	QVqZeuBi19Um8vqUH+qUXm7myMsYA/bMP+Z8II=; b=poT+QR7rrL8PzvufQ57Jo
	Z1PLk6Ax6iu4u70MQIVsqm+7VIJpx2S0uI9hvItJHXA+yIAb5zchYAGWbPSUJOcL
	O9VdVmi0xTfB6QvoVnDHU7o37yLbujcJEn1/D8D9OBIjw5kdo0DcUCMki9GBlmtl
	x8pu7c4ppuJy5JwMzE3/TA=
Received: from localhost.localdomain (unknown [114.98.57.142])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDHLymgmr9lRyxOBg--.39710S4;
	Sun, 04 Feb 2024 22:09:55 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: vincent.guittot@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq/schedutil: When updating limitations, frequency modulation interval not become invalid.
Date: Sun,  4 Feb 2024 06:09:28 -0800
Message-Id: <20240204140928.2865-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHLymgmr9lRyxOBg--.39710S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWrAr1rXFWfXr18AF1rtFb_yoWfGFg_Cr
	1fWwsrXr45Aw1DKF1fuF4Fyr9Iv3W3WF1vvry0q39xt34UAryFyry8Jr18AFWfW340kF9r
	AryqgF15Cr4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWlkxJUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhZ6q2VOBWhgYAAAsf

If the current frequency scaling policy is schedutil.
echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
This would result in an invalid frequency modulation interval.
In sugov_limit(), sg_policy->limits_changed is set to true.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..a0af38fcb7e2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2631,7 +2631,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	if (new_gov == policy->governor) {
 		pr_debug("governor limits update\n");
-		cpufreq_governor_limits(policy);
+		cpufreq_policy_apply_limits(policy);
 		return 0;
 	}
 
-- 
2.25.1


