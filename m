Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9880F498
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbjLLR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376771AbjLLR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:27:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351779F;
        Tue, 12 Dec 2023 09:27:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0c94397c0so34705025ad.2;
        Tue, 12 Dec 2023 09:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402056; x=1703006856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy94NtGvJMR2W5ZqUeOhkG8IQpCje9YrX1YzEkIZAAM=;
        b=Y0KyrIu26IiCXkXXXMv8JuE9bV146lAYbphRQWJPzj+Pukgp5a1w22HlOTpjWF4J4Z
         JA6HtNihTmyG1emfB6BkNiNN36MNnX1C0VY+I9l/rU5Ev1ZZ2cw+kQ418Bj4US5TcNRD
         Bvg2LPZ6SyIePc3qBI3lKN7X1zYZSumcP4zGexJUDM8fFPj0bs/3+VQ25dMAGOeq/ATG
         0RqadBiUjFGLTX4ZkGGMFf9Y40JYaae/bgMoltkVKDd8xRW5H6jRhh0QG7dhMfJofZu/
         i1C1f3r+Hi7dhHw4cOMLZENFMTzhthMKmyg0GgjN7SQfHpQO4n96Zlph2ZMRCH6AaCMb
         /JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402056; x=1703006856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy94NtGvJMR2W5ZqUeOhkG8IQpCje9YrX1YzEkIZAAM=;
        b=S2q0LiQj3J5g+Xdl9OYR0lsn9IOhMBbXAdsJNng+NDrMX/jcxemxQzr6oNx/7A+dVY
         iod0ozAJG6xh3ZD4N/0NiJ1OwLfoiwKXsBdQzsGYxwJ73C4P4aOLcQ3v7DQNsBWiGGh/
         2C8s14DS73Gbh92fjNy32gVnPt/H0MOIqnERKzuNPbpP0Fr/tLVxRtsjjjDfMYHDdvJg
         088V1M0tzMsX3FhzMPi9NUSVmoHBCZhsu90uRdiTGFgyDBCkc+JDu+Ov7awb29J3Tj1w
         /w1vuQvwDx5isy4xI+Dr/GkUrEQFc8fi/EVKJHjzpMDZ4dmcojRlc8PREx5uqcg2/0HB
         kWTA==
X-Gm-Message-State: AOJu0YygTsKzYc/P+r+2HvLayJGyEmY3JjKnuwdnMlXgDa0v01bpopNd
        i/sIpypGZmoaO2vTuK+Ypw6o3dbOyAtHgTuN
X-Google-Smtp-Source: AGHT+IGALwTtO0ngxAfBMYyJcAkEuG1b3rOwoiD6koZuZtCc8fHOHJYlSLgdrvsE41zp1hguGM8P8w==
X-Received: by 2002:a17:902:e789:b0:1d0:b8dc:ec90 with SMTP id cp9-20020a170902e78900b001d0b8dcec90mr3964074plb.64.1702402055592;
        Tue, 12 Dec 2023 09:27:35 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm8863170plg.145.2023.12.12.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:27:35 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 3/5] doc: Clarify RCU Tasks reader/updater checklist
Date:   Tue, 12 Dec 2023 22:56:51 +0530
Message-Id: <20231212172653.11485-3-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212172343.GA11383@neeraj.linux>
References: <20231212172343.GA11383@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the reader/updater compatibility rules for the three RCU
Tasks flavors are squished together in a single paragraph, which can
result in confusion.  This commit therefore splits them out into a list,
clearly showing the distinction between these flavors.

Link: https://lore.kernel.org/all/20231002211936.5948253e@gandalf.local.home/

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 Documentation/RCU/checklist.rst | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index bd3c58c44bef..c432899aff22 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -241,15 +241,22 @@ over a rather long period of time, but improvements are always welcome!
 	srcu_struct.  The rules for the expedited RCU grace-period-wait
 	primitives are the same as for their non-expedited counterparts.
 
-	If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
-	then the readers must refrain from executing voluntary
-	context switches, that is, from blocking.  If the updater uses
-	call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
-	the corresponding readers must use rcu_read_lock_trace() and
-	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
-	or synchronize_rcu_tasks_rude(), then the corresponding readers
-	must use anything that disables preemption, for example,
-	preempt_disable() and preempt_enable().
+	Similarly, it is necssary to correctly use the RCU Tasks flavors:
+
+	a.	If the updater uses synchronize_rcu_tasks() or
+		call_rcu_tasks(), then the readers must refrain from
+		executing voluntary context switches, that is, from
+		blocking.
+
+	b.	If the updater uses call_rcu_tasks_trace()
+		or synchronize_rcu_tasks_trace(), then the
+		corresponding readers must use rcu_read_lock_trace()
+		and rcu_read_unlock_trace().
+
+	c.	If an updater uses call_rcu_tasks_rude() or
+		synchronize_rcu_tasks_rude(), then the corresponding
+		readers must use anything that disables preemption,
+		for example, preempt_disable() and preempt_enable().
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,
-- 
2.40.1

