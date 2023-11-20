Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8295A7F21A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjKTXvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjKTXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:51:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35032BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:51:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA214C433C7;
        Mon, 20 Nov 2023 23:51:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5E3W-00000002PmX-11ek;
        Mon, 20 Nov 2023 18:51:54 -0500
Message-ID: <20231120235105.834774147@goodmis.org>
User-Agent: quilt/0.67
Date:   Mon, 20 Nov 2023 18:51:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] eventfs: Fixes for v6.7-rc2
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resend to trigger my patchwork updates, and Cc linux-trace-kernel ]

A couple of fixes to eventfs:

- With the usage of simple_recursive_remove() recommended by Al Viro,
  the code should not be calling "d_invalidate()" itself. Doing so
  is causing crashes. The code was calling d_invalidate() on the race
  of trying to look up a file while the parent was being deleted.
  This was detected, and the added dentry was having d_invalidate() called
  on it, but the deletion of the directory was also calling d_invalidate()
  on that same dentry.

- A fix to not free the eventfs_inode (ei) until the last dput() was called
  on its ei->dentry made the ei->dentry exist even after it was marked
  for free by setting the ei->is_freed. But code elsewhere still was
  checking if ei->dentry was NULL if ei->is_freed is set and would
  trigger WARN_ON if that was the case. That's no longer true and there
  should not be any warnings when it is true.

Steven Rostedt (Google) (2):
      eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL
      eventfs: Do not invalidate dentry in create_file/dir_dentry()

----
 fs/tracefs/event_inode.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)
