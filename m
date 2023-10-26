Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97067D7A29
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJZB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjJZB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDCCC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E5C433C9;
        Thu, 26 Oct 2023 01:27:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qvpA9-00CqSz-1x;
        Wed, 25 Oct 2023 21:27:53 -0400
Message-ID: <20231026012753.418244796@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Oct 2023 21:27:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mukesh ojha <quic_mojha@quicinc.com>
Subject: [for-next][PATCH 1/4] tracing/histograms: Simplify last_cmd_set()
References: <20231026012734.358814002@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Turn a kzalloc()+strcpy()+strncat() into an equivalent and less verbose
kasprintf().

Link: https://lore.kernel.org/linux-trace-kernel/30b6fb04dadc10a03cc1ad08f5d8a93ef623a167.1697899346.git.christophe.jaillet@wanadoo.fr

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Mukesh ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d06938ae0717..1abc07fba1b9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -774,23 +774,16 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 {
 	const char *system = NULL, *name = NULL;
 	struct trace_event_call *call;
-	int len;
 
 	if (!str)
 		return;
 
-	/* sizeof() contains the nul byte */
-	len = sizeof(HIST_PREFIX) + strlen(str);
 	kfree(last_cmd);
-	last_cmd = kzalloc(len, GFP_KERNEL);
+
+	last_cmd = kasprintf(GFP_KERNEL, HIST_PREFIX "%s", str);
 	if (!last_cmd)
 		return;
 
-	strcpy(last_cmd, HIST_PREFIX);
-	/* Again, sizeof() contains the nul byte */
-	len -= sizeof(HIST_PREFIX);
-	strncat(last_cmd, str, len);
-
 	if (file) {
 		call = file->event_call;
 		system = call->class->system;
-- 
2.42.0
