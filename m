Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8563A7907AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352107AbjIBLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352073AbjIBLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194E10D2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C00FB8277B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15288C433BA;
        Sat,  2 Sep 2023 11:51:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9s-000K05-0F;
        Sat, 02 Sep 2023 07:51:20 -0400
Message-ID: <20230902115119.889766881@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [for-linus][PATCH 09/11] tracing/filters: Fix double-free of struct filter_pred.mask
References: <20230902115035.786076237@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <vschneid@redhat.com>

When a cpulist filter is found to contain a single CPU, that CPU is saved
as a scalar and the backing cpumask storage is freed.

Also NULL the mask to avoid a double-free once we get down to
free_predicate().

Link: https://lkml.kernel.org/r/20230901151039.125186-3-vschneid@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c06e1d596f4b..eb331e8b00b6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1773,6 +1773,7 @@ static int parse_pred(const char *str, void *data,
 		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
+			pred->mask = NULL;
 		}
 
 		if (field->filter_type == FILTER_CPUMASK) {
-- 
2.40.1
