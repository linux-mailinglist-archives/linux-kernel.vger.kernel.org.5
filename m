Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6602777282
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjHJINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHJINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D27C10C4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so449279b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655221; x=1692260021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR96duwMScqqE4Do/jU3bN4CcpYhg3nXfWXt6kcMass=;
        b=TXdsabfFDEPwwJuaGZzBTo8pU4vepokuZPrymTlMQv1CvvfMKgCU29jA0QwH6nWuD0
         gznXsPzuwLjEwlDK0vi+3+2uRxC1XMbW+lp+jWxIiLx3wBIpH31hYECAny9GNhrdQoBp
         fQwpX0cY+EOzJNEIbOPRRsH7MYAIzMIZor3623Qqkm1xdI1C87niDDFOIeGXXw9YKZKm
         brvKjzr+H6AxlWG+iqKS93izG5cWAN1ArPQzOhLyXud37OGWuLg4IpUu1Ebn7x3jQUuM
         TpKXPVzkIRw4vQlWHA/ApQtbsInEvHS24H7J3wHllzsOpLmActmt8abO0eoPurB7QaOk
         svQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655221; x=1692260021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR96duwMScqqE4Do/jU3bN4CcpYhg3nXfWXt6kcMass=;
        b=DnJqFM39jwmDlRjAeufFifXSFWMGqjzvd12nBGsZ6/ZcODi+K1+bnFREQ7UDJIaQqA
         3BKDHlwIhfIwPI2imrQ9zYAupaZxOkRjW6rxnwYvDIWdEkqZmSbJj6LbERVNuOaFD6nS
         l2aDKPHFzgEOAZgsb05SA9xG3z+h9HoS4E05Z1nVRQjg/p9vo/iKiHr9zuxAERSfFx07
         3TOks3uM5GwCvvRbS7cyEGI3Fj3zSvXHF/c9p6tFnZmmSVGO+2vkNMwoXt1X01QFH8g/
         uyFfjj2iVIuGi1vCGmqHZ4y0NMesMx3zCYMTuGN7uG2VFFi3WRSQBAKBonNdoCNeNiYB
         LWMg==
X-Gm-Message-State: AOJu0YxG7SjH3cyU+suPRC6Xq3lAbUihcRYdIYmeJ0JruZh9kdYlho1d
        jaDrbFZ4pOYtXCF/OHZfknGJjw==
X-Google-Smtp-Source: AGHT+IGLxHS6Efr09r8Fx5K71xSslYVl/sG2ni7ae6H65/+PX1fMA8cicT8FgwPTgOcMbX17lAwmtQ==
X-Received: by 2002:a05:6a20:1387:b0:13d:af0e:4ee5 with SMTP id hn7-20020a056a20138700b0013daf0e4ee5mr1482972pzc.18.1691655220823;
        Thu, 10 Aug 2023 01:13:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:40 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC PATCH v2 3/5] mm: Add a tracepoint when OOM victim selection is failed
Date:   Thu, 10 Aug 2023 16:13:17 +0800
Message-Id: <20230810081319.65668-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a tracepoint to mark the scenario where nothing was
chosen for OOM killer. This would allow BPF programs to catch the fact
that the BPF OOM policy didn't work well.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/trace/events/oom.h | 18 ++++++++++++++++++
 mm/oom_kill.c              |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b6ae1134229c 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -6,6 +6,7 @@
 #define _TRACE_OOM_H
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
+#include <linux/oom.h>
 
 TRACE_EVENT(oom_score_adj_update,
 
@@ -151,6 +152,23 @@ TRACE_EVENT(skip_task_reaping,
 	TP_printk("pid=%d", __entry->pid)
 );
 
+TRACE_EVENT(select_bad_process_end,
+
+	TP_PROTO(struct oom_control *oc),
+
+	TP_ARGS(oc),
+
+	TP_STRUCT__entry(
+		__array(char, policy_name, POLICY_NAME_LEN)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->policy_name, oc->policy_name, POLICY_NAME_LEN);
+	),
+
+	TP_printk("policy_name=%s", __entry->policy_name)
+);
+
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(compact_retry,
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3239dcdba4d7..af40a1b750fa 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1235,6 +1235,7 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+		trace_select_bad_process_end(oc);
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
-- 
2.20.1

