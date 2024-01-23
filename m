Return-Path: <linux-kernel+bounces-34979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC92838A23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7A1F27D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489D59B48;
	Tue, 23 Jan 2024 09:19:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844358134;
	Tue, 23 Jan 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001556; cv=none; b=pk7Q8aNUZ+MPpk8C+/tmpi9pCr6FwzsMcaiU5clVcr9w1LIVE6SYtJuUWZKcKo6RyfjKRsm6Jx3HWq061p0IuBpqVvRtFlYVEg6wnY/BD8gUY2mBNtsJUzLALYxu6s9xADfDINQ42kXhFG6RRE7j5B7gUB+a7KyQx5z8yRjSz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001556; c=relaxed/simple;
	bh=SiWtbyNZNzEz2T7i5SIjV//aX/niwPXUWmBVnXoNsP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIAR2wTADuePdmXaxQu6uwhOePOiA/O7dVTOaHzGi9njSgxegiuQVW9vxMMnHsxwvhQXICLCDbWyT/JuedkxiafMgbh0lviVigy6+oNLIfsJqELjFPHZ0A7mbxSQ1qVBJ3aXicmAlmqWH/Ymo+bX6lBmlJxgHspSo0YUJ4QZWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TK1hK5R6nzvVDK;
	Tue, 23 Jan 2024 17:17:37 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D7D851404FE;
	Tue, 23 Jan 2024 17:19:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 17:19:03 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v4 1/7] string.h: add str_has_suffix() helper for test string ends with specify string
Date: Tue, 23 Jan 2024 17:21:33 +0800
Message-ID: <20240123092139.3698375-2-yebin10@huawei.com>
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

str_has_suffix() is test string if ends with specify string, and also
this API may return the index of where the suffix was found.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/string.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 433c207a01da..2fb0f22237fe 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -405,4 +405,32 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/**
+ * str_has_suffix - Test if a string has a given suffix
+ * @str: The string to test
+ * @suffix: The string to see if @str ends with
+ * @index: The index into @str of where @suffix is if found (NULL to ignore)
+ *
+ * Returns:
+ * * strlen(@suffix) if @str ends with @suffix
+ * * 0 if @str does not end with @suffix
+ */
+static __always_inline size_t str_has_suffix(const char *str, const char *suffix,
+					     size_t *index)
+{
+	size_t len = strlen(suffix);
+	size_t str_len = strlen(str);
+
+	if (len > str_len)
+		return 0;
+
+	if (strncmp(str + str_len - len, suffix, len))
+		return 0;
+
+	if (index)
+		*index = str_len - len;
+
+	return len;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.31.1


