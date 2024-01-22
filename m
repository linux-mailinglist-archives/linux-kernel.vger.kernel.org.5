Return-Path: <linux-kernel+bounces-32434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B6835BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE736281BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37C15485;
	Mon, 22 Jan 2024 07:37:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319D16416;
	Mon, 22 Jan 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909072; cv=none; b=tCJpB3ZWssMxwMwmSiSpq/4HokrxhUzH4LgVxw6N2X8Fqutv/2JY5GIb4wMrU7b8HlGHBi3u2BwjTgUFFMQEqqJHolhp/QA/eOEH6gUWiSo9TkP/GgjkPHchobEiBKZjZgcQAfytMnblyLOEOOJXOwwsg4QPgxWQG6mA4yJTevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909072; c=relaxed/simple;
	bh=sBwc0e0LX68ujIGPPtdpEdCtFeOhchnf4ztfTmcCrW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqdnJLFmR2y4yr6IFpsaa/yKHdTSXPzt3OZqQYX9CUSh8sw5QdTNl2T7fct/lxsUj66XLtH47+7utJiXYORZNx5BSTyOXtgMNRSOsgD1/hmDTl5dJpU+sn70ozaFgIDgu9NG9Z1uqGmlHcxpiZgS1pnXZ3tTfsim5bhHxPrf+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TJMVC181kzVjFn;
	Mon, 22 Jan 2024 15:36:35 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 49E9D1400E4;
	Mon, 22 Jan 2024 15:37:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 15:37:39 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v2 1/7] string.h: add str_has_suffix() helper for test string ends with specify string
Date: Mon, 22 Jan 2024 15:40:09 +0800
Message-ID: <20240122074015.4042575-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122074015.4042575-1-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
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

str_has_suffix() is test string if ends with specify string.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/string.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 433c207a01da..e47e9597af27 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -405,4 +405,24 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/**
+ * str_has_suffix - Test if a string has a given suffix
+ * @str: The string to test
+ * @suffix: The string to see if @str ends with
+ *
+ * Returns:
+ * * strlen(@suffix) if @str ends with @suffix
+ * * 0 if @str does not end with @suffix
+ */
+static __always_inline size_t str_has_suffix(const char *str, const char *suffix)
+{
+	size_t len = strlen(suffix);
+	size_t str_len = strlen(str);
+
+	if (len > str_len)
+		return 0;
+
+	return strncmp(str + str_len - len, suffix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.31.1


