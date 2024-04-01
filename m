Return-Path: <linux-kernel+bounces-127188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577888947DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62671F224B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C757306;
	Mon,  1 Apr 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGrDmcbR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775C53E01
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015089; cv=none; b=seWLJs+xt1aBpmWVtNUpJx2OfCTjn+XpdkgSYY5knQlDDYOVVAu/WYCTbm0TTYz3UjngNPzCDpUm2/++GdsK0OWIqxdgMBLoB1KmW/WFRhvoXkkTKL7t20w2yOUTIWR8hkzBFLtximmLKOwWv/wXS0vbX5LaATmQAkhGYiMvJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015089; c=relaxed/simple;
	bh=2Q15qKU4TEk3paDcBQEqu5RL2NNjLMVfcFI+46qxhTk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SAkzTpMF8t/IGGoQazhYA3CiO+R1qBBo/whHUDxFQTPpcBwnbYGabE+AXQ3oAuS40qr/Y4cOaO/rniZjWwRAShnUmKtQE/iBaBlD1sRzyW0z3yWAvN9I9+MgvB9TJNr/91o2o+emttQ8L6N3k3y7vdG53t0QCgTiJjFtUgDUSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGrDmcbR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29f96135606so4515194a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015088; x=1712619888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEVaGV6VpFFIL53obHhICqpjp2JWfn58K0aMuXZWdFk=;
        b=GGrDmcbRfrv8omB21y24LM5HVxw0/rIQ9N+xM5THDjwjjjcQJ8HoMVxgKS37Qpl7es
         wHV5BCMDhRyx0HWzlvpEmjP/J12CJVrwqAqBJ7lSxvYb9+gqCctQm6IQpqESZHN/iXvK
         kKBH67OPhfOEYQQOR42KIoqSro6GvWvNZ9b5UECktUS3uXzhHQ4sxvG1DtEhQ4QlS/Ow
         rwvgTiE4QSh4G6dEwoGpsIGkLbfNSRWc2Sz6lvYRPwZErkOhw3d//RU/JuSi2OYd5TvL
         zw35i+iGr1mzDfgDwnskVaDRE/YYn3gPpWGZsbkGrnHJaWM5O+GTObZje0pV9bmPod+K
         crjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015088; x=1712619888;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEVaGV6VpFFIL53obHhICqpjp2JWfn58K0aMuXZWdFk=;
        b=kbZBpn6DeFAtIW7QLa2dCmEahAHI36yl0nqFw1/XsM+UkI1ak/tTGBcLWqa7QtxScs
         Z4QzYW34aNy7Titq0H51yuv1saex8GMk3G/2fwfJeBh4NenO4O9c2Pd3QOS9WREpFcnL
         7jUl7n5V4404lpuckeHmG5ofS8kv1M9Ju7sc15MYefi7A9kNCZzZ7t9PS2tZ+FUkV4T0
         9SIr4VWOj3VxlYRZs0WgyIj09EuCtSXPoDVmKZRv1tWuvkOX8c9ur1jHfwC4kSBMhiGy
         Bh1PISyHSyS5+7VirkeHT1qahVBaBb2eT715vyQ9wzvRKMoTyCuZ2vx/9kFJj/9obPKi
         H7ug==
X-Gm-Message-State: AOJu0YycI2FHGEOEZ+gg72GaKKXHoQzuTO/zoCB6JMTXhs5+vJLGp0Cj
	OpLebU7fsTo0OdL1hmrLURwxPF/PQJ8V4cE9p8QhfnZ8Dso0tggBfUST1S2IbI5hnAQZ8S88Y0H
	9m7z7Lg0zzIAwrTkzcrIBFdTOH2Ipvf7DLWIOIs6Y7pYC4XkIa+EebFph1rqjR23ZMkEbpQLOOM
	ZWQWTmrA1xyWpLzZwYtsVRHtm436wjslGMUdrwG+dyTzco
X-Google-Smtp-Source: AGHT+IFDuT4AcPPdsC7N8gp4ZjDJAAG4CWaLlM3+vMAPSRV9K5J2tmusMipEMTUVzjSaOkcjPVeXzooHSvfG
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:124e:b0:2a2:313e:e2cd with SMTP id
 gx14-20020a17090b124e00b002a2313ee2cdmr22090pjb.9.1712015087219; Mon, 01 Apr
 2024 16:44:47 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-1-jstultz@google.com>
Subject: [RESEND][PATCH v9 0/7] Preparatory changes for Proxy Execution v9
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
can start to merge the less complex bits and discussion can
focus on the more complicated portions afterwards.

So for both the v8 & v9 of this series, I only submitted those
earlier cleanup/preparatory changes (note, between v8 and v9
there were no changes to these preparatory changes):
  https://lore.kernel.org/lkml/20240210002328.4126422-1-jstultz@google.com/
  https://lore.kernel.org/lkml/20240315044007.2778856-1-jstultz@google.com/

After sending v9 out a few weeks back, I=E2=80=99ve not heard too much,
so I wanted to resend this again.

(The only changes here are that I've added the Tested-by: and
Acked-by tags I received & rebased to 6.9-rc2).

As before, If you are interested, the full v9 series, it can be
found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.9-rc=
2
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v9-6.9-rc2

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
2.44.0.478.gd926399ef9-goog


