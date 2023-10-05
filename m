Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661107B99CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbjJEBwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbjJEBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D4DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB73C433CA;
        Thu,  5 Oct 2023 01:52:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYm-005FLk-07;
        Wed, 04 Oct 2023 21:53:52 -0400
Message-ID: <20231005015351.846757196@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [for-next][PATCH 7/7] tracing/selftests: Update kprobe args char/string to match new
 functions
References: <20231005015310.859143353@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function that the kprobe_args_char and kprobes_arg_string attaches to
for its test has changed its name once again. Now we need to check for
eventfs_create_dir(), and if it exists, use that, otherwise check for
eventfs_add_dir() and if that exists use that, otherwise use the original
tracefs_create_dir()!

Link: https://lore.kernel.org/linux-trace-kernel/20230914163535.487267410@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 +++-
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index ff7499eb98d6..c639c6c8ca03 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -34,7 +34,9 @@ mips*)
 esac
 
 : "Test get argument (1)"
-if grep -q eventfs_add_dir available_filter_functions; then
+if grep -q eventfs_create_dir available_filter_functions; then
+  DIR_NAME="eventfs_create_dir"
+elif grep -q eventfs_add_dir available_filter_functions; then
   DIR_NAME="eventfs_add_dir"
 else
   DIR_NAME="tracefs_create_dir"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a202b2ea4baf..a5ab4d5c74ac 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -37,7 +37,9 @@ loongarch*)
 esac
 
 : "Test get argument (1)"
-if grep -q eventfs_add_dir available_filter_functions; then
+if grep -q eventfs_create_dir available_filter_functions; then
+  DIR_NAME="eventfs_create_dir"
+elif grep -q eventfs_add_dir available_filter_functions; then
   DIR_NAME="eventfs_add_dir"
 else
   DIR_NAME="tracefs_create_dir"
-- 
2.40.1
