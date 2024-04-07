Return-Path: <linux-kernel+bounces-134257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868789AFBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BE21C20F27
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E5111A8;
	Sun,  7 Apr 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx2c2flj"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2E748F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479426; cv=none; b=Czg4VKHOLsOr8EvvzqoGroa7JFfvOT9k67YdS0iB0guYhW8oqoS3+g6pCc/tWRT+SzopUsxxk8jVZ46XZcRWr7sgNWiV0Be2arqlg6QE0+FqTEPLKhTSsBNBKHb1odkhARZFO50WUprWJps7L+nKXOFWs5Xgy0SOrXfjod6XV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479426; c=relaxed/simple;
	bh=Pn/Aq1bf9UcR43Rcp9QKgliQ6+KsPGp/MB4IAgTnEDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mSjYRP+Pmi5RTpfEJMxmbM5IZfaoWZxY/spVO/mntX5PS1BONW/RKvbqe36F2JhzV6Q+IcJAmKtU4JesW10zhQF8/FJabIRcnHPhIHoAojaTgvzoKXPjGqGVS1KV4cIxXVX4KiiN/BrcKUj0IH+/lZitm4m8jSFrerNJJRDxo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx2c2flj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d718efedb2so61831271fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479423; x=1713084223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSqrtmUuhyUZe9f/Zywq2SuZRFreiaDkWRjoQY0iyp8=;
        b=Cx2c2fljglr6C3IMPFkNuQ9QdJUJOY13yhss+2Tg8GzqBqQmia0hv2xPaVG05Wc6F5
         y1uy025In6jeriOTyp9NDVgznIRELD2AwBvEQAS4AQk+QZGUfs40Z9ND7YqpXzH/B4zI
         sHU4cnBkfRo/uqUS6Zy5VqwpMKN+gprHn/1Mh9cpYNrgGiQAHjcYSXKu1I2IwjB4zQ/9
         Np7dvPSqjLySmc+WOY39Z7CBvdjiQ6SFhEFwSDP/nDRhunCubF+1aPLeZyTWG455iven
         ZMeSWdI35/8P0evpYN2ZfWCotVCRarw/A42SUcL4h9YQacVvQuluIUT3OJTyfNN+4I6+
         MOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479423; x=1713084223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSqrtmUuhyUZe9f/Zywq2SuZRFreiaDkWRjoQY0iyp8=;
        b=M7dlYB9RZqOvctexldYJXKnVahAjY/uaOPs6cyt7KbFO4QJxP2W5SJ257OeYtBmg5j
         /4y5mofns7MBfi3ssXMgC1uFAdJHpt6B/iaCzfoHZqaH76WwRS7dd+t1TKmNpdO/5D2f
         vLpKbMEfJ1G5iWBXieYKp7nNqAZzjqGlT60GNvAUJTHB8yQGRcF2Nmwp5CZn9o+NQ0lQ
         P+VJVkmfsqxC885c6mk/4HFwy4OHvPT1+DTMDwOiqh9KeccoOyKoZSGjXok7aehMzNMA
         v7D0/Ags8vFS+9C2OXtsSG0omFb9EwmnAzRS4Vx7lcqhGc7ALD6E7nA9+RW0tveHx8G0
         wj9g==
X-Gm-Message-State: AOJu0YwDeoqRn0H0ufmuGPKh2CDylXGOfAzQMkf6F7wpDGr07VGpW4c1
	PRZ62EsqCdqKxcjFMLyZW9BqHUcm4uc5fgTiwkb7IXxUNHQHekOC/rst0+AJJMA=
X-Google-Smtp-Source: AGHT+IGtHEp4varAT7kxXDjI8B4SOqHfVJ4atAW/JySORRleR4oYz5uob0WsiUe0NBGpEevzU3QTEQ==
X-Received: by 2002:a2e:7210:0:b0:2d4:49d1:38e with SMTP id n16-20020a2e7210000000b002d449d1038emr5746593ljc.28.1712479422465;
        Sun, 07 Apr 2024 01:43:42 -0700 (PDT)
Received: from thule.. (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm2891579ejz.57.2024.04.07.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:43:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] sched: Split out kernel/sched/fair_balance.c, numa_balancing.c and syscalls.c, plus other updates
Date: Sun,  7 Apr 2024 10:43:14 +0200
Message-Id: <20240407084319.1462211-1-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/sched/core.c and fair.c have become a hodgepodge of scheduler
functionality that obscures core scheduling and fair-balancing
class scheduling functionality quite a bit.

Improve it all a bit by splitting syscall.c out of core.c, and
fair_balance.c and numa_balancing.c out of fair.c:

                                # of Lines of code
                                BEFORE => AFTER
                                ---------------
 kernel/sched/sched.h             3493 =>  3891
 kernel/sched/core.c             12067 => 10308
 kernel/sched/syscalls.c             - =>  1691

 kernel/sched/fair.c             13295 =>  5707
 kernel/sched/fair_balance.c         - =>  5103
 kernel/sched/numa_balancing.c       - =>  2277

 total                           49650 => 49765

This is only a first-approximation split.

Thanks,

    Ingo

=================>

Ingo Molnar (5):
  sched: Split out kernel/sched/syscalls.c from kernel/sched/core.c
  sched: Split out kernel/sched/fair_balance.c from kernel/sched/fair.c
  sched: Split out kernel/sched/numa_balancing.c from kernel/sched/fair.c
  sched/fair: Remove NEXT_BUDDY
  sched/fair: Rename set_next_buddy() to set_next_pick()

 kernel/sched/Makefile         |     3 +
 kernel/sched/core.c           |  1951 +--------
 kernel/sched/fair.c           | 13184 +++++++++++++-----------------------------------------------
 kernel/sched/fair_balance.c   |  5103 +++++++++++++++++++++++
 kernel/sched/features.h       |     7 -
 kernel/sched/numa_balancing.c |  2277 +++++++++++
 kernel/sched/sched.h          |   400 +-
 kernel/sched/syscalls.c       |  1691 ++++++++
 8 files changed, 12367 insertions(+), 12249 deletions(-)
 create mode 100644 kernel/sched/fair_balance.c
 create mode 100644 kernel/sched/numa_balancing.c
 create mode 100644 kernel/sched/syscalls.c

-- 
2.40.1


