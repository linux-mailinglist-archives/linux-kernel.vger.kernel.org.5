Return-Path: <linux-kernel+bounces-95045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB387488D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D786284E52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A31CFBC;
	Thu,  7 Mar 2024 07:18:04 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9BE200DB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795884; cv=none; b=eTAxNoO39e7JUyGjyNMkb4p+PAiwfz/5Z5bU5VoHuxR7Yz0sSKE6/5Aet6ULP0QBGdVEitMHhuZ2G8jPBb6mgQOU+DMlkNmC/4KxkbK5p7FuFSlav0wKgg2vS86+/hzGkhqY398s6eL9tZSpw+i96hV4puGtTN4SIprx2F/sLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795884; c=relaxed/simple;
	bh=HIo01TJSTbErOtfFpggP4HNn4QWtzF0ZBECJeNpS3JQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UMXqU3415Op58ZizomU2qUvee49nA8INnjE3evKUX4LR1niF57jzqrjkW9Ik+5QxvRXurPAr5/NkrKVp79LCOIbwp/+GPcozQRghyRU26iCeOST1zF77m8XDkALS6XfigbtBHWRkip0+trbIOsc41PeU3k21OYaMaQRDfVdfxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 10:17:51 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] assoc_array: fix the return value in assoc_array_insert_mid_shortcut()
Date: Thu, 7 Mar 2024 10:17:17 +0300
Message-ID: <20240307071717.5318-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/07/2024 06:56:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184019 [Mar 07 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 78.37.41.175 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;78.37.41.175:7.4.1,7.7.3;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.175
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/07/2024 07:02:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/7/2024 2:51:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Returning the edit variable is redundant because it is
dereferenced right before it is returned. It would be better
to return true.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 lib/assoc_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index ca0b4f360c1a..388e656ac974 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -938,7 +938,7 @@ static bool assoc_array_insert_mid_shortcut(struct assoc_array_edit *edit,
 		edit->leaf_p = &new_n0->slots[0];
 
 	pr_devel("<--%s() = ok [split shortcut]\n", __func__);
-	return edit;
+	return true;
 }
 
 /**
-- 
2.34.1


