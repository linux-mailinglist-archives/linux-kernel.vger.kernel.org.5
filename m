Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB3796F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbjIGCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjIGCrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:47:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8B1997;
        Wed,  6 Sep 2023 19:47:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DFFC433C9;
        Thu,  7 Sep 2023 02:47:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qe53r-000BHF-0h;
        Wed, 06 Sep 2023 22:48:03 -0400
Message-ID: <20230907024710.866917011@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Sep 2023 22:47:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 0/6] tracing: Fix removing instances while reading/writing to their files
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It appears that the dynamic code of eventfs has caused a race window
to open up a bit more and showed that several files were not protected
by the trace array ref count. This means that a task could open one
of the files in an instance, remove the instance, and still be able to
read or write to that file. That access will then cause a "use-after-free"
bug.

Close those holes!

Also, fix a left over unused variable in the eventfs dput fix.

Steven Rostedt (Google) (6):
      tracefs/eventfs: Use dput to free the toplevel events directory
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count

----
 fs/tracefs/event_inode.c           | 17 +++++++---
 fs/tracefs/inode.c                 |  2 +-
 fs/tracefs/internal.h              |  5 +--
 kernel/trace/trace.c               | 68 ++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h               |  2 ++
 kernel/trace/trace_events.c        |  6 ++--
 kernel/trace/trace_events_inject.c |  3 +-
 7 files changed, 85 insertions(+), 18 deletions(-)
