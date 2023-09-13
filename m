Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAD79DE68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjIMDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIMDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:00:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F321719;
        Tue, 12 Sep 2023 20:00:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6331C433C9;
        Wed, 13 Sep 2023 03:00:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qgG74-000QQc-0U;
        Tue, 12 Sep 2023 23:00:22 -0400
Message-ID: <20230913030021.967983629@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Sep 2023 22:58:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH 3/3] tracing/selftests: Update kprobe args char/string to match new
 functions
References: <20230913025855.615399273@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function that the kprobe_args_char and kprobes_arg_string attaches to
for its test has changed its name once again. Now we need to check for
eventfs_create_dir(), and if it exists, use that, otherwise check for
eventfs_add_dir() and if that exists use that, otherwise use the original
tracefs_create_dir()!

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
