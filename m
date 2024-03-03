Return-Path: <linux-kernel+bounces-89711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0986F48D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F12B21C0B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75920BA56;
	Sun,  3 Mar 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0AdJ4HJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FEBA26
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463912; cv=none; b=IV6ZWim1vcIWdtACK9clKguN+KeASiAOssGcWV6j0taQ+MQAMFb3+TatK384lnn38Zv5Rbde/6UD74o454/y78OvH3JhEk2eQD1ALYF3oLfq6EQ6KNt2dMsLq7REuK0/Bm3JForVkfUdbBPDtlGzyW9JWtN4NL+mFPud5y/8Bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463912; c=relaxed/simple;
	bh=8uBNJFXGEq/RaNLJaLovCAz+X7zBRcy9HZQL83ofgho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8x3CpdMp8Gidipg+UdZtl9mKW8UJc6HTiuFAiiE8pYrl4h1zXe0aAsA2miDUlui9ZUdzN25jTMWGJxohA16Cnl93zx92RwoOwDN3u06AJOVp3NVCsIimFTBcQaK0Z17eAcXnn9oxiKNG2/1CD/jAwK10/e9Pr7/Ql+GxGjsB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0AdJ4HJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d26227d508so39279501fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709463909; x=1710068709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUeLclwrqZxiuoy0yMMLFuLZrmcp0qpm1t1UxC0wgKw=;
        b=E0AdJ4HJi1Zbs+B78B8J5M18PeY3zJcSjP7198g6s4JReq+yZPtYC16Xt2fAJLWQ0U
         RIkn8vqXlfLRsytIey5Me77ZuFu5X8u1jTlPsTUOE4apnAzhT6LyAj8eP9XcNDxMb3VQ
         SbNFZ1IH/ZNtd5ivWdl16xapglIhmq4cPtginN/v68I+tci3y/zQlT1WBH7JcVt/q0qX
         HqltiM4FGilMRFaoxVmP3Y3AO8sFO3ezK77SpuC6RiLTWruhwhYAlgdRhpKV9la6KiP9
         +jZ4P3mdb6WZ0vbW431+mcrBrjC5Ki4bLi5kqxbVIH/HdlGfKF2VAv1QF/PjoilvRTks
         3mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709463909; x=1710068709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUeLclwrqZxiuoy0yMMLFuLZrmcp0qpm1t1UxC0wgKw=;
        b=eSXhrm+bfphhDnCFjsKOSJX7hjqK5jNMW66r+r3dol26hb86Vokp4kGxikQUyeNXwa
         y98resrVz3MTLgYQHDkMrpYXCGaojiCo3cTBGRJWFeUxgz7oVPScLxi9Rlr+pgo3NBnr
         TadEBu1MndFi8dSo1y/3xeACyKA8DH5dl6Lto2Ji5eJRYT4tEJxOy16dCz1cHToF0bAz
         lMSlPM3k0waatXRAd1Q8HUUveKH08IVc2DKQUquvIe/v+g/lmrO3fhHrm/Za4wbVmXUn
         baheblww0uCgDI0UBpuuPj2gn/HJBMdzHeoDzmAmueicgrokpXT36iV2U/ZztXqRPW2J
         zEHA==
X-Forwarded-Encrypted: i=1; AJvYcCX6nJrOo4i1ShKa8C8X2unovD1uVrBfukMAwIiuFJWWISlAo0HTY35xkKZsbU3AID4vf7RrZVe5FjTBYbGgnzhGlgzz6kyhTgeWMXaj
X-Gm-Message-State: AOJu0YzWNLD2thT/fKXw0y/ABjO2Ebc6f41Bo959IL9LusiZMLiWb3jg
	7bKdMijWnxckXvbZQbcUYDtjvtk0+gqSyFV1XMUUvyCp7oYBz5KL
X-Google-Smtp-Source: AGHT+IE9GPfTGFG+WbGtYBtF6u5SeY3yGbNNszwbA6aKSQmHs73DMOk+vR4ohQj0i+2icUEZ8ccziQ==
X-Received: by 2002:a2e:240c:0:b0:2d2:d9b2:b310 with SMTP id k12-20020a2e240c000000b002d2d9b2b310mr4027800ljk.47.1709463908950;
        Sun, 03 Mar 2024 03:05:08 -0800 (PST)
Received: from moskalets-nb.kdtln.ru (109-252-11-244.nat.spd-mgts.ru. [109.252.11.244])
        by smtp.gmail.com with ESMTPSA id y3-20020a2eb003000000b002d2ded7f592sm1253389ljk.30.2024.03.03.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 03:05:08 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: Ingo Molnar <mingo@redhat.com>,
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
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH] kernel/sched: use seq_putc instead of seq_puts
Date: Sun,  3 Mar 2024 14:05:00 +0300
Message-Id: <20240303110500.15239-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for newline characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/sched/cpuacct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda09949..54d9dd68f517 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -217,7 +217,7 @@ static int __cpuacct_percpu_seq_show(struct seq_file *m,
 		percpu = cpuacct_cpuusage_read(ca, i, index);
 		seq_printf(m, "%llu ", (unsigned long long) percpu);
 	}
-	seq_printf(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -245,14 +245,14 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 	seq_puts(m, "cpu");
 	for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "%d", cpu);
 		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 			seq_printf(m, " %llu",
 				   cpuacct_cpuusage_read(ca, cpu, index));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	return 0;
 }
-- 
2.34.1


