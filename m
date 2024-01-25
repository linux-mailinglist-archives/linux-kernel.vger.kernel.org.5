Return-Path: <linux-kernel+bounces-38089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7683BAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE2283FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A20134A3;
	Thu, 25 Jan 2024 07:39:47 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810E175A6;
	Thu, 25 Jan 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168387; cv=none; b=PRKQbkN6Ex8uEZo7U3LS/zeDgwsOOvVnJ1arDtg65M6aLRwu1STI2d6rEx1JLX55o3eyVL81nx3lAi7maiMl6O1zlKFEOuAQ6oRdmgH2FW7nTrznhxGKG+QXU0rjQogfubB7Z+G8TWeFlu1hE4WSGc1KBzTCqtE1sF7KGbgYie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168387; c=relaxed/simple;
	bh=erOBzZetGQeOc5+oyau5RI5nfAQAu9VK/IeB1+EeIo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOM7MssELzKjE54BJC6PGSNb2I18pCe7dKnD4RCiuvghNL7kD+b5Pv1/aQ/s/NZBaS1OHyg2nyfJNEZOIrqL0SVjNaZL/PLhGt8fwHT4sru3nH7zgPKKcGnhkklNRiJSxEmfka+RKBN485nwCZ0OT94KTMd0oNK9EW0DPSJnlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TLCNQ20Vyz1Q8D9;
	Thu, 25 Jan 2024 15:37:58 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id A73DD1404F7;
	Thu, 25 Jan 2024 15:39:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Jan
 2024 15:36:53 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v5 6/8] Documentation: tracing: add new type '%pd' and '%pD' for kprobe
Date: Thu, 25 Jan 2024 15:39:21 +0800
Message-ID: <20240125073923.2252057-7-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240125073923.2252057-1-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
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

Similar to printk() '%pd' is for fetch dentry's name from struct dentry's
pointer, and '%pD' is for fetch file's name from struct file's pointer.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/trace/kprobetrace.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index bf9cecb69fc9..f13f0fc11251 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,8 +58,9 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
-                  and bitfield are supported.
+		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
+                  "string", "ustring", "symbol", "symstr" and bitfield are
+                  supported.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
         is best effort, because depending on the argument type, it may be passed on
@@ -113,6 +114,9 @@ With 'symstr' type, you can filter the event with wildcard pattern of the
 symbols, and you don't need to solve symbol name by yourself.
 For $comm, the default type is "string"; any other type is invalid.
 
+VFS layer common type(%pd/%pD) is a special type, which fetches dentry's or
+file's name from struct dentry's address or struct file's address.
+
 .. _user_mem_access:
 
 User Memory Access
-- 
2.31.1


