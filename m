Return-Path: <linux-kernel+bounces-104100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011B87C8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DB52816FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18D18EB1;
	Fri, 15 Mar 2024 06:54:30 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D918C1A;
	Fri, 15 Mar 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485670; cv=none; b=cb7OEMGu9BmdVpaFYSf16VCVNHOF9ny5HuzsXd4U9P5ZwWyxts6/6gj37hQTvHmCoxmnqJEv0AMDD/DyqO7XhjJq9Dp57ygMuLAvwwdR3Dod597o2WkNUIKoxdpDMSANzlsCD0rMRQ/UO9WSCHa43VU3kAHX8UDx/+jY6qojGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485670; c=relaxed/simple;
	bh=erOBzZetGQeOc5+oyau5RI5nfAQAu9VK/IeB1+EeIo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7KS1PM1on3NYrnjE3fuOr78pXtURBqKjE0O0ElJvTNDiPng90NiYrBNQ62U1oi7uD+DdeZySExi94AkZUAd34Rn08KRVB09RzIuknZhBOYuDbuxe5YWSb16UKXzzniJu8ahefsQncAhp2NibiG2+LOm+yZXmjpwPvyjR1z95PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tww0W2CXnz1Q9kS;
	Fri, 15 Mar 2024 14:52:11 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 9516118007C;
	Fri, 15 Mar 2024 14:54:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:20 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 6/8] Documentation: tracing: add new type '%pd' and '%pD' for kprobe
Date: Fri, 15 Mar 2024 14:55:38 +0800
Message-ID: <20240315065540.1181879-7-yebin10@huawei.com>
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


