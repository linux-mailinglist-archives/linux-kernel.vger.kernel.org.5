Return-Path: <linux-kernel+bounces-69161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E385853D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AF1F21792
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24E2E3EB;
	Fri, 16 Feb 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N0SEb23L"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E71350C8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108303; cv=none; b=JswvYlVhzzlhzzeghn4DjLQ+didPVce39SMJNgA4S2etN8ZgbWthI31G/SG5P4KkoJTlZg1P0lw+gXxCiNwJn693lOyR+6MX0P3Iv/6kPlViXruXDKFPHrBC/mCYUYcIQQDRZUUq6JVLfmCJrDU9MBV/sFLbBE1/SIsyRU4duNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108303; c=relaxed/simple;
	bh=ZOaTdU6+mkYKcu73jBNLA/JSAJmZHt+8O8zlVTj/AiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpNxZGtHhm6Z01k2ZmWFu5OhKd1lN4Cfip12lKbb3nfxvEKtFV1adZcZst3FZA3SM3IQLr5NcbJTdgs2cLWuT+0CXABamg9JKF2AxHnOCOzWQfFqdRTxsq8GjbPFI+x7jMAbJWnfu5HLPCkJUJP4Kq2H6Y/tYbKQefUClpQk0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=N0SEb23L; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1333b0974so1781021b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108301; x=1708713101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIq/RsKJ+ZDmqaV4DNR53VSSNnL2VAVCUisag/qJ124=;
        b=N0SEb23LelsStLT58qIHRcuxwaRuV+ph907HfptgXBYsWzkKUUA6vLZG8d8B0yWkgD
         50vde9a1DrDily4MklVo7zvFUooP3m70ZqxC/tcveowBwH0YLvGbP96Sb4qMBKpLI+UX
         mBq2Zlphj5vn0HoEQlREACIte4xStNScB9C9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108301; x=1708713101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIq/RsKJ+ZDmqaV4DNR53VSSNnL2VAVCUisag/qJ124=;
        b=PBBSwq+vQfosGrsp0HRW3qII/WfkiiKcAoR7Uepz8mBAvSfC0RcqNN9KgruzAFAPqO
         jF5YXZ+Cy++V56W0dDCEyBeaBwej9ecgmTFp75icBp96K3ROlra2UjGJuzQTDluAoGkQ
         j+gwvD8nGNzgsj0tYDhhks1giLvWJt9ktziyxDHIVCO3Eqr1wkaxaihlXdT1MVhyPvNR
         7EJYJXy55KQJ1kIS+7yGjGpE2bvuuhgxu3ETx5r+XH/FRViUmu2oBeVd9tOmoqv4ENJb
         aGJUSugikkIXEtdw5XtxkzpJLRNyz1d42ggvFztosgAzKSplWlFKdO/37F2tOlDgqF1T
         TWsg==
X-Gm-Message-State: AOJu0Yyq2opdH4xOkPpoQgjh+/3v5EvaXcB8xhyHa8G97gOcm2AdjswK
	b/NEw6KqN0BlFYEGhgQjzyPq/744eISPqa9Fi4+zFLZGEsYZr11dol7uDTJYWTAgrEI1WVFUluu
	1
X-Google-Smtp-Source: AGHT+IHfLlmYY2tH68nTJrzTI3LtFVSzFmMAcGztCM/IKH8k8dg4/JeX+ZCpu5PdJvYZxlHkpp3T/g==
X-Received: by 2002:a05:6808:1642:b0:3c0:4d21:e62a with SMTP id az2-20020a056808164200b003c04d21e62amr6746614oib.31.1708108300676;
        Fri, 16 Feb 2024 10:31:40 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:39 -0800 (PST)
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
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 02/10] sched/core: Clear prev->dl_server in CFS pick fast path
Date: Fri, 16 Feb 2024 13:31:00 -0500
Message-Id: <20240216183108.1564958-3-joel@joelfernandes.org>
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

From: Youssef Esmat <youssefesmat@google.com>

In case the previous pick was a DL server pick, ->dl_server might be
set. Clear it in the fast path as well.

Signed-off-by: Youssef Esmat <youssefesmat@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f3a2596c1ed..63f41453b79e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6036,6 +6036,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
 		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
-- 
2.34.1


