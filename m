Return-Path: <linux-kernel+bounces-101010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A453687A0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDDA281671
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E201B95E;
	Wed, 13 Mar 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YwqqQl0g"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F4199A1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293128; cv=none; b=oRwfyUoZt4GE79BMeigOudiLRcW1UcIhCkyYl0dgLPD+01bLo8JjM8w82or/hGX5gA/Xv7v1WUlPVkhdJrShEnKG7ZjJBAUNHyP3WuhMxl8+46QyPG3fWm+4+DvgRzlwcX750xJzyDZxH6z0e1EEcIUhQims5p1VAIa0yFvJau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293128; c=relaxed/simple;
	bh=o8njkdLQwpeSFKVUbv1Vgg6wMteGEmlFXV/7brtrrq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsARZDgrjDmSVALNG7NrK8u/+2z9Dofom+flbY+ka0rH5uhTfUOv92aq54NxbianbU9RNyWGJnlxm6+2tfvY5CJXPIpgC3hpopuRbpCVnTYeBLKDR6zZ0gEp9hZRA5bP25rGnaxuUGykup9jBqlvJsnsScgUImMg1nTx5hsD32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YwqqQl0g; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690ca2d2c5bso20587396d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293125; x=1710897925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHQc0zFqwpbzybw0LbQrYD8RqgFtXPcRDLH11DqCLn4=;
        b=YwqqQl0g5t27KgfNPbMUaY3O7HQKd5jck/EyI1BsV9maYvOlMW9xjXLe8V0kVdEvIt
         PvX4nPyihdHkpEtfCoTDEHS75DOvEd5ZQribsRAQi1hQM8baN2c+6l47A8mC0xlCc8j5
         XWiRqmnSdazVVZ4lwY3Fsfpv7+x2jcpLv1M9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293125; x=1710897925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHQc0zFqwpbzybw0LbQrYD8RqgFtXPcRDLH11DqCLn4=;
        b=jSiNxfndsbvyAEKikFl6PdqcMYURN9dRgh4AetO/iEAgtd8nUiPGvcF4ZSYHoVaUpm
         vHu4MC7v8oS0MQVyuGDMDsH9ghAgPpaaerJXZ+cBbIK1HmUcD1fHjDrBAskQWkDB7HLL
         Uw7tlscCtbVH04q8+YmjwUd6VPypIuMhRym9/KMxRtmGNU9YCbkZgaT+QpiciZVBSnLe
         Ij+I9G43Udgdf4hoMEVzpvXneivliEZqA9IABP4hkpo+cjqRZ5Ybm9q1MV2ZCK8GvI65
         wWfqgM9QdRe5yUoxVgIyNCr+x+QZQWBrIXZpWtDFMJdnMohMw37oNH42jzcV07uUDY0O
         7rVw==
X-Gm-Message-State: AOJu0YzqGFwnO4Gf5zcpmdNmN748gPjQGpTh/7WweflebWF5K3U/eVB2
	u2RwkQXMWzvQikmGuaQ+lcRK+dvECLaBOS78xnrqtK58FpNkF3P9gatnRbmvWU6uq3HRmF8exir
	z
X-Google-Smtp-Source: AGHT+IFH9PpSr8f9cA/V1GrvQXnCI5vJgzMU1R4IjJUUe1gozissvxwo7WyqvGk2jTOwm5nF85t3Cw==
X-Received: by 2002:a05:6214:240b:b0:690:f644:147f with SMTP id fv11-20020a056214240b00b00690f644147fmr3900286qvb.36.1710293124921;
        Tue, 12 Mar 2024 18:25:24 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:24 -0700 (PDT)
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
	Valentin Schneider <vschneid@redhat.com>
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
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 10/15] sched: Fix build error in "sched/rt: Remove default bandwidth control"
Date: Tue, 12 Mar 2024 21:24:46 -0400
Message-Id: <20240313012451.1693807-11-joel@joelfernandes.org>
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

This fixes a build error introduced by  "sched/rt: Remove default
bandwidth control". The issue happens because a function is unused
when !CONFIG_SMP. It could be squashed into the original patch.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 37bee56a70f7..d3065fe35c61 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -964,8 +964,10 @@ struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 	return &cpu_rq(cpu)->rt;
 }
 
+#ifdef CONFIG_SMP
 static void __enable_runtime(struct rq *rq) { }
 static void __disable_runtime(struct rq *rq) { }
+#endif
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 
-- 
2.34.1


