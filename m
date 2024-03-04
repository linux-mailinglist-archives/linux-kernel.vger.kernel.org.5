Return-Path: <linux-kernel+bounces-90350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40086FDF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962BD1F231A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CF3717C;
	Mon,  4 Mar 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpekwtjC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D725750
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545731; cv=none; b=maB7Y7J74az1OAldfMwjK8/cFp97oD3oc1DmEEoTEo5yVhdNbsk3L8xvXq7eKdc/bJirBzPCPgy/C+BjMW1Dx7elgLv/JKnm/3LZuexX2FeX/2DGnVSQE8pm38vheN+bzV0g4jCECFny88Mud4e2RqX6IhsKXYciVQycR5wk0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545731; c=relaxed/simple;
	bh=MzMJY9/zgf5Oz86g7Hieae+K/U88BNmCb9J5ynGrUUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um5wek52Sfht0uu+OmSKI/Wht+N3w+FR9U04qiTtaJ9aHrbKPOysfQlfiR5Poxn2H5l0qmBfA/oxwjWQ9F2PlSLlhJrhu9hM0XFMbPFJWNFb3diTHADAxNuFUlHAqvOsJjUSRC7q2eBVMvL5C77XzNWH7j6WpkXH5lHBcIHXhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpekwtjC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5672afabb86so812663a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545728; x=1710150528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyidcM4nXcEaVfVvwbOfTiXrFeqdSr6X/aGwmAepY54=;
        b=IpekwtjCpsKJZSp25TIKYofc1BjLVik0e3LlvD3c1SxFQaK/FNBwjc3jN+Gb0ldkMd
         +ErZe8cCEK/HFwmBdvuuyOribkh35u5ZE8zdTR9in+5ASiLPS3HrLOjsMQcFlBPnHfyZ
         WP6WTOWFxGjZ+133NvhJrf1G7wxoaeCOIx1b+PdGs4fLhzM5YVDrTkv4X46OEgVcHUcy
         iYliXS3y/zdMSmIEkr3gAJwq/2Jg9j07epuY6GfKLj3i3S2c/UmdRJ1lgnFg9L7zpZEj
         cigs6B5lumFsvHL3xoYxYyNzNcIK1PIG9xlpkOLf7AK/IcTlnV+S1jJStRBKyd8kyM6T
         hWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545728; x=1710150528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyidcM4nXcEaVfVvwbOfTiXrFeqdSr6X/aGwmAepY54=;
        b=rmM/1Nve2gd481S6zU7pP/Dwywx1/hyY1qn3BTgbtFE54eFAx8WETp8Xj3/vo61tW1
         b93UgvGJt+5/sgWPwTVECujoeZEEJ90suz0v7Go9NRuKTQVpbUvzv9mWv/GLuXkxirtZ
         bHm1Y+ibhOPuPGW5/0u3FLmPRbb0+1XRa4kI4lIkN5sczQeXhshamCjMmUdCk9xcn2TZ
         sciaBkSXEujxlK8XxGeM+TqLvLoklZwPgydvkKx+fKYFW9B5psD/W1AWx4CbCclWfdH2
         gSDAMGc7hesmeVt7LHF6WAuDkcnu+HdgT4pyuyX5gpw/l93n2S/hGrodiPLIJm7Rf7WN
         Q6og==
X-Gm-Message-State: AOJu0YySCAjhMV8ois7Q4OWnEuJH++SWOcmlVOKCBtsdK+dq6hsKnzL7
	XcEV2ugoUWZ8rhhfPUow7IT08Lwsx+zHc7eHMx0d4cmtxhn9ioU1M4Wgj8Ajdk4=
X-Google-Smtp-Source: AGHT+IGrWu7ee0LRPYL/ogLZoLapZyet5fE/pHJ0/OdMvcuuyaSKS29gsFHD7A6W/DvdQU2UBJTt5w==
X-Received: by 2002:a17:906:d045:b0:a44:4d9b:9062 with SMTP id bo5-20020a170906d04500b00a444d9b9062mr4866205ejb.69.1709545727613;
        Mon, 04 Mar 2024 01:48:47 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 5/9] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
Date: Mon,  4 Mar 2024 10:48:27 +0100
Message-Id: <20240304094831.3639338-6-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two typos:

 - There's no such thing as 'nohz_balancing_kick', the
   flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.

 - Likewise there's no such thing as a 'pending nohz_balance_kick'
   either, the NOHZ_BALANCE_KICK flag is all upper-case.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 934ace69eb30..4c46bffb6a7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 /*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
+ * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
-	 * If this CPU has a pending nohz_balance_kick, then do the
+	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
 	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may
-- 
2.40.1


