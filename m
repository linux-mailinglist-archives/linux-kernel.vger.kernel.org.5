Return-Path: <linux-kernel+bounces-83723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72851869DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B82282A26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534211419B3;
	Tue, 27 Feb 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Vonsz9"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BC4DA0C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054938; cv=none; b=DQgOLhMQIIZI1BECikOef76WOiXIfcY2ALwV4kZHC/aA+T4fVoRcixd9LIh0q1kjJBq0jhIcHWt+6Jz2Fmqs+1EDEODTyBNfUKgy7cHkk3NvFfpfcrldgFas84+iJiVD7wAH9ALq/Zt2HIGaWRBWoq5ZICXVAZihmJuj0hml6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054938; c=relaxed/simple;
	bh=rpzx05MEe2C5jbCRQ2zuVzxgklHLvFcFJN75I/4Pmvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3/0uyLkPWKIJgpNx5QEgSRhYGWUvyjM/73Bq6bT9PEHW8ymd4HniQAnRoHjDjt2F7hahVeR8tx/kF2PRNWbaeJaPT+PxNTu4/Dq2TAkMXlgJbjHB6s+jkwg7ZLn3ybHfNreeCiy6DvQ0tU+CuBO8imMG40uhbx8MRzeL/anIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Vonsz9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c19e1846ecso1480546b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054936; x=1709659736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gNPtIoL06oeeYpXkg6N4H09fhaAtL5qc0i96Ce3R3Cw=;
        b=c5Vonsz9lhcVTdefDYfuoMbXVGM4XZr4TJwPVJFYVPfZoit9fe1xPB6XxuOKOHkMO6
         /9bMxdlkgqQ4ppv74paBl8kR/4PZE3Ij9o3OaEAVNlSRPobDHX9+dXv1hc2xNj5UNngJ
         Fo0xkdHPEOriH2WZEw+Yz1frHBMttZUF4Ut5Uc2eyf45n9KyeUgDv4c60djAB8LcZL7x
         6l3N65KQTFuvlTG2i3wdokvr7IzBY1cf1tckBWU70sqfFpXSk5OXaTz2ndECxhwaWWMV
         k+YBKSvLCo+xnwdyDGKCdD1r3xkp66m95W2Hn8MpKyEY2AWx3RPjDbYE7PthrfCuI4pC
         oQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054936; x=1709659736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNPtIoL06oeeYpXkg6N4H09fhaAtL5qc0i96Ce3R3Cw=;
        b=Q4+q645zSKyOfbpuyxGGKP+T6kWPow/cbFklrYWMaElQvps6/txR+eK5XrEmG9cXMW
         l70AUle9C2gWsBj2c1c1aaCg64lC3762eFiiXeiRfVY3Dmz3RY27DTTarYznugFm5jUY
         Mod96C9KXTgE49ZwbHXyNK/K/D6xyrzFlSWgwLxQsFldLQi19vSsa3e0+0ktGXMiyxAv
         sAq4wrSt+zuX044zt6Y/fdZJHLPByQiFscLBUM0qt1SjJgyXzn1aLm9i4b4s5mNJIV0O
         ar8rAI1nXgdvEcr8Hi2buVT19koAFuNLDl3dub71i60C7goiPvwbMgRYjLhaG9csri0t
         wjCw==
X-Forwarded-Encrypted: i=1; AJvYcCVetUtpgEjVjQiB8nUjwfWxF7Yy+huQc6Vl+kGox7RsIsK+9Rj1SVZHEz3CciTsYYRfusxWNFvGM7zqGeXAk/J9EkxSbeIbkB6JpxTm
X-Gm-Message-State: AOJu0Yxq4bXq2ZWXQLM/4/SvvORpu+bx/Yb2+WS3y3/NEgtcG+6F3Vc7
	2mayeliCDa/t7WtHYiXpcEoebHhpSOZeISrRsafrKGKSn8jjZCeN
X-Google-Smtp-Source: AGHT+IFopm/BO2YRLzUATVX827DquINQUK6lem9gxkTvzJJ+aO3LiboQ11gaQlUI55c04kp3dPzCjg==
X-Received: by 2002:a05:6808:14c3:b0:3c1:8412:e9d1 with SMTP id f3-20020a05680814c300b003c18412e9d1mr3506029oiw.31.1709054935576;
        Tue, 27 Feb 2024 09:28:55 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id h14-20020a63df4e000000b005dc4806ad7dsm6137182pgj.40.2024.02.27.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:28:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org
Subject: [PATCHSET v3 wq/6.10] workqueue: Implement disable/enable_work()
Date: Tue, 27 Feb 2024 07:28:11 -1000
Message-ID: <20240227172852.2386358-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes since v2 (http://lkml.kernel.org/r/20240221174333.700197-1-tj@kernel.org):

- enable_work() was incorrectly using local_irq_enable() instead of
  local_irq_restore(). Fixed. (Lai, Boqun).

- In __flush_work(), instead of usring the pool returned from
  start_flush_work() and testing it to tell whether the work item being
  flushed is BH, use the work item's WORK_OFFQ_BH bit. This is safe because
  the test is only need when @from_cancel is %true and we know that the work
  item must be off queue and thus its OFFQ bits are valid at that point.
  This makes the code a bit simpler and makes
  0005-workqueue-Update-how-start_flush_work-is-called.patch unnecessary.
  (Lai)

- There were discussions on whether we want to name the syncing variant
  disable_work() and async one dsiable_work_no_sync() instead of naming them
  disable_work_sync() and disable_work() respectively. While there are clear
  benefits in doing so (continuity from tasklet interface, shorter name for
  something used more widely), there is also the clear downside of breaking
  consistency with cancel_work_sync() and cancel_work(), which the disable
  functionality directly builds upon. I'm still leaning towards keeping
  things consistent with existing workqueue interface but open to listening
  to arguments, so if anyone has strong opinions, please pipe up.

Changes since v1 (http://lkml.kernel.org/20240216180559.208276-1-tj@kernel.org):

- Added missing disabled checks to queue_work_node() and
  mod_delayed_work_on(). (Lai)

- __flush_work() was derefing RCU protected pool pointer outside
  rcu_read_lock() section. Deref and test inside and remember the result.
  (Lai)

- queue_rcu_work() doesn't need a disabled check as rcu_work doesn't support
  canceling and disabling; however, in case users reach into rcu_work and
  invoke disable on the embedded work item, add disabled check to
  queue_rcu_work() and trigger warning if disabled. (Lai)

- The first ten cleanup patches have been applied to wq/for-6.9 and dropped
  from this series.

4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace
tasklets") implemented workqueues that execute work items in the BH context
with the goal of eventually replacing tasklet.

While the existing workqueue API covers the basic queueing and canceling
operations, tasklet also has tasklet_disable*() which blocks the execution
of the tasklet until it's re-enabled with tasklet_enable(). The interface if
fairly widely used and workqueue currently doesn't have a counterpart.

This patchset implements disable/enable_work() and the delayed_work
counterparts to address the gap. The ability to block future executions is
something which some users asked for in the past, and, while not essential
as the caller can and often has to shutdown the queuer anyway, it's a nice
convenience to have. Also, timer grew a similar feature recently with
timer_shutdown().

- tasklet_disable() keeps disable depth so that a tasklet can be disabled
  and re-enabled by multiple parties at the same time. Workqueue is updated
  to carry 16bit disable count in work->data while the work item is not
  queued. When non-zero, attempts to queue the work item fail.

- The cancel_work_sync() path used WORK_OFFQ_CANCELING to synchronize
  multiple cancel_sync attempts. This added a completely separate wait
  mechanism which wasn't very congruent with the rest of workqueue. This was
  because the canceling state was carried in a way which couldn't
  accommodate multiple concurrent uses. This mechanism is replaced by
  disable - cancel_sync now simply disables the work item, flushes and
  re-enables it.

- There is a wart in how tasklet_disable/enable() works. When a tasklet is
  disabled, if the tasklet is queued, it keeps the softirq constantly raised
  until the tasklet is re-enabled and executed. This makes disabling
  unnecessarily expensive and brittle. The only busy looping workqueue's
  implementation does is on the party that's trying to cancel_sync or
  disable_sync to wait for the completion of the currently executing
  instance, which should be safe as long as it's from process and BH
  contexts.

- A disabled tasklet remembers whether it was queued while disabled and
  starts executing when re-enabled. It turns out doing this with work items
  is challenging as there are a lot more to remember and the synchronization
  becomes more complicated too. Looking at the use cases and given the
  continuity from how cancel_work_sync() works, it seems better to just
  ignore queueings which happen while a work item is disabled and require
  the users to explicitly queue the work item after re-enabling as
  necessary. Most users should be able to re-enqueue unconditionally after
  enabling.

After the changes in this patchset, BH workqueues cover most of the
functionalities provided by tasklets. The following is how the two APIs map:

- tasklet_setup/init()		-> INIT_WORK()
- tasklet_schedule()		-> queue_work(system_bh_wq, ...)
- tasklet_hi_schedule()		-> queue_work(system_bh_highpri_wq, ...)
- tasklet_disable_nosync()	-> disable_work()
- tasklet_disable[_in_atomic]()	-> disable_work_sync()
- tasklet_enable()		-> enable_work() + queue_work()
- tasklet_kill()		-> cancel_work_sync()

Note that unlike tasklet_enable(), enable_work() doesn't queue the work item
automatically according to whether the work item was queued while disabled.
While the caller can track this separately, unconditionally scheduling the
work item after enable_work() returns %true should work for most users.

This patchset contains the following 6 patches:

 0001-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
 0002-workqueue-Implement-disable-enable-for-delayed-work-.patch
 0003-workqueue-Remove-WORK_OFFQ_CANCELING.patch
 0004-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
 0005-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
 0006-r8152-Convert-from-tasklet-to-BH-workqueue.patch

Given how many invasive workqueue changes are already queued for v6.9 and
the subtle nature of these patches, I think it'd be best to defer this
patchset to v6.10 so that we can use v6.9 as an intermediate verification
point.

0001-0002 implement disable_work() and enable_work(). At this stage, all
disable[_sync]_work and enable_work operations might_sleep(). disable_work()
and enable_work() due to CANCELING synchronization described above.
disable_work_sync() also needs to wait for the in-flight work item to finish
which requires blocking.

0003 replaces CANCELING with internal use of disble/enable. This removes one
ugliness from workqueue code and allows disable_work() and enable_work() to
be used from atomic contexts.

0004-0005 implement busy-wait for BH work items when they're being canceled
thus allowing cancel_work_sync() and disable_work_sync() to be called from
atomic contexts for them. This makes workqueue interface a superset of
tasklet and also makes BH workqueues easier to live with.

0006 converts drivers/net/r8152.c from tasklet to BH workqueue as a
demonstration. It seems to work fine.

The patchset is on top of wq/for-6.9 (ccdec92198df ("workqueue: Control
intensive warning threshold through cmdline")) and also available in the
following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v3

diffstat follows. Thanks.

 drivers/net/usb/r8152.c   |   44 ++++----
 include/linux/workqueue.h |   23 +++-
 kernel/workqueue.c        |  384 ++++++++++++++++++++++++++++++++++++++++++++++---------------------------

--
tejun

