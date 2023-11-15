Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F27EC949
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjKOREb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjKOREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698041BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700067860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nT8mn+CYHK0/rYux6OcfYs1wPw2RH0li5fDfUDzstNM=;
        b=Aw44Lqb/IHGOBaZ95vDdU/HTapHnwCvDHV6Qw3wJpCxKbuyzcERFM0AKdDc6OSZlWWaXoy
        +YrYdhDRTkt2OWrbVM/MmzLIMDDtvOGByCTxG2AJcrrSLsvdcL1l3GdNiIjPCk0xJTtd3P
        KUFd4TLazJ+OMt+lLoQNQqjJuRBWejw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-fM9_B0zOOhmjiCp8CSg7IQ-1; Wed, 15 Nov 2023 12:04:16 -0500
X-MC-Unique: fM9_B0zOOhmjiCp8CSg7IQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 798E1101AA42;
        Wed, 15 Nov 2023 17:04:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25F9F1121308;
        Wed, 15 Nov 2023 17:04:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 3/5] selftests/cgroup: Minor code cleanup and reorganization of test_cpuset_prs.sh
Date:   Wed, 15 Nov 2023 12:03:57 -0500
Message-Id: <20231115170359.163299-4-longman@redhat.com>
In-Reply-To: <20231115170359.163299-1-longman@redhat.com>
References: <20231115170359.163299-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup of test matrix and relocation of test_isolated() function
to prepare for the next patch. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 142 +++++++++---------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a6e9848189d6..2b825019f806 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -146,71 +146,6 @@ test_add_proc()
 	echo $$ > $CGROUP2/cgroup.procs	# Move out the task
 }
 
-#
-# Testing the new "isolated" partition root type
-#
-test_isolated()
-{
-	cd $CGROUP2/test
-	echo 2-3 > cpuset.cpus
-	TYPE=$(cat cpuset.cpus.partition)
-	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
-
-	console_msg "Change from member to root"
-	test_partition root
-
-	console_msg "Change from root to isolated"
-	test_partition isolated
-
-	console_msg "Change from isolated to member"
-	test_partition member
-
-	console_msg "Change from member to isolated"
-	test_partition isolated
-
-	console_msg "Change from isolated to root"
-	test_partition root
-
-	console_msg "Change from root to member"
-	test_partition member
-
-	#
-	# Testing partition root with no cpu
-	#
-	console_msg "Distribute all cpus to child partition"
-	echo +cpuset > cgroup.subtree_control
-	test_partition root
-
-	mkdir A1
-	cd A1
-	echo 2-3 > cpuset.cpus
-	test_partition root
-	test_effective_cpus 2-3
-	cd ..
-	test_effective_cpus ""
-
-	console_msg "Moving task to partition test"
-	test_add_proc "No space left"
-	cd A1
-	test_add_proc ""
-	cd ..
-
-	console_msg "Shrink and expand child partition"
-	cd A1
-	echo 2 > cpuset.cpus
-	cd ..
-	test_effective_cpus 3
-	cd A1
-	echo 2-3 > cpuset.cpus
-	cd ..
-	test_effective_cpus ""
-
-	# Cleaning up
-	console_msg "Cleaning up"
-	echo $$ > $CGROUP2/cgroup.procs
-	[[ -d A1 ]] && rmdir A1
-}
-
 #
 # Cpuset controller state transition test matrix.
 #
@@ -304,7 +239,7 @@ TEST_MATRIX=(
 								       A1:P0,A2:P2,A3:P1 2-4"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4,A2:1-4,A3:2-4 \
-								       A1:P0,A2:P-2,A3:P-1 ."
+								       A1:P0,A2:P-2,A3:P-1"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1,A2:2-4,A3:2-4 \
 								       A1:P0,A2:P2,A3:P-1 2-4"
@@ -347,10 +282,10 @@ TEST_MATRIX=(
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .     C4      .      P2     .     0 A1:4,A2:4,XA2:,XA3:,A3:4 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .     X1      .      P2     .     0 A1:0-3,A2:1-3,XA1:1,XA2:,XA3:,A3:2-3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .      .     C3      P2     .     0 A1:0-2,A2:0-2,XA2:3,XA3:3,A3:3 \
 								       A1:P0,A3:P2 3"
@@ -359,13 +294,13 @@ TEST_MATRIX=(
 								       A1:P0,A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .      .     X3      .      .     0 A1:0-3,A2:1-3,XA2:3,XA3:3,A3:2-3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .      .     C3      .      .     0 A1:0-3,A2:3,XA2:3,XA3:3,A3:3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .     C4      .      .      .     0 A1:4,A2:4,A3:4,XA1:,XA2:,XA3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
@@ -804,6 +739,71 @@ run_state_test()
 	echo "All $I tests of $TEST PASSED."
 }
 
+#
+# Testing the new "isolated" partition root type
+#
+test_isolated()
+{
+	cd $CGROUP2/test
+	echo 2-3 > cpuset.cpus
+	TYPE=$(cat cpuset.cpus.partition)
+	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
+
+	console_msg "Change from member to root"
+	test_partition root
+
+	console_msg "Change from root to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to member"
+	test_partition member
+
+	console_msg "Change from member to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to root"
+	test_partition root
+
+	console_msg "Change from root to member"
+	test_partition member
+
+	#
+	# Testing partition root with no cpu
+	#
+	console_msg "Distribute all cpus to child partition"
+	echo +cpuset > cgroup.subtree_control
+	test_partition root
+
+	mkdir A1
+	cd A1
+	echo 2-3 > cpuset.cpus
+	test_partition root
+	test_effective_cpus 2-3
+	cd ..
+	test_effective_cpus ""
+
+	console_msg "Moving task to partition test"
+	test_add_proc "No space left"
+	cd A1
+	test_add_proc ""
+	cd ..
+
+	console_msg "Shrink and expand child partition"
+	cd A1
+	echo 2 > cpuset.cpus
+	cd ..
+	test_effective_cpus 3
+	cd A1
+	echo 2-3 > cpuset.cpus
+	cd ..
+	test_effective_cpus ""
+
+	# Cleaning up
+	console_msg "Cleaning up"
+	echo $$ > $CGROUP2/cgroup.procs
+	[[ -d A1 ]] && rmdir A1
+}
+
 #
 # Wait for inotify event for the given file and read it
 # $1: cgroup file to wait for
-- 
2.39.3

