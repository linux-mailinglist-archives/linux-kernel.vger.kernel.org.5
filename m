Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12447BCB74
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjJHBRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjJHBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109091AE;
        Sat,  7 Oct 2023 17:51:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB2DC07615;
        Sun,  8 Oct 2023 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726252;
        bh=2qwbD9T+rQJfqazFd+vrEHjBtOQ9LSdzi8cMzAH/Rzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKd8kvEEzwlQIJn604gGaSc+NKUimPp5npvzoO7x3vTm0MSdZnNVOCsJecO9n44fe
         e/2wGip3XyDK0VAAoOPiZ/hS0+utPDqHsET3j+1lqQ66s9BYq1ewwcUzRGxqJyEL0p
         +fKsCh7jfwMLffYPpeEL7f9dMxm+W35Alimgp/gDurFODo0+jqJIg+DLkaGvYr/fio
         31YDJEICPuWTBvsF/To23bPYseQLPXrgYFPt6e/EZ0x4Zjh41zjUP4L5zPbkkGQJAG
         0u3mrny97ifzAFYeUJ9ntxxnm3WRfrK+oCeLOD+DBVwgitscWvRqGHgrpu4riNPpKh
         /pE3/sYOVpTxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 8/8] tracing: relax trace_event_eval_update() execution with cond_resched()
Date:   Sat,  7 Oct 2023 20:50:38 -0400
Message-Id: <20231008005039.3768522-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005039.3768522-1-sashal@kernel.org>
References: <20231008005039.3768522-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 23cce5f25491968b23fb9c399bbfb25f13870cd9 ]

When kernel is compiled without preemption, the eval_map_work_func()
(which calls trace_event_eval_update()) will not be preempted up to its
complete execution. This can actually cause a problem since if another
CPU call stop_machine(), the call will have to wait for the
eval_map_work_func() function to finish executing in the workqueue
before being able to be scheduled. This problem was observe on a SMP
system at boot time, when the CPU calling the initcalls executed
clocksource_done_booting() which in the end calls stop_machine(). We
observed a 1 second delay because one CPU was executing
eval_map_work_func() and was not preempted by the stop_machine() task.

Adding a call to cond_resched() in trace_event_eval_update() allows
other tasks to be executed and thus continue working asynchronously
like before without blocking any pending task at boot time.

Link: https://lore.kernel.org/linux-trace-kernel/20230929191637.416931-1-cleger@rivosinc.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3dc6c126b3ee..ed39d3ec202e6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2242,6 +2242,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

