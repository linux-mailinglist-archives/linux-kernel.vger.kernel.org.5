Return-Path: <linux-kernel+bounces-96891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD898762A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BFB2172F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63F55C34;
	Fri,  8 Mar 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwop8B73"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F875B5C1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895568; cv=none; b=b08QHit3L4GXkjb4uuHnBZg87BgPk05mpVFFFYKBvxu93iOGpwTgDVzzpBhdmfEXibaUpAiluIh3dFIZDAPyOYEQwVL/ZtW2T3oiBG0dTljDPkgE56k6tei+6OeSLcg9rJSurdzUWtK3+N4KKhEy8yRi2rES4uXEGvFC0xqn++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895568; c=relaxed/simple;
	bh=8cwQfRzQGnh4brkT8CjyLXxcv9IIDXvGcNIoK5bYZ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWzfHcJGoibvqKZRS/tDvyL/v38nGX+1G3F4UttK38YqfoWUHyQBVOv8WqvLGeHVt95NtYyv/rFJSFoP8f07GbK5gxTcBurXsLi9mBnXRNTAGig6Vu24F3NBEUZdVpt0K/o1zI8lv/hYb+puRFkdwcWlBQ2U47ALKr0f7sKAVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwop8B73; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4131804e695so2943775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895565; x=1710500365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL0vnFENbcjnhhWim8StIpvyCHhEh0ryI7d1fyMUSfQ=;
        b=iwop8B735MigXQ4fcA/0FiEA1iBWYdEJEoWKRB/gRepfOrMPbcMOaRiYM2zJADHLxz
         ApjcQjr7qM+FpDRy4+B6HTBIf+qjhcjelcivcVRlRk9PMx4KinlW7rbjpzJ73M7xkMaB
         +NvVLDxEdniNakbun9SJG0juNb0YELtPtO7xCWYIeK11P8TZUfKcnVTqsU3hsQL+hSxa
         UBZqh1guhMxIvrA7SLH+PYghpCSVqZ+acFC7eUEQGdhb5Zu+IQ8ajQjeJBGkJ5EjPSOJ
         2n41VOJva8Kn+WAe6m4nOAM5dOeHsD27/G9JR1OM6Mf67wXwACWD77YIu1qr2LSXAyy6
         qwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895565; x=1710500365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oL0vnFENbcjnhhWim8StIpvyCHhEh0ryI7d1fyMUSfQ=;
        b=h9vbSnwZZxI8/swyZimLqJPn4KVjooqZibN04oxhAk7v6fWPh+qbnvWt21sOJd5oB4
         tXmhb44TG4tzYsUmJIZaPKVeobTyXe+6XC5Z1+LydBzP08xzjqiTFru7nWwkh/XTuua6
         rhJm5IunHva3WIH4s6+vSrWhCcfuElQJhReojfIQ4VE+nAaq+nslXo+4PBpYv4e3amHk
         ffEiA+IaIy92MKzDfWZF6n3qho/mphs68Kyhes/tK8pKpJzWtjw27hjFSoQInCnZDyow
         4vSEH6Z8MaT5qSrTpIURvaNrbmrkJXGAn0zZ5o9wA+OhoAmI8YZn/PideooEWURnlZyK
         X/Ig==
X-Gm-Message-State: AOJu0YxsHdSx6jlFKMQGvjN/uzEWt8b8BdrGCh0tGCCp/gmtLRllXo09
	K+8ERJSTFjCEvIPrk1NIQ7bEK87NM9YXGuCFC9TrJEmG4LZxSSgveCboM7HFLDU=
X-Google-Smtp-Source: AGHT+IHKMzwKstVRsql0EYbiSJAEPbtqcFTBBtihUSdD+H41bRadVI/kPcqNbZ3kjXIfag2jxlMVMg==
X-Received: by 2002:a05:600c:4589:b0:412:bca4:6a00 with SMTP id r9-20020a05600c458900b00412bca46a00mr3891981wmo.18.1709895564745;
        Fri, 08 Mar 2024 02:59:24 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:24 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 10/10] sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Fri,  8 Mar 2024 11:59:01 +0100
Message-Id: <20240308105901.1096078-11-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40b98e43d794..116a640534b9 100644
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


