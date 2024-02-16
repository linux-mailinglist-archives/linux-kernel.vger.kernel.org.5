Return-Path: <linux-kernel+bounces-69118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4998584D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846B8B235CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB6134CFB;
	Fri, 16 Feb 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsPg8PuQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F612FB3F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106776; cv=none; b=WtZsbCKYhwJHhhtzp9Zmq9j/Fs8jUu7y5cWyEhndP7b2QJ3SS+aYEc05UUfD4lNHceFEZw+1fmywPjWui3QdY+XSi6td0O0RQed5a4D/uW0hebTvAk4G8JurwLPTeTnSs3/n/9VjITB1ix2iNRp5j6ruKpQBR924/QB4nOsT+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106776; c=relaxed/simple;
	bh=InEqV//tI6xYdTdog8RsMxijHBBpnylQuN0t5YboujM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULbHEjEXia/87JEDoBfEpR2FHt8Gg2E8DVwrGIwG56F3rCi6didrolWyXZfveHV+bArYinlbstPI6gAdWJK7Kwl4t1CY7YZO3q3DeyW14lLW3S3n1jw0uyNpN9oR+Z+0/16SEACSy11e0s+z3QEUKT7U0Zjy2DPb02oWZ3yDJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsPg8PuQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6de3141f041so1888041b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106774; x=1708711574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j3X8KggwRU1Zu0ltcss+oU60aPOk+cskLQZs2GIWgEI=;
        b=VsPg8PuQnpjrXQkTld9RoZlXGw4LVBTryCe+rzhos5lfxo3R/QWd5du33zJ2rbISBB
         XlT8jM0pKIpJ6huDmGiwRhsUU5swHYqx4TjoEvSUlO8QQDlNHZvTOClrJyirj5w/9JhK
         ATxW5Xh9MSafsVZb69aSGv97ESMyEUJfeytI/o7mf7pocQe/R4o+8vGyTeURtLpGj6W/
         YLZ8o2Z5NtsBOwtxLnBnwc31IT6MjZ/PQbN+AF5yisoKPdNde8/gkF8J1MrX/M1g7VMl
         JFfRFqH7kISv3k5eW76oluS0fD7iDjdDPr8H3OY0iorHnYqM51E0dv3k8PwklLoi/GTl
         ZO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106774; x=1708711574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3X8KggwRU1Zu0ltcss+oU60aPOk+cskLQZs2GIWgEI=;
        b=EW9MIrDqB7v0qYdo8PsXX9A5czWzYc34bnARpOzs2f2geCPRpwyQyDqBzy4AFOsi/i
         wu9E9Eeo/F71hNwwE5RLv1U5udQePfNalcyxMC8sSwxP7Y7SRfAPWTb4F+sJCuEbjbDR
         5bEfzjXTWIO+uso8pfk48GeZ4Nxl1FgEtTnE+/3ZbRXBc2ElLWFKrAyfoCB+rvwCMR2v
         wYL8Ws9lB9W19u3djKwLfTe1gB8yQ1ODe0OqU65Bewa9wH4FsB6bBTihuRYDvIOeZk3E
         i1EhIpjLwew981SWecQPohFvCM9k1bWaN8lidUnFOXJBZ1EWf5hoFGpC73vQF0m+qN80
         TMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5zPEJz0ntlDNeaFo/sIQBZGAdYguQ1BTImO9XFJUyreCGR8D+xsTBoHiB711bnGwr0/+O03VzpoOlIEc3EBLwfMxKtYWNhgfxMyj
X-Gm-Message-State: AOJu0YzORd77SIhzsvvEthlJltOviS4wmUcwAg0BmXgw+fZ5qYs8rEu/
	dgE9N2XW1IX5b1If4SjWl1TW/GZY8PFCzsdqBT+O97IaYXaiCKD3
X-Google-Smtp-Source: AGHT+IFZYCdaNJtbumUUOngkqjluVcogO7UVxdE98vL2ZJanZIGKrQlzRjIUBSayeHBUEtoFSs5jTw==
X-Received: by 2002:a05:6a21:670b:b0:19e:cf1a:5376 with SMTP id wh11-20020a056a21670b00b0019ecf1a5376mr5782148pzb.40.1708106773490;
        Fri, 16 Feb 2024 10:06:13 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm202167pgi.9.2024.02.16.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
Date: Fri, 16 Feb 2024 08:04:41 -1000
Message-ID: <20240216180559.208276-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

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

This patchset is on top of wq/for-6.9 and contains the following 17 patches:

 0001-workqueue-Cosmetic-changes.patch
 0002-workqueue-Use-rcu_read_lock_any_held-instead-of-rcu_.patch
 0003-workqueue-Rename-__cancel_work_timer-to-__cancel_tim.patch
 0004-workqueue-Reorganize-flush-and-cancel-_sync-function.patch
 0005-workqueue-Use-variable-name-irq_flags-for-saving-loc.patch
 0006-workqueue-Introduce-work_cancel_flags.patch
 0007-workqueue-Clean-up-enum-work_bits-and-related-consta.patch
 0008-workqueue-Factor-out-work_grab_pending-from-__cancel.patch
 0009-workqueue-Remove-clear_work_data.patch
 0010-workqueue-Make-flags-handling-consistent-across-set_.patch
 0011-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
 0012-workqueue-Implement-disable-enable-for-delayed-work-.patch
 0013-workqueue-Remove-WORK_OFFQ_CANCELING.patch
 0014-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
 0015-workqueue-Update-how-start_flush_work-is-called.patch
 0016-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
 0017-r8152-Convert-from-tasklet-to-BH-workqueue.patch

0001-0010 are cleanup and prep patches with the only functional change being
the use of rcu_read_lock_any_held() instead of rcu_read_lock() in 0002. I'll
apply them to wq/for-6.9 unless there are objections. I thought about making
these a separate patch series but the cleanups make more sense as a part of
this series.

For the rest of the series, given how many invasive workqueue changes are
already queued for v6.9 and the subtle nature of these patches, I think it'd
be best to defer them to the one after that so that we can use v6.9 as an
intermediate verification point.

0011-0012 implement disable_work() and enable_work(). At this stage, all
disable[_sync]_work and enable_work operations might_sleep(). disable_work()
and enable_work() due to CANCELING synchronization described above.
disable_work_sync() also needs to wait for the in-flight work item to finish
which requires blocking.

0013 replaces CANCELING with internal use of disble/enable. This removes one
ugliness from workqueue code and allows disable_work() and enable_work() to
be used from atomic contexts.

0014-0016 implement busy-wait for BH work items when they're being canceled
thus allowing cancel_work_sync() and disable_work_sync() to be called from
atomic contexts for them. This makes workqueue interface a superset of
tasklet and also makes BH workqueues easier to live with.

0017 converts drivers/net/r8152.c from tasklet to BH workqueue as a
demonstration. It seems to work fine.

The patchset is on top of wq/for-6.9 fd0a68a2337b ("workqueue, irq_work:
Build fix for !CONFIG_IRQ_WORK") and also available in the following git
branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1

diffstat follows. Thanks.

 drivers/net/usb/r8152.c   |   44 ++--
 include/linux/workqueue.h |   69 ++++---
 kernel/workqueue.c        |  623 ++++++++++++++++++++++++++++++++++++++++----------------------------
 3 files changed, 441 insertions(+), 295 deletions(-)

--
tejun

