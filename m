Return-Path: <linux-kernel+bounces-101915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293287ACAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D051C21A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725D86260;
	Wed, 13 Mar 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSuXHZnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFD8624D;
	Wed, 13 Mar 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348055; cv=none; b=oQhU7a3xemAulo6VsOq2WjkjaEUTxyVk9cpagse6a30skAFpessGNxoKLVR7h6XZNzuqiYI+SSgyU2ZeJEg5rZXk6cJrCN6y67rsXVZk1feEfVr/e6JBXbTSjPh75F/psF3Rr7irYdJ5SfOENhHoYf7uSWI50WADeWIk6xjj4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348055; c=relaxed/simple;
	bh=C9GUrPMH2cVL8miH76/ny0uWeulQVdoKNRFf5/jrCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezrTZIvY247uYFoYi63Uy+ObowrKI1k793AYe1urRJ42ynrAuW5Zqkb3cUv1NE53V/DPdj47u6qampJqfcOF6xZfp8xr4UVpNpdyz9dBXvcLXQee6Jqgw7OX7dkXwfL7AE58fBfmBvUV/+ovBknc62QAXZSfxEMLk0QTdxc8xQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSuXHZnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6942AC43390;
	Wed, 13 Mar 2024 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348055;
	bh=C9GUrPMH2cVL8miH76/ny0uWeulQVdoKNRFf5/jrCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSuXHZnt+cxCFf9uoRXC8y5mmq4eehMBjYRriN27MFqr5FDdQYqWXy2UIff+c9UZe
	 XQWEwKsrIjRDGmE/4xD031KbH2Fd/V78ejd6Sso1gMUnS82bvu4JvRwCZ8dQfhhXPF
	 AROcjToQDXhllu/xLae0ctKeePoVvu1DYljetCyv4uygK1/Sm6ovfPD49Ysk04RfQK
	 94uqX3uxw3/lihKLqriS9IuyRRqY6KZldqyf9Y9xS1tHE20rp0WIaTW9leRDreBiRo
	 /DAHFWWKRYGEbewfZ/wTNr/EMcHHzv6B+skzYTipWZESn8iLmsBvwxLs/c66X/IdGA
	 CXsbuB14Xu7pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 47/71] selftests: mptcp: decrease BW in simult flows
Date: Wed, 13 Mar 2024 12:39:33 -0400
Message-ID: <20240313163957.615276-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index 4a417f9d51d67..06ad0510469e3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -301,10 +301,10 @@ done
 
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


