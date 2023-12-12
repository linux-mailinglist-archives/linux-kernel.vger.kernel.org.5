Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF780E04E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbjLLAcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLAbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:52 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000FDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:55 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso23274655ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341115; x=1702945915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ozM4BpN3Xt6MsBMcAeU5+sN7FM9jw+H7uMlVGcPsYU=;
        b=M6fROFzYXqiUvfysdgYd9JyunX57Gbfjd9muWKBsFPOw9QisqV9jZQgPygmbevtprR
         3MSiK6BlgahonWwHTRCE0VFkz/4IGNWF51swsD8HtuMMIriFL2+VlnpmBPqoBanxFv8U
         iaRlVG6kI9fwKfZYy6vHWbP/VDcBIgu8TUNWjigyE172tLdjLlr/1um2TxIKKOI5VlqH
         Z1kDoChgh8q/RjH+uqRDfc7ro0IOLTosAEDzxH0s7LCl9QoTkRsGYKZ5u20rcZMkDYLQ
         qSqxPv7Fgj0HpI1feVlod7Iu+UjTglgFWkTKjKzsyx3VB6R9EQkKehpQcp1Fq/NyqRnD
         oDiw==
X-Gm-Message-State: AOJu0YwvYjG5KSZJYiKX2aRPNI22ltV8XhcRIGyvrvkQxStgx+Fc+aaz
        XkW5JZxzZNpShrZ5Shvh33XBV2IErqVABBaP
X-Google-Smtp-Source: AGHT+IGY6C9FW7edbpxzeexxFByWSS3gYTIQtq7pOV92sM4gqltpbhoxDAXZ3g8d271lmJEzVXZGVg==
X-Received: by 2002:a05:6e02:1a4d:b0:35d:a4a9:7bb7 with SMTP id u13-20020a056e021a4d00b0035da4a97bb7mr8463770ilv.63.1702341114970;
        Mon, 11 Dec 2023 16:31:54 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id u4-20020a056e021a4400b0035d714a68fbsm2619217ilv.78.2023.12.11.16.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:54 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 4/8] sched: Check cpu_active() earlier in newidle_balance()
Date:   Mon, 11 Dec 2023 18:31:37 -0600
Message-ID: <20231212003141.216236-5-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newidle_balance(), we check if the current CPU is inactive, and then
decline to pull any remote tasks to the core if so. Before this check,
however, we're currently updating rq->idle_stamp. If a core is offline,
setting its idle stamp is not useful. The core won't be chosen by any
task in select_task_rq_fair(), and setting the rq->idle_stamp is
misleading anyways given that the core being inactive should imply that
it should be idle for a very long time.

Let's set rq->idle_stamp in newidle_balance() only if the cpu is active.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e1b676bb1fed..49f047df5d9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12284,18 +12284,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->ttwu_pending)
 		return 0;
 
-	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
-	 */
-	this_rq->idle_stamp = rq_clock(this_rq);
-
 	/*
 	 * Do not pull tasks towards !active CPUs...
 	 */
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	this_rq->idle_stamp = rq_clock(this_rq);
+
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-- 
2.42.1

