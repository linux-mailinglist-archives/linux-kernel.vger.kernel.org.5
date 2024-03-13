Return-Path: <linux-kernel+bounces-101235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E887A462
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C9B21C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F51B7F9;
	Wed, 13 Mar 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnhOtDzG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689C1AAD4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320309; cv=none; b=p0zaTQU48zFUG9O+io0hvzMU+eU2jHeqhNyYfVyGT1MB8Usu3S00j7ucrRRRzuKZ2RJGE+s0IZivP699KjXIJmKrCkKnxDUTmTsmzx4d7TW5F0ebVfo61VJfr3pggRkC0AYVjqYkgN84JdL64fC0kl4prdn8z4RCJnnanTRF53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320309; c=relaxed/simple;
	bh=kCp9HVXPhRp7NMjJ4e2BGHnQLPGtkMmG62GCznhyQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJaN/Ksj9zcKwKSNx3vqx0nbSECxRXUKnUEmRhPDwR4hXgg+2OxOp2tB5IuhvCNbKYtUk5+ofshRgINqp3GgO755Zhdbfh5bNzkQkIlK0V/AOfb64FJSE9rgPqwlgkfHTMUlC4EImzbMOIqVGtFXN6v+0c+3WpaZ3mAE7gVIOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnhOtDzG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd5df90170so6008715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320307; x=1710925107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIrDh8lB94CwYXoBew7XaDRCsSW7KAjXffZ933XhSFA=;
        b=hnhOtDzGkN4yPPsY8feZ0ZBP0yWLYvcGHN93Q96aIG4cE5+lJFmRoOYyk9K2hlK8uI
         IhUsmrpE4p/IEmv6OfNqZ+Trm2YCig/srN+qyZrOBOVHO4LK1ZAg8xJLowvhGl2ylI/q
         0xwlJ3TDrjlqm/sYpSZzxT1qlQ/V1xm97ld1aXKUNdG6iLlJT6jUanundj/68zhqAVJG
         a3cT70I2SYYOlhKE+jSlZzbF8i3mbfxxljUtZOvWsZXupnp7sYYhp8wuMbDtBFmQuWLR
         kABFMC+1g8ewBgLSLpnj5gGQwnU6vM+baW2g8eVAzCYjBeIt2h+DWaj9MqRd2ldom14A
         jYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320307; x=1710925107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIrDh8lB94CwYXoBew7XaDRCsSW7KAjXffZ933XhSFA=;
        b=EOgygpLBHnwtU/JT97hmEW+/sp6mGw0jzTVCvWMohISiGhd8DyJOsQMfiEUZ4WrcwN
         T6Ge5AKOj02i6Ymuu/Wxdyg2lorG1p4JFWZFCrp3L09wJEc6pM4uEfTwDC0Jy+rhqRIB
         1ncyBJQZksJx4Ur0ciWSq+AMyLQ8eVlJsyGM14azR86z6ikmXzgfnAAuKhpS+70pvQiJ
         q+pY2GSpWH1mtYqtJBC/YkqEdBF+sBiKz+00/T+8osgDlDNQIvdJNHBystoTXwJS6w+s
         MXCkYwizz/pyVAGDeNKM3r4JYNS1lN/8c+DQbVw42yOfGpyhvG1Ef3lQdi9nZgUrG1bf
         +6AA==
X-Gm-Message-State: AOJu0YwtSfkdu9m7nE9v/XDcU7dkP0f9iemqRCnQEgjVHj77/vNJ1mvn
	xNYqWyn0YlvTD9ZfaeWfvndu6fXBQODdi4IhSJfPAn1esEYVvs6j
X-Google-Smtp-Source: AGHT+IHjREkC86DI8IrxNQa2CcWK/wq//9mkbDceAizzeVif3w2Z3ksFfx2wcq6RtRslqcZCbo0Wbg==
X-Received: by 2002:a17:902:da91:b0:1d9:4106:b8b5 with SMTP id j17-20020a170902da9100b001d94106b8b5mr3127445plx.11.1710320306721;
        Wed, 13 Mar 2024 01:58:26 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.14])
        by smtp.googlemail.com with ESMTPSA id w13-20020a170902d3cd00b001dd707d5fe6sm8114791plb.158.2024.03.13.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:58:26 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH] sched: Improve rq selection for a blocked task when its affinity changes
Date: Wed, 13 Mar 2024 04:58:17 -0400
Message-ID: <20240313085817.48892-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observered select_idle_sibling() is likely to return the *target* cpu
early which is likely to be the previous cpu this task is running on even
when it's actually not within the affinity list newly set, from where after
we can only rely on select_fallback_rq() to choose one for us at its will
(the first valid mostly for now).

However, the one chosen by select_fallback_rq() is highly likely not a
good enough candidate, sometimes it has to rely on load balancer to kick
in to place itself to a better cpu, which adds one or more unnecessary
migrations in no doubt. For example, this is what I get when I move task
3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:

        swapper       0 [013]   959.791829: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=13 dest_cpu=23
kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=23 dest_cpu=24

The thing is we can actually do better if we do checks early and take more
advantages of the *target* in select_idle_sibling(). That is, we continue
the idle cpu selection if *target* fails the test of cpumask_test_cpu(
*target*, p->cpus_ptr). By doing so, we are likely to pick a good candidate,
especially when the newly allowed cpu set shares some cpu resources with
*target*.

And with this change, we clearly see the improvement when I move task 3964
to cpu 25-26 where cpu 25 has a cpu bound work pinned already.

        swapper       0 [027]  4249.204658: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=27 dest_cpu=26

Note we do the same check for *prev* in select_idle_sibling() as well.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/sched/fair.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..9ef6e74c6b2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7511,16 +7511,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, target))
+	if (cpumask_test_cpu(target, p->cpus_ptr) &&
+		(available_idle_cpu(target) || sched_idle_cpu(target)) &&
+		asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+	if (cpumask_test_cpu(prev, p->cpus_ptr) &&
+		prev != target &&
+		cpus_share_cache(prev, target) &&
+		(available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+		asym_fits_cpu(task_util, util_min, util_max, prev)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(prev, target))
-- 
2.41.0


