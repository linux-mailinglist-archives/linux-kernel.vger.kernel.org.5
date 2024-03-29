Return-Path: <linux-kernel+bounces-124934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA942891E66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A139B2DA13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D561A4C26;
	Fri, 29 Mar 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QynAd3GQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FA1A5698;
	Fri, 29 Mar 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716451; cv=none; b=L7w4qXOUdQ9OBOrFBNlapJFdO6TBgUYj0P5x2p6VFWLUgWxmbA66F+ZZdIs4FSx8BcyfiFr3cBIKNMG94U5z+wGNUuCJnRuuGXD8EqOUTVDq6gLP5vNpIVs4y+KlGr8Z6z+/YF63JeJ0auJsYgxMyz8ob+ufmE3mQ+7L3v130kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716451; c=relaxed/simple;
	bh=nwj+Golkv2V9iD1q874DlQZnbaaJjC8jpQDnuTb3mME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS3yktrws8KDSlMWR2jiLpb23h0knLfYKSn7wep1kwUkmnR4AXCBwCJsKfcuzWKu2jCGGIkCsUvXizr0d4oKnZiut1VvsMysWA77ceDt7kxtxTB24LaTFlRy+oQ9EyQhgGVuxQCcJhEa81qqZ+EPnarX2rP7n0N9c4dF9vAIED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QynAd3GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BBAC433C7;
	Fri, 29 Mar 2024 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716451;
	bh=nwj+Golkv2V9iD1q874DlQZnbaaJjC8jpQDnuTb3mME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QynAd3GQ+u/78d9XFVcP5sqvMx0ldHK73Bgpw4Y1y7EABj/xYq+VaYcO1CWJCwsa/
	 j6poBh3XyqgBNJO040vg2pormo3RvDKuMxxrKhmVqYE0mM3PGMXpvkY0aylTQRLqTr
	 nnE77mCtH7OAejxxRiv/63MXcNS2jLSauOxxaQjOayOddJMAXblZVcf4EVK9H0zJcM
	 iALjm1HEAUJ6B4GhV7IQbeIz/ABhXA9nA71t8HU9IJqsSGwbl/4WkvXHGk29+7+1nT
	 Rsi03YT2mA/3NRre7QspeodybfrM/wkPsgGcZn6s2uBf+/g9RRApGViv1YkJP8zYLQ
	 e1ExAoFYDvwTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 50/52] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Fri, 29 Mar 2024 08:45:44 -0400
Message-ID: <20240329124605.3091273-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 29297ffffb0bf388778bd4b581a43cee6929ae65 ]

The Revision Guide for AMD Family 19h Model 10-1Fh processors declares
Erratum 1452 which states that non-branch entries may erroneously be
recorded in the Last Branch Record (LBR) stack with the valid and
spec bits set.

Such entries can be recognized by inspecting bit 61 of the corresponding
LastBranchStackToIp register. This bit is currently reserved but if found
to be set, the associated branch entry should be discarded.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Link: https://lore.kernel.org/r/3ad2aa305f7396d41a40e3f054f740d464b16b7f.1706526029.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/lbr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 38a75216c12cf..7b65bb890ba38 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see Erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
-- 
2.43.0


