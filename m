Return-Path: <linux-kernel+bounces-126769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED17893C77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B651C212D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BAE46BA6;
	Mon,  1 Apr 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoPZZLgy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269445BF9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983568; cv=none; b=TDglhj5AXNUfj87prOPG8fNQ8KwfOsv+ERbRb2xtx/pLLY2j/2K+pnfuDkozR4IWjgUhMBa02HMhyFzn9oIpAKGea1jjk10VUpjRh2YNcMEA+n4KODZyQaIIj6gyzxqWCAzKHG/nKOpvMW82VGxfUFRmHyITHYsY3k6fRq36N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983568; c=relaxed/simple;
	bh=Y173ouXifC0UgenFiTZyN7ZdMZSoLV5wM5RT2GlmCFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUIY5ZQzCb+F1Oa0Kd/Bf2ieRI/jSAIQAQlNu7VN43PTWOJEI+L5/LJ8l9oKGy9+Uml3/6YmtKbA2pegiDXQumzDN3KnWMeonDXc7hxvmRL5lUSy1CU3srlctx52QHrsdXZ+Fq96LgRRiINAM19gPBYsd2IMsorYMY0NMlkALaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoPZZLgy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711983565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYtrXSODkF7n06ZabqM/gn748i0MzfQn245Hdj5AU1M=;
	b=WoPZZLgyS7k5QLaig9h7RFIR0/tBY9PET29wMTabd1L9G0Wl8a6RNgIPOODYCsDkYE+OU+
	LkklOPl1CKIbihAqU1JZ5MjmHmPHPBuVq36s7lDxgLg95Vgi9wZHFEwJg5Ow/XRi6JnHQl
	eZKXPap36U5ht+m5K6wCsCHh/zG37Gk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-2-d38DFfNMaBj4mHhv0i_A-1; Mon, 01 Apr 2024 10:59:21 -0400
X-MC-Unique: 2-d38DFfNMaBj4mHhv0i_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9E33185A781;
	Mon,  1 Apr 2024 14:59:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 955A58177;
	Mon,  1 Apr 2024 14:59:18 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Add test_cpuset_v1_hp.sh
Date: Mon,  1 Apr 2024 10:58:58 -0400
Message-Id: <20240401145858.2656598-3-longman@redhat.com>
In-Reply-To: <20240401145858.2656598-1-longman@redhat.com>
References: <20240401145858.2656598-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a simple test to verify that an empty v1 cpuset will force its tasks
to be moved to an ancestor node. It is based on the test case documented
in commit 76bb5ab8f6e3 ("cpuset: break kernfs active protection in
cpuset_write_resmask()").

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile       |  2 +-
 .../selftests/cgroup/test_cpuset_v1_hp.sh     | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 00b441928909..16461dc0ffdf 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wall -pthread
 all: ${HELPER_PROGS}
 
 TEST_FILES     := with_stress.sh
-TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
+TEST_PROGS     := test_stress.sh test_cpuset_prs.sh test_cpuset_v1_hp.sh
 TEST_GEN_FILES := wait_inotify
 TEST_GEN_PROGS = test_memcontrol
 TEST_GEN_PROGS += test_kmem
diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
new file mode 100755
index 000000000000..0d0a1923d8ec
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the special cpuset v1 hotplug case where a cpuset become empty of
+# CPUs will force migration of tasks out to an ancestor.
+#
+
+skip_test() {
+	echo "$1"
+	echo "Test SKIPPED"
+	exit 4 # ksft_skip
+}
+
+[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
+
+# Find cpuset v1 mount point
+CPUSET=$(mount -t cgroup | grep cpuset | head -1 | awk -e '{print $3}')
+[[ -n "$CPUSET" ]] || skip_test "cpuset v1 mount point not found!"
+
+#
+# Create a test cpuset, put a CPU and a task there and offline that CPU
+#
+TDIR=test$$
+[[ -d $CPUSET/$TDIR ]] || mkdir $CPUSET/$TDIR
+echo 1 > $CPUSET/$TDIR/cpuset.cpus
+echo 0 > $CPUSET/$TDIR/cpuset.mems
+sleep 10&
+TASK=$!
+echo $TASK > $CPUSET/$TDIR/tasks
+echo 0 > /sys/devices/system/cpu/cpu1/online
+sleep 0.5
+echo 1 > /sys/devices/system/cpu/cpu1/online
+NEWCS=$(cat /proc/$TASK/cpuset)
+rmdir $CPUSET/$TDIR
+[[ $NEWCS != "/" ]] && {
+	echo "cpuset $NEWCS, test FAILED!"
+	exit 1
+}
+echo "Test PASSED"
+exit 0
-- 
2.39.3


