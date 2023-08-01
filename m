Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37E76A558
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHAAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAAOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5E173E;
        Mon, 31 Jul 2023 17:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030156134A;
        Tue,  1 Aug 2023 00:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F48C433C8;
        Tue,  1 Aug 2023 00:14:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQd24-003g8f-2n;
        Mon, 31 Jul 2023 20:14:36 -0400
Message-ID: <20230801001349.520930329@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 20:13:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH 0/2] tracing: Remove eventfs_files by use of callbacks
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch set is on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/
  trace/core

The first patch adds a file to tracefs that shows all the event_files
that have been allocated for the dynamic eventfs file system. It also
shows the dentries that were created and their current ref counts. This
is useful for debugging and knowing when a dentry has been created and
freed.

I plan on adding the first patch to the next merge window. The second
patch I plan on adding to the merge window after that.

The second patch is a bit of a redesign of the way the eventfs is
created. It no longer creates a descriptor representing every file but
instead just the directories. These descriptors get an array of
entries that represent the files within it (but not for sub directories).
Each entry has a name and a callback, where the name is the name of the
file (used for lookup) and a callback that is used to create the dentry
and inode for the file. This saves more memory, this approach may
be possible to create a dynamic way of doing this for other pseudo file
systems.

Steven Rostedt (Google) (2):
      tracefs: Add show_events_dentries
      eventfs: Remove eventfs_file and just use eventfs_inode

----
 fs/tracefs/Makefile          |   1 +
 fs/tracefs/event_inode.c     | 781 ++++++++++++++++++++++---------------------
 fs/tracefs/event_show.c      | 125 +++++++
 fs/tracefs/inode.c           |   2 +-
 fs/tracefs/internal.h        |  34 +-
 include/linux/trace_events.h |   2 +-
 include/linux/tracefs.h      |  31 +-
 kernel/trace/trace.h         |   4 +-
 kernel/trace/trace_events.c  | 309 ++++++++++++-----
 9 files changed, 795 insertions(+), 494 deletions(-)
 create mode 100644 fs/tracefs/event_show.c
