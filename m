Return-Path: <linux-kernel+bounces-147857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1718A7A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD064B21BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD058566A;
	Wed, 17 Apr 2024 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eGW5mryr"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09E1FA3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321214; cv=none; b=RfFYOHkrgs4GxBTAQ8aqnI18zgcA8uk8ArO8cfoh1OjqOoIqghnavc1HgGpNf9pFM7N/E3tLyHkXjyL2BMOoI87y35Hrn3EIF/3VU9LZ3FxS5YFcogj/lnhM8Em52JHdUHnfgPgK2bFs2mqT6/9qsZiQmcdsgYC1ZzQV6gaKt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321214; c=relaxed/simple;
	bh=FhjVDRLD7ruijDpi6M0nx+1/+GQfdCBJ2txr6s3zGMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t2sbLC+AOPAReOIgl/2WH7ysFOi3uoGrV66xQ82s9I2GIy9vrNHX2DPA053/1FLdMZxOij/zvnFrC3o6SlsEp00xPTfFVb9PruQHz5frsg+uK3hkzz+FH+Od83UI9wmF3V5fb7yLqG3yHh5mRAJbQS2kd+c/9syqc/DkGVciz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eGW5mryr; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713321204; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/QB9KOe9fOOrxWFAdrp0BBQcosnlwxzNgoV2+zG95vI=;
	b=eGW5mryrTIvf0ebkSx9243yM6EJwVJaNRObOCwqMaY8NLywukUBlol/U2zaAust/6XaTamIpKTyzFdZ3wjXfb2vesE/Z1CGz5NUAt1otIV7ScgAS7oJqlMUqzR1GsOlbQnjP+MP2qbcKXpiFCeE5Eh2oL/KmhkfwJLtr8oa1aFM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4jfAcv_1713321197;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4jfAcv_1713321197)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 10:33:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] sched/fair: clean up some inconsistent indenting
Date: Wed, 17 Apr 2024 10:33:16 +0800
Message-Id: <20240417023316.79470-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

kernel/sched/fair.c:3331 task_numa_work() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8773
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 21af847c13cb..9951777dcdf1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3328,7 +3328,7 @@ static void task_numa_work(struct callback_head *work)
 			 * to prevent VMAs being skipped prematurely on the
 			 * first scan:
 			 */
-			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+			vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
 		}
 
 		/*
-- 
2.20.1.7.g153144c


