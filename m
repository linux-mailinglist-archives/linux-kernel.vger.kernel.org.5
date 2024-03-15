Return-Path: <linux-kernel+bounces-104098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86787C8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD7CB214E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3B182A0;
	Fri, 15 Mar 2024 06:54:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9314012;
	Fri, 15 Mar 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485665; cv=none; b=DNAdjZJ8Vjsh90bHWrDRMbDIsmrJfnVojAFUtSdcyjKKG01494RjFdnFC9Khm8yfdyyfFvG0+sYVF3OPwyYSCLq1iEolQww+CrrEPfTnh8z6y7RxNUr5rz3bN/Y3p/PoBRG33cRqZE+gVzexH64W2QOPugykaRRdpDRx09/tWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485665; c=relaxed/simple;
	bh=0/WV/6Kb3iC5gYSeZVx26GoOUUshmVEdVz9ZIolb0aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8dWxQDg3UA20vCmHMN2dZiakXOdctVVpbiBfoXx45mREQur9eVjNz4QpjhNYAPpIF1neqfN87RoIihSf1z9NPJDyAC615D2bbm+wb+WMupOB4bKIQCYw15y+tuBRCndLpWeGyvTDghFiiYnkuEr1k6vUmxgo9lVAQkNPGp51jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tww2g2ZJzz1FMW1;
	Fri, 15 Mar 2024 14:54:03 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F13814040F;
	Fri, 15 Mar 2024 14:54:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:20 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 7/8] selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
Date: Fri, 15 Mar 2024 14:55:39 +0800
Message-ID: <20240315065540.1181879-8-yebin10@huawei.com>
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

This patch adds test cases for new print format type "%pd/%pD".The test cases
test the following items:
1. Test README if add "%pd/%pD" type;
2. Test "%pd" type for dput();
3. Test "%pD" type for vfs_read();

This test case require enable CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
new file mode 100644
index 000000000000..8bea9a75a331
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event VFS type argument
+# requires: kprobe_events "%pd/%pD":README
+
+: "Test argument %pd/%pD in README"
+grep -q "%pd/%pD" README
+
+: "Test argument %pd with name"
+echo 'p:testprobe dput name=$arg1:%pd' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pd without name"
+echo 'p:testprobe dput $arg1:%pd' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pD with name"
+echo 'p:testprobe vfs_read name=$arg1:%pD' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pD without name"
+echo 'p:testprobe vfs_read $arg1:%pD' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1"  events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
-- 
2.31.1


