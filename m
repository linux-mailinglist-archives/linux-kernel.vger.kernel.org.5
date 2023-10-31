Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25C7DD85B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbjJaWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbjJaWeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:34:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F925F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:34:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C75C433C8;
        Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxxJT-00EPgI-2v;
        Tue, 31 Oct 2023 18:34:19 -0400
Message-ID: <20231031223326.794680978@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 18:33:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 0/7] eventfs: Fixing dynamic creation
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found an issue with using a union between the rcu list head and
the "is_freed" boolean (word). That is, rcu list is a single link
list where the last element has a NULL pointer. That means, if
the eventfs_inode is the last element (which it likely will be)
it will not have its flag set to is_free.

Instead use a bit from nr_entries to be the is_freed flag.

Changes since v4: https://lore.kernel.org/linux-trace-kernel/20231031193109.018322397@goodmis.org/

- Updated on top of the change to separate out is_freed from the union

- Add another fix to only delete the eventfs_inode after the last
  dentry has cleared its reference (there's more races there without
  doing that)

- Make the top level eventfs directory the same as the rest in
  being removed.

Steven Rostedt (Google) (7):
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory

----
 fs/tracefs/event_inode.c | 431 +++++++++++++++++++++++++++++++----------------
 fs/tracefs/internal.h    |  27 ++-
 include/linux/tracefs.h  |  43 +++++
 3 files changed, 353 insertions(+), 148 deletions(-)
