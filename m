Return-Path: <linux-kernel+bounces-100069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63A879161
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE61F23124
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758B7867E;
	Tue, 12 Mar 2024 09:49:34 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0B78288
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236974; cv=none; b=daAHaGrmxtQkZ+31VGp0HOjI7sMcjWXdw/2WccqnlszxTVFSzQ0SEUmu+tzCwRAHrBU+oRAzmfclAModh+LMGr2ydxegxE2LyhQYT+xca+ByXGlEgDN5p0Xmb6Bceytf9De79N8vSjX7HwS/xvep8v7eLorGR6qLixeG3hilQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236974; c=relaxed/simple;
	bh=TIL3iYxP4zmJ6nFF1TGQYikRpF2lwNTb6W5dM6L1DN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0h7q+0gPvCJO+MjaskZiJ5I+E3y47nt6jja1+mdFyFqyzZtBprzGPZMlEo/XgsBb+PCWMvXrZN6j6lBJ9pVyFP0CzMr70qruAH5ns/TO1GZaBmX+Bfartk4lV+hUrqtWmOPsw9NRDswmq3xAwBSAiD+a5J06mYLqaO59jVgugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 12 Mar
 2024 12:49:14 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-kernel@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] fixp-arith: prevent division by zero in fixp_sin32_rad()
Date: Tue, 12 Mar 2024 12:48:52 +0300
Message-ID: <20240312094852.15400-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/12/2024 09:25:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184094 [Mar 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	78.37.41.175:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 03/12/2024 09:29:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/12/2024 6:48:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The parameter twopi can have a zero value. It is necessary
to prevent division by zero.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 include/linux/fixp-arith.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index e485fb0c1201..434eee8bd9ef 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -118,8 +118,9 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
 
 	/*
 	 * Avoid too large values for twopi, as we don't want overflows.
+	 * Also prevent division by zero.
 	 */
-	BUG_ON(twopi > 1 << 18);
+	BUG_ON(!twopi || twopi > 1 << 18);
 
 	degrees = (radians * 360) / twopi;
 	tmp = radians - (degrees * twopi) / 360;
-- 
2.34.1


