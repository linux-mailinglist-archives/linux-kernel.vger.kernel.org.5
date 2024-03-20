Return-Path: <linux-kernel+bounces-108945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E1881251
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584561C226C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43A47F63;
	Wed, 20 Mar 2024 13:28:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFC40C09;
	Wed, 20 Mar 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941302; cv=none; b=uqA+YnJgh3WSDvQJUl8umMsPKpl8XqHlKAXrdn/iuZIQQ5ayryTcr6KPCjXZLYcUYNK31VTdtAz09DRzFxiennEeXfWaz6XEYyYcSwTW4DY0RcTKIA8pk7kO/LIBPGPG5w1DE/C5XJfLA7szUPuoGFs/NLYpLsFM2NTDcWiIg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941302; c=relaxed/simple;
	bh=PAuV3wGybOkWPg2txqBYQgpyb2BYdYoi5e0uWKeMlW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTkfP24wKbTOtxboZMRvKWy4OenfC1tmxDwXRSmTPoGjElILx8jrFMCsdidL+bvGfvEQvc3GD9QhrFlxH/RQN/QGZat3L6aAWumeZJv+Xkg2BfwkBv44WFcgH6/ahSKLgJ6vRr0H2GKuuftgdbXhOOBXdxnZndQCUK+/mlZAcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V08XC5lKGzbdBZ;
	Wed, 20 Mar 2024 21:27:23 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 89F27140158;
	Wed, 20 Mar 2024 21:28:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 21:28:12 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v7 4/5] selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
Date: Wed, 20 Mar 2024 21:29:23 +0800
Message-ID: <20240320132924.2802187-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240320132924.2802187-1-yebin10@huawei.com>
References: <20240320132924.2802187-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)

This patch adds test cases for new print format type "%pd/%pD".The test cases
test the following items:
1. Test README if add "%pd/%pD" type;
2. Test "%pd" type for dput();
3. Test "%pD" type for vfs_read();

This test case require enable CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
new file mode 100644
index 000000000000..21a54be6894c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event VFS type argument
+# requires: kprobe_events "%pd/%pD":README
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


