Return-Path: <linux-kernel+bounces-90347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63386FDF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8388282075
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796624B2B;
	Mon,  4 Mar 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnAzd6Kv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E4249F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545727; cv=none; b=M67OQ4VGQPP6vq0c2LfnHlqD3XTccMGkkOErxckpGx4kHH7dl2VwYHfjnOkp/06O3WqRRiiM1kkWcaicv/jrO1r4RIfUq5S1zd+B4VhlprPjZmCSEnYvz/14kma9O5QQN8Fz7lhm4ndZvfo2a5kOEbHnk+2TzhH4SerwKczfaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545727; c=relaxed/simple;
	bh=MzgCGm4DkmCkgSo9Fwl5qScTKTAx39yHwF+oGgxbR/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoyh+sCDJ892DCDwxUXYWTK+2U0cz/LyjMSzOlnBXPjzDSLJZ+1AZ+icunGqcIrTtWH39e88+UtPiUMB4nxeEoF0rPgbATKaPjwOdvnz5t7hOdnNXVJCzduJFZDeac54wF35qGvBIBe6CCatrDR4o3uFw0aY2s7JvLbsLEDktHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnAzd6Kv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a36126ee41eso648191366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545724; x=1710150524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPxGhOU8RasJef8Q2V28r0rMSdjIoPzVN4GRwFqx08I=;
        b=bnAzd6Kvkktz8mW7ZoNQHCfR3gSVTxJNhmKFw4pubL1TIZZfNUp5qJBuf9je+nnzpe
         OPe1MgbEIWpq/Gb9X7gkOmJYMHI3Lb+oLgj7Ha73plpARl7u3A/MnoGXfM+RoUGBsK44
         HdLTl8S5BjfQizD08ME24X/KA0UFfQKyWdMs4yzOJZx8Mylc4e1JzrXjoPgs3WZIIIBj
         EkC9zpdgJz+ce8/d74o+BElEszHnLKecFSwll4Me8cL7epGiWyxgBsYonhyoPkNv1n1E
         m6GVoccSsWS45bJIp6cQXAPHth1ADedZmuoVfAOdKNHaw8pE9ek/e3lg08o7vBNuWMFS
         pLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545724; x=1710150524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPxGhOU8RasJef8Q2V28r0rMSdjIoPzVN4GRwFqx08I=;
        b=mnYlTY1gsM0iODKoJirCMTvQv1b01n8siQr7hS+XXMNcOyVJHzB3K59tVMluCtjN4K
         +Xz29Bh9O3oOelAXinbxt6HX7hKT01qAwPhDWhzQRAEdDv65QT6J4qDEN948sCElheIy
         yFnVpJ61XOR7OzG7ghnNiYAGMkctd07x5qCzjqJxKgfyCyl/Nj3Q/zYsKmdJlYROiHfZ
         ZfdW5+2NZqgmXySs9uwkKLq39LDrOnL7x0PjPtJDG0LHi8OezOleybHZnsRLiB88jg4m
         n4+EqOXPJW8Vs/5NbQFGbfNLBlYXuC1T4j7WQtUwEWpf9xR+b6220k9/tpW3VeNjM1eq
         Mz/Q==
X-Gm-Message-State: AOJu0Yz8NRNUIOL6i2AxIuUTpezGARUDZZZO5G4gEtwrMS4JpwF3poyR
	4BCAYPoGCh1Eq+VBe8tl9vD4UJVfoNrdCC5tqXOuUefnRwAwghcx/pwwC4ETH3c=
X-Google-Smtp-Source: AGHT+IG6wrOmtjndbSn9gZFusYafkuuV/lv/Fk2FB+1cNj7V071mAUwIwkmsk53uVmKM9d82EmaNbw==
X-Received: by 2002:a17:906:6b94:b0:a45:26fd:f5aa with SMTP id l20-20020a1709066b9400b00a4526fdf5aamr2226490ejr.17.1709545724507;
        Mon, 04 Mar 2024 01:48:44 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 2/9] sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
Date: Mon,  4 Mar 2024 10:48:24 +0100
Message-Id: <20240304094831.3639338-3-mingo@kernel.org>
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

From: Shrikanth Hegde <sshegde@linux.ibm.com>

Shrikanth Hegde reported that show_schedstat() output broke when
the ordering of the definitions in 'enum cpu_idle_type' is changed,
because show_schedstat() assumed that 'CPU_IDLE' is 0.

Fix it before we change the definition order & values.

[ mingo: Added changelog. ]

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..85277953cc72 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 			seq_printf(seq, "domain%d %*pb", dcount++,
 				   cpumask_pr_args(sched_domain_span(sd)));
-			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
-					itype++) {
+			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
 				seq_printf(seq, " %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
-- 
2.40.1


