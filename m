Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037207F6568
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbjKWRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455C98
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED50C433C9;
        Thu, 23 Nov 2023 17:30:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r6DX8-00000003651-2Q2u;
        Thu, 23 Nov 2023 12:30:34 -0500
Message-ID: <20231123172539.582640797@goodmis.org>
User-Agent: quilt/0.67
Date:   Thu, 23 Nov 2023 12:25:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] eventfs/tracing: More updates for 6.7
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventfs bug fixes and clean ups:

- Use GFP_NOFS for allocations done under eventfs_mutex.
  The eventfs_mutex can be taken on file system reclaim, make sure
  that allocations done under that mutex do not trigger file system
  reclaim.

- Clean up code by moving the taking of inode_lock out of the helper
  functions and into where they are needed, and not use the
  parameter to know to take it or not. It must always be held but
  some callers of the helper function have it taken when they were
  called.

- Warn if the inode_lock is not held in the helper functions.

- Warn if eventfs_start_creating() is called without a parent.
  As eventfs is underneath tracefs, all files created will have
  a parent (the top one will have a tracefs parent).

Tracing update;

- Add Mathieu Desnoyers as an official reviewer of the tracing sub system.

Mathieu Desnoyers (1):
      MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer

Steven Rostedt (Google) (4):
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/dirs

----
 MAINTAINERS              |  1 +
 fs/tracefs/event_inode.c | 24 ++++++++----------------
 fs/tracefs/inode.c       | 13 ++++---------
 3 files changed, 13 insertions(+), 25 deletions(-)
