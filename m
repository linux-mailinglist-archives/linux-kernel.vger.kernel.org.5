Return-Path: <linux-kernel+bounces-94739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC8874493
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5491C21D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAD25763;
	Wed,  6 Mar 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+meUeFi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E11B299
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768467; cv=none; b=FQlWDlch8XOaE6WhBwEFcWjq/hO6+sk/E81dyNl4wRQr/8SUvcW4t3JGjsNkjuWIcUEIlz8wJ3lMQtluOgo2QmsJXIUZUsh1qvuJmuuzQLHNoYCush6EGdVwrKjA70u9+yzAo1hu1JDBtihwJ0Tm/Ip6/64pHz+oL7BuJpobcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768467; c=relaxed/simple;
	bh=8uBNJFXGEq/RaNLJaLovCAz+X7zBRcy9HZQL83ofgho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILkM8aCc/FnTiA+asknvPiKOi8+2xnnpiPXFcSDWKAcuAnve1fL1oGVpvVdrcPC6dzAQwAMnNM6ekweCgp4FCkfUfQxLH8w4AT02W2Z6BnaqAaso5I4Ply8+Wv4fgKjdf2RUWvvJxa+ynTAl3UG/W62/NbCiySDUSMOiBWI5Fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+meUeFi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2505352e6so2798691fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709768463; x=1710373263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUeLclwrqZxiuoy0yMMLFuLZrmcp0qpm1t1UxC0wgKw=;
        b=B+meUeFi66cGRMQA3PAiSuqMoOMj42XrgbtiZVPvJRJHFoWG7nUj1delTQhTQGvfKm
         V9eadTpR9tiP/J6I+h3AXxwFLyAjTu44VarUZUlieHYkqGnvfH3aM+hqvwC1AUej70iL
         oUGjLayWRNsOijfVa7dOg35Gpk4xjSt72hlMgBOYuotZF1zUEx6FLjKBqeeQKaX7mosB
         SW0ZC3BncuwX2mDmvJv4W9rnCxJspvYhiVNCnrueKfT34Nx+pjN8Rc59DZXYrwnOEAma
         R9NSfmWqYzArTXHdhVqJLKDWfBc6HE/huhRErNxswLw9SOf6mTh9XgmBPinSuKin9lxV
         wGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768463; x=1710373263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUeLclwrqZxiuoy0yMMLFuLZrmcp0qpm1t1UxC0wgKw=;
        b=qrsattZ0EBHGyFSHL5sh0UsplYom+4zHCwdEk5i9ywnnUzWVdTszfYnPANYT4OlUsv
         qdwevsHKBnB/MaKbYZxbo/nMt671k9jPVJJms4NpyEV0bpwF8G2JZGG97d/wEUL3bJDO
         qAiXm5yNBOhTVAA9Zxv4lMcNQpTae/m1H7Mo+kCUIGWP8smCbP7UIY9mtmY8UNxr5elb
         3GUd73shISbv7fo6OTnjVPPvuia28ldxIuQSbk6XICB59+YiJcxf76CzYzbQae+IQg7A
         Rrr60ZNAQ352gUhTVOEVsfjTnxRTsQgn5gVe2Dzg1KDSodGvi+zTSUM9/dxCvRgkoptT
         gUBQ==
X-Gm-Message-State: AOJu0Yz127Zh/Mw863VuXV4t6velkbIwWYRtVyN+a95JKjj+UsRTlGv4
	l4Ky8uQo5MhJK34rO7/LwWiW0Ab5xh6CsA+QFZcMzChs7CV6uPk4U4o9OunR6Qkp9w==
X-Google-Smtp-Source: AGHT+IFU6AmbshSxwC6wamLAoP3Hu+M4ecA42KRmUt/NiRNwZmNRzNXhPNSaWvppyRKw3IXVOONw2Q==
X-Received: by 2002:a2e:8186:0:b0:2d3:ecf7:dbd with SMTP id e6-20020a2e8186000000b002d3ecf70dbdmr293058ljg.0.1709768463391;
        Wed, 06 Mar 2024 15:41:03 -0800 (PST)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id b41-20020a05651c0b2900b002d40303b8d1sm366319ljr.115.2024.03.06.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:41:02 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: Maxim.Moskalets@kaspersky.com,
	bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH RESEND] kernel/sched: use seq_putc instead of seq_puts
Date: Thu,  7 Mar 2024 02:41:00 +0300
Message-Id: <20240306234100.10356-1-Maxim.Moskalets@kaspersky.com>
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


