Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C280C756B47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjGQSIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E6AF;
        Mon, 17 Jul 2023 11:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47B2611BF;
        Mon, 17 Jul 2023 18:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BE3C433C8;
        Mon, 17 Jul 2023 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617321;
        bh=j3LiqcbdyR4pUyr/8vAguOUbJf46aGe4ZoMPIdgaxWo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BgScox2CtKAHHP8gx5IkjM1adHNRwbtYKX9xLv9nd8Eol32/Q5xbv1JvGGa72BPDk
         Bc1Icg56OA8wJjhpuScHnGmRA+r8HLsT0CpB6h0KvyFJAzIxHSlwePIzOTVjLwS+vu
         EL0BKmrpomtOeVICBuT3GwCOQ1IX0NkVnqhldLkC1PyCJyzc4s7vcuQn+GBRzjTDet
         ans4LI8SPV7NFVrcRsQw/aQIB/uvdgikxxfdn1V5demSfKraYYSwIxRgBfTNVCgOYw
         j6hTX4tAjOThjfTCo0Y5hqe0+pKavBrbV5xErXVEFPZoV+I0I760Y2ccFESgKsoZPW
         Td9yCZisnCfVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E011ACE03F1; Mon, 17 Jul 2023 11:08:40 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:08:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/13] RCU update-side scalability test updates for v6.6
Message-ID: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains update-side RCU scalability tests:

1.	Permit blocking delays between writers.

2.	Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario.

3.	Fix gp_async_max typo: s/reader/writer/.

4.	Fix uninitalized use of wait_queue_head_t, courtesy of Waiman
	Long.

5.	Add minruntime module parameter.

6.	Add a "jiffies" test.

7.	Print out full set of module parameters.

8.	Print out full set of kfree_rcu parameters.

9.	Measure grace-period kthread CPU time.

10.	Add kfree_by_call_rcu and kfree_mult to documentation.

11.	Print grace-period kthread CPU time, if recorded.

12.	Measure RCU Tasks Trace grace-period kthread CPU time.

13.	Add RCU Tasks Rude testing.

14.	fix building with RCU_TINY, courtesy of Arnd Bergmann.

15.	Move rcu_scale_writer() schedule_timeout_uninterruptible()
	to _idle(), courtesy of Zqiang.

16.	Add CONFIG_PREEMPT_DYNAMIC=n to TRACE01 scenario.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt                  |   17 +-
 b/Documentation/admin-guide/kernel-parameters.txt                |    5 
 b/include/linux/rcupdate_trace.h                                 |    1 
 b/kernel/rcu/rcu.h                                               |    3 
 b/kernel/rcu/rcuscale.c                                          |    4 
 b/kernel/rcu/refscale.c                                          |    3 
 b/kernel/rcu/tasks.h                                             |    6 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh |    8 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon   |    2 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01    |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT  |    1 
 kernel/rcu/rcu.h                                                 |   17 +-
 kernel/rcu/rcuscale.c                                            |   83 +++++++++-
 kernel/rcu/refscale.c                                            |   34 +++-
 kernel/rcu/tasks.h                                               |   13 +
 15 files changed, 180 insertions(+), 19 deletions(-)
