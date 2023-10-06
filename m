Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759237BB515
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjJFKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjJFKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:25:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B0E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:25:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b9a494cc59so350799266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587928; x=1697192728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTTMqokwpEu0MsOdcm3T01Oj4as3iuY9zTcrlzN0rDU=;
        b=M/8iLqeJu0xzRcKqd8EIx7ok/9ABVKErDCdUZZpsf/XX5X3prvlqWafPpFOParyzJs
         2+CF/KSizDVerZHbekNjyFa/fVTl/SvpovO97IwnQ6wShR9lZA+t/VsA56W0LA12bpRK
         VdGx2jR4P2yY+CtSeHlBaNxjloqeBZss+n7jljuvGOrhJp9H4tdaQNd3KBdK7TxZwd0F
         K8ng1YoS/a3rts9yG372iUHNqJac7rnfk1nEfZypVPBHG5I2bV+2rxnZDHmMP4Q15Uu/
         d8P7rxxiZvDB/bsDM1qtuqL389MgH20FCvUcAacHGbRg91L/lxq8voEATlbWTkpAx1N/
         z8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587928; x=1697192728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTTMqokwpEu0MsOdcm3T01Oj4as3iuY9zTcrlzN0rDU=;
        b=Mp5VhGx7UBuy/UFqf4ms6hd4cogHvyYMUpJnaTcR8kwOgyddYdZGwR6dDtllJUNOEB
         i5K7R8dwU5ZATDYm7JnTBEXfqZxhU4tn9v9To1ivhpYqQj0+/e8SdDcXvl70twz1uNky
         Q2lhf01M7D+7ko8FU6r4pTI+LyCh2DrZ3CumFjBj32DEj1RxqBJDgaRK4NY26sFGDIGA
         L3VjRYWg7h2Q5DxZCpezJay+uQr2xDX+n4Wac0Lo9am+QuZksBv0b/e0iiGprkZZN8GW
         REzL/BKr0LFwm0s4l8d5qsYyRI+O6YjLzgM4fIbX5bZuxPrDcvsMDeDwV2hvnpgdE/Wf
         2+8Q==
X-Gm-Message-State: AOJu0YxJH2ElwxeB4QihdqM4W5EtBc183rOJeI3CrsnAKh2T98Z4KN0u
        /TXM93/VQD45qgvP/5rPLIYFCQn9Wk0=
X-Google-Smtp-Source: AGHT+IEGJerMor5S1sb3oq33pbZ965U8KAsIcmLU4zsiRF7Z7xVfzrjhKZ7tSzVJhvpJ0htjRZIjkw==
X-Received: by 2002:a17:907:77c5:b0:9ad:e180:16e3 with SMTP id kz5-20020a17090777c500b009ade18016e3mr6838021ejc.37.1696587928317;
        Fri, 06 Oct 2023 03:25:28 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009b957d5237asm2613502ejc.80.2023.10.06.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:25:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3] sched/nohz: Remove weird error handling from find_new_ilb()
Date:   Fri,  6 Oct 2023 12:25:18 +0200
Message-Id: <20231006102518.2452758-4-mingo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006102518.2452758-1-mingo@kernel.org>
References: <20231006102518.2452758-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_new_ilb() returns nr_cpu_ids on failure - which is a weird
choice in itself: not only is it a global variable, it is
a +1 out of bounds CPU index...

Its only user, kick_ilb(), then checks the return against nr_cpu_ids
to decide to return.

Instead of this, use a standard -1 return on failure to find an
idle CPU, as the argument is signed already.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4e90d15bd77..dad60576cf56 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11572,7 +11572,7 @@ static inline int find_new_ilb(void)
 			return ilb_cpu;
 	}
 
-	return nr_cpu_ids;
+	return -1;
 }
 
 /*
@@ -11593,8 +11593,7 @@ static void kick_ilb(unsigned int flags)
 		nohz.next_balance = jiffies+1;
 
 	ilb_cpu = find_new_ilb();
-
-	if (ilb_cpu >= nr_cpu_ids)
+	if (ilb_cpu < 0)
 		return;
 
 	/*
-- 
2.39.2

