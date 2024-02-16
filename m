Return-Path: <linux-kernel+bounces-69159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C2E85853B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2541F235CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52727C0A8;
	Fri, 16 Feb 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZFeQVpPm"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1526AD1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108299; cv=none; b=ihA9c7Ell/cuDk8aenrV+APiEr/Sgxzl8ioh5dDf6tbbOnYQSTfGYbaAtXKavVvnj3f+uipSsVcyGmbdJLkF5a600aIilkLz+tTxwwoGQMLZntmyfyISPxbZp7g1YLTTkdCd252P2dDnHKvpFg0Bd0HOZIcWf6kb7ifpgoCZE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108299; c=relaxed/simple;
	bh=jNXUayxdVOBkwWM7+pRIC9YuvsjOYXtBwv1Wh6oI4tU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miHqYGutvZrvquNLixUfhxfwu3vZUMHbq4dGlfIlaQ/a2NulSluTY6p4nltDH8semMGCQs6aKv2qSpWudjHFt60Vau1Bom/4RGen6+yH2RqkrcgdZUx/2sDnnS2GHmkzsrdXgFXQYOmeQnhHAjKTKYGZlOOOnlSRrxkgCwSB9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ZFeQVpPm; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c13410a319so1452238b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108296; x=1708713096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVfu+j4M4dKORd0DGuQdOcQUC+s7DFnphkySbXWQt5U=;
        b=ZFeQVpPmuq4fMKpIhZNEHJqNaQwqSpd2wshNDmAMHxu8MTK1rv97hZxpI6LYLyg6ge
         9OMNAi7nDo26HHaziYrxlZwM9EWHtC9/G+P0/nrxWqrSnRPbqMicH153D3L7AFf5FDtD
         sjlSABivSYAxvJC4jG1MvKDZitMy/LoP0HwKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108296; x=1708713096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVfu+j4M4dKORd0DGuQdOcQUC+s7DFnphkySbXWQt5U=;
        b=ScngDG3mMDd7INzHFapS6DW2939QEH2LIrsy4VL5xORzsOe/mP4UkwfA+FKwxLvI1u
         271gCQARKJ3j7PxpzkqrUkCEmobhcm8GIfavHEbSfrBKPf74sV4Zqvja40N6ODCY/kMG
         f6a1SqwaCdlFrYBzjjkuRW6Ar80yM/7/3RMADKwt1rpEuIuZsDIt1UgAuP+NCoEuVUw1
         7rM0e7L4scGLqj1N+krDs2mMDUXHMB7eP1C2cBxnkUWpJ7CDb9w2x6btCsZYnSf6Y1ex
         jDl20NBpDlGSEC01Zc+Hgih6eEXunPNB1wMJtM/kOayoQThVm5BcJHYSNuwXReMuC+c7
         VHfA==
X-Gm-Message-State: AOJu0Yyf5FPU3BDlBHOSwNj+H9C3HPEdmLBNY4J0IX6H4JoQGkV4CThW
	uK730MWjS1SHlsoERSQVzEQHXagY6zuVVZxPMQ/g7uTJEBKwRercSt7Q1z39jVTab7N8Uok4RW/
	m
X-Google-Smtp-Source: AGHT+IEFj+iOREgSG6dImBuMGADWZbfuc6gcbU2EUF+HGI3Zuumj12EcIk3OfyJ+8FAR0kTrfISsDw==
X-Received: by 2002:a05:6808:1209:b0:3bf:dff4:7055 with SMTP id a9-20020a056808120900b003bfdff47055mr6902898oil.50.1708108295869;
        Fri, 16 Feb 2024 10:31:35 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:34 -0800 (PST)
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
Subject: [PATCH 00/10] Fair scheduling deadline server fixes
Date: Fri, 16 Feb 2024 13:30:58 -0500
Message-Id: <20240216183108.1564958-1-joel@joelfernandes.org>
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
deadline server [1] for ChromeOS.

The main fix is to core scheduling, but we found several other issues.

These patches are based on Daniel's preview branch for v6:
https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/?h=dl_server_v6

Daniel mentioned he is working on fixing the fair server interface issues [2].
These patches apply cleanly on his preview version.

[1] https://lore.kernel.org/all/cover.1699095159.git.bristot@kernel.org/
[2] https://lore.kernel.org/all/091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org/

Joel Fernandes (Google) (8):
  sched/core: Add clearing of ->dl_server in put_prev_task_balance()
  sched/core: Fix priority checking for DL server picks
  sched/core: Fix picking of tasks for core scheduling with DL server
  sched/debug: Use unsigned long for cpu variable to prevent cast errors
  selftests/sched: Add a test to verify that DL server works with core
    scheduling
  selftests/sched: Migrate cs_prctl_test to kselfttest
  admin-guide/hw-vuln: Correct prctl() argument description
  sched: Fix build error in "sched/rt: Remove default bandwidth control"

Suleiman Souhlal (1):
  sched: server: Don't start hrtick for DL server tasks

Youssef Esmat (1):
  sched/core: Clear prev->dl_server in CFS pick fast path

 .../admin-guide/hw-vuln/core-scheduling.rst   |   4 +-
 include/linux/sched.h                         |   3 +-
 kernel/sched/core.c                           |  46 +++-
 kernel/sched/deadline.c                       |  34 ++-
 kernel/sched/debug.c                          |   4 +-
 kernel/sched/fair.c                           |  22 +-
 kernel/sched/rt.c                             |   2 +
 kernel/sched/sched.h                          |   3 +-
 tools/testing/selftests/sched/Makefile        |  17 +-
 tools/testing/selftests/sched/common.c        |  24 ++
 tools/testing/selftests/sched/common.h        |   8 +
 .../selftests/sched/cs_dlserver_test.c        | 254 ++++++++++++++++++
 tools/testing/selftests/sched/cs_prctl_test.c |  74 ++---
 13 files changed, 424 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/sched/common.c
 create mode 100644 tools/testing/selftests/sched/common.h
 create mode 100644 tools/testing/selftests/sched/cs_dlserver_test.c

-- 
2.34.1


