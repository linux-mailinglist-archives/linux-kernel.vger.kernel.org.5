Return-Path: <linux-kernel+bounces-29346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93171830D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B991E1C24373
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0C249EB;
	Wed, 17 Jan 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRzZsFvT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A424204
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518351; cv=none; b=g86oIQVBdX32q8nUJdh0QoeqJlgPmVlrD3x9uaS4wL5KHFeiDLMNE/Q9wkhTnRYiw8k/5A5PH9SrAULbVUmy3Wo8KrSV9luhmBv1naqN96Pgy70ja0654kmuiYZZCftmq8NdnwZ8wMDS+hFfINWx3k4MdL30CS+9cKSBUwJEjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518351; c=relaxed/simple;
	bh=YlxqM4DyCpZEyO5is3UfPRushkiakegLMnu449V7+Wc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=TH9FS0zVf6+zkx+JMxH6gAet/lhcJy1LojIUB+XCOjCEy65sLodCY8IB3SkByjCPoPWIC70tnR1A/ENyS1DGuZMBsSS++T7E30W9Y3Y13CgaYUIGAeyLfDz/b98YnEMJ6c4A/yWGFPLy6uG9grNDkzFZd8oMKMhpH/v4D/PhlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nRzZsFvT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e88012233so13145585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705518348; x=1706123148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnfczORJSbsGVoVGrb/m1mmcyOVrLC0qsA2hV/d6ukI=;
        b=nRzZsFvTAbKFDZUI4TW2eP93EedFJm/a9koatLpjaSEescOJklzLj0XoltxubevyKo
         mZNftqI0g1mfkrElIOiGmacwSM4TgRjmlsuA3enmHClqrHus7YFfMiYSttgS1cXNsM/5
         6lh6ZNa0+KZoI73RqXB3X0lhXEaDT7GE4VldVla3zWCoHJ6Wwq0XOMdY3zVlOspE4Mo1
         M+F8k5+J8/NAe58/fa1k/oJ/nWJ1guJivJxwEehm1Dr42g3ZBCKfJZyoPPZuKde+tVLT
         O5+AITfgGFCEGE4OKHUQ8XwjOXmHBfKGlvpuvt2kGrYyGaRdaEzSx0845k13/UfaKvzK
         i+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705518348; x=1706123148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnfczORJSbsGVoVGrb/m1mmcyOVrLC0qsA2hV/d6ukI=;
        b=uWZ/ZzXeiNtMo72O6finXv8LycHL0f8gacqRtuweCT/B/QWrnoSJmoZzq4k2IuRiRx
         OOkV8Bh/nK9Ck9Tf/BEgyNqEonkBLNYxlwP/9hECjCyc46qQ4sZC0W1CtitbrdMQ82iy
         Xds6uri7QmQtWAkZ85GJoyK0F878FlRbS6KaMstkxDgJixMc3PAbzGnnkJBgOXTuerD7
         PXrSEM6frgS9OmBps5GJFO1wQFtW6lG1cOL8qbz7pfKh8R2dg3o61dPM1PogcgbvW9iB
         jeETAF3GRcAR/tbVPdnmZwH9HDXXP1h3wp9EncYxT73LH54ysJ+7LCy/8s2QblV8k9GC
         OYQg==
X-Gm-Message-State: AOJu0YxuvkVd+ghk/Qj3m/Pbamrmk3R13fyo7DTTbkB4lSOQIKyL4yTe
	SI2BEYtDX0qHeKgj7MPJziA2/Tcz10ZqcQ==
X-Google-Smtp-Source: AGHT+IFjOAbVcdEkgihXfHhvNXsBwaNTwbfFSXRW2fS9/g1h1+klXB2XmHVhRP/XMMzSQL/Kn1Ppjg==
X-Received: by 2002:a05:600c:4212:b0:40e:5d1d:8746 with SMTP id x18-20020a05600c421200b0040e5d1d8746mr4309045wmh.178.1705518348163;
        Wed, 17 Jan 2024 11:05:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:bb1a:7f34:40f9:f455])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b0040e89ade92fsm2813520wmq.14.2024.01.17.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:05:47 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Date: Wed, 17 Jan 2024 20:05:45 +0100
Message-Id: <20240117190545.596057-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
normalization step which includes setting per_cpu capacity_freq_ref.
Always register the notifier but skip the capacity normalization if
raw_capacity is null.

Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Resend with correct email address for Sudeep

 drivers/base/arch_topology.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5aaa0865625d..2aa0c6425290 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -417,9 +417,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity)
-		return 0;
-
 	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
@@ -436,9 +433,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	}
 
 	if (cpumask_empty(cpus_to_visit)) {
-		topology_normalize_cpu_scale();
-		schedule_work(&update_topology_flags_work);
-		free_raw_capacity();
+		if (raw_capacity) {
+			topology_normalize_cpu_scale();
+			schedule_work(&update_topology_flags_work);
+			free_raw_capacity();
+		}
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
 	}
@@ -458,7 +457,7 @@ static int __init register_cpufreq_notifier(void)
 	 * On ACPI-based systems skip registering cpufreq notifier as cpufreq
 	 * information is not needed for cpu capacity initialization.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
-- 
2.34.1


