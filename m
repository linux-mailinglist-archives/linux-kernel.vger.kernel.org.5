Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146AD756BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGQSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B5E56;
        Mon, 17 Jul 2023 11:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A43F611D1;
        Mon, 17 Jul 2023 18:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72307C433C7;
        Mon, 17 Jul 2023 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618214;
        bh=Kfoxnxr+2TTZpNOD4vqbiveWcX93cGtNMm57sfTfn0o=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XfREkXjm8utcp2ax69ybDgYlzKm6bNwK1bcOo0XSZYETl0Mz9d/MU6lyUDY3Ql7hr
         N7xeT/OsISM7MctBKDo3K2IjsNLnDW3MEgz/yMUytcxReVuIrz0wW192AMsG30WheK
         NW/yxNDDW6dgn59IqZg2ZyrFNwgAZs9cQGddjmI4XbhURuE5rbQ44oOrEtG0nTYADf
         n4froOSNIrhzwlUUhnPMdO+jnrz+iH4WW5Sk3GuQbKphWqaHfBBWIg/S/izjB3QStF
         3cYIqIDxkdwK/GF7tBwF6DfmT22ypBTcQZpyxTma5FrSja4kkQT+AZ/l1dip6kqxk7
         OdwEMSn7t4Qeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01F7DCE03F1; Mon, 17 Jul 2023 11:23:33 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:23:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/18] Torture-test scripting updates for v6.6
Message-ID: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
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

This series contains updates for torture-test scripting:

1.	Remove obsolete BOOTPARAM_HOTPLUG_CPU0 Kconfig option.

2.	Remove formal-verification tests.

3.	Add "--no-" as synonym for "--do-no-" in torture.sh.

4.	Remove contradictory Kconfig constraint.

5.	Allow #CHECK# in --kconfig argument to kvm.sh.

6.	Make kvm-recheck.sh report .config errors.

7.	Add RCU Tasks individual-flavor build tests.

8.	Make kvm-remote print diagnostics on initial ssh failure.

9.	Remove obsolete parameter check from mkinitrd.sh.

10.	Place --bootargs parameters at end of -append list.

11.	Make torture.sh summarize config and build errors.

12.	Loosen .config checks for KCSAN kernels.

13.	Add srcu_lockdep.sh to torture.sh.

14.	Avoid torture-test reboot loops.

15.	Add init-program support for loongarch.

16.	Switch qemu from -nographic to -display none.

17.	Make init program dump command-line arguments.

18.	Cause mkinitrd.sh to indicate failure on compile errors.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/configcheck.sh                                   |   61 -
 b/tools/testing/selftests/rcutorture/bin/functions.sh                                     |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh                                   |   37 
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh                                    |   12 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh                                |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                                           |    2 
 b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh                                      |    1 
 b/tools/testing/selftests/rcutorture/bin/torture.sh                                       |   44 -
 b/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh                        |    5 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03                                  |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01                                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh                         |    5 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh                    |    5 
 b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh                    |    5 
 b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh                         |    5 
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh                                     |    7 
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh                                  |   19 
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh                                        |   17 
 tools/testing/selftests/rcutorture/bin/torture.sh                                         |   77 ++
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore                            |    2 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile                              |   17 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore              |    2 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h               |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h                 |  152 ----
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk                       |  376 ----------
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h                          |   17 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h                        |   41 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h                          |   14 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c                 |   14 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h                          |   28 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c                    |   32 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h                    |   34 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h                           |  221 -----
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c                            |   12 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h                            |   58 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h                          |   93 --
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c                         |   79 --
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h                         |   59 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c                |   51 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h                      |  103 --
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore      |    2 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile        |   12 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail      |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail     |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail     |    1 
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c          |   73 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh                  |  103 --
 48 files changed, 218 insertions(+), 1689 deletions(-)
