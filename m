Return-Path: <linux-kernel+bounces-112266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896D8877A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09791F221BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598ABDDAE;
	Sat, 23 Mar 2024 08:57:47 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-05.21cn.com [182.42.157.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58331D535
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184266; cv=none; b=suVlr08LZP/eYLUqUCQ5iRVbs5E0hH0VzUvTw5/iw00nOB261FeIcYE/XicRL2/Yk0mkiyF64o1Ej6V7vWrgDOcHQ5Y8uipos0oGv5MNwILat4oePikvR/oRLpgqjnpivhTP8xW9GhKf5da5RWTbm+8ACcFsgwEAefP/ug4bWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184266; c=relaxed/simple;
	bh=YR9Icjn4E0WLpXvgUHdNENF0Q30VS6zm01rlmVJ+EX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=michQtWn408dD2PCVNuXcQ+eqSsWVmqk1kc9O3XN7RpIy32oX9MpGXTCail6LJXY4ntiUTZ6r5yrelP/wytLukSbUwesdPORM7Xm4iV1awDcwviahi1CP8/7Nty7hTIhyShNFMqm5aGv9UL/1M8oH9SGGsDUvlwDqvjsqlawZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:3649.1797840252
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.84 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 368419BD0A;
	Sat, 23 Mar 2024 16:46:08 +0800 (CST)
X-189-SAVE-TO-SEND: chentt10@chinatelecom.cn
Received: from  ([36.111.64.84])
	by gateway-ssl-dep-77bc75f6c8-jgbgh with ESMTP id 093e69577b2144e3b8c2a8bd28ab5af2 for akpm@linux-foundation.org;
	Sat, 23 Mar 2024 16:46:12 CST
X-Transaction-ID: 093e69577b2144e3b8c2a8bd28ab5af2
X-Real-From: chentt10@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: chentt10@chinatelecom.cn
From: Chen Taotao <chentt10@chinatelecom.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] mm: get_mm_counter() get the total memory usage of the process
Date: Fri, 22 Mar 2024 23:11:39 +0800
Message-Id: <20240322151139.7417-1-chentt10@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the get_mm_counter() function returns only the value of
the process memory counter percpu_counter ->count record, ignoring
the memory usage count maintained by each CPU in the
percpu_counter->counters array, which leads to an error in obtaining
the memory usage count of a process, especially when there are many
CPU cores. counts, especially when there are many CPU cores.

It is now possible to have get_mm_counter() get the memory count of a
process by adding the memory counts maintained by each cpu, thus getting
an accurate memory count of the process.

This patch is an unofficial version that simply fixes the above problem,
as I'm not sure if it makes sense to do so.

Signed-off-by: Chen Taotao <chentt10@chinatelecom.cn>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5..5cf6443aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2569,7 +2569,7 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	return percpu_counter_sum_positive(&mm->rss_stat[member]);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
-- 
2.27.0


