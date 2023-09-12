Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5A79D859
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjILSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbjILSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:07:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7845A10E6;
        Tue, 12 Sep 2023 11:07:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 05BA7212BC1C;
        Tue, 12 Sep 2023 11:07:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05BA7212BC1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694542031;
        bh=/6uRDgkxFJTctUG2IpL7tJpAeMqES8n2c5VEJ7ldNDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+eP9QnLYCdAXodvzBc1cs54l8NN3J7LU0gHN9Y3I4hrVY0+mRjbiKAIMq640BolF
         erX4q9x6QMNs+3lVpiMio4g3zobypEMiAX8jawSkWt0Vgm0Ys2axosoqzGapXlkrP6
         zbHUIookLyN2lp9SMz/5wfcUOUKXIGlF5pAlIX5M=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v2 3/3] tracing/user_events: Document persist event flags
Date:   Tue, 12 Sep 2023 18:07:04 +0000
Message-Id: <20230912180704.1284-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912180704.1284-1-beaub@linux.microsoft.com>
References: <20230912180704.1284-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users need to know how to make events persist now that we allow for
that. We also now allow the dynamic_events file to create events by
utilizing the persist flag during event register.

Add back in to documentation how /sys/kernel/tracing/dynamic_events can
be used to create persistent user_events. Add a section under registering
for the currently supported flags (USER_EVENT_REG_PERSIST) and the
required permissions. Add a note under deleting that deleting a
persistent event also requires sufficient permission.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index e7b07313550a..576d2c35f22e 100644
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
2.34.1

