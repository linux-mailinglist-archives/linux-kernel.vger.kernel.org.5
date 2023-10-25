Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DE7D6F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbjJYOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbjJYOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DD99;
        Wed, 25 Oct 2023 07:09:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50802148be9so3291544e87.2;
        Wed, 25 Oct 2023 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242960; x=1698847760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHDEJ3lmtmiX3laFHnI04RPu1+R3BEM2SvSjdFI6IHw=;
        b=bV+G90lwvN9BcfEZj224zGCwJFYBE24UNYELzszmLEq8mkLEjp4zimKfkDI9yTeKV9
         tHvowpymvKUbzs823PhvQUIl3TmN9qD9h+ztXhz9fWWtU6NXMt6YaAjxnMW7CJlB4z0H
         hl+KEfxUgkkav6B1ZH+8I0oxwAmGOeGw6AM1pwBzh85kqK+h7o6K9ZSM+XDZQQEXL2Tj
         9+f1nvk5q6NqczyiNqxhc85n6a+xVWtJv3SOxHUuaoZiIWUCaXPVsNnLeQCtbmcmSO45
         H/EQx7XtOYK7SZGulI0qq/67QqhYp83hptZsVk7z4TnWBB1zOUbHQ3Sx1jGGQR7TXzp6
         en+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242960; x=1698847760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHDEJ3lmtmiX3laFHnI04RPu1+R3BEM2SvSjdFI6IHw=;
        b=EbTKbBkCf122pqXBmq5wkr+QbSWGeKnjLrP0zRRglMEnqAmUo5o2Isvx+np45rgbPO
         jEreXTQqGj5uq+EIoMIOSDzzhHt3wPFzV0GivUXwrbAmfNLYVPTX8jCSs8VIX+1+trrr
         0wxvNGvGBYcaKPd+N6Scs/wovw5ATQSwJUqYsBon+aQu04HAf25hvzI4NvPt3c89WWFe
         +s9Z7sHKpRVIu4EAbcie+0ML1elSExjPgTrId1bClxFFnBZf8wLeQwOSLPGsrctCc9+G
         c3ZgvpIlL9Thvl6WKYyPihVIf+vV8KHGwVXicD+l4zZ/B2PxZSDSlHcUSdoDX58+hnR/
         L7DA==
X-Gm-Message-State: AOJu0Yx6gbZS2odTjBR+RV5WT0C48QL+RBctIewMdcQC1dSs8sdHdoFQ
        f+NPw7TKyI1webz9bEoaMgw=
X-Google-Smtp-Source: AGHT+IF2a2BcuDMUvcqqW4DjSHl+OiEP9LhpdbWw0DDHKhuwwlmc2ueRJ6LI0qhlK5xn/914byNmjQ==
X-Received: by 2002:a19:ee16:0:b0:507:a5e7:724 with SMTP id g22-20020a19ee16000000b00507a5e70724mr10723334lfb.38.1698242960027;
        Wed, 25 Oct 2023 07:09:20 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24e88000000b00507977e9a38sm2555680lfr.35.2023.10.25.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:09:19 -0700 (PDT)
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
Subject: [PATCH 2/3] rcu: Add a trace event for synchronize_rcu_normal()
Date:   Wed, 25 Oct 2023 16:09:14 +0200
Message-Id: <20231025140915.590390-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025140915.590390-1-urezki@gmail.com>
References: <20231025140915.590390-1-urezki@gmail.com>
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
index 63e46a8f3e60..25c7618b4533 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3626,6 +3626,7 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 	if (READ_ONCE(rcu_normal_wake_from_gp)) {
 		init_rcu_head_on_stack(&rs.head);
 		init_completion(&rs.completion);
@@ -3646,6 +3647,7 @@ static void synchronize_rcu_normal(void)
 	} else {
 		wait_rcu_gp(call_rcu_hurry);
 	}
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
 }
 
 /**
-- 
2.30.2

