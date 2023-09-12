Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16C79D893
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbjILSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjILSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051510D8;
        Tue, 12 Sep 2023 11:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B27C433C7;
        Tue, 12 Sep 2023 18:22:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qg824-000JRV-16;
        Tue, 12 Sep 2023 14:22:40 -0400
Message-ID: <20230912182240.156094298@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Sep 2023 14:22:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Tero Kristo <tero.kristo@linux.intel.com>
Subject: [for-linus][PATCH 1/3] tracing/synthetic: Print out u64 values properly
References: <20230912182213.795801173@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <tero.kristo@linux.intel.com>

The synth traces incorrectly print pointer to the synthetic event values
instead of the actual value when using u64 type. Fix by addressing the
contents of the union properly.

Link: https://lore.kernel.org/linux-trace-kernel/20230911141704.3585965-1-tero.kristo@linux.intel.com

Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
Cc: stable@vger.kernel.org
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9897d0bfcab7..14cb275a0bab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
 		break;
 
 	default:
-		trace_seq_printf(s, print_fmt, name, val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
 		break;
 	}
 }
-- 
2.40.1
