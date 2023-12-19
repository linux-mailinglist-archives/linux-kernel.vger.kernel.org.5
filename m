Return-Path: <linux-kernel+bounces-5231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63B818842
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE461285936
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539C18C31;
	Tue, 19 Dec 2023 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BfHuZel9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279818B04;
	Tue, 19 Dec 2023 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/n2XJ
	IfcbrULIis+G3+HtQ6D4FhSo/cN2GijjyoaIW4=; b=BfHuZel9uSjVEsxqIKnJS
	6DTf6qRV7W0rWdkzkmasVYH8yQ1+SiOImVyVUJgyVV7mxcffF56Y+4xEGxnWwuHz
	fUP+eONWdoh/jCe2nCjcCJvTLp36RyrWiEfxNqjIgpXHSEK6zX5T7SDwywk5eol8
	Ho6m9rWbXZ4Op7c8d8zv+U=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wC3PxBUlYFljtpaEA--.10184S2;
	Tue, 19 Dec 2023 21:06:29 +0800 (CST)
From: chenguanxi11234@163.com
To: rafael@kernel.org
Cc: len.brown@intel.com,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next v2] kernel/power: Use kmap_local_page() in snapshot.c
Date: Tue, 19 Dec 2023 21:06:25 +0800
Message-Id: <19e305896a2357d305f955fa14cc379e40e512bd.1702977429.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3PxBUlYFljtpaEA--.10184S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fKFWkZF18tF1fCr43GFg_yoW8WFy8pF
	4UAFyDG3yYva48t34IqF1vkry3WwnxA3yrJFW3A3WfZrnIgwnFvr1Iqa18t3W3trWxJFWr
	ArZrtayvkFs5KwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jJiSdUUUUU=
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiQABL+mVOAjMcXAABsq

From: Chen Haonan <chen.haonan2@zte.com.cn>

kmap_atomic() has been deprecated in favor of kmap_local_page().

kmap_atomic() disables page-faults and preemption (the latter 
only for !PREEMPT_RT kernels).The code between the mapping and 
un-mapping in this patch does not depend on the above-mentioned 
side effects.So simply replaced kmap_atomic() with kmap_local_page().

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 kernel/power/snapshot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index e3e8f1c6e75f..5c96ff067c64 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 	s_page = pfn_to_page(src_pfn);
 	d_page = pfn_to_page(dst_pfn);
 	if (PageHighMem(s_page)) {
-		src = kmap_atomic(s_page);
-		dst = kmap_atomic(d_page);
+		src = kmap_local_page(s_page);
+		dst = kmap_local_page(d_page);
 		zeros_only = do_copy_page(dst, src);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		kunmap_local(dst);
+		kunmap_local(src);
 	} else {
 		if (PageHighMem(d_page)) {
 			/*
@@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * data modified by kmap_atomic()
 			 */
 			zeros_only = safe_copy_page(buffer, s_page);
-			dst = kmap_atomic(d_page);
+			dst = kmap_local_page(d_page);
 			copy_page(dst, buffer);
-			kunmap_atomic(dst);
+			kunmap_local(dst);
 		} else {
 			zeros_only = safe_copy_page(page_address(d_page), s_page);
 		}
-- 
2.25.1


