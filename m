Return-Path: <linux-kernel+bounces-34655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC788385C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B72892CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4F1FA5;
	Tue, 23 Jan 2024 02:55:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5D374;
	Tue, 23 Jan 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978517; cv=none; b=Df1wFzcR9bjo6PyOQxq7ar63xm3JUyaOccwvkOs9JYIsdeZA2xia2ubDTnD+3CiZIOIDqLVTCD2oCkdRvCdZdnkO5UszF4+nQ3YxO8PhywUkaIE+6oXGdVXVotidbGBeIOOB7U1RNoocLR30s+81hP0sMXUX9ryqNxQCIp4BO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978517; c=relaxed/simple;
	bh=IZ2ztT+g8180deg7EL3rrFcIgg1N/vQXRmntkTF7fOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMRR98SMobb9LeBojXpV+EHoWh+tENKbSsPSNKVZYyJ3Pwa+mHGn0+GaxW0JMy8Evm07c8eDYUrmZBlnBeLTDhUtGSxfXZ55kj/vSmDOh19bpmrNI8KceicIrg/994xncRvc7WEz9mKe6Rj0qKwgM6MEnrG/JMP8QrYqQrf6lHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TJs6450xNz1FJfN;
	Tue, 23 Jan 2024 10:50:52 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D1F94140485;
	Tue, 23 Jan 2024 10:55:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:53:35 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v3 6/7] Documentation: tracing: add new type '%pd' and '%pD' for kprobe
Date: Tue, 23 Jan 2024 10:56:07 +0800
Message-ID: <20240123025608.2370978-7-yebin10@huawei.com>
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

Similar to printk() '%pd' is for fetch dentry's name from struct dentry's
pointer, and '%pD' is for fetch file's name from struct file's pointer.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/trace/kprobetrace.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index bf9cecb69fc9..a1d12d65a8dc 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,7 +58,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
+		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD) for print
+                  file name, "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
@@ -113,6 +114,9 @@ With 'symstr' type, you can filter the event with wildcard pattern of the
 symbols, and you don't need to solve symbol name by yourself.
 For $comm, the default type is "string"; any other type is invalid.
 
+VFS layer common type(%pd/%pD) is a special type, which fetches dentry's or
+file's name from struct dentry's pointer or struct file's pointer.
+
 .. _user_mem_access:
 
 User Memory Access
-- 
2.31.1


