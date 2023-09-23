Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB37AC5B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 00:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjIWWdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:33:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7B1180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 15:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F225C433C7;
        Sat, 23 Sep 2023 22:33:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qkBCA-003ttc-2K;
        Sat, 23 Sep 2023 18:33:50 -0400
Message-ID: <20230923223331.720351929@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 23 Sep 2023 18:33:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Fixes for 6-6-rc2
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 6.6-rc2:

- Fix the "bytes" output of the per_cpu stat file
  The tracefs/per_cpu/cpu*/stats "bytes" was giving bogus values as the
  accounting was not accurate. It is suppose to show how many used bytes are
  still in the ring buffer, but even when the ring buffer was empty it would
  still show there were bytes used.

- Fix a bug in eventfs where reading a dynamic event directory (open) and then
  creating a dynamic event that goes into that diretory screws up the accounting.
  On close, the newly created event dentry will get a "dput" without ever having
  a "dget" done for it. The fix is to allocate an array on dir open to save what
  dentries were actually "dget" on, and what ones to "dput" on close.

Please pull the latest trace/urgent tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: ef36b4f92868d66908e235980f74afdfb9742d12


Steven Rostedt (Google) (1):
      eventfs: Remember what dentries were created on dir open

Zheng Yejian (1):
      ring-buffer: Fix bytes info in per_cpu buffer stats

----
 fs/tracefs/event_inode.c   | 87 +++++++++++++++++++++++++++++++++++++---------
 kernel/trace/ring_buffer.c | 28 ++++++++-------
 2 files changed, 85 insertions(+), 30 deletions(-)
