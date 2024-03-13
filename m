Return-Path: <linux-kernel+bounces-101006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8387A0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E8284857
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1D17541;
	Wed, 13 Mar 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Yj5qNxpO"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4A14A97
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293119; cv=none; b=ZjVU2qiir+3grSWlKXrAnLW2HBXzdU2Xlbz9jYpHZDbXh2cDVSuG8/R/blsS1PFHWjzontOGGX6WzFgVcY4M522Tm1fbmiCUVoUDQxQ+G3dV9ORvruaWBVdbc6J8eL/QgNAqtf77uNjx9rjqbloLnqvcP88q8mOSNnQ15qAl0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293119; c=relaxed/simple;
	bh=G1fDd4qTQBCk+lDij0THy4jcCMe3hYb5TF5caIUyaxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqk4Cm8T0TCtQdl+MJ1g4Oq9hTFxT8PYOM5RM1tcuSUR4gQvxcP5Od0lYTvWWlDOOkzO6Jf77CeBlI8/OkiZ7RFKFkO30lrZFDfOaRHWlsF1wxoqLOrGs4RVYJJ4NP3S9ps+PoSd1Hz34p3A5qcq1FoPxkO01O3qV37WlbqIz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Yj5qNxpO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69107859bedso3472436d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293116; x=1710897916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIgRVY95Czz2uvDMLBT/P8lHA/YSLsxu7WXMaEzsDZ8=;
        b=Yj5qNxpOM9DBANALmv+Kiut7N14/5IeMZUkpI+zPYYoC0UbLInDVOP0fBHq95RakIk
         nQ6oZAKM7KXWOKe3vyFRmRzEZUE45kEYYFTOPP7dUzkFWs+9HoVT6WIeYqLr0O0hU/uY
         yPnk6JswUFMhsVaqRkaSHHpMOpsb/4gwkMrzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293116; x=1710897916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIgRVY95Czz2uvDMLBT/P8lHA/YSLsxu7WXMaEzsDZ8=;
        b=SInlx4seYqkRzrLvYie2fgaZUvZ3Dyxgwyt4O7YlGlNZWEeCl1p8JalEfnWx82GEr+
         w3yMC2Go5Q/4tEzWXm36YLrSI4jY9nWtB4HPL6o4V9E2rSl6NbQ9zbu774NoJ5B2oxd5
         47I9qilKwdbWbB6In9mISDQ1nnHafhbgnCBp45DRkhMsS3/l6W/SXBbuhstf67GDgSqQ
         q5ZeooEN8CLSVVTxkxFZnjqf9e1G8XVu1jaO0Lk20R6jIgeRhlNZdnxTg6gAoceFhuFo
         Ihb8YgEOmXP4Mn9VDC3uYyXhHOFVIGpWJRZXaabDctubAs3NF2YY4iIExZEaMDKhsLuh
         W04g==
X-Gm-Message-State: AOJu0Yw5euQVXhu5+tQWVEoyGomtUoDkc4m8UMpbtxLsh+Dl73b0Be58
	UUxTfJ3DKfmu1A2xg0sE00PsoREPlKMRiVWWOVUGnzJC2AD6MPfj2DoCbPULpeNr0CphLEK0Ej2
	8
X-Google-Smtp-Source: AGHT+IGDvfbapxrZkVxMym6KQupINN2xVHHvjKMlG2VhI6KAqiOpH9z9LYAoPfehJ8VFbhJq3AOnkQ==
X-Received: by 2002:a05:6214:2e14:b0:690:7c8e:afcf with SMTP id mx20-20020a0562142e1400b006907c8eafcfmr5071713qvb.43.1710293115705;
        Tue, 12 Mar 2024 18:25:15 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:15 -0700 (PDT)
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
	Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 06/15] sched: server: Don't start hrtick for DL server tasks
Date: Tue, 12 Mar 2024 21:24:42 -0400
Message-Id: <20240313012451.1693807-7-joel@joelfernandes.org>
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

From: Suleiman Souhlal <suleiman@google.com>

Otherwise, we might start it even for tasks in a sched class that should
have it off.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 kernel/sched/deadline.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8fafe3f8b59c..5adfc15803c3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2325,11 +2325,12 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	if (!p)
 		return p;
 
-	if (!p->dl_server)
+	if (!p->dl_server) {
 		set_next_task_dl(rq, p, true);
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, &p->dl);
+		if (hrtick_enabled(rq))
+			start_hrtick_dl(rq, &p->dl);
+	}
 
 	return p;
 }
-- 
2.34.1


