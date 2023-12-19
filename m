Return-Path: <linux-kernel+bounces-5248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67119818882
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1481C21CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273A18E3C;
	Tue, 19 Dec 2023 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="erPv+WI/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153D18E1C;
	Tue, 19 Dec 2023 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/n2XJ
	IfcbrULIis+G3+HtQ6D4FhSo/cN2GijjyoaIW4=; b=erPv+WI/kNMr9h89V3TyF
	udkUWO1/NK5CPRRU9i292Aw3Ru/uZTCW80fcgjVcr09j9DMvmhLXSDF1AkYARwz6
	QJ1KYn7nnac3Xqyh7eOerqfQHFY4Xi2qcobC7uOOZOnQsEME2ODDyVPm7iZo4Be5
	ZqyBNuECX0HM1ZcQwlldLU=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wDHz15qmIFlPM9qGA--.1378S2;
	Tue, 19 Dec 2023 21:19:39 +0800 (CST)
From: chenguanxi11234@163.com
To: rafael@kernel.org
Cc: len.brown@intel.com,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next v2] kernel/power: Use kmap_local_page() in snapshot.c
Date: Tue, 19 Dec 2023 21:19:36 +0800
Message-Id: <19e305896a2357d305f955fa14cc379e40e512bd.1702977429.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHz15qmIFlPM9qGA--.1378S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fKFWkZF18tF1fCr43GFg_yoW8WFy8pF
	4UAFyDG3yYva48t34IqF1vkry3WwnxA3yrJFW3A3WfZrnIgwnFvr1Iqa18t3W3trWxJFWr
	ArZrtayvkFs5KwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jCxRDUUUUU=
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiQA9L+mVOAjNiVQAAsT

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


