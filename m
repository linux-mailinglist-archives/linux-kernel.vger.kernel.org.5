Return-Path: <linux-kernel+bounces-90345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E186FDF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17202813AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97661B819;
	Mon,  4 Mar 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNDoXLOx"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A6249EA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545726; cv=none; b=qddP/RVSOg85lYCYSBGrQXeBWrMyBiUbrnPUhgEusuOhx3tAw8lIew0Lhs8TcVRyCH9CynbMLtAmZ35Oj/idtI1Qr3qCYtbh7PCSG5Uk8L4Cxo8FD7UwyLHXcJsWIJ+3+FP1J0496HtEql57cJhAAck8KZY+24vNSl7mjPrSmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545726; c=relaxed/simple;
	bh=uR56VaQdyXJ0R8QHE29Lj3rrF/jxHnBRV0SNOGJYrUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoJudtow+PXa7A02DptHMOOeY4pvW5Y85fCB3fNpC0UyHE2HPNdukGtnQT4aSmBRGF8YL44KUg/E8kDpObSzELAe4SWrwrNw6bx7A6bQGtWCCUzydkH4AeYBo/kDvGFDj861yLjxPyWJzGFnSl5c/t/0W4iyAI5eAwLyZcHqqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNDoXLOx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4515f8e13cso116625766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545723; x=1710150523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nZlq0bY/zjZDSiZdaoEBJ6UeMOJDcZiWFNuH0wBv5YM=;
        b=SNDoXLOxOs2IMciC4zUVWv6E41uV/OwhlHWlt+ZZjv0BhOg2qwO16Oq28ep1/aIo4y
         RV8dslsXBhD+c7FLh4HiJqYvbCHZDoihlo7/asYj8iTy4bMfIdDKTPA3vW6+jQk6dDgI
         qwCs244AA+hahtob7YOmdPqAZusi0v26zStJeQ+ipNAsaxgHI24bxT1o1dC7k+G7C+Tr
         XfmTSiap/FUahuNrPpON7xK8jX8nY69YKVjkhqqt/riuN6tGqXavdzCg1R6j0KyA5eCB
         eOJyMQus6vglaHV9pSxT2+1Wzh6RDOtrad8AuKLTDXzQS/Q/4HnwcIjlo7IaU+aJyRuZ
         d+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545723; x=1710150523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZlq0bY/zjZDSiZdaoEBJ6UeMOJDcZiWFNuH0wBv5YM=;
        b=AM7gMrJjkyyAQ09Erfrd5jqXW0808VuGjb/ykUWN9nRsYQe8km6PtO55eqR+6taP7O
         QByWtsJGCLs1Dq5IhgUtfMgTnU2zNABRYXztFLXnuxJLXKDJfkT7R1FUtenMjEcTb6Mm
         tSg0huVh4OOpgKnPURf5IInFTG73AA2hd1a3Fo9UaMgVHoCeZyVHX1anOAYzbued16+k
         auYcsU+XTlCZSpq6bkM06b25KtxGvR+Vd+YuDaD3V9UBrkXTBco97F6EaXfu1h8ODOu5
         aFezMhxdJO3dkVQ4Z2B8D7Md7BugSRW9HJleb9fOA9Ozc7eiK26nW9fr4m5OIgYmLYK4
         lb1Q==
X-Gm-Message-State: AOJu0Yz03rSzP/sT6nmSL5zla+96//WoxacW+OMfmGgXcd5TbVYmMXmR
	455luVmdwPQIVHBumwvDJZOpJP3wkmrqY2tqWyW+OL6Mfs25uHelewSaAxksduE=
X-Google-Smtp-Source: AGHT+IEtfPhd7QtAp8hqjBHXqVrIEYN2r6CfOXgm3TPgGCn6oTpqmFBNET9dH6DVkv71Y/4KpyZ/hA==
X-Received: by 2002:a17:906:7809:b0:a44:19df:63dd with SMTP id u9-20020a170906780900b00a4419df63ddmr5578952ejm.8.1709545722541;
        Mon, 04 Mar 2024 01:48:42 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH -v3 0/9] sched/balancing: Misc updates & cleanups
Date: Mon,  4 Mar 2024 10:48:22 +0100
Message-Id: <20240304094831.3639338-1-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve a handful of things I noticed while looking through the
scheduler balancing code. No change in functionality intended.

Changes in -v3:

 - Fix a show_schedstat() assumption found by Shrikanth Hegde
 - Rename the scheduler softirq handler

Thanks,

	Ingo

======================================>

Ingo Molnar (8):
  sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
  sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
  sched/balancing: Change comment formatting to not overlap Git conflict marker lines
  sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
  sched/balancing: Update run_rebalance_domains() comments
  sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
  sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
  sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()

Shrikanth Hegde (1):
  sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()

 Documentation/scheduler/sched-domains.rst                    |   2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst |   2 +-
 include/linux/sched/idle.h                                   |   3 +-
 kernel/sched/fair.c                                          | 108 +++++++++++++++++--------------
 kernel/sched/stats.c                                         |   3 +-
 5 files changed, 65 insertions(+), 53 deletions(-)

-- 
2.40.1


