Return-Path: <linux-kernel+bounces-96881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7887628F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2F61F24D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DE55E6F;
	Fri,  8 Mar 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSogPcg0"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2B5577F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895558; cv=none; b=PdEDyu88qab61JhX3FgT45ghyeGctut83VuvgU+bVLZ8s4rxg52ZTuKZVWpb4d202OGi0D35RMt4WWcU8+odAPBL78UZ9dA/KVU31jow1h9BtiA78q8fLaNV+D1XDlt8/0/khY8diydnWJTrPU1u5etxLFtmv0szwVMHcZShmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895558; c=relaxed/simple;
	bh=8uKN17tChLLcjDRGC147sf1KRTEmRbskDyS1Pa5JRJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ym6tz1Id6SP6ZleJU/wII2nZpaWlEeqOP9Uy1OAPw1B5M3SQ8Wb8V+XR/TDEINuZhhfaDZEyUg9F5eQCuJcVBhvQh/U2q7uDvFf59L2IxKVrZ9NuT0oYD3aYTgGEX2Te0BoPEDTgwDqWUDyw6inKoNrz4MuXsz9WtGF2olH7P/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSogPcg0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3f4fef377so25643811fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895554; x=1710500354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cXUYa1i1leTPNo3lpu0cyAI33Y6OlWwEUI1tp05/Ppg=;
        b=nSogPcg0W/FmQ1ILownHobFz2N8SShXtqxq4Df/bh7Qoh8a22TMVJ8WnYcJrZ3//ej
         MLAlXVTZH+vPP1l5NFVU34kpd9my5tGZCxR9ldGjJMp3p5LJIqAWEJOKXbYX+eR6XPh8
         HVB5W9xpopyN6TZ6rWW5DZ1PO4XFgdHz2Y8R4vbKyf6O54rcDmHbwU29NpuyVzwF3qjN
         Zz6H0zZgmbfRu7Z1TRgyd22EGeVr3AsQXK9SpHzlq2kltK2UlgjvYWVKyWQC8MQedYh7
         IztJuvOaClzG3E2QNS3wBQBRUtqP7UZB0IiS5MY9QlQbTP91CFVZQMnZjQrtPszm45gy
         dHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895554; x=1710500354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXUYa1i1leTPNo3lpu0cyAI33Y6OlWwEUI1tp05/Ppg=;
        b=nn55cXT4fFWCU1C5+fVWTYUe04iX88w6UvVvh5U2FTDe/f5QU+JCaa3Za84DZDHJVv
         6w4IyRE08Yv3qB+I7Rm74OEA8YuSBMHhevkjvrwpp4nSvhaHVFunnJMn8r+/1kuUVQX5
         k9CVbZ/e+jp+8He+JLI9v/SJFMp8jg3USIvEV0zvZydTTcWtBBn/X4ZmEwafRM5bfElf
         vFTcebl6q9boPfbOEHJXtR3yxi7WbS6fArqf8ML9aJy8+R7lAxE+WbKAc6rdue4ZfEW+
         trraLHzeCUU/03gi7pPwRr/kkU/sVVzevY2VUEnKshto0EP79sGvx5VZbuLAwnmYX2J7
         x9eg==
X-Gm-Message-State: AOJu0YyxcxyKSMVAbRrM8Hz8ShKbpqV6Az8/2ahgOSUNLD/j5M0gOffK
	8yBa/yv0JisCcqP6vO7Na1pScquEveHHcQICJXfryBsh0D6PxB1ekjS762WhM7w=
X-Google-Smtp-Source: AGHT+IHzQlc0VCFTjHOYxh2RRupNoYpsOBtMcfww5k5aKaFunGwNXa8KivWSpsdxMXtiIlqnixQr2g==
X-Received: by 2002:a05:651c:1a24:b0:2d4:22d9:b016 with SMTP id by36-20020a05651c1a2400b002d422d9b016mr237249ljb.6.1709895554308;
        Fri, 08 Mar 2024 02:59:14 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:13 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH -v4 00/10] sched/balancing: Misc updates & cleanups
Date: Fri,  8 Mar 2024 11:58:51 +0100
Message-Id: <20240308105901.1096078-1-mingo@kernel.org>
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

Changes in -v4:

 - Incorporate review feedback
 - Bump SCHEDSTAT_VERSION to 16, due to the changed order of colums
 - Allow CONFIG_SCHEDSTAT builds more widely

Thanks,

     Ingo

==============================>
Ingo Molnar (9):
  sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
  sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
  sched/debug: Increase SCHEDSTAT_VERSION to 16
  sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels
  sched/balancing: Change comment formatting to not overlap Git conflict marker lines
  sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
  sched/balancing: Update run_rebalance_domains() comments
  sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
  sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'

Shrikanth Hegde (1):
  sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()

 include/linux/sched/idle.h |   2 +-
 kernel/sched/fair.c        | 103 +++++++++++++++++++++++++++++++++++++----------------------------
 kernel/sched/stats.c       |   5 ++--
 lib/Kconfig.debug          |   2 +-
 4 files changed, 62 insertions(+), 50 deletions(-)

-- 
2.40.1


