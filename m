Return-Path: <linux-kernel+bounces-28772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58E8302E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F86A1C21353
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AC1BC55;
	Wed, 17 Jan 2024 09:56:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19515EA2;
	Wed, 17 Jan 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485365; cv=none; b=gpCkuS5KTbmn3UYZKmuQ5mzxOH94xAbMwcnPopHTGu4OlXlEvSbgI+7+YoVaPSre+Ex0wtZcpKkrNU9K7B1ItECClFtN4zy7UDRXJGrvhk+pRhUmfKfGxYXYxS0occaYsO8UPkWDOuhC44pxZZQwm8ILQ3FjwVvxODB1fFiNxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485365; c=relaxed/simple;
	bh=6Wi5CZcTdePdWR3CmLK/lfq50M9LGiUfZZMfj9IusOE=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=J9p9oGQezd1cWKTWcdgr2KrlVu55cLqHpp9REG38CcxarpYtjqw6BsK1HIg3AqmR8WD2l4nYUhe93R/4BJarNfvDRNj7MfC6tHSpmpHTxXtjF8RPSp+nzk4v2D51UUgtw55ljZbNJL0KCe7nUV1yVQmHGkEBXvEn6QgCBEHfp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C211DA7;
	Wed, 17 Jan 2024 01:56:49 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 372AE3F5A1;
	Wed, 17 Jan 2024 01:56:00 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v7 02/23] PM: EM: Extend em_cpufreq_update_efficiencies() argument list
Date: Wed, 17 Jan 2024 09:56:53 +0000
Message-Id: <20240117095714.1524808-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to prepare the code for the modifiable EM perf_state table,
make em_cpufreq_update_efficiencies() take a pointer to the EM table
as its second argument and modify it to use that new argument instead
of the 'table' member of dev->em_pd.

No functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 8b9dd4a39f63..42486674b834 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 }
 
-static void em_cpufreq_update_efficiencies(struct device *dev)
+static void
+em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 {
 	struct em_perf_domain *pd = dev->em_pd;
-	struct em_perf_state *table;
 	struct cpufreq_policy *policy;
 	int found = 0;
 	int i;
@@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 		return;
 	}
 
-	table = pd->table;
-
 	for (i = 0; i < pd->nr_perf_states; i++) {
 		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
 			continue;
@@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
-- 
2.25.1


