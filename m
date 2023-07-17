Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962B756BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGQSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGQSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A4171C;
        Mon, 17 Jul 2023 11:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB57661218;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2113FC4167D;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=F9UudZvmwm9L+mKVQGqYbPDfGRLLSTExPAhqAyUKUiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTtP2w2ybqx7JRe2grIuHO/8iNwx6II/XytBgdExW+Tr5OtezDnpcS4GWU99jdZcF
         UWBcYI39KULX/7wZzoO8dgIxpF6PHRUPu+OXdIdmFZYAOr9H7Q/A8JOfbL7DC8+kvD
         9GY3+iwqVXsc3zCSl0gHjN70EAk94bOWs2K0Q3nvVwq1kZMRg+x5Otxre+ir/YxN2l
         v2C0A+Tnt3ogmzLqfMQ+x1WG5Z1bHViIzO3k1oXUy0UQXUaxzTGYl9C85CjU7nRdny
         B9upwyU6vDEwC2TaqtB8/UlJWMfZZD57c5zEyCAfTiIFSO/lhhQWmiSoHluK1Un1Fl
         OP0VaoNI9ULeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CE82CE0A13; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/18] torture: Avoid torture-test reboot loops
Date:   Mon, 17 Jul 2023 11:23:33 -0700
Message-Id: <20230717182337.1098991-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the various torture tests sometimes react to an early-boot
bug by rebooting.  This is almost always counterproductive, needlessly
consuming CPU time and bloating the console log.  This commit therefore
adds the "-no-reboot" argument to qemu so that reboot requests will
cause qemu to exit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1e7566997e51..3bc0140438ef 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -9,9 +9,10 @@
 #
 # Usage: kvm-test-1-run.sh config resdir seconds qemu-args boot_args_in
 #
-# qemu-args defaults to "-enable-kvm -nographic", along with arguments
-#			specifying the number of CPUs and other options
-#			generated from the underlying CPU architecture.
+# qemu-args defaults to "-enable-kvm -nographic -no-reboot", along with
+#			arguments specifying the number of CPUs and
+#			other options generated from the underlying
+#			CPU architecture.
 # boot_args_in defaults to value returned by the per_version_boot_params
 #			shell function.
 #
@@ -139,7 +140,7 @@ then
 fi
 
 # Generate -smp qemu argument.
-qemu_args="-enable-kvm -nographic $qemu_args"
+qemu_args="-enable-kvm -nographic -no-reboot $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args_in" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
-- 
2.40.1

