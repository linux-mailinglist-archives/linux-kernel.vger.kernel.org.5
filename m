Return-Path: <linux-kernel+bounces-69164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B838C858544
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7090B2826BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55B13667E;
	Fri, 16 Feb 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bCBBuWpQ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B6135A7F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108310; cv=none; b=At77EbsyA+4PQQ1JAaw5YZa6hfPQvNTphInLJfu3Il+v8G88A7Um4qV2/vQf6KGxUGmYLJUGBg0Ijfbur00mYSzXZjtYBfUekMeIZoqvlcSmhHdWhDj4c9Hs+SWLal+N995qjucWLYU+b8BRjSw77n1Z+uwo2OahxT91+KwNTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108310; c=relaxed/simple;
	bh=BdbG0yYlQpcAJTV+cb1BRObS/3sDHMAKLat6xu5MQUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ka16JsMSJnsUFTpR33OIX1S3Yss8+la4r1xVm3GpkaDezPn2WY71I9nR78GSQOPrEQ58etLWvW2KemEHE3Jeg/HxPb7ozXOv90JqJ7MgRDoLQFv1iitnjYCSSjCD/Aq74jhiN7xzAdbHXULMz/fa/JGrAC+0GErYixXnaYGOAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=bCBBuWpQ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f429f55b7so559466d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108307; x=1708713107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgoJ2Cj2+UUPtAnwZcQw+JcHc1DVxxL4Tm75yla0jg4=;
        b=bCBBuWpQNaNjqeDmb9JQNQd6M4Tf5qyq3qj4KuPzKpG6UNtipEGWIVqM0AWhnRJoJP
         j/mCSmz0i2+Av6GXBWugAl5tLOrNHQzc3QzFLw0UyoPGwZ+FVj+0y427MX1eQ+O/O+o9
         5JXEjxER3QIn4nmdrGrrkTUqcYjZO+eC1y6zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108307; x=1708713107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgoJ2Cj2+UUPtAnwZcQw+JcHc1DVxxL4Tm75yla0jg4=;
        b=vbCEcHvy5ga77oqRDNo6tT5LOjo7YIB7h8UEwt3nRIqE47F8zfwZY8vEGLSR78HLgb
         qJpZDX6mWGc/zuBNOy8ouPzPDECN7wL6Zg9h2sSeMa9DqoxqzjidRl3igI0KA2+3xgwh
         HMTbBpQiy7FspANSxGI6v8OsHuipzKzm2wH+jAmjxb+pwS6pQcVOJ6ztsq3E5aQW98mh
         IhryW3lFbZ+HbFyQ5h1BjSe9WC9pkztwVUpGQwoVx0xI0k+lXGJpBu0niXgykLJUGZkV
         zYntrQYZt+Z8/wp54jtCHd4ghiR5TCJa3T/kHSmMS7ARjCnUsJ6I3Trl0fPuuwdlCPpR
         TU4g==
X-Gm-Message-State: AOJu0YxMIMgWlML+juUMIKHxBEamQ3tyS/fXdm5NItiC+kO8di/VoTQ2
	Py7HqYVpvc3Zm1SCTqyiXdqwI3800+ayn5X4xWXgHnpHFlcR7HOu4xDSZu89B9cJEfNvFlbrRWa
	6
X-Google-Smtp-Source: AGHT+IEgm/Rt03+CeLnQ0S8r32mOvp7WezqLoTo4VJlM/CGcCwSRr9+Ve15KD4TNaat1Fb+SopCMdg==
X-Received: by 2002:a0c:f0ce:0:b0:68e:f036:f5dc with SMTP id d14-20020a0cf0ce000000b0068ef036f5dcmr5456748qvl.15.1708108307279;
        Fri, 16 Feb 2024 10:31:47 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:46 -0800 (PST)
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
Subject: [PATCH 05/10] sched/debug: Use unsigned long for cpu variable to prevent cast errors
Date: Fri, 16 Feb 2024 13:31:03 -0500
Message-Id: <20240216183108.1564958-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216183108.1564958-1-joel@joelfernandes.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
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


