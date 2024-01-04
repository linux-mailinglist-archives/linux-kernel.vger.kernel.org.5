Return-Path: <linux-kernel+bounces-16263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C406823BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0581B1F2539B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2919454;
	Thu,  4 Jan 2024 05:41:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38F18EBF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4045eZCU057778;
	Thu, 4 Jan 2024 13:40:35 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T5Fct75KXz2QcMNy;
	Thu,  4 Jan 2024 13:33:50 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 4 Jan 2024 13:40:33 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>
CC: <longman@redhat.com>, <boqun.feng@gmail.com>, <ke.wang@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
Date: Thu, 4 Jan 2024 13:40:30 +0800
Message-ID: <20240104054030.14733-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4045eZCU057778

The lookup_chain_cache_add will get graph_lock, but the
validate_chain do not unlock before return 0.

So add graph_unlock before return 0.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 kernel/locking/lockdep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..24995e1ebc62 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3855,8 +3855,11 @@ static int validate_chain(struct task_struct *curr,
 		 */
 		int ret = check_deadlock(curr, hlock);
 
-		if (!ret)
+		if (!ret) {
+			graph_unlock();
 			return 0;
+		}
+
 		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if the new lock introduces no more
@@ -3865,9 +3868,9 @@ static int validate_chain(struct task_struct *curr,
 		 * serializes nesting locks), see the comments for
 		 * check_deadlock().
 		 */
-		if (!chain_head && ret != 2) {
-			if (!check_prevs_add(curr, hlock))
-				return 0;
+		if (!chain_head && ret != 2 && !check_prevs_add(curr, hlock)) {
+			graph_unlock();
+			return 0;
 		}
 
 		graph_unlock();
-- 
2.25.1


