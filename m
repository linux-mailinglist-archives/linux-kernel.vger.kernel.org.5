Return-Path: <linux-kernel+bounces-148262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9808A7FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537D01F2203C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21113C68F;
	Wed, 17 Apr 2024 09:39:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB313C3FF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346752; cv=none; b=Y5UqMilRpob1xrk6HvXjM+OAc7C9LvpTsrHKH5GoDcyF/jK2HPkGfyvOacC60bQ/hO0uk2pMuVXVyagLuwD62KtLg6yovBUfAMlnx0CPpC35/2MLcbhvXYXWcobfRRaawbdjrP48A+2Y6cMbTHo61y5RMwxeWKCU5OrHZjwvlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346752; c=relaxed/simple;
	bh=zVISUDfH5Und8B2M0/FRkHymAWK9FfVIOHuACS05Y0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKCPXaLFTySGi5FPQ91TMSEw7Ual9ur04VY5+7+UaUKpauy++qmo1zMouDDyK6GgcQIKw5tW+lKBR2TZ5DVilNso9wQtK2IkZG6Q56cexAVdZpVw2SvJhO/kbTuovY/oPOIzXavapLs/sbyhH0Qy/O1YCJdfWkf3qVuABnRgi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D3A21477;
	Wed, 17 Apr 2024 02:39:38 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5D333F64C;
	Wed, 17 Apr 2024 02:39:08 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: [PATCH v5 5/5] cpufreq: Use arch specific feedback for cpuinfo_cur_freq
Date: Wed, 17 Apr 2024 10:38:48 +0100
Message-Id: <20240417093848.1555462-6-beata.michalska@arm.com>
In-Reply-To: <20240417093848.1555462-1-beata.michalska@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures provide a way to determine an average frequency over
a certain period of time based on available performance monitors (AMU on
ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
represent the current frequency of a given CPU,as obtained by the hardware.
This is the type of feedback that counters do provide.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f6f8d7f450e7..89118406ec68 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -793,8 +793,10 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	unsigned int cur_freq = __cpufreq_get(policy);
+	unsigned int cur_freq = arch_freq_get_on_cpu(policy->cpu);
 
+	if (!cur_freq)
+		cur_freq = __cpufreq_get(policy);
 	if (cur_freq)
 		return sprintf(buf, "%u\n", cur_freq);
 
-- 
2.25.1


