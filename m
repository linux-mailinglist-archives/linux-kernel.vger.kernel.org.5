Return-Path: <linux-kernel+bounces-44681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D7842619
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77593B23D22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0E6BB2B;
	Tue, 30 Jan 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO/mGNHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFFF6A337
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620456; cv=none; b=hwqyyOVUDRhjL9AN6IREGHn1jJliwnLlKdJUUzJC0w23jhryliSJU8d95KlrCeIVzHye+lQR/fSM2HJOMed3IkQd/EcOPYGs0emIDhF9gj/0UIL88VgXYCXbmGyN7v5JpftyFcdzJ7J1FoGlVCsbowTvcgwVMa0LOOA0awty8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620456; c=relaxed/simple;
	bh=igel0xrDbniIkaaDmTpoNc96gkHdCdCHSRZ68ZZFEe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIEqFyRpzVg2I0A4eJmEJ87a/Tb30bvbke6b6CgVd8MaUKLNfQt+ZVpwv9sGXxSXxEGyOF/lwqmh6jwhe18XyKGVZZbhzEfAypmIGaQjxo3n7h5ibkZIeFwgKlftZbTmTfq1xkXPzuremmmxwuIBioSoFBNks1w1EXBuRukv9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO/mGNHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC6C433C7;
	Tue, 30 Jan 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620455;
	bh=igel0xrDbniIkaaDmTpoNc96gkHdCdCHSRZ68ZZFEe0=;
	h=From:To:Cc:Subject:Date:From;
	b=kO/mGNHPhKqQWzL8j0hqH3l5sXFFbDogLO41f5djOqMxCipaBrG0h4rBODXPevz9/
	 qW6XeRZybwxQw70VKy53GVtMppl2Pz2RDUtwDV8JnqpEg1ji0rIRMBaRhuKNIpCZco
	 y4fSSK37mcprJR7eTlU0Gm2R9JldtM5zfi+9gXXLlpPZIZDPjbze+0qVt6AW2ONvjZ
	 XvjbBnwiW0DqmN7HnNxOjT7jRA5djDlrIenDZQtWn0X7eqWHKe3gjSInyz8bQMxdqu
	 dniLjoe6QWjEQPgt7NB4eeHrC78gL5NK8JXfrc2DOS/2y7QLvwtSmLpyzH1j0x6eKG
	 dZmQUBsVgapYA==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2 1/6] sched/fair: add SD_CLUSTER in comments
Date: Tue, 30 Jan 2024 21:17:03 +0800
Message-ID: <20240130131708.429425-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The SD_CLUSTER omitted in following TOPOLOGY_SD_FLAGS explaination, add
it to fill the absent.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Ben Segall <bsegall@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..c342c52b1f34 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
  * function:
  *
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
+ *   SD_CLUSTER		    - describes Cluster topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
  *
-- 
2.43.0


