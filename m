Return-Path: <linux-kernel+bounces-101000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AD87A0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE251F23A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D8AD25;
	Wed, 13 Mar 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oOT4oJiA"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34D9444
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293106; cv=none; b=aM2UVljLFu0PPxZnIsv9k84E8A0UjgL6nYY8zTw5UJa6WG9BdSRlpF0wyNoE3gBRoGKJMRiBZm5Z/9mcE5gE/szU6nmRCpDR6JhXMaEmsPl5oUwDPpoXXKlOUjYk8Gs4IgT3+eBOPPaOb5jN9SMjgBioYwYYXzUQ4Hk+76BVZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293106; c=relaxed/simple;
	bh=Xed/+9vg1uBq89mAGM6jEwgHU5GzFADJaBvpXtl+8Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tsKhJ1ZIYqrdzaGCUVWx3dptQQ1XhxYnEE2jnfedMDpcDMgXzc3DaV3lZXs8ab+KQXbCj+ruBwGiymdptHnh1JGHonogm0n/RHsrII+3OUWIhGGgKM1j2jWV5W34/Zre5Wf+8gCjhVXjHK0WJKVtsFO96QC9Apv+aII8NWOn14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=oOT4oJiA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f41af71ebso4403086d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293102; x=1710897902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrJDkOKo1+JZZr4ZI11hsRHjr+5I0fR2jTuSqQPTPac=;
        b=oOT4oJiARDLgSJnrgyLtsdTTrGWqD5zztJ32Q3D5qFLWyLlykvMtoJ8pi0EpPs5Owp
         YQVuDYoFhP1GSy5/BCM/Y2BZVqVZBIZpjqwyFqvmvvpfciwzOVHayhbSCFV3nc5Ju8iO
         ObUIapMWZ4e0ZNUxwptXTYQVTbs+42diQBkiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293102; x=1710897902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrJDkOKo1+JZZr4ZI11hsRHjr+5I0fR2jTuSqQPTPac=;
        b=aNVffrfD4XEigaeUapE6nn0A51TnEg7zrwDpyWH1mlNF/3p0g4N6oKuGkeoCXX6PKU
         S2SbQpRO5VlsPokCyEMxlcPue48/VVhvvy2HJVTIlFACY/AGGM5SjEF3QAcEQzqYS4mK
         dFHSXflyykAiThXTXx2gSmUlEzfVR5PFGkIVke/U0z5fS+UgcoXEQwQisy6UG6LBi8qb
         FHnYXCU9GJhwOoB/grWjgYc++UxpnPjX3eEA9V89b2B2nRXYS/yoyxoYut3UQgpVFqX9
         X1RMVlJNWb0VEtYHEH3x7fQDOkWm/46eDYb+BhtLKmTonbmNBcfhB0zGEmGRi4Z8qk75
         sPHA==
X-Gm-Message-State: AOJu0YwZTwNglAccRgrXvl3ujJdDRwCrXlkfAyVyvUbUYVBq6Pm8KKa6
	/9kQCqXT5V2v18MspfyTc28450NCHB/NU674PpqT+R2h4E5wbdbLsRXLXLU0qZL2OW0TBV9ekTv
	Y
X-Google-Smtp-Source: AGHT+IFU3RRHOiD/YGsC/rGevZ/XrSch/6/oMTX54MWBgiEZfe1b3H+4MHGRznr1iS3mYTt9iwwDDA==
X-Received: by 2002:a05:6214:15c1:b0:690:df46:2ebb with SMTP id p1-20020a05621415c100b00690df462ebbmr2149499qvz.56.1710293102324;
        Tue, 12 Mar 2024 18:25:02 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:01 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 00/15] Fair scheduling deadline server fixes
Date: Tue, 12 Mar 2024 21:24:36 -0400
Message-Id: <20240313012451.1693807-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The deadline server [1] allows RT tasks to run on a system safely, while not
wasting CPU that RT tasks may not get on an idle system due to RT throttling.

Here are patches that are mostly fixes that we found while testing out the
deadline server [1] for ChromeOS. It snowballed from 10 to 15 patches as I
found that my unit test was breaking, and then we also saw some crashes in the
field related to the dl_timer! All of that is fixed.

There is also a fix to core scheduling among several other fixes.
Appreciate a thorough review. I kept all the patches on top of Daniel's and
Peter's patches because I will let them squash it with appropriate attribution
to the contributors.

These patches are based on Daniel's preview branch for v6:
https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/?h=dl_server_v6

Daniel mentioned he is working on fixing the fair server interface issues [2].
These patches apply cleanly on his preview version.

[1] https://lore.kernel.org/all/cover.1699095159.git.bristot@kernel.org/
[2] https://lore.kernel.org/all/091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org/


Joel Fernandes (Google) (12):
  sched/core: Add clearing of ->dl_server in put_prev_task_balance()
  sched/core: Fix priority checking for DL server picks
  sched/core: Fix picking of tasks for core scheduling with DL server
  sched/debug: Use unsigned long for cpu variable to prevent cast errors
  selftests/sched: Add a test to verify that DL server works with core
    scheduling
  selftests/sched: Migrate cs_prctl_test to kselfttest
  admin-guide/hw-vuln: Correct prctl() argument description
  sched: Fix build error in "sched/rt: Remove default bandwidth control"
  sched/deadline: Mark DL server as unthrottled before enqueue
  sched/deadline: Make start_dl_timer callers more robust
  sched/deadline: Do not restart the DL server on replenish from timer
  sched/deadline: Always start a new period if CFS exceeded DL runtime

Suleiman Souhlal (2):
  sched: server: Don't start hrtick for DL server tasks
  sched/deadline: Reverse args to dl_time_before in replenish

Youssef Esmat (1):
  sched/core: Clear prev->dl_server in CFS pick fast path

 .../admin-guide/hw-vuln/core-scheduling.rst   |   4 +-
 include/linux/sched.h                         |   3 +-
 kernel/sched/core.c                           |  46 +++-
 kernel/sched/deadline.c                       |  87 ++++--
 kernel/sched/debug.c                          |   4 +-
 kernel/sched/fair.c                           |  22 +-
 kernel/sched/rt.c                             |   2 +
 kernel/sched/sched.h                          |   3 +-
 tools/testing/selftests/sched/Makefile        |  17 +-
 tools/testing/selftests/sched/common.c        |  24 ++
 tools/testing/selftests/sched/common.h        |   8 +
 .../selftests/sched/cs_dlserver_test.c        | 254 ++++++++++++++++++
 tools/testing/selftests/sched/cs_prctl_test.c |  74 ++---
 13 files changed, 456 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/sched/common.c
 create mode 100644 tools/testing/selftests/sched/common.h
 create mode 100644 tools/testing/selftests/sched/cs_dlserver_test.c

-- 
2.34.1


