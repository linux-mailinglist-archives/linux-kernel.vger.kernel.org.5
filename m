Return-Path: <linux-kernel+bounces-101993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173587AD69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75F1F2A236
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE95149E0F;
	Wed, 13 Mar 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCAUmSCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB6149DFD;
	Wed, 13 Mar 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348205; cv=none; b=nGMoli7aC98ddX2s+2wXeiP8/ZZSkeDABbYpUmjidPnrdwCop925GNAk3b2NmPblXDCWbPo4ppG7rQOuj8MBggyczh5QD9cQakdtTaia/ngGYRCvuT+wNatuKwsQqlPxE6cNpBY75BroAToA/mWFOf5+yPEpzaLrMOjykAIUpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348205; c=relaxed/simple;
	bh=otcY7mfhal37SsnDZ5/grTWidMrFmetWGelHWtWZv1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxA8Wc8YU8mkX7TxAf9e3EbUlZnvwYIgLgqGTP2jeymGMcW76JextRRT6PsOa/5simQ0sPxNcVQpuFIB+dG8iWUhjvPcTEMiUszoV4vEamssDppEYbnd45QrYfJI2/nPeZzKKoj0cbksp6Q9wViAVm157WsJbmR/5ku2H/rPA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCAUmSCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6403EC433A6;
	Wed, 13 Mar 2024 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348205;
	bh=otcY7mfhal37SsnDZ5/grTWidMrFmetWGelHWtWZv1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCAUmSCu6qD7oYa1PiUFpJfekgwj/DF2RD40CeaDU+NkHG7smayN/BxYAEFZ7YN2a
	 4fNdsl+qlt/CLZ7ApMVfqjyzs/CXtMFjCW3uf4TNs1yg9uaCYRKlnmLjht02CJX3cH
	 /xs43wne5GdZAwMSiQsT2NVZpGcJapCpL5NysWZpnnDQmRN8MAdo2NXuP2ZzfxPSis
	 Z3RL+V8cwWJOnrKcUI47FMefLOx39+vRMnGPbJVY40dCyKJDzwa9XCGQ66GG1YPLH6
	 2MzzCNUCgqh0HZJ/c8Ts2ap/8Brrqm0vxOSOLkg1UVZgeRD+JCuG1fWoZcy13HwLaB
	 Dflqx1RANLqbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 53/76] selftests: mptcp: decrease BW in simult flows
Date: Wed, 13 Mar 2024 12:42:00 -0400
Message-ID: <20240313164223.615640-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 5e2f3c65af47e527ccac54060cf909e3306652ff ]

When running the simult_flow selftest in slow environments -- e.g. QEmu
without KVM support --, the results can be unstable. This selftest
checks if the aggregated bandwidth is (almost) fully used as expected.

To help improving the stability while still keeping the same validation
in place, the BW and the delay are reduced to lower the pressure on the
CPU.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-6-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 752cef1688040..99deb3abb169f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -289,10 +289,10 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 exit $ret
-- 
2.43.0


