Return-Path: <linux-kernel+bounces-124625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0E891AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDA41C258A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489813EFE5;
	Fri, 29 Mar 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3AcRsKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99815E200;
	Fri, 29 Mar 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715572; cv=none; b=uzccIy9/Rl2Wmwv6sVIW4RSvna2kxPEM8RCCL6DaExsHRzW7ej61wXRCuhDFrk/+Cy1Iyzc1XmXQGxuP0v7H35TFzGwz/LPZNqeBZGlajXo6xm1boJ7sh0SR7jGMGuMQEXmIHbpW+m7RJKijOExbl6sPG9YW5Q7PschuxzTlNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715572; c=relaxed/simple;
	bh=atto/ogA6M8ZBYdQ2P1WfmZG6v0P4C0Cd59ErmHOJ+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrlace+x30fhPlluScok5V+8wMl/HEX4jrqTWwYXK3Y2LlA77UGJtfJ9uWJmQ+eDx1zokFtTVmX4CudKg79KrAx8SEwarMeqYqAQA/PG3IBpDD5q7uOqhAlollqWfxdi3f8//fHjaPyNbGgdGTtML7UO0U2YE4WvY+DxgE1aZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3AcRsKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C89C43390;
	Fri, 29 Mar 2024 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715571;
	bh=atto/ogA6M8ZBYdQ2P1WfmZG6v0P4C0Cd59ErmHOJ+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3AcRsKTZFiH+BEMHMhXk08L3HiDTDssg9Wy7TLJilkYNW2Qx4uUtDhlznWoXKTgv
	 zxrkuwSNJiUkdoGwlZvmKXdFtvSHhTNS7FU/gUHZg4+ioD3rguqwEc/d1wN/FsevUX
	 M6bvBz7gAgXqHDmQNSQkwLjyaaquegJYE9jgcMqSCCVMkH28+1l9KoIOVw9MLRAGVp
	 co5B56pRISlr5y26pgNWkopwphnq0bvZZJgFVvFAAfczN4yxP6FmZGLqiVIVkI/r3S
	 RLMqFu1ncRE7HcEfeiPs/vAxeBCoegjkRimI8+eTRhjt0fPDT+8fB+uXcvZQiofCWE
	 1k7wy48sD4+5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
	Roman Stratiienko <r.stratiienko@gmail.com>,
	Dhruva Gole <d-gole@ti.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/31] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Date: Fri, 29 Mar 2024 08:31:41 -0400
Message-ID: <20240329123207.3085013-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit c4d61a529db788d2e52654f5b02c8d1de4952c5b ]

Offlining a CPU and bringing it back online is a common operation and it
happens frequently during system suspend/resume, where the non-boot CPUs
are hotplugged out during suspend and brought back at resume.

The cpufreq core already tries to make this path as fast as possible as
the changes are only temporary in nature and full cleanup of resources
isn't required in this case. For example the drivers can implement
online()/offline() callbacks to avoid a lot of tear down of resources.

On similar lines, there is no need to unregister the cpufreq cooling
device during suspend / resume, but only while the policy is getting
removed.

Moreover, unregistering the cpufreq cooling device is resulting in an
unwanted outcome, where the system suspend is eventually aborted in the
process.  Currently, during system suspend the cpufreq core unregisters
the cooling device, which in turn removes a kobject using device_del()
and that generates a notification to the userspace via uevent broadcast.
This causes system suspend to abort in some setups.

This was also earlier reported (indirectly) by Roman [1]. Maybe there is
another way around to fixing that problem properly, but this change
makes sense anyways.

Move the registering and unregistering of the cooling device to policy
creation and removal times onlyy.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218521
Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c8912756fc06d..91efa23e0e8f3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1525,7 +1525,8 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+	/* Register cpufreq cooling only for a new policy */
+	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1609,11 +1610,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	else
 		policy->last_policy = policy->policy;
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
-	}
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
@@ -1674,6 +1670,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		return;
 	}
 
+	/*
+	 * Unregister cpufreq cooling once all the CPUs of the policy are
+	 * removed.
+	 */
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	/* We did light-weight exit earlier, do full tear down now */
 	if (cpufreq_driver->offline)
 		cpufreq_driver->exit(policy);
-- 
2.43.0


