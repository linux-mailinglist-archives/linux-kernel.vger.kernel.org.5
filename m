Return-Path: <linux-kernel+bounces-118628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971E88BD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A8D2E6AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3C67A04;
	Tue, 26 Mar 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFYSUJ9r"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786A548FE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444588; cv=none; b=LTKwAV5U36h5C1H0myNnDx5+bpjkN32NSBBkyW1Jav6MfLt+5pfY9e07jiZFxF+GuxFz4MjlfrwNvw9nKOFy4zsV/JCMyqWzt2/ARmL/ueG5hEIlwgvB2bZnZjGQb4p/7Iu+nrIDRYLFTBYFRFdwupxFmyxHJIG8qezLLnz5oPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444588; c=relaxed/simple;
	bh=NH+YelPPPjROrc5YsDu/t/VqueRYTW17RR28mWQ+TxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAfX6QpKiUR3L5ZZ6tnpTdvGYBGdphPtOA3Dd75Ajqm/ESS05I4x4BxLXe/8Cd1s/xug7IKCq6ZXYgx+HlGFxVMWVeipIrMiAzqh17uzx8LuNT2B8HYapxR8GwNrUUCvlTgf7GPyCgIPCBju+k6Fzr4NduT6Mn3hym8NviAf1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BFYSUJ9r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148c2a3a3fso7636415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444585; x=1712049385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ammHs6vW1OsPJVQNMpuIMjJitue7UK+ZVRA8E34u8K0=;
        b=BFYSUJ9rfI8tlGSciHMcdLs4QlASBGJF4dLAgD9ZXH7opzb6Ycan1E27FUb9qwZuCB
         hoDGAGyTPzLQtd9i0TbduFx6OZdr5UxtsKVBz5PrP4m2PVvQovNhJR/kliZ1PzryDpJ+
         BYnpVbtyLy93D1rhxfzqnEerhCSac+Hsd87tjVaa6hMVMbe90VA3TDW8BFdC2kew4JgL
         z2JWgZCYrH0PStI0Yjl1a8DjcnJ8kbqxjxk/Npx1bze8FflXuLuZOW+w173eoh0qCunT
         3aUWMaIY/ZOv+GhwlXxk7GTE77TBr5q0HCUeDdzQxLiVDQyaVx6/qrv28gpduiGSsaEw
         UJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444585; x=1712049385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ammHs6vW1OsPJVQNMpuIMjJitue7UK+ZVRA8E34u8K0=;
        b=aTJwRQ/m4WTXy5sVwHApv5GLxMDedUzWTSFfgFJCYp7VjlGrm+KmhJmeXX6kWndcwo
         1LJ2OGNnZS/vPHhPu7Oq4uT7ROD0KO+iTi7pKj7Fp5sVIEoerAYHmpaFT1+GCPEeNNIb
         tCPDjceDDGkD349Q7yzppwbVsfy+ux9QZQRpQLUY4x26MJy4vBB0q0m+LmziWxgDQ/tu
         8Qo40qIKIhOdb4zWhqj/KJvohcAKsstd3WpNMk481ol0EH2mbrn6uORlsxReu/BM8IzU
         gsWFGh9yfoV2b0uxNqx+ltBv8pdLZi88PS2ghLpPtwgH+WjSoPYA5jgW229lSXMFB2xY
         sqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUXK/NDm1Nf5fvGgC0ZWmDaVUwilKuDHVI4RlPGS5MhMjxsvUrWJ88VZeW3FtnI6YL6R59KRGykes6Gr6tsfgOpVnTemOxD3NlzHDru
X-Gm-Message-State: AOJu0YwQp9Asx6rsV5rZFWqKLzAx9/OIS9lK59BI6MoEsZH1PB8YDtdR
	C1RQvF4LV/iDMlbNF86ikX9srNhLHdvLcbiQXQ8bcb1lVIZSOngcBsA+Iy6sBbs=
X-Google-Smtp-Source: AGHT+IEtDqvTrp3LQMqivjk1kFcHLuxSotNAE9cJSHtwNsbpF6i2yUL7nqRFZLu7OjM8PT7RKYqlyQ==
X-Received: by 2002:a05:600c:474d:b0:414:9048:40ba with SMTP id w13-20020a05600c474d00b00414904840bamr317033wmo.0.1711444585096;
        Tue, 26 Mar 2024 02:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e6b6:c92e:43ff:71d7])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b0033e5c54d0d9sm11647606wrs.38.2024.03.26.02.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:16:24 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 3/5] thermal/cpufreq: Remove arch_update_thermal_pressure()
Date: Tue, 26 Mar 2024 10:16:14 +0100
Message-Id: <20240326091616.3696851-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326091616.3696851-1-vincent.guittot@linaro.org>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_update_thermal_pressure() aims to update fast changing signal which
should be averaged using PELT filtering before being provided to the
scheduler which can't make smart use of fast changing signal.
cpufreq now provides the maximum freq_qos pressure on the capacity to the
scheduler, which includes cpufreq cooling device. Remove the call to
arch_update_thermal_pressure() in cpufreq cooling device as this is
handled by cpufreq_get_pressure().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9d1b1459700d..280071be30b1 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -477,7 +477,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	struct cpumask *cpus;
 	unsigned int frequency;
 	int ret;
 
@@ -494,8 +493,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->related_cpus;
-		arch_update_thermal_pressure(cpus, frequency);
 		ret = 0;
 	}
 
-- 
2.34.1


