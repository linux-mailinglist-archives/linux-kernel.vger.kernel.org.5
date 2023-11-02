Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA07DF0EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbjKBLIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347250AbjKBLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:08:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DA2195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qFcwlZbJGI3mZ6tk1eSs1KhV+fJx4U/ktIGDPTZc0Pc=; b=aMNkQB5wNSpVwTgdqEsi4hDCuk
        kObwC24b8DXMqPp6CQxT1462hEJEydk0G+YD9Qndep6z6kThMM+ZiMc3JlTB36MKCLbSwdbi3anTv
        M0j0v5OmKYyReX25TH4gPEMnL86cotwhBWLiyZyuOsubaEqbnXqaifOwcw7IlgGRv72GCwxyO1/xY
        GZO4SIfialuDpzEruDlVswasCq1UvHeUHrIouHuUGYZSOuzP9ohJFBgTfsoJ5PVx92ddIrbUhC+YY
        11jewuIcNubyyH3Hxqog9LcVs8zk/Mh18xeq4benxeO6bpm4+x4aNrrzG/0xwsP5IkdPu86BuO249
        JlJIxWBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyVYZ-006WAP-2T;
        Thu, 02 Nov 2023 11:08:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 6BDB23004AB; Thu,  2 Nov 2023 12:08:11 +0100 (CET)
Message-Id: <20231102104429.025835330@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 11:44:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 0/2] cleanup: Conditional locking support
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two patches, the first extending the cleanup/guard stuff to better handle
conditional locks, mutex_trylock(), mutex_lock_interruptible() etc.. And the
second a small ptrace conversion that I've been using as a test-case.

The normal scoped_guard() is changed to simply skip the body when a conditional
lock fails to acquire. A new scoped_cond_guard() is added that takes an extra
statement argument to provide an explicit 'fail' action.

The ptrace patch has:

  scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
		     &task->signal->cred_guard_mutex) {
    ...
  }
  ...
  return 0;

Where if the lock acquire fails, it does 'return -ERESTARTNOINTR'.

The crazy perf thing then becomes:

  scoped_cond_guard (rwsem_read_intr, goto no_lock,
                     task ? &task->signal->exec_update_lock : NULL) {
    if (0) {
no_lock:
      if (task)
        return -EINTR;
    }
    ... body with or without lock ...
  }


Specifically, that thing needs the lock when there is a task, but otherwise
needs to still do the body without the lock.

IIO also wanted something along these lines, although they have a custom
'trylock' thing.

Barring objections, I'm planning to merge this into tip/locking/cleanup which
I'll merge into tip/locking/core (and tip/perf/core when times comes).

My plan is to post the perf patches in 3 batches of roughly 10 patches each,
the simpler first and the more crazy ones (including the above) last.

