Return-Path: <linux-kernel+bounces-34984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378A838A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F21C21F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD458AAC;
	Tue, 23 Jan 2024 09:19:37 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DF5C60D;
	Tue, 23 Jan 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001576; cv=none; b=Tp2Rdwv0q7epr1Q6Qd+RvyyoRpjuK7O0dKLfrKglIWdtDysruU3QLxHs++LNLwh2RTCjh35OfhDngpGnfRDDejMbBmyZUYYhOvZJwi+uff4Y6Gt7u2g0pc/HyLCvyjbXDsmDZfyTetvB4mlZ5cfW9ZRGN1mGqPql0iy4xiMX5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001576; c=relaxed/simple;
	bh=IZ2ztT+g8180deg7EL3rrFcIgg1N/vQXRmntkTF7fOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtSYB9ae66ZsJKTBY2vqJEZdae2Tq9LD4+jBJmCx4or2XeGKiyLijZBmYzOO9dVHF01MURY70H/oqTVFq+hQ7Zt6pUqJTaHGdg7TMm31ABvPVZqB5R8ic8holzYgoNmHMoX02/nmLcyCWnwJtebhLMn/WEUOhYgPzbYB0Py8/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TK1jY39PYzNlQ6;
	Tue, 23 Jan 2024 17:18:41 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 31CEE180089;
	Tue, 23 Jan 2024 17:19:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 17:19:06 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v4 6/7] Documentation: tracing: add new type '%pd' and '%pD' for kprobe
Date: Tue, 23 Jan 2024 17:21:38 +0800
Message-ID: <20240123092139.3698375-7-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240123092139.3698375-1-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
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


