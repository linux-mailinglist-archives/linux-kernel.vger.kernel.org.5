Return-Path: <linux-kernel+bounces-86035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C1786BECD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D39B231A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853236B0E;
	Thu, 29 Feb 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYLMi600"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9C364B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172899; cv=none; b=XVZwod5ErywPln1kO9wkDJElLfHRNuSVctJ9G3jyX6nTMobjHMTYrlN+UQaO30gQHYzUZI28FwmY9z9LHIsWchoUSLyLOuyh+Z4GBNJvBdLbgWvJrf2O/joL6nqnXiKMoLqEpie6461bMn+ZvCqsjH9UYrZip46FRoSCOP8bSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172899; c=relaxed/simple;
	bh=hingJ5EXVicls4BQfV94vjpMA1BgNof8PS1gsswv0lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pfBHeG54DmGzIhHtkTR/wny8x1lUu/irn3aj9Ovpk9hQZlF1aqKTNif84oeWBhxcgNuPIsxnhKGnlz3qituCr+1Pcx1x+nOWvD43wSurDvUBnDox73qQF9CTJ1VCyowG4mhU1zCvP17P/E3SO0nzQpZujpObDLDEM6MfSzz4EWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYLMi600; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709172896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uLYPtBm4p8G3yFydUnPEm3+xNcp+Ap8SsLOv9W66tkg=;
	b=GYLMi600cDzI+wUKmgpDND59CM4qHBkvX5W7wmMPTi4Wtb2+S2AsApysf90fnQb75/lQlW
	HD9YkUQltv+Wr2jHW5EYPJ9+xZrIfCs5vWN077O3osedBR+OuRFFszV9PoxCmXYeAdkacK
	Pr6rXHhsduuRtjlRrNSPNloNbaXid+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-VmLpVkUKO5irHrQOAreqhw-1; Wed, 28 Feb 2024 21:14:51 -0500
X-MC-Unique: VmLpVkUKO5irHrQOAreqhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE2FA881EA3;
	Thu, 29 Feb 2024 02:14:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4190492BE2;
	Thu, 29 Feb 2024 02:14:48 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Cestmir Kalina <ckalina@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] isolation: Exclude dynamically isolated CPUs from housekeeping masks
Date: Wed, 28 Feb 2024 21:14:12 -0500
Message-Id: <20240229021414.508972-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping processes to minimize
disturbance to latency sensitive userspace applications. However, some
of housekeeping CPU masks are also checked at run time to avoid using
those isolated CPUs.

The purpose of this patch series is to exclude dynamically isolated
CPUs from some housekeeping masks so that subsystems that check the
housekeeping masks at run time will not see those isolated CPUs. It does
not migrate the housekeeping processes that have been running on those
newly isolated CPUs since bootup to other CPUs. That will hopefully be
done in the near future.

This patch series only updates the HK_TYPE_TIMER and HK_TYPE_RCU
housekeeping masks for the time being, though this is subject to change.

Waiman Long (2):
  sched/isolation: Exclude dynamically isolated CPUs from housekeeping
    masks
  cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks

 include/linux/sched/isolation.h |   8 +++
 kernel/cgroup/cpuset.c          |  30 +++++++---
 kernel/sched/isolation.c        | 101 +++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 8 deletions(-)

-- 
2.39.3


