Return-Path: <linux-kernel+bounces-111176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD548868C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA371F2460E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2F1B7EF;
	Fri, 22 Mar 2024 09:02:17 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B041B267
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098136; cv=none; b=hl7bEbtuTRqnkYX4Gf9RpEYx/sHwzN5udUd1EJ/8ZS50kjx96gyCe13jvzJaNOGeg+cP0zGEyv8jZ/pnrK3efiRfRVKeLTGe6vtNVl9CtIv2GPhwYkNvo5LadTgJ8ZCPforI8C6HuhFKkxWghVub92CBZItQrgHS2rhgnWHW3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098136; c=relaxed/simple;
	bh=R0hfuKh1a36ZLHJsB/SZwOd7UoiwUuK8ECg7FM6l7Tk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPgGddxleHeRypLQ9VHUfxQgG78W6vt3RwlqmLk5CIoMMv52ms9LkzveMZ95supInxfT1ABPjHAIy3PlpfolXNdxvdxwckln8RWW/eBs+IRVsSeh9AIWcYpV1Csuk1vaS+MmFWsPiO2eBe+DoGitHJ79aGF987S4QX9/Bm20NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.5) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 22 Mar
 2024 12:02:05 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>
Subject: [PATCH] udf: udftime: prevent overflow in udf_disk_stamp_to_time()
Date: Fri, 22 Mar 2024 12:01:45 +0300
Message-ID: <20240322090145.11175-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/22/2024 08:41:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184344 [Mar 22 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 11 0.3.11
 5ecf9895443a5066245fcb91e8430edf92b1b594
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.5
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/22/2024 08:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/22/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

An overflow can occur in a situation where src.centiseconds
takes the value of 255. This situation is unlikely, but there
is no validation check anywere in the code. It is necessary
to convert the type of expression to 64-bit.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 fs/udf/udftime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index 758163af39c2..2824b90c8288 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -33,6 +33,7 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
 	u16 year = le16_to_cpu(src.year);
 	uint8_t type = typeAndTimezone >> 12;
 	int16_t offset;
+	int64_t nsec;
 
 	if (type == 1) {
 		offset = typeAndTimezone << 4;
@@ -46,13 +47,13 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
 	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
 			src.second);
 	dest->tv_sec -= offset * 60;
-	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
+	nsec = 1000LL * (src.centiseconds * 10000 +
 			src.hundredsOfMicroseconds * 100 + src.microseconds);
 	/*
 	 * Sanitize nanosecond field since reportedly some filesystems are
 	 * recorded with bogus sub-second values.
 	 */
-	dest->tv_nsec %= NSEC_PER_SEC;
+	dest->tv_nsec = do_div(nsec, NSEC_PER_SEC);
 }
 
 void
-- 
2.34.1


