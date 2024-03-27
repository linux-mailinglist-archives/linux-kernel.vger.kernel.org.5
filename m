Return-Path: <linux-kernel+bounces-120750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C662988DC81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2041DB22339
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79964768E5;
	Wed, 27 Mar 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKI6l2e4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518055F869
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538964; cv=none; b=bnUKmezvFhwRIoDJkn73WfbKcXrdpukjeK8KVCQPBP2j8PKsp01jWp7RIusmxZGOSvyjBB4EfESsCuiVUtml/g4FdkGamHabk2w+g6oOuqw6smwkk75ME1tjQyTOEkCXJar16W1qWlyqQl/r9IQpHS5pXDIhFEGXFN3K+3ahQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538964; c=relaxed/simple;
	bh=nsw/Rlm6QWYLk+qz4DJpNeS9tub8iDz1dJCAyezYlIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/bl0IpbdQdPQU8vjSfI6UKDi3DSd+/sqN+gsrKzvmp3q13vw7MnZJoO2QtFn4L6r1GFAHtK8IStsneF7Kz1F3H2CC5vg5NUisyNNde3gNHI/DYSeiYNUf487i1oN7qYuAHDXDXZkep47Px7fj7Pvtuw19K8J9/KNbtGPPqLrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKI6l2e4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711538962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZqOgaNlUICmRrTLGBar/YHxoUMuvE6lugicHc7KuaA=;
	b=EKI6l2e4aFWwXfZoRSVB89l+tzkz27IbpFU0Cx6CIfYqgJd4qguo9o627hAReTF0r2hcZb
	W5wCmT+vLzFH9pe77jNUHifruqPCpCHxLLvb6Y1r9IZFpbCSMsqiBbRL7YPI5t+VR5Wvpx
	UW+kmewkhtRcgGP0okqt+3+Wzkpm38I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-q9tstAjEN1-lvFNkJk7hnA-1; Wed, 27 Mar 2024 07:29:17 -0400
X-MC-Unique: q9tstAjEN1-lvFNkJk7hnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7CE082248C;
	Wed, 27 Mar 2024 11:29:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3626D2024517;
	Wed, 27 Mar 2024 11:29:14 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 0/2] context_tracking, rcu: Standardize naming related to contex_tracking.state
Date: Wed, 27 Mar 2024 12:29:00 +0100
Message-ID: <20240327112902.1184822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi folks,

As I'm working on respinning [1] I'm trying to send standalone things
separately, and this is one of them.

No code change, just enum/const renaming, see [2].

[1]: https://lore.kernel.org/lkml/20230720163056.2564824-1-vschneid@redhat.com/
[2]: https://lore.kernel.org/lkml/ZL6QI4mV-NKlh4Ox@localhost.localdomain/#t

Cheers,
Valentin

Valentin Schneider (2):
  treewide: context_tracking: Rename CONTEXT_FOO to CT_STATE_FOO
  context_tracking, rcu: Rename RCU_DYNTICKS_IDX to CT_DYNTICKS_IDX

 arch/Kconfig                           |  2 +-
 arch/arm64/kernel/entry-common.c       |  2 +-
 arch/powerpc/include/asm/interrupt.h   |  6 +++---
 arch/powerpc/kernel/interrupt.c        |  6 +++---
 arch/powerpc/kernel/syscall.c          |  2 +-
 arch/x86/entry/common.c                |  2 +-
 include/linux/context_tracking.h       | 22 +++++++++----------
 include/linux/context_tracking_state.h | 20 ++++++++---------
 include/linux/entry-common.h           |  2 +-
 kernel/context_tracking.c              | 30 +++++++++++++-------------
 kernel/entry/common.c                  |  2 +-
 kernel/rcu/tree.c                      | 12 +++++------
 kernel/sched/core.c                    |  4 ++--
 13 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.43.0


