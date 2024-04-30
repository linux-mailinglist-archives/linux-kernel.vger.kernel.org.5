Return-Path: <linux-kernel+bounces-163306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462388B691A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ECE1C21CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE210A36;
	Tue, 30 Apr 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QoKrTKQz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A810A1D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448413; cv=none; b=Z5NevW0Nv9+NpDGosXT+xEbNks39xk3tHc6dCRSkjzpsAuSCjaVcCNnzt+6LIRNFg1IO5PUe9w49f6zoj9pwzsQJImsmG9vKBzF7cht13j21n42KaFNnuWo68jYE/ri3wFp9ylRp0ReYp45GJl2zwKkUYMVpKpDJz5hZJjbER2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448413; c=relaxed/simple;
	bh=kgulp39c5a3fL0csnghKeNyo/+J+0o0YRGHyjTmxqog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmYebRIxJPNKugz46gKZAsjfLpFcfy6lN7FFAwktsPM04cWWVYMZxkWWvxrMTONkSpujbceE/PzNT9Sp1H29BdZoQ6gezZ5PXr2PVAj6nOSSySvNv77RMvgK14+pkVV1EejCAcmYgtk6zU2/+DzypoE1F5Hb+T/7azDY9EkpgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QoKrTKQz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so1917836b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714448411; x=1715053211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFwM1uMaed1GB197fv8QaEFA2adWM9OL1p7SZZL/tY4=;
        b=QoKrTKQz6hKnfuXQHC706vbu9lw06cEuc5f6xsQ/7JHDMrIEJZl6HTaedQsLiOvYQx
         Wzf8NUCHGQYqucN4u9Q+5mSdxV6UV5ahQ8vA2zE0q0eirK0eaKmhL3FVDrqVR16Nu972
         HRd5zRFY/v5lYk1HCFw6dkOWfDsu7eRn3YTbJ8j9iXUkVNEpDbB41r7FKyhHthLulLmz
         77WSoMh+ysTYkcq4t4wCdH1F0hCcOPtour3/ubuE+c59aoYvZH5pSPjPtChPouFyiiXZ
         MpswSFl+iUWX0OAcWe/V0l3H6osNWxI6xAsxTHti9hLF+GMCbHWowIpQTyifhpUtxNfB
         D11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714448411; x=1715053211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFwM1uMaed1GB197fv8QaEFA2adWM9OL1p7SZZL/tY4=;
        b=vjuuJPyVSectm9dE3ggaF+BF9U/35KtW48jLTE8j3rYgtsCUyQkJYu9deNJJp9jKIO
         5DMVDKNN3bh4ygz+/O6qk322sVHvlQ0ue1ZEmC/te06n5m7OIkCoZlW+O2FGmvKKumuS
         +yUKkKzqUkG9+wZyI12BAl3i/Pu/sF7CVv1toDrzCCN3nJcmiWsWrjeqju3OKjgGzt1T
         lki9JxVnxL8O9zXt3HG5rDMPW2HBChCw9muENXr0wfR8pxWsEvd3PBlJ9RXgj9Di5Awi
         QL+gsy7orcWpm2YjAHbELCY0NN0Pzvm36huIClE4u9SGK8QK+M60tokF5K+nHOpih3NE
         IH8A==
X-Gm-Message-State: AOJu0YwbFMfPFFdc0+3ShLkRlx6np1tPcS9BVoOtm/EPiGOvMz1E6AK5
	GYzYVHL2LkjTYuc59hn1gshnty8eBeJJkOLstcH3kYp0bx2JEnmOWDwAQmrhFwk=
X-Google-Smtp-Source: AGHT+IGjRAI2IN9bQE9c3IhZns8vEPxdJlrSpA+4FqfrCIasvU7LYq7+6LCPkU46ADWz2kbRd1ayFA==
X-Received: by 2002:a05:6a00:8a82:b0:6f0:be31:8577 with SMTP id id2-20020a056a008a8200b006f0be318577mr9669446pfb.22.1714448410812;
        Mon, 29 Apr 2024 20:40:10 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b006ecfd2ad4ddsm20767564pfh.146.2024.04.29.20.40.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 20:40:10 -0700 (PDT)
From: lizhe.67@bytedance.com
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com
Subject: [RFC] sched/isolation: Fix CPU affinity issues for several task
Date: Tue, 30 Apr 2024 11:39:48 +0800
Message-ID: <20240430033948.12165-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

If the parameter of cmdline "nohz_full=" contains cpu 0, the cpu affinity
of the kernel thread "kthreadd", "rcu_sched", "rcuos%d", "rcuog%d" will
always be 0x01, that is, these threads can only run on cpu 0. This is
obviously not in line with the original design.

The root cause of this problem is that variables 'cpu_valid_mask' in
functions __set_cpus_allowed_ptr_locked only contain cpu 0 before smp
initialization is completed. If we call set_cpus_allowed_ptr and pass in a
cpumask that does not contain cpu 0, the function call will return failure.
Thread "kthreadd" and "rcu_sched" call the function set_cpus_allowed_ptr
early in the system startup. Thread "rcuos%d" and "rcuog%d" inherit the
wrong cpu affinity of "kthreadd".

I tried to fix this problem by adapting the function set_cpus_allowed_ptr,
but the variable task_struct->cpus_ptr will be referenced or modified in the
scheduled process, which seems to make it more difficult to fix this problem
by adapting the function set_cpus_allowed_ptr. So this patch clear cpu 0 from
nohz_full range to fix this problem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 kernel/sched/isolation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..7b9bcfcd3c55 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -152,6 +152,13 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	if (cpumask_empty(non_housekeeping_mask))
 		goto free_housekeeping_staging;
 
+	if ((flags & HK_FLAG_KTHREAD) &&
+		cpumask_test_cpu(smp_processor_id(), non_housekeeping_mask)) {
+		pr_warn("Housekeeping: Clearing cpu %d from nohz_full range\n", smp_processor_id());
+		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
+		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+	}
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
-- 
2.20.1


