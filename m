Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AB7DD6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjJaTed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1EFC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:34:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529B8C433C7;
        Tue, 31 Oct 2023 19:34:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxuVQ-00EK7o-0L;
        Tue, 31 Oct 2023 15:34:28 -0400
Message-ID: <20231031193109.018322397@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 15:31:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/3] eventfs: Fixing dynamic creation
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is really just putting together two eventfs patches that were
stepping on each other in conflicts. I decided to rip out the free_ei()
part into its own patch (as that was what was confliciting.

This series is just a combination of:

  https://lore.kernel.org/linux-trace-kernel/20231031111325.50087cd8@gandalf.local.home/

and

 https://lore.kernel.org/linux-trace-kernel/20231031113627.2edfa83f@gandalf.local.home/

With the stripped out free_ei() patch.

Steven Rostedt (Google) (3):
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode

----
 fs/tracefs/event_inode.c | 217 +++++++++++++++++++++++++++++++++++++++++------
 fs/tracefs/internal.h    |  19 ++++-
 2 files changed, 208 insertions(+), 28 deletions(-)
