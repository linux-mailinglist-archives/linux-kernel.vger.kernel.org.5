Return-Path: <linux-kernel+bounces-124805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C4D891D10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C62FB2B96A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF013A263;
	Fri, 29 Mar 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfrMEVeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975B19067E;
	Fri, 29 Mar 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716165; cv=none; b=VPkUdJkf7jBKEkTHqDjiS6P/Lw2CNBDmsCfDDAa/utKKbLZ2K5BpNLnTmduVWax9ODA5+SsoGjCW0YjSU0STx8GjVjWBNigdyB8Q0RajpETVpJSvmdiX967mr1oy4jNpT1I1qQIPDO8CpzdkedJ99ZbZg2zA6T2a1FE3buIBkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716165; c=relaxed/simple;
	bh=NVK4O8B5BrAcw48L7NZu7ZI5jWxrvoi1ZutcB4pKe/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4XafSp/i7i/sSIJpeHKgHZklLQBhAgEoqJlnugTO+L+W495OiWxXd0hI6/CH5V2QMu8IJ7aobMmVkMHtHXmXgfb4mYrxYVrQlVPoP7I5QDEV0I8LEAue/LmxuaQ1XyzklgSM1iUmtMEBuEkwv9dcSW30eVUywimY71kYrjlTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfrMEVeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02AFC433C7;
	Fri, 29 Mar 2024 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716164;
	bh=NVK4O8B5BrAcw48L7NZu7ZI5jWxrvoi1ZutcB4pKe/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfrMEVeYEkFWRZ8z4HnwFfw5y3OrZSVFIpyx1xDZtgNc4H9OXe3Q/lonzYmY8TCUx
	 CFK6NOgNvHi3zYelZF2qHhWgv/PpZoNdUAkGN8mGgut8TfTvIy8s5A+JocGrFrH2EN
	 AuVgZkescv75RaKx2jVLlNKNIfF2UHwHwxGDqzUhuBx4Fo2c7GJgcIX3FRfgW2tJ7F
	 I0ArXf5q1it3Lg6dwRKys3jae8YV5VoArZhJDgNkVG7nihI1NUvArDR7Ho0XF3dZuD
	 sKxPWclMBj+wrJ3GkC40V54HXFr1U4DVFJNTRT/VlNTwv1py3BZazZZeQgz2+N4VC8
	 9U16ivlumDP8g==
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
Subject: [PATCH AUTOSEL 6.8 94/98] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Fri, 29 Mar 2024 08:38:05 -0400
Message-ID: <20240329123919.3087149-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index eb31f850841a8..4a1e600314d5d 100644
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


