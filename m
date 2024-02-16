Return-Path: <linux-kernel+bounces-69170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493C85854D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79E51C20FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596331420B8;
	Fri, 16 Feb 2024 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RTI3IZt0"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92013A88C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108321; cv=none; b=XdayfiBthx4Jh1CX2fcq8kcw8TrCWcTyvfmb2or0Os8xhQJzPaR08CAudiapJ1tpZ3GENSxHTbVPOoKsFLZ90+F9ncnVbgtD4Znw5x2CAOTuahdtwQh+/VQAoOzzAm+/weV6MgC4HpmCWjTuI3kb+JnF28YlbVhgplzmm6yh2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108321; c=relaxed/simple;
	bh=o8njkdLQwpeSFKVUbv1Vgg6wMteGEmlFXV/7brtrrq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mb9xhuBtoiClZH7c0H6DOQk/Zdld1n59kCl8z+DfpiNRnRJxpvOCOcqAXUBJbiEhjW+GLhnJm5Tev1k5AnfCnre99Uyq5GzGZFk0mNws3wbi3EyI630Tpl1ziWGMjxSKBAiMg1bykk01Nb7AdlXcRmTAvsi9Pk/d2PeUUjAHeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=RTI3IZt0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7872ade6f0aso55512985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108318; x=1708713118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHQc0zFqwpbzybw0LbQrYD8RqgFtXPcRDLH11DqCLn4=;
        b=RTI3IZt0wq+6/wGYTtp0kX1KgE7ZTrBGCvNgfzdabuTMLsiY9itQArhMd4Cikoz1ez
         ceKRROrCAzSjh0xtzAFtiQ7821XRu97ZZulp+iJ0U4Ykm0QMomY+SUG5ezJ692/NMXXI
         frFVKtK/uZgvnfi0rW0z2hyVfaZ40NXxwsKs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108318; x=1708713118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHQc0zFqwpbzybw0LbQrYD8RqgFtXPcRDLH11DqCLn4=;
        b=cn4iOX+rB2Dk+aQ2iDPqQZWA+OJLC+FEbgRDplIo370kP2Oy6AI4tnYVxez46bpYYs
         UIB+IG0vak3ZBN/bbQuWw7QTtFaSONOxcN++/d1c9gaacNCvHpd/APsa0iJV+oaPcZU3
         hKC2i4iNgM+ZOAYRT0WcjO5FDuOcsq74ljOUfDumkSHQbhdewnQV26SnH8q3BHj2HdQs
         Udacy6ytLWO6zkfrQENa5/n2XzLs1Nqbl64RiwmxxlY/IXwOHZQRx0Q/RLuJaAqvEMet
         /N+djVGq43hC4MUyoVCSdtjLDJYgTSdGoqwxJvYsTAQpzCiPCJTjAaND67v2/lcNKRf4
         fQtQ==
X-Gm-Message-State: AOJu0YwYWkpLVP4r8s2kai0dg/zXh3PTOTbry8FCZbMdtbFA3L4sD24v
	iq33UAMx1zTexibELaI7rknMteKaQXbSmtdgPWP8jYCUhj4aPMy8Ht4tDPUJzSsYDHZtzhcx7MX
	n
X-Google-Smtp-Source: AGHT+IFBKuy553o0SxY+baIXFsZYeaJKSoNLM3xELgWqh57AsVbOsnUirYjkQQVzjewQhFJtyM+wkw==
X-Received: by 2002:a0c:f38d:0:b0:68f:1e7c:5f46 with SMTP id i13-20020a0cf38d000000b0068f1e7c5f46mr4946028qvk.45.1708108317858;
        Fri, 16 Feb 2024 10:31:57 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:57 -0800 (PST)
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
Subject: [PATCH 10/10] sched: Fix build error in "sched/rt: Remove default bandwidth control"
Date: Fri, 16 Feb 2024 13:31:08 -0500
Message-Id: <20240216183108.1564958-11-joel@joelfernandes.org>
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


