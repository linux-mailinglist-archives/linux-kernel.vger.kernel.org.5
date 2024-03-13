Return-Path: <linux-kernel+bounces-102506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F487B310
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E5E1C21294
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882151C59;
	Wed, 13 Mar 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L0Be1V/F"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4320DDB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363391; cv=none; b=QM3Eaa33tXZpEC+Fw54xzZOf7TbyLL84aFuuQV7FozDFAq4KQ9BrUWNansDnuvAVo/Y0/6iSYPaV9n7TYQGdirgvlYFtV1ffCsIyeDxQgQsFmP+j9Un0MzDLy3v8oUyqEkzRTwPy7mOF+zd6kx9Oreei02D0BREpWn3r3dFcFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363391; c=relaxed/simple;
	bh=ombC87M/jDfVGex2UxCohkXM5I06cdOhxPkknjHKUX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8zX3yIXjJ2x3drFUASXFHHp68x9tihdaIRpoUcHtVo6dDKCBf/HqKDSEINKkQMElrRFfJf45JuxHANivk/cnsQagtgka7LH/IT9FaU6WcprblfmOzSNcdHF+zgacFoJOmOMCvHEwh+pry3cu0vsfaTeZ3rqJntIJYLTaac1BTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=L0Be1V/F; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710363381;
	bh=ombC87M/jDfVGex2UxCohkXM5I06cdOhxPkknjHKUX4=;
	h=From:To:Cc:Subject:Date:From;
	b=L0Be1V/F5E3uHHIK18kHDRKtGttorOPLvQ786BQ1vDLVwQAU05Ya82DAF7CFBXPVS
	 HuQ+J1Y+UdsDAPfs7y4sXeCq3WhqkNVW0Q0d38ac0vdcJV6BMmm/1ZfkTSv7IGq897
	 BgIh5p3CPtbV+bC8wKW/4nm5GHeDUisQs8dptfHBz93bMQ0iDlSJJTowz3R5niePJ4
	 cBlmzbNd3BY8vz37TGu+zCsb1/lbkDkCpdAKhnXrA2wrCZHxcwYrZe8cUIDqzwvNcx
	 frB9izs9s0woYijBIYQXGPtqZwswjaBLIufME2OgUboIHYqI9OdG4maLweULnokyTr
	 w+YIp5+9m8ojg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tw2qT3X1Dzjnn;
	Wed, 13 Mar 2024 16:56:21 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Oskolkov <posk@google.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Hunter <ahh@google.com>,
	Maged Michael <maged.michael@gmail.com>,
	gromer@google.com,
	Avi Kivity <avi@scylladb.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH 0/2] Introduce serialized smp_call_function APIs
Date: Wed, 13 Mar 2024 16:56:20 -0400
Message-Id: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 944d5fe50f3f ("sched/membarrier: reduce the ability to hammer on sys_membarrier")
introduces a mutex over all membarrier operations to reduce its ability
to slow down the rest of the system.

This RFC series has two objectives:

1) Move this mutex to the smp_call_function APIs so other system calls
   using smp_call_function IPIs are limited in the same way,

2) Restore scalability of MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
   MEMBARRIER_CMD_FLAG_CPU, which targets specific CPUs with IPIs.
   This may or may not be useful, and I would welcome benchmarks from
   users of this feature to figure out if this is worth it.

This series applies on top of v6.8.

Thanks,

Mathieu

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: gromer@google.com
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Oskolkov <posk@google.com>

Mathieu Desnoyers (2):
  smp: Implement serialized smp_call_function APIs
  sched/membarrier: Use serialized smp_call_function APIs

 include/linux/smp.h       |  40 ++++++++++++++
 kernel/sched/membarrier.c |  24 +++------
 kernel/smp.c              | 106 +++++++++++++++++++++++++++++++++-----
 3 files changed, 141 insertions(+), 29 deletions(-)

-- 
2.39.2

