Return-Path: <linux-kernel+bounces-97547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDB876BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE351C216C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16805D47A;
	Fri,  8 Mar 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoXiJxlo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19A5CDF7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929393; cv=none; b=X4vs7l2S48E/S9BSG90sdmTtj49KhU3Ke8V0hlxHkxKHO7RwQOMImBr73VuwpOV6AiznrFA+9KJH0STOUehsuuLWHdlUeMg79F5E6/x59SDbzi62N3X7fvne+qTbyVqUkM7iNWW2Rq5KmVAGMHRv0X3cgqcpGIp6G6lRoOUvDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929393; c=relaxed/simple;
	bh=yFsDfFZEuUv9qxH8zmyWfG7Z90+2XNnoBEt9sDtCYdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGzTLilwicfkATOnkFpwuHmHbzECoXpaO39eKOj2qQ+raSwTdACwvXn0WegA0x2EiFTJOWr8oGTYOe8nS1Twlj6+YrnTDjhsX7rIa5gTj2nq1Sxal0OkghjR/UYlQeMua5kyJAoj3Veu4Lhi2mc5UbSeI9y0WLnZyhPmXeUkRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoXiJxlo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd10ae77d8so21219575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709929390; x=1710534190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZitMuoImhYtWdV65IPpOlVhKETBgBqtF5UNRwTLlB8=;
        b=YoXiJxlo4GpZ75S/ijiyARapcem0gxvnx0nh4/G4r8S1jCXc8qVvEdkm3pyzpGsGq6
         ttb7kiWYCkIT6Yy2LRQNQn5wju1LajOF7jFx1k47uc99jTE7psK57jikAxkwCbKzzQDV
         0jNkBdLBso8rxBo33Mi045QOsBiOaYjqJEmEjMiRd3lfG7BEjeF+qKHVMZNfauv0l+Zr
         8CiIraeyzhW3/Ea00QpDhjy1WDqAUXE7GFJrA02+5snnNWzaMIYkG79GdckdCK3T/UsH
         8Ropfi1g/tMh8FbFmSUqXf2Ez/O6vO3ShspI9lWcPOZNexRL0iJreyBjg3mp7JPF330l
         aeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709929390; x=1710534190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZitMuoImhYtWdV65IPpOlVhKETBgBqtF5UNRwTLlB8=;
        b=i88+TdQtrqNZx1CByYmL5pCEYmjBgtaLb/TB2fyjbBnqYX8vbQFh1HBEwBu+ItNkkT
         SwfuTyLOi1GdloG684IzctsKLI0rzEXSUFganRSVEXC4EOBOWHSwYmE9crD4RclQK5Ss
         /jOpvMCY0xKjn7V4MMCnF4q8Ht4bQQPrFbjAes6tPDTHSa7dv7Rg0gapopUIANOGKUKO
         p12HorSj9mT5MBqMY0K4sGelYZ1k7vzg8QnBJZLPxuMSWZij9bh9g7sWKoT7AoCJBx4B
         EU+MFbkK7be8W6MuymZuAEl5KiCDEu2DekNK5PQ5ECjzZC4TWi44BCsNnV+Z2FEMT8HQ
         /Gmg==
X-Forwarded-Encrypted: i=1; AJvYcCXo6NhaalIzuKvyWc9vL0CM7wuraaqyw7nBi17Hfpd9O7ZSVEgSePfuEvxXKjbDytNDtGP5mC05PzpuDhzGClJh7CC/CUYhV9BtEhb9
X-Gm-Message-State: AOJu0Yy6+8yOFrlycKwy+9zgLrJSb4mDM3FEJ/Pnn2iDTxmIR/IPQdMr
	f3/Ss2Sj8kdmjdslopHIdfvAoP7WjwdKzcT3BFLwccRp7mmwXjzl
X-Google-Smtp-Source: AGHT+IHtFDQR34zJtF/NYPE9NQ7THRG2FcDB2wl/fjYgQD6swUTkJdpVz5AWyRJ5/P6gWeYHkvkj6A==
X-Received: by 2002:a17:902:7844:b0:1db:5b41:c59a with SMTP id e4-20020a170902784400b001db5b41c59amr103949pln.45.1709929390449;
        Fri, 08 Mar 2024 12:23:10 -0800 (PST)
Received: from ub23.localdomain (c-24-16-118-101.hsd1.wa.comcast.net. [24.16.118.101])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001dcf91da5c8sm52303pla.95.2024.03.08.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:23:10 -0800 (PST)
From: Dawei Li <daweilics@gmail.com>
To: 
Cc: Dawei Li <daweilics@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: fix initial util_avg calculation
Date: Fri,  8 Mar 2024 12:22:08 -0800
Message-Id: <20240308202209.2452-1-daweilics@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the comment for post_init_entity_util_avg(), it seems that
we are assuming se->load.weight has the same scale/unit as that of
cfs_rq->avg.load_avg.

As far as I understand, se->load.weight is the scaled-up load, instead
of the true weight (as mapped directly from the nice value) of a task.
When CONFIG_32BIT is set, we have load == weight; when CONFIG_64BIT is
set, we have load == weight * 1024. However, cfs_rq->avg.load_avg is
the sum of true weights of tasks, as se->avg.load_avg corresponds to
the true weight of a task.

Based on how sa->util_avg is calculated in the code, we could be
inflating sa->util_avg by 1024 times? Could this be the reason why
"However, in many cases, the above util_avg does not give a desired
value. ... "?

I'm not entirely sure about it. Posting this for clarification and
comments.

Signed-off-by: Dawei Li <daweilics@gmail.com>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..0d13e52e1a92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
- *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
+ *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
+ *		* se_weight(se)
  *
  * However, in many cases, the above util_avg does not give a desired
  * value. Moreover, the sum of the util_avgs may be divergent, such
@@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
 			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
 
 			if (sa->util_avg > cap)
-- 
2.40.1


