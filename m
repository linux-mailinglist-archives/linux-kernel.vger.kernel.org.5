Return-Path: <linux-kernel+bounces-90353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56086FDFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC231C21029
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952A38F88;
	Mon,  4 Mar 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVE9sAto"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE4376F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545734; cv=none; b=O5JBahLZ+DF2QutSc7sNeK4m30con9VeQCbn8uin3aAYbI7A48p7ypMvMOcUxYetxqC0LNcAyBpoY6R7lZI3kP5dby6hk8z5SWXQIBp5b5n3YJu/2a6FvPotWPQIgcVSjSdBkyVJ058n4tz6SpbwfeOXXTuNVVIPAVgvU/yQmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545734; c=relaxed/simple;
	bh=5q4oEyd8gvew6IIC9Mzd7ppJ4jXjtnRcQTUuMhWmx0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+tjDeaWERFmU07f3+ga9UGUbc5401nwnN5JSCvWcyeQfpORvES4g1+9iDAvA54dqit2fLXEKSLwKTUchqdstbiBRs0GncIGtNk1FUfXr3N/b7ZW33UWBGlL1pogWFMOf9M5VgaRkx2e71SubT7ACLpX2K3cfoIfXncNihgPoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVE9sAto; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a452877ddcaso107787166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545731; x=1710150531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNOPsWtOzHmhyJLPA4H5Sikwc9camJCP2VR8Yk1oBD8=;
        b=RVE9sAtoD82SWvKSCdKRsDZOE9etGwaEbt5Ci8aQdN5LAIQJ4QVzkoA4brMhUZrwd+
         dHfLbvxaGjyMtRpOukzK9wiSiXxtbZY80RFaiRnnOkDPS79K8gyPJlkgpqG1/C81Ewij
         4qxw1Cxby/DtHUvNZRss3xUc/OnglVoikAdAorZMidvc7b+DGw/1vmU3evazp9Ih37th
         KhX1psyp9C2tN8Gid0O6W5Lab7sGoMxnSbsSsOxdTpu1jXAcphkCtl3kkCNwiGj58wjs
         eOggwt5r646r+bcohhhbQnKWPy74OYMsaNqd7FM22Og3ZlIbyTc8Rta++svgx+YO7FUG
         +xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545731; x=1710150531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNOPsWtOzHmhyJLPA4H5Sikwc9camJCP2VR8Yk1oBD8=;
        b=qxA2qociFxO0B9wq4CIciZv05Xx0oj2n69G025Dc2xyGSIKdnvLVEKXVh98EBl3HL+
         5f8MrHuNMC1oi0gOKeZELpLPTrAqXMa983CMpnUjOcxjCv0zAHA8DpIxwsd5nt7eMDDc
         bVVeiDRQEj6sU4T+oclBSg61zwR9jtCtO+d1ATb7XG0T8oVuDJSUb9XtCgm+ih+ExZ2s
         qgZqsLGWNvkCh/GMRh0mU4Ra4weWl7oqxk5Y0nJgWwhYKcgSmtPkNsPRDWL9zliFCTTx
         ocdoflVpEq8CvqGi0sUwmxyqrIFmD5daGRxLnuhtp/4/6lASjH1ZHmoYP6q0E+L54vrs
         TwUg==
X-Gm-Message-State: AOJu0YwZpiHIRrpf5U5gD6928bQHSM8CHuUNL6O3WTtykJKdB1C0THA5
	+gmKjJiuhRz5rGQKaDUNO2SNsTHRH8wcI2T8fmNFdusFmtyDqPH3CSpmmZb7/w4=
X-Google-Smtp-Source: AGHT+IHLcHDtBKBKDPD5G3XyH0bgIbP85i9nC7qxzLNV0qSA4YXmeadC79OyG807zrHN7QrKbVxc5w==
X-Received: by 2002:a17:906:349a:b0:a45:214b:73cb with SMTP id g26-20020a170906349a00b00a45214b73cbmr2116320ejb.36.1709545731205;
        Mon, 04 Mar 2024 01:48:51 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:50 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 8/9] sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Mon,  4 Mar 2024 10:48:30 +0100
Message-Id: <20240304094831.3639338-9-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Align for readability
- Capitalize consistently

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc4b2df7ddf2..0eb2cafa1509 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9433,17 +9433,17 @@ static void update_blocked_averages(int cpu)
 /********** Helpers for find_busiest_group ************************/
 
 /*
- * sg_lb_stats - stats of a sched_group required for load_balancing
+ * sg_lb_stats - stats of a sched_group required for load-balancing:
  */
 struct sg_lb_stats {
-	unsigned long avg_load;			/* Avg load across the CPUs of the group */
-	unsigned long group_load;		/* Total load over the CPUs of the group */
-	unsigned long group_capacity;
-	unsigned long group_util;		/* Total utilization over the CPUs of the group */
+	unsigned long avg_load;			/* Avg load            over the CPUs of the group */
+	unsigned long group_load;		/* Total load          over the CPUs of the group */
+	unsigned long group_capacity;		/* Capacity            over the CPUs of the group */
+	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
 	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running;		/* Nr of tasks running in the group */
+	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
 	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
-	unsigned int idle_cpus;
+	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
@@ -9456,8 +9456,7 @@ struct sg_lb_stats {
 };
 
 /*
- * sd_lb_stats - Structure to store the statistics of a sched_domain
- *		 during load balancing.
+ * sd_lb_stats - stats of a sched_domain required for load-balancing:
  */
 struct sd_lb_stats {
 	struct sched_group *busiest;		/* Busiest group in this sd */
@@ -9465,7 +9464,7 @@ struct sd_lb_stats {
 	unsigned long total_load;		/* Total load of all groups in sd */
 	unsigned long total_capacity;		/* Total capacity of all groups in sd */
 	unsigned long avg_load;			/* Average load across all groups in sd */
-	unsigned int prefer_sibling;		/* tasks should go to sibling first */
+	unsigned int prefer_sibling;		/* Tasks should go to sibling first */
 
 	struct sg_lb_stats busiest_stat;	/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;		/* Statistics of the local group */
-- 
2.40.1


