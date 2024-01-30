Return-Path: <linux-kernel+bounces-44220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4F841EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C301F21D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7C605D0;
	Tue, 30 Jan 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtE0a1N/"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676059147;
	Tue, 30 Jan 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605986; cv=none; b=usI73/VpF7iB/I+nAhco3O7RuHEl25K8AfP46j5Hg3JBXYs8u+HGdrMn6b3/YFmB2XLpkL7iUzcFhciixarJkPhwlSqvUYvJcneMwh+RrUG7qolC/gmdpI33LD13YdUIIwvkEGpMqq+hXEgdvaG2FF9HWgrBACk23evlISPA73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605986; c=relaxed/simple;
	bh=BQgMw4kft6HibyH5hZoeL9BrKIi7CbOCh2ArBtsepu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITriVkw1t4r8/JIorABrVRpqDecz0m6TE/ui/AEucMuJQvencbq18NVzL67Iw8eXlcn64FCtjstmU71siV8MkwHbJFvg5tpvLE/kWHKYjtFPhgLi1WE7yc70XEjy+VdUwwc+aZkKgDLf19RgGq6NejZKSIr+Gc3fkqfJo+2Loa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtE0a1N/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so2355016a12.1;
        Tue, 30 Jan 2024 01:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605985; x=1707210785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2419AmMRLK1a8gM2JjFp9RCfwyGRI0AG4Y0NxPY7Sr8=;
        b=RtE0a1N/54VEvNzmEZNZLV8yLQlDx1X6FzFS/vp0fxTMT0xNDcwDXwqcfalSXH8DDw
         n6ERRQVjaro6D/hNYW4Oc/tAzmnAlH4QSNxStRi7xQkIaALoCbX6pjjUzYFI+hj+rfCw
         3SlqvNXMsYHIfwdWzJwMxySXVdiYmA8T0mDEPsAjFQyhr/cNbD/s+Tq6rg1KAJ5Gi4hT
         aLtvTfYNxSuWd5WjNNAFPgN65fyvZiKpUwA9DoR7FbuzMJwIVtdglFU1v5bIfp/cZPzj
         A9EHtphULYREXt0I/w0+mp6bWo0KGzPBm480vnA8rVhrGoIEmKTbbgrnLquy2Y0H6PLo
         km6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605985; x=1707210785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2419AmMRLK1a8gM2JjFp9RCfwyGRI0AG4Y0NxPY7Sr8=;
        b=FNlp0+SryZbhUeUkWHJaUDzmsy1Bv6C+J9NHCsC14p1l+n9ZlRw4NDKYUtklgdoSwq
         GW32FPZBeQE0JP8kgAWzZuOPM6ta3oN5PWRelr9BDPV00aCRVoquQtn10XrYtNHCaQLG
         uxM2ckjFGzQuYPdLQ0lfD20GPZvRn8NX6OuONcnyI5IbJp7bOh18KGxnQepXTF5xMlaT
         WccSP75Sl8ppwzw/nPxpnjGKkxGRUMAvGuLI/Q0jJ97/dRfI6axrZDsAhHrqNCH3/M8s
         woFtlSCxOVSs87q2dNrvtyiHudKMagfa7ZGP7cHjmrIaak/unhIWZm+Y8N/1KL0TaOUY
         2pwQ==
X-Gm-Message-State: AOJu0YxRNLSfdZWtuRymqW0CCnHFzjOVzKcklAuvXH3zf9kIdFl1w+9h
	WpT3QgTpY6+a5QVC83+CaFJlorIIEX7v7isrG7g9xV5lrY+AUIt7s/h0SgkL
X-Google-Smtp-Source: AGHT+IF+ENnioD53E4T34dqSWY4jx2ydBtNwJkgOEgDkPE6BjYRC7VhcjnQWsA29LbzRUKq+5ffnDA==
X-Received: by 2002:a05:6a21:2d8c:b0:19a:2b15:2a2f with SMTP id ty12-20020a056a212d8c00b0019a2b152a2fmr686345pzb.28.1706605984525;
        Tue, 30 Jan 2024 01:13:04 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id gu2-20020a056a004e4200b006dde1781800sm7491336pfb.94.2024.01.30.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and convert several tasklet users
Date: Mon, 29 Jan 2024 23:11:47 -1000
Message-ID: <20240130091300.2968534-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws such as
the execution code accessing the tasklet item after the execution is
complete which can lead to subtle use-after-free in certain usage scenarios
and less-developed flush and cancel mechanisms.

Mikulas Patocka recently reported that dm-crypt and dm-crypt are affected by
the access-after-completion issue and suggested adding TASKLET_STATE_ONESHOT
flag which selectively removes post-completion access while significantly
limiting how the tasklet can be used in the following thread:

 http://lkml.kernel.org/r/82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com

Linus didn't like the approach and suggested extending workqueue to support
execution from atomic context:

 http://lkml.kernel.org/r/CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com

As suggested, this patchset implements BH workqueues which are like regular
workqueues but executes work items in the BH (softirq) context and converts
several tasklet users.

- The name bh is used instead of the suggested atomic as it's more in line
  with widely used execution context interface - local_bh_enable/disable()
  and friends.

- The system default BH workqueues - system_bh_wq and system_bh_highpri_wq -
  are provided. As queue-wide flushing doesn't exist in tasklet, all
  existing tasklet users should be able to use the system BH workqueues
  without creating their own.

- BH workqueues currently use tasklet to run the work items to avoid
  priority inversions involving tasklet_hi and WQ_BH | WQ_HIGHPRI. Once all
  tasklet users are converted, tasklet code can be removed and BH workqueues
  can take over its softirqs.

This patchset is on top of wq/for-6.9 (aae17ebb53c ("workqueue: Avoid using
isolated cpus' timers on queue_delayed_work")) and contains the following
eight patches.

 0001-workqueue-Update-lock-debugging-code.patch
 0002-workqueue-Factor-out-init_cpu_worker_pool.patch
 0003-workqueue-Implement-BH-workqueues-to-eventually-repl.patch
 0004-backtracetest-Convert-from-tasklet-to-BH-workqueue.patch
 0005-usb-core-hcd-Convert-from-tasklet-to-BH-workqueue.patch
 0006-net-tcp-tsq-Convert-from-tasklet-to-BH-workqueue.patch
 0007-dm-crypt-Convert-from-tasklet-to-BH-workqueue.patch
 0008-dm-verity-Convert-from-tasklet-to-BH-workqueue.patch

0001-0003 prepare and implement BH workqueues.

0004-0008 convert some tasklet users to BH workqueue. The conversions are
relatively straightforward but are in descending order of confidence.

The patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git wq-bh-v1

diffstat follows. Thanks.

 Documentation/core-api/workqueue.rst |   29 ++++-
 drivers/md/dm-crypt.c                |   36 -------
 drivers/md/dm-verity-target.c        |    8 -
 drivers/md/dm-verity.h               |    2
 drivers/usb/core/hcd.c               |   23 ++--
 include/linux/usb/hcd.h              |    2
 include/linux/workqueue.h            |    9 +
 include/net/tcp.h                    |    2
 kernel/backtracetest.c               |   18 +--
 kernel/workqueue.c                   |  312 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 kernel/workqueue_internal.h          |    3
 net/ipv4/tcp.c                       |    2
 net/ipv4/tcp_output.c                |   36 +++----
 tools/workqueue/wq_dump.py           |   11 +-
 14 files changed, 335 insertions(+), 158 deletions(-)

--
tejun

