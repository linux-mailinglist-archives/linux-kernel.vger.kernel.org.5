Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8700F79D892
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjILSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjILSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15505115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF34C433C8;
        Tue, 12 Sep 2023 18:22:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qg824-000JQt-0P;
        Tue, 12 Sep 2023 14:22:40 -0400
Message-ID: <20230912182213.795801173@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Sep 2023 14:22:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Some more fixes before pushing to 6.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing updates for 6.6:

- Fix NULL pointer dereference with eventfs_remove_rec()
  If an allocation fails in one of the eventfs_add_*() functions,
  the caller of it in event_subsystem_dir() or event_create_dir()
  assigns the result to the structure. But it's assigning the ERR_PTR
  and not NULL. This was passed to eventfs_remove_rec() which expects
  either a good pointer or a NULL, not ERR_PTR. The fix is to not
  assign the ERR_PTR to the structure, but to keep it NULL on error.

- Fix list_for_each_rcu() to use list_for_each_srcu() in
  dcache_dir_open_wrapper(). One iteration of the code used RCU
  but because it had to call sleepable code, it had to be changed
  to use SRCU, but one of the iterations was missed.

- Fix synthetic event print function to use "as_u64" instead of
  passing in a pointer to the union. To fix big/little endian issues,
  the u64 that represented several types was turned into a union to
  define the types properly.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: c8414dab164a74bd3bb859a2d836cb537d6b9298


Jinjie Ruan (1):
      eventfs: Fix the NULL pointer dereference bug in eventfs_remove_rec()

Steven Rostedt (Google) (1):
      tracefs/eventfs: Use list_for_each_srcu() in dcache_dir_open_wrapper()

Tero Kristo (1):
      tracing/synthetic: Print out u64 values properly

----
 fs/tracefs/event_inode.c          |  3 ++-
 kernel/trace/trace_events.c       | 13 +++++++++----
 kernel/trace/trace_events_synth.c |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)
