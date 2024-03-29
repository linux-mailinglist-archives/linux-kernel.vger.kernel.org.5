Return-Path: <linux-kernel+bounces-124474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E58918A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FD1F24A15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D566A34B;
	Fri, 29 Mar 2024 12:24:52 +0000 (UTC)
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B22E84F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.246.186.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715092; cv=none; b=BJ79g5oRHHnyC52HMCFVPLWQYg9x2YdYrSSUCJdmnDzp4q+QitPJZfOXZsKi4Wk95HMc6CikgRXrfJlVrRxy+mKj0loimw3smul0bkL5S8aqiK537x+Otph60YmywU2NlI/QSJfuW/tF4kX79/ImxUgsvGICeRflc+ReUj7xtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715092; c=relaxed/simple;
	bh=eKVBy8A5H4w/5K4UmXNPq2gfSSyNQ6AFGwlC/UacDuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laQ1xOFpFHVtR/jkuPzDX8aNeZU+4gHRalRydRx8ng4Kvm46jzQNbAcDWoPJH6LLOWhLRlPNCnkNowQcqtSrs6Kl0fZRW8X0FZKFbfRY2ivNSHJ+PlKhC9ceTESj7sji0vJ/MQJaMa6KgJffJt7wzG7Y0iM1jtEbgBm+HU8d8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru; spf=pass smtp.mailfrom=red-soft.ru; arc=none smtp.client-ip=188.246.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red-soft.ru
Received: from localhost.biz (unknown [10.81.100.48])
	by gw.red-soft.ru (Postfix) with ESMTPA id 541543E1AB8;
	Fri, 29 Mar 2024 15:16:32 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] fs/jffs2: Fix NULL deref in jffs2_scan_dirty_space
Date: Fri, 29 Mar 2024 15:16:29 +0300
Message-Id: <20240329121629.316171-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 184491 [Mar 29 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;localhost.biz:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/03/29 10:56:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/29 08:22:00 #24505801
X-KLMS-AntiVirus-Status: Clean, skipped

As was mentioned in 2ebf09c2, it is possible to get oops,
when marking space dirty in scan, but no previous node exists

It still can be in jffs2_link_node_ref() via deref jeb->last_node.
Since all jffs2_scan_dirty_space() callers check value of a
function, we can return error code safely.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 fs/jffs2/nodelist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c6..6bebf1d64000 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -669,8 +669,11 @@ int jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 			size, jeb->free_size, jeb->wasted_size);
 		BUG();
 	}
+	if (!jeb->last_node) {
+		return -EINVAL;
+	}
 	/* REF_EMPTY_NODE is !obsolete, so that works OK */
-	if (jeb->last_node && ref_obsolete(jeb->last_node)) {
+	if (ref_obsolete(jeb->last_node) {
 #ifdef TEST_TOTLEN
 		jeb->last_node->__totlen += size;
 #endif
-- 
2.37.3


