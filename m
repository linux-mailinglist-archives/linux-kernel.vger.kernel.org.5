Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50637F5505
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbjKVXva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjKVXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:28 -0500
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA091BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vHBOI/gb4bP4f3pn2dixxtLUAGn+Uu9iktX/uif8nNw=;
        b=jDpMb3vXniSRNiceRApcxGTittUE4JUykbUub21puPF98jZaSg+n+YSIaMLhDk7jIYei8u
        A3qjWKKOSLQPNh5jnrN/+F9bhMlo/+I5B/RB1NT9Tih+aGJ2MWz0CfIppuiG8wxU6bTzgz
        HgHJ+8gka7zN2f3luU3FAwM3hMXzUjw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/6] lockdep enhancements for bcachefs
Date:   Wed, 22 Nov 2023 18:51:07 -0500
Message-ID: <20231122235113.180132-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds:
 - lockdep_set_no_check_recursion(), which allows lockdep checking for
   bcachefs six locks

bcachefs has a cycle detector for deadlock avoidance; there is no lock
ordering for lockdep to check w.r.t. other btree node locks. However, we
do want held btree node locks to be tracked, and lock ordering to be
checked w.r.t. other locks.

 - lock_class_is_held(), which we use for some extra locking assertion

We want to assert e.g. that we're not blocking on IO with btree node
locks held.

Kent Overstreet (6):
  locking/lockdep: lock_class_is_held()
  locking/lockdep: lockdep_set_no_check_recursion()
  bcachefs: Assert that btree node locks aren't being leaked
  bcachefs: Use lock_class_is_held() for btree locking asserts
  bcachefs: Check for btree locks held on transaction init
  bcachefs: Switch to lockdep_set_no_check_recursion()

 fs/bcachefs/btree_gc.c        |  3 +++
 fs/bcachefs/btree_iter.c      |  2 ++
 fs/bcachefs/btree_locking.c   | 14 ++++++++---
 fs/bcachefs/btree_types.h     |  1 +
 include/linux/lockdep.h       | 10 ++++++++
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 46 +++++++++++++++++++++++++++++++++++
 7 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.42.0

