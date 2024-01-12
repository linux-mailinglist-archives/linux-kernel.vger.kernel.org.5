Return-Path: <linux-kernel+bounces-24483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729082BD43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377E428816F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AEA57301;
	Fri, 12 Jan 2024 09:29:08 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6E5EE73
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp89t1705051522tyz7br0a
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Jan 2024 17:25:20 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: +ynUkgUhZJlWJYfugG9WXGDVRo1HNc7HAavUfj+xVJXenq9uSV3BTSZY0AMuw
	glC0ZXYsPODMGDc3LZkmWwac3A3evU+fsnuR/ZjH797SUbJSaG/85nwUyXEISJwbGiDy/nu
	lknpE2DiK/XXC1iEHTozek2S8MxmKcZb8o8fVIrUwxPycoUKU5LoNG+h7E3x+p1uoxtEzXe
	ZW/u22ux0FbMUg6LRitGhstAxMmnXJP2/awUyAFqwQ3gUieGAmVAuJrfDvomBrAihkpL9FD
	+LDdzIPGuyONuWNCrHwqPRHk6KBc0t3uhJEWTknlojBCPw7fEUdIb83dEQlVotLOYMDUXcN
	4x1NAW0+nvcfi8aspk4EemXV82O2QHkbYEqpH5GdJCdHrpvCM0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3674884271751342367
From: Song Shuai <songshuaishuai@tinylab.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 2/2] sched/preempt: Avoid updating for duplicate preempt mode
Date: Fri, 12 Jan 2024 17:19:16 +0800
Message-Id: <20240112091916.696185-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112091916.696185-1-songshuaishuai@tinylab.org>
References: <20240112091916.696185-1-songshuaishuai@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2

When echoing the current preempt mode to /sys/kernel/debug/sched/preempt,
we don't have to update SC or SK in the sched_dynamic_update() function.

Stop it at the sched_dynamic_write() function.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kernel/sched/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..dafcfdfae23d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -235,7 +235,8 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 	if (mode < 0)
 		return mode;
 
-	sched_dynamic_update(mode);
+	if (preempt_dynamic_mode != mode)
+		sched_dynamic_update(mode);
 
 	*ppos += cnt;
 
-- 
2.39.2


