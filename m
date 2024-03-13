Return-Path: <linux-kernel+bounces-101005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B46D87A0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1D1C22146
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06091428A;
	Wed, 13 Mar 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fvt2DG9i"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56B12E4E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293117; cv=none; b=l7ULVDAnFuGoMhUMnaV7obUI6D/YMWCMsS68WL+CSMzSVzVAbhWa16+tpb8M3wh6Pv6qkFoxL1Klqsco7lNn39qmIAR4jCfHJn6OEdC/90mfK3X7DLcYyoDu8QNc9bgQzeNiEHth8xrcYDCd9z13ZTF2MRYNAOjiEwuGjhddMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293117; c=relaxed/simple;
	bh=BdbG0yYlQpcAJTV+cb1BRObS/3sDHMAKLat6xu5MQUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ky3kREDB4lF+G7cFB3Do90NnlweABiNxcowm8dB6QK7NMbH0Fus6q8ZBQlXJDQ1ggu4xbaKUU8d8OfqIiXRRuL2wW2+hi79RTTRsqeuSAx/3G0nXmGlr80mLJ2XeCGLyojqWXTtdvbK5aw53RVaX8gsS01GXoaIRc84CdkktxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=fvt2DG9i; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f41af71ebso4404396d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293114; x=1710897914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgoJ2Cj2+UUPtAnwZcQw+JcHc1DVxxL4Tm75yla0jg4=;
        b=fvt2DG9i08ArM6uUdv35//9sTm3nLCxklABUyuAKmRC6TVmgFS9Qono92GNuB4fNmL
         6Rp32oN7Hl1NJyDrmtq+Xj9dNNa0rJJV4hHgIfBIqYabgCIHOpa30hxr2rR2tv05VF4T
         SHPWdf7Zliz3KPDjRpfEUeW6oVV0aS79PxQZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293114; x=1710897914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgoJ2Cj2+UUPtAnwZcQw+JcHc1DVxxL4Tm75yla0jg4=;
        b=g26RCNzYtSA6BKz97AQ5JMm4Mda4psmeLm6g6n3OUkd46IcTNDwZIOjXlvITzE7nap
         wSiHUBS9NuanVq1Q+BlrO1uzvME1ipwk+Z8KBs6mkve/8YThJ7nfWZISTQTuZnQubDV2
         wWMsrxg+5mf1pgzWdfdnDwwgN15JrvVLgy4lTtlQ39eoIutQI9C+NItewqEVdb6aznzn
         RLk+m05VhCtkT06E0lbLxCkf37B0RoB+M2vbqBh5hwYp1mn8o3x0ShJjJklZlsXcEFUx
         4PvOAZiU03F3A7r2wnHgqO4H0XsJRQTO4iMJNqtNaXrm/h7/qRLcvn5GvBm5gqxqBw4j
         Jp8Q==
X-Gm-Message-State: AOJu0YziTh/G0sVHb18ylnjcbs8QKJK005Wz5Vvgp00ESSJOGoiJv/E9
	2YMR8e+UbYhhW7gVH79FjDsSjwRg6g+nTqeygDaz+mIHr8jJQ6roG4AbLcuL7ctg8vbw78hYuCy
	h
X-Google-Smtp-Source: AGHT+IGrnT4NaK5dgEfbg6BsheeR1Bp46xKOKlinXlRpGxwicEeQcbXPiAZiOr+R4nhkDUtlf00cVg==
X-Received: by 2002:a0c:ecca:0:b0:690:9a95:d8f9 with SMTP id o10-20020a0cecca000000b006909a95d8f9mr1796667qvq.2.1710293113824;
        Tue, 12 Mar 2024 18:25:13 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:12 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	llvm@lists.linux.dev
Subject: [PATCH v2 05/15] sched/debug: Use unsigned long for cpu variable to prevent cast errors
Date: Tue, 12 Mar 2024 21:24:41 -0400
Message-Id: <20240313012451.1693807-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids compiler errors seen with clang:

In file included from kernel/sched/build_utility.c:72:
kernel/sched/debug.c:532:47: error: cast to 'void *' from smaller integer
	type 'unsigned int' [-Werror,-Wint-to-void-pointer-cast]
debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c6c0120ff105..2590041696bc 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -516,7 +516,7 @@ static struct dentry *debugfs_sched;
 static void debugfs_fair_server_init(void)
 {
 	struct dentry *d_fair;
-	unsigned int cpu;
+	unsigned long cpu;
 
 	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
 	if (!d_fair)
@@ -526,7 +526,7 @@ static void debugfs_fair_server_init(void)
 		struct dentry *d_cpu;
 		char buf[32];
 
-		snprintf(buf, sizeof(buf), "cpu%d", cpu);
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
 		d_cpu = debugfs_create_dir(buf, d_fair);
 
 		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
-- 
2.34.1


