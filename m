Return-Path: <linux-kernel+bounces-73787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4585CB35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DADB2299A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13742154BF1;
	Tue, 20 Feb 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="NsUaWPf3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3315442B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469801; cv=none; b=QVMfYoY4Rmv2ivr3bar9Mf/5pJVUcyd502xPuinXM0D2eVzSIHP1Wcq7PFL0m6uae+c4P5OW4pbQIs16IRQgux9e8ispKyC1Wsg218+Hoy4wvYRphDdmWI0nSJtamNfAdrKLopMcyppiH6B6MsfNUtbK1EwZPd+ou1aBEUiE5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469801; c=relaxed/simple;
	bh=FQQWqlHG9UJ+0lG2we8igF6gAoLLpYlVJt/gcnDLSiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APcqM6fTOHHZwiuSw+40kHx1IoQE5TzeuYkGedTCerCkOFT+6z6odpZzMXHa5Y8UMXsauq4qXv/j0YQFOvsOrnBt3W1zizJVLwytx3Icd/wS5ezVbtS2ApocVqkKGnCcphb606mfq6mVR/ANSF2H2TA0nEkjjXpPGO6+pcYI42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=NsUaWPf3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so344013966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708469798; x=1709074598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0OJtBJmsVtrdWRAtlV2dG6TCQIPBabKpIehhsZoRq8=;
        b=NsUaWPf3WunHtzuCbP65mzbLGe2uRo6oJf1C/MT2YynxCNXJKQ56PfUE1rP4neMA4N
         i7avw1wjoT3zBMGvrtckWBQRcFU9oz+gg46tEwM1FXODHyHGLBqMrGzTrcbr/ufADA10
         np6brSsDtizdOvA33iMkOvULk6ibBM2ghIQqcWNp/cyPOgGq8yc1MLf/iB8baDhEsm8d
         89PY84Z/k/ggW2cZUCswBonnZ19557oAdZtQ4c3K/KAuiMsUUz3I4CYwcgeL5oSs7qTp
         zaG8IXvON9zuQLKbC3N28k8unbroCoYOFrCaFECbvBAlfIsMRKd2ARNsecX7D5tYlU2j
         Jlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469798; x=1709074598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0OJtBJmsVtrdWRAtlV2dG6TCQIPBabKpIehhsZoRq8=;
        b=MZbH4fGENhusPg7mM+xnSttk1xozwRwHGuqeVnrVO5o+bWys1G+qQgFUETkTo7F89I
         fULBy99uRVRwTiOn15t+XagOmssYQ+qQotl61oB5pnKgU8MuATW/NJqY5RdyS55gT+1Z
         sKsE2mlNyYTisysMjgYE4SA7bncCBsNXGK6mFWhBoCRgsTDplHMFO5j2fBlIvc2EmlKU
         EE/ZCuFmdzhyaGGOaw+X9CHiH4rwr2RxHSf1PVH+9DCMuKnw1dSjnM3dCtikunfV79uz
         9nsaOfSv6MjeLOklEpP0WHVGsftvN4aKl7vKF7kpDi0WKYfSfI9WOPHyICMmnV5+tMf3
         t3OA==
X-Gm-Message-State: AOJu0YzMIFyEOOHBGjekq53YpO9zQ8+Md7eB92/67qclle/oFxYg+qzH
	zRxIxY+WFXf8WxK13dIU+VeqaiqdNdf+8MmyhWBwdsZ1s7vaQZQoFhxg67Lcj5g=
X-Google-Smtp-Source: AGHT+IFZQyaaLGWuPzBmBGRF1gnUaRaQLKADCauVFthMEcDdu2QqV2GE2sPbBHnr/hBFXmSLPPkLYQ==
X-Received: by 2002:a17:906:b0d9:b0:a3d:6eb4:9769 with SMTP id bk25-20020a170906b0d900b00a3d6eb49769mr15638737ejb.15.1708469797818;
        Tue, 20 Feb 2024 14:56:37 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a3c5d10bcdbsm4381946ejc.114.2024.02.20.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:56:37 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 3/4] sched/topology: Remove max_cpu_capacity from root_domain
Date: Tue, 20 Feb 2024 22:56:21 +0000
Message-Id: <20240220225622.2626569-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220225622.2626569-1-qyousef@layalina.io>
References: <20240220225622.2626569-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value is no longer used as we now keep track of max_allowed_capacity
for each task instead.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/sched.h    |  2 --
 kernel/sched/topology.c | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e85976bd2bab..bc9e598d6f62 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -917,8 +917,6 @@ struct root_domain {
 	cpumask_var_t		rto_mask;
 	struct cpupri		cpupri;
 
-	unsigned long		max_cpu_capacity;
-
 	/*
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1505677e4247..a57c006d2923 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2513,16 +2513,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
-		unsigned long capacity;
-
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
-		capacity = arch_scale_cpu_capacity(i);
-		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
-
 		cpu_attach_domain(sd, d.rd, i);
 
 		if (lowest_flag_domain(i, SD_CLUSTER))
@@ -2536,10 +2529,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
-	if (rq && sched_debug_verbose) {
-		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
-			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-	}
+	if (rq && sched_debug_verbose)
+		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
 
 	ret = 0;
 error:
-- 
2.34.1


