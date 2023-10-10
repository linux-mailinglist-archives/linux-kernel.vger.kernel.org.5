Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB687BFA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjJJL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjJJL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FFDA4;
        Tue, 10 Oct 2023 04:59:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06633C433C7;
        Tue, 10 Oct 2023 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939174;
        bh=sYHoqOrEbMAZaMKLim6NthKBNfLinTYcsgpfSBhdkxM=;
        h=From:To:Cc:Subject:Date:From;
        b=jgR/fImUTS/Qe+BQe0gYv9Lw0tdrGJlGdSzjQ/wgglQTvzOFc93kL8P3N6OtwQTaK
         0yaKbHJ2SZBF/3rQLkx4DA2DRBimzK7ie37+FpkoVTrMRwLO9e/atoZhO/VQEY9bJ+
         cxcJg3vZvBaWVStX86GF2MYeudtN3dDAc0HXbappYmIvw1ubhq7SR9p2pq0sSWaPx8
         e2YUP00HPzTRoenkh4fHsUqZx5v4eFpVsa6PgBy55JVlq8KBeCsSErmSZ2qvbFYQDg
         q9Rgav7OxDRCK9ryVrbIio0OYmVO/S3FPtsw4UJWvDrfUC17W6pyGdD9NLVKL0DsJO
         yodlUic09q0IQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 00/23] RCU/lock torture updates for v6.7
Date:   Tue, 10 Oct 2023 13:58:58 +0200
Message-Id: <20231010115921.988766-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find below the updates for RCU torture, locktorture and the
generic torture infrastructure.

Arnd Bergmann (1):
  rcu: Include torture_sched_setaffinity() declaration

Dan Carpenter (1):
  locktorture: Check the correct variable for allocation failure

Joel Fernandes (Google) (3):
  rcutorture: Fix stuttering races and other issues
  rcutorture: Copy out ftrace into its own console file
  rcutorture: Replace schedule_timeout*() 1-jiffy waits with HZ/20

Paul E. McKenney (17):
  torture: Share torture_random_state with torture_shuffle_tasks()
  torture: Make kvm-recheck.sh use mktemp
  torture: Make torture_hrtimeout_ns() take an hrtimer mode parameter
  torture: Move rcutorture_sched_setaffinity() out of rcutorture
  locktorture: Add readers_bind and writers_bind module parameters
  rcutorture: Add CONFIG_DEBUG_OBJECTS to RCU Tasks testing
  locktorture: Alphabetize torture_param() entries
  locktorture: Consolidate "if" statements in lock_torture_writer()
  locktorture: Add acq_writer_lim to complain about long acquistion
    times
  torture: Print out torture module parameters
  torture: Make torture.sh refscale testing qualify verbose_batched
  locktorture: Add new module parameters to
    lock_torture_print_module_parms()
  locktorture: Add call_rcu_chains module parameter
  doc: Catch-up update for locktorture module parameters
  locktorture: Rename readers_bind/writers_bind to
    bind_readers/bind_writers
  torture: Add kvm.sh --debug-info argument
  torture: Convert parse-console.sh to mktemp

Zqiang (1):
  rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()

Thanks,
        Frederic.

 .../admin-guide/kernel-parameters.txt         |  57 ++++-
 include/linux/torture.h                       |   8 +-
 kernel/locking/locktorture.c                  | 216 +++++++++++++-----
 kernel/rcu/rcu.h                              |   4 -
 kernel/rcu/rcutorture.c                       |  16 +-
 kernel/rcu/update.c                           |   9 +-
 kernel/torture.c                              |  75 +++---
 .../selftests/rcutorture/bin/functions.sh     |  29 +++
 .../selftests/rcutorture/bin/kvm-recheck.sh   |   2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh |  17 +-
 .../selftests/rcutorture/bin/parse-console.sh |   9 +-
 .../selftests/rcutorture/bin/torture.sh       |   2 +-
 .../selftests/rcutorture/configs/rcu/TRACE02  |   1 +
 13 files changed, 322 insertions(+), 123 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

-- 
2.34.1

