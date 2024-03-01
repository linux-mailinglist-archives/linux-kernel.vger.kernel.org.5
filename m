Return-Path: <linux-kernel+bounces-88426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C786E171
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EFB1C212CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7B3EA76;
	Fri,  1 Mar 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIfJ5ZbX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81E138C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298087; cv=none; b=hKIpeSURoULW0QUJ4vBPQ3AxCwdkBrGUh4DtJ/1q5DUmtYt+k5cRGqt+2dCtJu5syBaCoDPWZJhSDFYkuxUciW3zxJZIQBkuHW8g3srke2q0vLz63mFYwXKZH88uiMps2aXfOSmOJRW34TrnwhFEp8mpULL6mHw21+xLcAvQkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298087; c=relaxed/simple;
	bh=j7zuS8Ij+yXSL/H6z+IvnSI89CpNjyQx4SrLvMxcAMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqvjQAdY4U+oY4axoaabt0s5i7tT4S1O9qFqZR8TC3oi4AxDwEimD3p3kPRHArhw4FGEHkVsQmGQnNHgl7tDijOTxrh/1fOluwikw9ByoS0eltsvi4hDbTircl4jMrQoWDp6rXWd98XPEUpm8kE37hFuPOGZxZEsCEEvdr59WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIfJ5ZbX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dcd0431f00so15242865ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709298084; x=1709902884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOILK422YY1QiwyeOuXV0KdcQ6+z0fm2Teor/xT4k1Q=;
        b=JIfJ5ZbXfBrUVEJHq7o+LQNAFjZ8qsbqNsYMWewOrsxpw2Z/o+Pd8+XbKxdgYTk8re
         0tXbdKGYpePyvRhrjyUOHmM2ccD3OpA2vpOQv9hZikCy3d8h8uMMUI0j9Rx99P48jqa7
         HsgEM3vM2EHH05kPrS5im2XCBquB7xacMFIBTxFg1SCKWTz/QXv34Wuu+qEMvp9zVNm5
         tQ6yKV24gRbOpE5hnu9pzttsTCToM8Nf3m5qwCSqIetIWoRHGPrwqG9933uAsct8PKrU
         fM59fzWTpcyoBLJ37Ad9if4jAIvLn75wyFsSzP2vnhw7L7kXp1dKlWmOjPSqSotYeHJ0
         gRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298084; x=1709902884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOILK422YY1QiwyeOuXV0KdcQ6+z0fm2Teor/xT4k1Q=;
        b=OpVi0g8p1M2sjdfWhzHG+i8c58VxOjsIp0uc9GGJXOwjUYhrO7ZU0Pyx2v0pbkq8g3
         XnKgjfEqr+7/QjZbjvRkgLhrvcqHPcOxXygW8VRZFk43q3wIcuB0Yne7H3GGC45+nyQu
         Nm9Y8odE3J+jcB6PMwGHrji2Su0WrP6l/p/HOlJMfAExjx+YWRa4146OTwfk49hFOQ+d
         pZMmdMgP3kR0XLsxvJuA1d4LVvPb56whUklCiNoAlOrunumYniqUWdlXHEZQkRMuCKb1
         tMZxTGqwacM1QjCDdq09UhixLV8EdyBUlt5B5AQVbxlisU6vFiUHXYMHGi/Fs1R3KUVd
         G3gQ==
X-Gm-Message-State: AOJu0YxYjTTlNZHnfqwiXNgxTFcqSqXrihISmigUsC4KnXJlzN9IGS+a
	NEY2ry8Y3/apdHa5fzRl4JT60TftJHNKesypK78z53xjje7lsDj3ASkoGgFPt9Q=
X-Google-Smtp-Source: AGHT+IHf01swVRh40WtT1WbTWOnRRuGe4TBje44tP0wyirVqhgmIDWo7oT4BXL/UI0C33TWHE6qOPg==
X-Received: by 2002:a17:902:d2d2:b0:1db:f6b0:92d with SMTP id n18-20020a170902d2d200b001dbf6b0092dmr1908146plc.6.1709298084353;
        Fri, 01 Mar 2024 05:01:24 -0800 (PST)
Received: from bala-mariner.. ([167.220.238.207])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001dc78455383sm3372702plg.223.2024.03.01.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:01:24 -0800 (PST)
From: Balakumaran Kannan <kumaran.4353@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	Balakumaran Kannan <kumaran.4353@gmail.com>
Subject: [PATCH v2] Check whether the wakeup task is eligible first
Date: Fri,  1 Mar 2024 13:01:00 +0000
Message-Id: <20240301130100.267727-1-kumaran.4353@gmail.com>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_prempt_wakeup_fair is checking whether the current task has to be
preempted by the newly wake-up task. To avoid multiple swaps the logic
is decided as if the wake-up task is the best task then only preempt the
current task.

In CFS time, getting the best task was as simple as piking the left-most
node. But in EEVDF non-fast path, the entire tree has to be traversed in
a worst case scenario.

So, IMHO let's first check the newly wake-up task is eligible before
searching for the best task.

Signed-off-by: Balakumaran Kannan <kumaran.4353@gmail.com>
---
Changes in v2:
  - Fixed the commit message with proper name and Signed-off-by

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..8d810d6a2cb7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8334,7 +8334,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (entity_eligible(cfs_rq, pse) && (pick_eevdf(cfs_rq) == pse))
 		goto preempt;
 
 	return;
-- 
2.33.8


