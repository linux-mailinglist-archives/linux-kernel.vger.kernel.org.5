Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99587DBB09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjJ3NNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjJ3NND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:13:03 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D024C6;
        Mon, 30 Oct 2023 06:13:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5210a1515so64618441fa.0;
        Mon, 30 Oct 2023 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698671578; x=1699276378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLQIP7HJ05XUR3kXWK/jPVaD6NokUBVQvcd3TzedbeE=;
        b=VnlS8V8P4dWlbRDbL6/s/z7T1WFSmIJIm7pCQMvXrpU1wwyON1FNEpU7aQ/KRORKX7
         8XeMj6Wb8/Uy+9BSaJr1SqZBzAe06gbVhGkc7GEWnfL1twhtSxnqTkdUQiocTZQ51JLm
         NF76LfNmLfntTVSB+K+u2fE2eE8bUxfnjSdn2uOSMtu23Q4iVPQIboz5JgurYfBzMZ7j
         +lRHi3BU8dfbCNyjJMEPXJ8AwCgTW/iSukTN81JEUCTe0cbizMln5ZLoGCA30w+1cwC9
         GBKUpBsK3MglhUKNLm96d+Nala9uvQ5a8kjWVCCXEa8XN3JWTetvvA0+BRxATjNukdp+
         zmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671578; x=1699276378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLQIP7HJ05XUR3kXWK/jPVaD6NokUBVQvcd3TzedbeE=;
        b=wwDiXHV/Q++LkvEQcntyl7NrE/kChS6olJaNt2gOSlS3tEfLk+WfV+iOgSYCFfcOsd
         j1hjYxvDPr6zd0PE8Flfc7w/QJbty72j40Qh9HeTEhvXwNa3zEuo1QtwR5rKJnzXhv8i
         r/e4z/nw8rbbnzgMZE30+GEDoalPdyAphXLBx2WtsUWOQkA4n6dTsa8WLnjGDGBEkW34
         gncUvmxw2WYmzsUE5+Y/E5Sj5PJo4dia99C7+EWyRf4v2+szd0tRk5QrnuG4jDTtKc4A
         Tjb7GpZeZiJmKmM7WL+E/NcBGz2Fsyc2v9JY8rucg7vpalktHBJ4kL6NXVxdI6amuNKy
         xHfw==
X-Gm-Message-State: AOJu0YwDB1FQ/ZspBpHunNs7DdaUxH9fB9lBXPCj9JCEWQf15mnWJTIw
        cAYhPtQU4xTdaMd9a/tDclY=
X-Google-Smtp-Source: AGHT+IFaEFOYAxfUr2GRfE4Hpgo1Etljy7Y86mcCMS3ebjFp4lrGFrmHbimCo3gwQFjNZQKBSNI+pA==
X-Received: by 2002:ac2:5def:0:b0:500:daec:2817 with SMTP id z15-20020ac25def000000b00500daec2817mr6956916lfq.54.1698671578431;
        Mon, 30 Oct 2023 06:12:58 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2510b000000b005079691360csm1431887lfb.49.2023.10.30.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:12:58 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 2/3] rcu: Add a trace event for synchronize_rcu_normal()
Date:   Mon, 30 Oct 2023 14:12:53 +0100
Message-Id: <20231030131254.488186-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231030131254.488186-1-urezki@gmail.com>
References: <20231030131254.488186-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an rcu_sr_normal() trace event. It takes three arguments
first one is the name of RCU flavour, second one is a user id
which triggeres synchronize_rcu_normal() and last one is an
event.

There are two traces in the synchronize_rcu_normal(). On entry,
when a new request is registered and on exit point when request
is completed.

Please note, CONFIG_RCU_TRACE=y is required to activate traces.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 2ef9c719772a..31b3e0d3e65f 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -707,6 +707,33 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
 		__entry->rcuname, __entry->p, __entry->nr_records)
 );
 
+/*
+ * Tracepoint for a normal synchronize_rcu() states. The first argument
+ * is the RCU flavor, the second argument is a pointer to rcu_head the
+ * last one is an event.
+ */
+TRACE_EVENT_RCU(rcu_sr_normal,
+
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp, const char *srevent),
+
+	TP_ARGS(rcuname, rhp, srevent),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(void *, rhp)
+		__field(const char *, srevent)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->rhp = rhp;
+		__entry->srevent = srevent;
+	),
+
+	TP_printk("%s rhp=0x%p event=%s",
+		__entry->rcuname, __entry->rhp, __entry->srevent)
+);
+
 /*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f04846b543de..189975f57e78 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3630,6 +3630,7 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 	if (READ_ONCE(rcu_normal_wake_from_gp)) {
 		init_rcu_head_on_stack(&rs.head);
 		init_completion(&rs.completion);
@@ -3650,6 +3651,7 @@ static void synchronize_rcu_normal(void)
 	} else {
 		wait_rcu_gp(call_rcu_hurry);
 	}
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
 }
 
 /**
-- 
2.30.2

