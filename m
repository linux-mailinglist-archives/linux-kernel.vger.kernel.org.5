Return-Path: <linux-kernel+bounces-133071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7593899E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41622B234D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120616DECB;
	Fri,  5 Apr 2024 13:33:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10216D9DD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324028; cv=none; b=rJqScwRBm3moj+t5JNYfckQ25/i3mJc9awqabgovTiqgj1g8kXbhJf4QYxLXG3yJOTm/QE36JhILlnzM9q54l/+WcnTPB2xIml5jLVL0WHM1bRh62f269ENwWHqbv7EnXjmCjQfeBGnJEsA6C4UIO+cOmSP2uF7xgYgwt4N4Puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324028; c=relaxed/simple;
	bh=rbd3jknnd/pc9mbUuV7BSlIpgk6c+O5l7EkIsKegyLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mG55DTb+MR/iN89h3b0R2KZX0COMZ5xZRQIoK99tiDJ+rJGzb7EWbW3mjKXCAYevJ/d2R/pZNhTrM0qW+0QbK0veiQPIcWB4YX0OWzcSUTqt5PAFLdIo/udvP3r4DxePlDFsZdX0jIF8j57kJJYTKDCevwRwAybFC0zqloaB7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAAE916A3;
	Fri,  5 Apr 2024 06:34:16 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A65843F7B4;
	Fri,  5 Apr 2024 06:33:44 -0700 (PDT)
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
	lihuisong@huawei.com
Subject: [PATCH v4 4/4] cpufreq: Use arch specific feedback for cpuinfo_cur_freq
Date: Fri,  5 Apr 2024 14:33:19 +0100
Message-Id: <20240405133319.859813-5-beata.michalska@arm.com>
In-Reply-To: <20240405133319.859813-1-beata.michalska@arm.com>
References: <20240405133319.859813-1-beata.michalska@arm.com>
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
represent the current frequency of a given CPU, as obtained by the hardware.
This is the type of feedback that counters do provide.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..603533b2608f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -795,8 +795,10 @@ store_one(scaling_max_freq, max);
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


