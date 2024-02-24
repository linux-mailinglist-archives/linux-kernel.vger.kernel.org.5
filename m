Return-Path: <linux-kernel+bounces-79343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3F86210A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E41C21427
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAD623;
	Sat, 24 Feb 2024 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR5l5cgI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555119A
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733524; cv=none; b=DzqfVl5oFkazuicYq8NqcvaTJErTmB5clKsWiAUmvf5/oRK57zkFBF41Z1mjDHOsch4TN9FZM2XcrxFYK7j01/JDvcIHszmMN5xozumIYbeQYZb6A9YUf42qdcoqS4BJVweNPXnKN9pnfpuE3z8kPH4FNIaRwCX13NVGMkjyuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733524; c=relaxed/simple;
	bh=LPpWgJSNSUqkMM+2TmoJV0u8ewrDuMwgqkHvBe+r8S4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BNfbEUil8zQB67wYJfPndhHJytg7nKzUrEeJQViXWrBo1cmLwcAciprPSQ+54mVuBkzX0nmZWmRtrzfWTA8y9CDMmNtrKuCfODdae9Tl6C3v4ccYmB0/xi1UYGW8EN/kP55Lh6ssAirlLzZgEFMcBRfXR0DTYiSQJ3hcCMM/hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tR5l5cgI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso20720857b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708733521; x=1709338321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPtJcJCeMuVw6r9hInSrqVQWf5ePSY5D8abyGQm8sgg=;
        b=tR5l5cgIa/OVCxSJfEyITQCjBe5/A6AhPCgbHVq/nmtEBZ/T2zoyaSOXrR4d7hB9Zg
         e3RSSCinCrKTOmC7h1oH2f3hJ7fOm70VPayNW/SJUIf+JYiJ0J7mIofzjOgLdmnY9QSL
         imD5vvE48xQEVThRaTwkE5Xv2O9pJBQHNRk9ZwwsC0iLc5s5KtC/ZPzzhjaYGKrAQMGR
         odtEXHQbkbxtstvmqmkL7OOC0uS5nxOEiCOS0F4jPt9heGAFOc77ZR+fp7vlZ+adMZPf
         VttzA+8apAKhWAIydL3sfaO9TUZrFZcljw6Uq/M7rUUy7fcO2Y6CDpdD2S82HfHG8J20
         iEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733521; x=1709338321;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPtJcJCeMuVw6r9hInSrqVQWf5ePSY5D8abyGQm8sgg=;
        b=savypUIFJSIclqTgq83Lbeg1YDy53T5amBKj9b2/WPc7gPs6AAs0mu8tsn8+2alD3r
         VAqXapXA8un4bv8glnGJ+cIMnFx7AhhCybeNO1sfJA5+P7OMEb4JyTKvMcUZuz+ZjcW/
         04FllPvGH/hXY7EKiafaEqNR6MgwGK/LOePRxCqt+/bYTMdKfu43zo5Y8rj1sziuW+SK
         YTrl4dMhdYcBhdh9gfQMBeImCym8XsA9P0XI26PIBfsH9ijhnbkWm4Ywfu6395BkoVgD
         7kBaZYKnslalahYRVe6jv7iXscX/KF/MzZF2uUXiIYS0eIZ/6Sz/LZAGZyA5uMR8IbMN
         DO0w==
X-Gm-Message-State: AOJu0YwWaLP80Ff93L006QmfagQ9kp6KvkwzY2E97EGRJG4v6hAxedha
	GV0bMvFzIcitFEvHNH2LhKNFKenR6tK9SY7ZYxwMhOqvXdH5PKWD9VygsvjBrPFu/6KKTISDnS8
	yRVHsEVmzih37+Gro/1ZwdtF9dLMpIhs/eyaLRkN7HIx0DiRcku23vHOfRkZnP45gaYfbpM7R0q
	M2zDJJz5Sz5KbQKgpljgg6pNr+MBb/QCn5ahw+2t3ueOII
X-Google-Smtp-Source: AGHT+IExW4hKgXb8tbamRGKxaHYr1dy4dYvhrJgIzYGytHyGwPkdjVh85U14jNkiAIx4fcgBgoRkA7iQdMz/
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:98b:b0:608:53ab:73fd with SMTP id
 ce11-20020a05690c098b00b0060853ab73fdmr345805ywb.2.1708733521595; Fri, 23 Feb
 2024 16:12:01 -0800 (PST)
Date: Fri, 23 Feb 2024 16:11:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224001153.2584030-1-jstultz@google.com>
Subject: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After sending out v7 of Proxy Execution, I got feedback that the
patch series was getting a bit unwieldy to review, and Qais
suggested I break out just the cleanups/preparatory components
of the patch series and submit them on their own in the hope we
can start to merge the less complex bits and discussion can focus
on the more complicated portions afterwards.

So for the v8 of this series, I only submitted those earlier
cleanup/preparatory changes:
  https://lore.kernel.org/lkml/20240210002328.4126422-1-jstultz@google.com/

After sending this out a few weeks back, I=E2=80=99ve not heard much, so
I wanted to resend this again.

(I did correct one detail here, which was that I had accidentally
lost the author credit to one of the patches, and I=E2=80=99ve fixed that
in this submission).

As before, If you are interested, the full v8 series, it can be
found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v8-6.8-rc=
3
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v8-6.8-rc3

However, I=E2=80=99ve been focusing pretty intensely on the series to
shake out some issues with the more complicated later patches in
the series (not in what I=E2=80=99m submitting here), and have resolved
a number of problems I uncovered in doing wider testing (along
with lots of review feedback from Metin), so v9 and all of its
improvements will hopefully be ready to send out soon.

If you want a preview, my current WIP tree (careful, as I rebase
it frequently) is here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-WIP
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-WIP

Review and feedback would be greatly appreciated!

Thanks so much!
-john

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com


Connor O'Brien (2):
  sched: Add do_push_task helper
  sched: Consolidate pick_*_task to task_is_pushable helper

John Stultz (1):
  sched: Split out __schedule() deactivate task logic into a helper

Juri Lelli (2):
  locking/mutex: Make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (2):
  locking/mutex: Remove wakeups from under mutex::wait_lock
  sched: Split scheduler and execution contexts

 kernel/locking/mutex.c       |  60 +++++++----------
 kernel/locking/mutex.h       |  25 +++++++
 kernel/locking/rtmutex.c     |  26 +++++---
 kernel/locking/rwbase_rt.c   |   4 +-
 kernel/locking/rwsem.c       |   4 +-
 kernel/locking/spinlock_rt.c |   3 +-
 kernel/locking/ww_mutex.h    |  49 ++++++++------
 kernel/sched/core.c          | 122 +++++++++++++++++++++--------------
 kernel/sched/deadline.c      |  53 ++++++---------
 kernel/sched/fair.c          |  18 +++---
 kernel/sched/rt.c            |  59 +++++++----------
 kernel/sched/sched.h         |  44 ++++++++++++-
 12 files changed, 268 insertions(+), 199 deletions(-)

--=20
2.44.0.rc0.258.g7320e95886-goog


