Return-Path: <linux-kernel+bounces-104097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461587C8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D1E282AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788017C7F;
	Fri, 15 Mar 2024 06:54:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A514A85;
	Fri, 15 Mar 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485664; cv=none; b=mTm2MqGjPXoSfpI8MT0jVAxQfgJfgJzSpcAv4YKRiXZBvmKkLV4NHpHmdttOA6C+MhW7WWEjPT5gXr+186dOFVxSs/dR/1uzWbravmXxnr7CKUUL9LJwd/iybcNdyrzFS2RYqxiQl3tjEPUNxyo/VLzpaajbTlLeYgMia5nFffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485664; c=relaxed/simple;
	bh=mm/LKOibx69xdWi9kZO3FwKzMXoZWR3O/2RiRcPvCZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACnZ5z+N//vWOvf5IbCcuY6SHTLNXQPdv0fDBhtDw8AYUCd09PWHL1nxFk0AvEANMRWq+GZVVNGy03N5cgZ5aJJnVDOwM5bFva3tg213dDo9CL2FFttTvd3FQKmJsU2jVB2PYgq+J9PZ6U/wkqn0VJzM+DbQmtxbFaod7rt2A48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tww0y1KZ5z1xr44;
	Fri, 15 Mar 2024 14:52:34 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 763A61A0187;
	Fri, 15 Mar 2024 14:54:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:21 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 8/8] selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"
Date: Fri, 15 Mar 2024 14:55:40 +0800
Message-ID: <20240315065540.1181879-9-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240315065540.1181879-1-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

This patch adds fprobe test cases for new print format type "%pd/%pD".The
test cases test the following items:
1. Test "%pd" type for dput();
2. Test "%pD" type for vfs_read();

This test case require enable CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../ftrace/test.d/dynevent/fprobe_args_vfs.tc | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
new file mode 100644
index 000000000000..49a833bf334c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event VFS type argument
+# requires: kprobe_events "%pd/%pD":README
+
+: "Test argument %pd with name for fprobe"
+echo 'f:testprobe dput name=$arg1:%pd' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pd without name for fprobe"
+echo 'f:testprobe dput $arg1:%pd' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pD with name for fprobe"
+echo 'f:testprobe vfs_read name=$arg1:%pD' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pD without name for fprobe"
+echo 'f:testprobe vfs_read $arg1:%pD' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1"  events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
-- 
2.31.1


