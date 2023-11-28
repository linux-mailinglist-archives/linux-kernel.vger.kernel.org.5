Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAB7FB373
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbjK1IAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbjK1IAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53D3F5;
        Tue, 28 Nov 2023 00:00:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso7172841e87.2;
        Tue, 28 Nov 2023 00:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158438; x=1701763238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix4aRk838AcYQmbPKw3siGTbYQUaFkXlULCZyng7Pu0=;
        b=BZ6G+63AffuFlXIRRCr1u1Nr8ecbP8MOAYjMuyr7jWsWDAhnJms/9R5Z/nOGPYAqh3
         GRjkJU1HLhPadxrMO+H6HKD+X5w/qkP44pmd7wVttowREYHK693jwX84WbVsP0Lyxk7Y
         RPajvj5eqzLZaYDEVLAbpyKlktLvu7PgSZDCmu5BjtcgzfKNdNGvsUcsVq8gYMP5vHKh
         MniLZdGMI+/t4HK/TucbPYJrGga1avZOdWLxX5U0foUeooCGUOAG2Hb09JOuKz9YWCqD
         rUt/42N0PtMSn+dWX63tyDzcvpBYThPExMVrWqRan0qb9cjo3jFk9L4qL8q+Nhhj/tZJ
         HgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158438; x=1701763238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix4aRk838AcYQmbPKw3siGTbYQUaFkXlULCZyng7Pu0=;
        b=hIfEPAcguwqhLq6XC7QiL1Xd1JAmVcYlgRAIEDcQfwvn04NTbzRlvm7xqTUtyuvT1R
         oml4DBney5QMxgTF9QTYzUm9z4I8AnX+LieVnEjcCh9xp9zLc6/gXGbjdZyrjCQOnN7f
         ioto1e351/lr9bDrg6FUIWGsu4f70xev6jgt6t3s/ojouXqQOTTkED2xXxqzyxc1he7y
         knXhyUbXGM8SFDtKEtfRwAmiLAIjqkAqKWlDMDTYAq9t7KcFRgYIE8SxKQsVgMadeAdH
         OZVXh62norLuvd+lIzOGjruu6pwSFiJKhb3jqiFkt1GYis8n/kizr6rj1XcSTZ29oQsI
         0y4Q==
X-Gm-Message-State: AOJu0YyiSJEUL/NYP/7VKEjiitucJj2cwVDlQu/LvI2mDHRpvexWJ4Pf
        u2WGaxzgWhO+oXbZ56u/F9o=
X-Google-Smtp-Source: AGHT+IHGoDIkR+3LGSkpG2prqFUrijD96VN1lQHXfiKNn0H0hE3PzO+EvHHz4GFAsa/fPXxY4wtBuA==
X-Received: by 2002:a05:6512:ac3:b0:4ff:7f7f:22e7 with SMTP id n3-20020a0565120ac300b004ff7f7f22e7mr11962877lfu.17.1701158437824;
        Tue, 28 Nov 2023 00:00:37 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:37 -0800 (PST)
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
Subject: [PATCH v3 2/7] rcu: Add a trace event for synchronize_rcu_normal()
Date:   Tue, 28 Nov 2023 09:00:28 +0100
Message-Id: <20231128080033.288050-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/rcu/tree.c          |  7 ++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 57cfa467697b..975621ef40e3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3597,9 +3597,11 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
+
 	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
 		wait_rcu_gp(call_rcu_hurry);
-		return;
+		goto trace_complete_out;
 	}
 
 	init_rcu_head_on_stack(&rs.head);
@@ -3618,6 +3620,9 @@ static void synchronize_rcu_normal(void)
 	/* Now we can wait. */
 	wait_for_completion(&rs.completion);
 	destroy_rcu_head_on_stack(&rs.head);
+
+trace_complete_out:
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
 }
 
 /**
-- 
2.39.2

