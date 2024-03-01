Return-Path: <linux-kernel+bounces-88414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97586E146
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6503287E53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7609040872;
	Fri,  1 Mar 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE8kJxhE"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF77E1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297176; cv=none; b=PMwTDpBIlgAkVxXsZHnkJjlEaybATLzDDtLdW/wUspTIC8xTassg3uKzab6JHAqKkjXOhWNHYTJIBjWAek0a+oGR0MS/ccxIzc7Zb6Ew/nqZNqpoAiwAWonQJ30njxtYRgA5OmIfgIAkJGW2/iUxzmCNtTvLo4P83cPaRRVP8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297176; c=relaxed/simple;
	bh=AZR+noD3l0LO4X6LkzgkiZes2MssLiK0uXwj8oDVL8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnNr0CyYEqB2pCCIu4W0XqBx8SaFh6gOgFj0bl2QNCrmMeKGMhX+knmqnHs8SpHUK0Hf10cKQd3k3QMg8BVrrJJFVkiL+N+AJQ2gjlSR/Sc19Jp9O+JyHjZv2rabKVrFskR8vqDsJqRIZNVAZkneT7URWd0oAxBFJQtt5GeDIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE8kJxhE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5d7f1f15bso28158b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709297174; x=1709901974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2eeFzJsafgYjz1aTeqb4t74nvXWY+dyBVmhOrpXIj0=;
        b=kE8kJxhE+ghRjEca9RTo6vSMAPqY/+yRygLi7vkCFyhIAD1u5G3Pi1RCpXEbAniXjt
         /lVnjBUiCTOH/SJwWWBQvkB9tKKk6wgo3ZbjOLQ0dSllE0Y0JgsnU63cmFHN+42bKRuW
         fyA63kn6bZDFb/iO9sTfr2DqRQC+JbhuYOVobEH5q61u2mmPkyAmxWC3l5A1e3ojDHsP
         1+8RN+26NoOCt6EIGTF5n1TQW9kyw4uViUdRiaF/QxhlE5jP736kWTxb7YZ8ISahpTkT
         okwBue04+geXUwnIT/WuiXutklfzDf5Oa8rvJ1qxtmVpNxloXMOI6YKKHUvJb43Mt+Ik
         3uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709297174; x=1709901974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2eeFzJsafgYjz1aTeqb4t74nvXWY+dyBVmhOrpXIj0=;
        b=b4QR8kZdHaATtihtOmsPZ4r8aykmxMCh5JVq5ALJlV6ANyxdpb1Yvma+L31uF3cOcY
         oBS3swyGUpaTrSM8hGzWLv2Py4Qt8lw/1j8Z7GVRqMZd5ieZFZmlqQ/0glIZO9XDd8nF
         enSDujrc7avtckXsOw5UoMv0JKduNjzUwvFI4yfp1USEaRC5qwO6Vy0FevMtwz0+nuLN
         U7orXh8Hjn5/CFsTg0Yo/9l06K27tpEuG3QoIBkLLNLxQtZ/Ne49tEykpCeGvpdsKZ5d
         PSeLCdOJ+YzuHLfoCrUZf8hGbr5eA0siPftnu0ZJqE22hnM1m4zrBCRjJ10l+9I3wEIi
         u98Q==
X-Gm-Message-State: AOJu0Yz4jnn3TSxrcwnv4KHESvy4DelY7AsGXhx1I1g2zjtStJ9mBdNz
	0A+H3OgiCZmEZTxStpUROBHS5DMVfn11FL2WU5dpoqTCq2UV658omsW3xuVme9Q=
X-Google-Smtp-Source: AGHT+IFJvVDCGYql4DB6oEsPDW/k9KaYZLbUkBNYVRLbF5p/6BFljMicHj4CXssZ0wjwshqrD4gQsg==
X-Received: by 2002:a05:6a00:b48:b0:6e5:af58:20ac with SMTP id p8-20020a056a000b4800b006e5af5820acmr1656806pfo.13.1709297174476;
        Fri, 01 Mar 2024 04:46:14 -0800 (PST)
Received: from bala-mariner.. ([167.220.238.143])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79a07000000b006e5ac1b3c13sm1703751pfj.138.2024.03.01.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:46:14 -0800 (PST)
From: bala <kumaran.4353@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	Bala <kumaran.4353@gmail.com>
Subject: [PATCH] Check whether the wakeup task is eligible first
Date: Fri,  1 Mar 2024 12:45:56 +0000
Message-Id: <20240301124556.248820-1-kumaran.4353@gmail.com>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bala <kumaran.4353@gmail.com>

check_prempt_wakeup_fair is checking whether the current task has to be
preempted by the newly wake-up task. To avoid multiple swaps the logic
is decided as if the wake-up task is the best task then only preempt the
current task.

In CFS time, getting the best task was as simple as piking the left-most
node. But in EEVDF non-fast path, the entire tree has to be traversed in
a worst case scenario.

So, IMHO let's first check the newly wake-up task is eligible before
searching for the best task. At least until the comment becomes
effective to preempt the curr irrespective of the waking task.
---
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


