Return-Path: <linux-kernel+bounces-69160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FD85853C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7822828225D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8A1350E4;
	Fri, 16 Feb 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jtG1w6j9"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40C12FB18
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108302; cv=none; b=CRRa83AkzCXeZS4TB5Hze0hoWJVsVrSAJ6T/lZfXjw0cqip3NWj0c2KZjph8RJg76GWrHjoB8ewNRvKDJOmyXTYrHVNyBWnXaFl0wL2hzN8KwWAeJg8V7W76mAyjSJBfq0HK0hEsDbO2FLuoUqJ7ml43EmtkkWKJJREWBngF0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108302; c=relaxed/simple;
	bh=/tum2WF4xPzP3d2/oUJvAp904N/cyC9DIis13Mprwms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhhFfbGXCyGXvimt2OaVALuE1Bisilw0lodYH5/8x45glyZpKAanQ9ttBmUXYJOxg1U0Y9D2GRB+g2Hfctcv+rkH1pk49p3DTAdH78gES1whLOFy5UxA/dnZKCNngQUsAGHSGGOxtaVUxYOOwLQROP4gh6C52FbuJx4W9fqqftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=jtG1w6j9; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a94c0fb55so1148342eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108298; x=1708713098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVFjYg00n2ZAFDWX2JpqdHNuxugRyfOJfGbuxjDxV/Q=;
        b=jtG1w6j9N5plCISXLHBSv/uwTyCu7EH8Sx8Ee3zv11t6ywmECZSmwpY0oybC7bZ5vs
         3HQnp+vpaNyOiNVApl+5btIdCgtlyPizk07ugC55D8sOSb7Fu+M2dweor+2Qxok7q7wD
         owi1guotqKnwmb0LsKmonexOPeI+yra9+hN+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108298; x=1708713098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVFjYg00n2ZAFDWX2JpqdHNuxugRyfOJfGbuxjDxV/Q=;
        b=vzAEpyDBZ1jmtWKlJ7/pYt9oDhRAEMB7wuJLmC+sgWzG5F6S4UlWp0w6tz3Cdb/MvJ
         zzC6LzNZOannRnVLbLLA5X69gZFOms3Js0jIl0/xmzA3tGi7izNwQ2x/DwxUIn9Kc/AV
         j8lENOACWC45iAg/i1R/Dm4GoBj6g4HjA1j3ZX0xS5pa8Cp8e8dKwjerT7yVfK/nndEB
         aQlHibMQ06LPsUwcH0C1PYYVBHBKuNq6QD4RGLdU1lCDTYkN3tz5iHLFeAWx7BJTdDGq
         w4I2zIRbzpqaYLT30z2OJMHCSkGJ8x/7E4f34tKqB5Bmilscc0OlUfwLTWCzXCfnG2hq
         E50g==
X-Gm-Message-State: AOJu0Yw8UfvwLET/uoBhZgMTxhWg/NrzQXSXgPzzwLGWFThEn/JqrCL7
	2nsuVvfukAvvDJ3v3clV0sT5vIve9H825i3rE3gjI/Hd2zUFWeydBIp+UyLkYlS64FS1+Ibt1wB
	7
X-Google-Smtp-Source: AGHT+IG4d+tTgEr7HVS2i1dyAW42NfNP2FA8s/3EREPMydnyHcJOKe6m7BgCYUEnEbDv0LJlWGMLLQ==
X-Received: by 2002:a05:6358:3384:b0:176:d46c:e704 with SMTP id i4-20020a056358338400b00176d46ce704mr6500262rwd.16.1708108298409;
        Fri, 16 Feb 2024 10:31:38 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:37 -0800 (PST)
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
Subject: [PATCH 01/10] sched/core: Add clearing of ->dl_server in put_prev_task_balance()
Date: Fri, 16 Feb 2024 13:30:59 -0500
Message-Id: <20240216183108.1564958-2-joel@joelfernandes.org>
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

Paths using put_prev_task_balance() need to do a pick shortly after. Make sure
they also clear the ->dl_server on prev as a part of that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 973fd610d089..7f3a2596c1ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5998,6 +5998,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -6041,14 +6049,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
-- 
2.34.1


