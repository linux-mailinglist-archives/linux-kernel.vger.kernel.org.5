Return-Path: <linux-kernel+bounces-163617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B328B6DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6D1F22C19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB121127B68;
	Tue, 30 Apr 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QujuHNpB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780713A29A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467895; cv=none; b=Y6QygxucS6F6Pik38SrcmfMNFkBCyOBfxbvC3b+TngmICAxpGesbjz8UtXbkt4aJ6UUlU1gDdGZEtuctn+XCG8HxFbD7K7eInKHRwTlBZOIPWVtoYM4Hb3YKr8bHeMV16l99gAaDPWzxjMMwqw19ixa5pxEyzOvz7a/C1MgLGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467895; c=relaxed/simple;
	bh=o7L7kC+671KRwUuDU7TEX3kWMhyi/AbplEOEV2kdbLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOZzjUtGEE2591hEU2W9YSlGLsVnaEKcxK4bWDBDgm1YV92AFGgwivbfro2hetvWpZucY3kdNubrcTYgW8JSSbxl0VMJCbXTFv6rNesQ4mf2Nf3+94WOYVKa9yHeYP6eCay3aXUkMx+vWO5WsJsDlpEAoDOIWpSgj7smBKBvIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QujuHNpB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec4dd8525cso2161565ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714467893; x=1715072693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiezQFrImeHjq4kKSLZkZSIcYVjSLXGfiOvcD86j6Ks=;
        b=QujuHNpBF62qT6iApfCzPSPHY0UnyuUlTYeqK2ImxEIbflRi/dM8HA/9ow14lgs9Wt
         Vo0Tf12HLhPn6H9bapmmRdKeD+kVdK+OMGVEFSqRbC1cCRELkKWCppnBJYJ4GsF0AuRQ
         TOr8M0kRBfXXl9y58mvDOahNz/SuJRAzQ43XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467893; x=1715072693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiezQFrImeHjq4kKSLZkZSIcYVjSLXGfiOvcD86j6Ks=;
        b=A0grrjFmoIg29sgoYCIGz1RirEeqfOVTZ9uH+r5Ih45tTye4woz/UmVdpGBJ08pbI1
         ymsHQ5fuWDhJGk4ydP/sUo3m3kfZgfmFnOSQglyZuhP0UAIthH7jIsScKlJ020mf6/+P
         JSZzMH4flpknpwstKlusa+thQGgRq4uSo98iu60jbld+qZRBuQTWcRNxELNn0X1m1e11
         b3R2d23UnOAWbjsNgYE8FD2RQ6471wnXbE1dPNLkzo9gjiKqB2fNlxRHv64jqB169c3J
         R/Wn6Wnwwg+Y2gK33Arv9f1Y1sRDwXSX8yPwWC+qxeN8QVL6PGsHooA2V0CYzjY8UI9R
         0fWw==
X-Forwarded-Encrypted: i=1; AJvYcCXm8qOqzJ0u2gRuURkyRavmI4VCC9IeSLu1sabf4JI8hNXbsKG1De7z/jNceZHBwUf5vXjesFaJpqhbdnWcdViD2JeLdtwfcU4nN5dM
X-Gm-Message-State: AOJu0YxOR9o1bNxE03EbN1x3dmuB89VGeQCr+WHRYmtBH9HdhCW4opEK
	vAlnh/zKmWD1vzClJL9YuT2w4HBtLWBZm1kg02DwuKblp0CM1VK6IqVmK74QPA==
X-Google-Smtp-Source: AGHT+IFKUVxq47GGttceDN19xDIOQhh0WXQmrnXBvYJ85DWXAgUXJ2fC7B0FJTKhsgRNVzorwj9BxQ==
X-Received: by 2002:a17:902:e752:b0:1eb:7899:adaa with SMTP id p18-20020a170902e75200b001eb7899adaamr8629355plf.55.1714467892674;
        Tue, 30 Apr 2024 02:04:52 -0700 (PDT)
Received: from ankit-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001e3f4f1a2aasm21822461plh.23.2024.04.30.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:04:52 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: juri.lelli@redhat.com,
	pauld@redhat.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH] lib/cpumask: Boot option to disable tasks distribution within cpumask
Date: Tue, 30 Apr 2024 14:34:31 +0530
Message-Id: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
introduced the logic to distribute the tasks within cpumask upon initial
wakeup. For Telco RAN deployments, isolcpus are a necessity to cater to
the requirement of low latency applications. These isolcpus are generally
tickless so that high priority SCHED_FIFO tasks can execute without any
OS jitter. Since load balancing is disabled on isocpus, any task
which gets placed on these CPUs can not be migrated on its own.
For RT applications to execute on isolcpus, a guaranteed kubernetes pod
with all isolcpus becomes the requirement and these RT applications are
affine to execute on a specific isolcpu within the kubernetes pod.
However, there may be some non-RT tasks which could also schedule in the
same kubernetes pod without being affine to any specific CPU(inherits the
pod cpuset affinity). With multiple spawning and running containers inside
the pod, container runtime spawns several non-RT initializing tasks
("runc init") inside the pod and due to above mentioned commits, these
non-RT tasks may get placed on any isolcpus and may starve if it happens
to wakeup on the same CPU as SCHED_FIFO task because RT throttling is also
disabled in telco setup. Thus, RAN deployment fails and eventually leads
to system hangs.

With the introduction of kernel cmdline param 'sched_pick_firstcpu',
there is an option provided for such usecases to disable the distribution
of tasks within the cpumask logic and use the previous 'pick first cpu'
approach for initial placement of tasks. Because many telco vendors
configure the system in such a way that the first cpu within a cpuset
of pod doesn't run any SCHED_FIFO or High priority tasks.

Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
 lib/cpumask.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index e77ee9d46f71..3dea87d5ec1f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -154,6 +154,23 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 }
 EXPORT_SYMBOL(cpumask_local_spread);
 
+/*
+ * Task distribution within the cpumask feature disabled?
+ */
+static bool cpumask_pick_firstcpu __read_mostly;
+
+/*
+ * Disable Tasks distribution within the cpumask feature
+ */
+static int __init cpumask_pick_firstcpu_setup(char *str)
+{
+	cpumask_pick_firstcpu = 1;
+	pr_info("cpumask: Tasks distribution within cpumask is disabled.");
+	return 1;
+}
+
+__setup("sched_pick_firstcpu", cpumask_pick_firstcpu_setup);
+
 static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
 
 /**
@@ -171,6 +188,13 @@ unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 {
 	unsigned int next, prev;
 
+	/*
+	 * Don't distribute, if tasks distribution
+	 * within cpumask feature is disabled
+	 */
+	if (cpumask_pick_firstcpu)
+		return cpumask_any_and(src1p, src2p);
+
 	/* NOTE: our first selection will skip 0. */
 	prev = __this_cpu_read(distribute_cpu_mask_prev);
 
-- 
2.23.1


