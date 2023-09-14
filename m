Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87057A0AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbjINQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjINQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:35:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFE1FD7;
        Thu, 14 Sep 2023 09:35:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2578C433C7;
        Thu, 14 Sep 2023 16:35:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qgpJX-000tV7-0l;
        Thu, 14 Sep 2023 12:35:35 -0400
Message-ID: <20230914163504.884804272@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Sep 2023 12:35:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH 0/2 v3] tracing: Remove eventfs_files by use of callbacks
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a bit of a redesign of the way the eventfs is created. It no longer
creates a descriptor representing every file but instead just the directories.
These descriptors get an array of entries that represent the files within it
(but not for sub directories).  Each entry has a name and a callback, where the
name is the name of the file (used for lookup) and a callback that is used to
create the dentry and inode for the file. This saves more memory, this approach
may be possible to create a dynamic way of doing this for other pseudo file
systems.

The second patch fixes the kprobe selftests yet again, and the function
that it uses to attach to was renamed once again.

Changes since v2: https://lore.kernel.org/all/20230913025855.615399273@goodmis.org/

 - Removed the show_eventfs_dentries patch and queued that for mainline.

 - Rebased on top of the queued mainline tree, as the show_eventfs_dentries
   patch was modified.

 - Updated the numbers in the change log to reflect the latest code.
   (Things actually got better!)


Changes since v1: https://lore.kernel.org/all/20230801001349.520930329@goodmis.org/

 - Rebased on mainline and some minor clean ups.
 - Fixed kprobe selftest

Steven Rostedt (Google) (2):
      eventfs: Remove eventfs_file and just use eventfs_inode
      tracing/selftests: Update kprobe args char/string to match new functions

----
 fs/tracefs/event_inode.c                           | 763 +++++++++++----------
 fs/tracefs/event_show.c                            |  51 +-
 fs/tracefs/inode.c                                 |   2 +-
 fs/tracefs/internal.h                              |  54 +-
 include/linux/trace_events.h                       |   2 +-
 include/linux/tracefs.h                            |  29 +-
 kernel/trace/trace.c                               |   7 +-
 kernel/trace/trace.h                               |   4 +-
 kernel/trace/trace_events.c                        | 315 ++++++---
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   4 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   4 +-
 11 files changed, 691 insertions(+), 544 deletions(-)
