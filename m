Return-Path: <linux-kernel+bounces-34660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC58385C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781671C27C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58263BF;
	Tue, 23 Jan 2024 02:55:19 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53177A40;
	Tue, 23 Jan 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978518; cv=none; b=Ni4igL6R/DhTvkHu+Z2QrofBQ83SByJis+LUTrArx3zSxxSEYGbuUDsGkMe4kdsOtoURV4bsQ89HFv6LS3Opi7xvYzJiO5GVk6Fwt2GAIwm44/Zzi6x4J+xcX0gNLytwbK4jnj6WELH7WvwL0zohktlj83eXivGXOVINKYBnOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978518; c=relaxed/simple;
	bh=wqD3BcIyhEmryJcEFaCD5uVA14nzmG5cK5v0iik8hsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hieRYvErEWOQcNa3P+ZyMr9eRolS4NUcU87VVDLOT1MNwsKC2rGUPJ1DJZE0rTJ4By0sLTZqyjV1tbiHgbqPaHh368wn+wa/YeXupn5jpHxRjm0qaps8R818znKvnoIfv5lFTMoLcEdLa6DN5WdbhzrYBwr79qCPlSSRgoEqz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TJs952mS1z1S5QL;
	Tue, 23 Jan 2024 10:53:29 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D72251404D8;
	Tue, 23 Jan 2024 10:55:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:53:35 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v3 7/7] selftests/ftrace: add test cases for VFS type "%pd" and "%pD"
Date: Tue, 23 Jan 2024 10:56:08 +0800
Message-ID: <20240123025608.2370978-8-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240123025608.2370978-1-yebin10@huawei.com>
References: <20240123025608.2370978-1-yebin10@huawei.com>
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

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
new file mode 100644
index 000000000000..1d8edd294dd6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
@@ -0,0 +1,79 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event VFS type argument
+# requires: kprobe_events
+
+case `uname -m` in
+x86_64)
+  ARG1=%di
+;;
+i[3456]86)
+  ARG1=%ax
+;;
+aarch64)
+  ARG1=%x0
+;;
+arm*)
+  ARG1=%r0
+;;
+ppc64*)
+  ARG1=%r3
+;;
+ppc*)
+  ARG1=%r3
+;;
+s390*)
+  ARG1=%r2
+;;
+mips*)
+  ARG1=%r4
+;;
+loongarch*)
+  ARG1=%r4
+;;
+riscv*)
+  ARG1=%a0
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+: "Test argument %pd/%pD in README"
+grep -q "%pd/%pD" README
+
+: "Test argument %pd with name"
+echo "p:testprobe dput name=${ARG1}:%pd" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pd without name"
+echo "p:testprobe dput ${ARG1}:%pd" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pD with name"
+echo "p:testprobe vfs_read name=${ARG1}:%pD" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1" events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
+
+: "Test argument %pD without name"
+echo "p:testprobe vfs_read ${ARG1}:%pD" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+grep -q "1"  events/kprobes/testprobe/enable
+echo 0 > events/kprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > kprobe_events
+echo "" > trace
-- 
2.31.1


