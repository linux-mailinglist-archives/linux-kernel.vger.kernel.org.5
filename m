Return-Path: <linux-kernel+bounces-17498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A081824E65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8B91F2330A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F8569F;
	Fri,  5 Jan 2024 06:06:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D775662
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40565A0p056912;
	Fri, 5 Jan 2024 14:05:10 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T5t6m0M9xz2NZjcg;
	Fri,  5 Jan 2024 13:58:24 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 5 Jan 2024 14:05:07 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <boqun.feng@gmail.com>
CC: <longman@redhat.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lockdep: Add missing graph_unlock in check_prev_add
Date: Fri, 5 Jan 2024 14:04:56 +0800
Message-ID: <20240105060456.15331-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40565A0p056912

The check_prev_add() is held graph_lock, and it should unlock
the graph_lock before return 0.
But there is one condition where it will return 0 without unlock,
that is:

/* <prev> is not found in <next>::locks_before */
	return 0;

So add graph_unlock before return 0.

Fixes: 3454a36d6a39 ("lockdep: Introduce lock_list::dep")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
Change in V2:
-move the graph_unlock to check_prev_add from validate_chain(Boqun)
-Add fix tag
---
---
 kernel/locking/lockdep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..c8602a251bec 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3178,6 +3178,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 			}
 
 			/* <prev> is not found in <next>::locks_before */
+			graph_unlock();
 			return 0;
 		}
 	}
-- 
2.25.1


