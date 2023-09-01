Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B075078FFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbjIAPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350116AbjIAPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8BC10E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8YZj7U283/XjuckA+i8EXyp3nE30BsVfSwsfevewvQ=;
        b=C12UG4TW22NoRFflQNWNAAAqed8lx5cxbhXKoCN0LppatpN5aqqkZXO3/lHh37N7d6eaHo
        VziHy6kSGS0uw/yfGbjFN05ddcbk05+gLOB3cdChJAMm1cJjFP7xZ56M6M3C4a+1T9TzAm
        du4gnjYZEKPjXZmMwEl0wD/zCxcGlb4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-3uY_UUUjNK2Mc0YnL1wBTQ-1; Fri, 01 Sep 2023 11:11:04 -0400
X-MC-Unique: 3uY_UUUjNK2Mc0YnL1wBTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B8B23C025BD;
        Fri,  1 Sep 2023 15:11:04 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66C442012F37;
        Fri,  1 Sep 2023 15:11:03 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/4] tracing/filters: Change parse_pred() cpulist ternary into an if block
Date:   Fri,  1 Sep 2023 17:10:38 +0200
Message-Id: <20230901151039.125186-4-vschneid@redhat.com>
In-Reply-To: <20230901151039.125186-1-vschneid@redhat.com>
References: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Review comments noted that an if block would be clearer than a ternary, so
swap it out.

No change in behaviour intended

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index eb331e8b00b61..09b4733a2933d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1782,13 +1782,17 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			if (single) {
-				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				if (pred->op == OP_BAND)
+					pred->op = OP_EQ;
+
 				pred->fn_num = FILTER_PRED_FN_CPU;
 			} else {
 				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 			}
 		} else if (single) {
-			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+			if (pred->op == OP_BAND)
+				pred->op = OP_EQ;
+
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
 			if (pred->op == OP_NE)
 				pred->not = 1;
-- 
2.31.1

