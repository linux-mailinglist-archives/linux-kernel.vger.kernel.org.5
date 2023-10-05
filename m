Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A57B99CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbjJEBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244371AbjJEBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0D9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8139C43397;
        Thu,  5 Oct 2023 01:52:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYl-005FKc-1x;
        Wed, 04 Oct 2023 21:53:51 -0400
Message-ID: <20231005015351.417870465@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 5/7] tracing/user_events: Document persist event flags
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

From: Beau Belgrave <beaub@linux.microsoft.com>

Users need to know how to make events persist now that we allow for
that. We also now allow the dynamic_events file to create events by
utilizing the persist flag during event register.

Add back in to documentation how /sys/kernel/tracing/dynamic_events can
be used to create persistent user_events. Add a section under registering
for the currently supported flags (USER_EVENT_REG_PERSIST) and the
required permissions. Add a note under deleting that deleting a
persistent event also requires sufficient permission.

Link: https://lkml.kernel.org/r/20230912180704.1284-4-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/user_events.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index f9530d0ac5d3..d8f12442aaa6 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -14,6 +14,11 @@ Programs can view status of the events via
 /sys/kernel/tracing/user_events_status and can both register and write
 data out via /sys/kernel/tracing/user_events_data.
 
+Programs can also use /sys/kernel/tracing/dynamic_events to register and
+delete user based events via the u: prefix. The format of the command to
+dynamic_events is the same as the ioctl with the u: prefix applied. This
+requires CAP_PERFMON due to the event persisting, otherwise -EPERM is returned.
+
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
 process tells the kernel which address and bit to reflect if any tool has
@@ -45,7 +50,7 @@ This command takes a packed struct user_reg as an argument::
         /* Input: Enable size in bytes at address */
         __u8 enable_size;
 
-        /* Input: Flags for future use, set to 0 */
+        /* Input: Flags to use, if any */
         __u16 flags;
 
         /* Input: Address to update when enabled */
@@ -69,7 +74,7 @@ The struct user_reg requires all the above inputs to be set appropriately.
   This must be 4 (32-bit) or 8 (64-bit). 64-bit values are only allowed to be
   used on 64-bit kernels, however, 32-bit can be used on all kernels.
 
-+ flags: The flags to use, if any. For the initial version this must be 0.
++ flags: The flags to use, if any.
   Callers should first attempt to use flags and retry without flags to ensure
   support for lower versions of the kernel. If a flag is not supported -EINVAL
   is returned.
@@ -80,6 +85,13 @@ The struct user_reg requires all the above inputs to be set appropriately.
 + name_args: The name and arguments to describe the event, see command format
   for details.
 
+The following flags are currently supported.
+
++ USER_EVENT_REG_PERSIST: The event will not delete upon the last reference
+  closing. Callers may use this if an event should exist even after the
+  process closes or unregisters the event. Requires CAP_PERFMON otherwise
+  -EPERM is returned.
+
 Upon successful registration the following is set.
 
 + write_index: The index to use for this file descriptor that represents this
@@ -141,7 +153,10 @@ event (in both user and kernel space). User programs should use a separate file
 to request deletes than the one used for registration due to this.
 
 **NOTE:** By default events will auto-delete when there are no references left
-to the event. Flags in the future may change this logic.
+to the event. If programs do not want auto-delete, they must use the
+USER_EVENT_REG_PERSIST flag when registering the event. Once that flag is used
+the event exists until DIAG_IOCSDEL is invoked. Both register and delete of an
+event that persists requires CAP_PERFMON, otherwise -EPERM is returned.
 
 Unregistering
 -------------
-- 
2.40.1
