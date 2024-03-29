Return-Path: <linux-kernel+bounces-124529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131B891964
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADA1B25164
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B191474CF;
	Fri, 29 Mar 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgOI7KLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B412F362;
	Fri, 29 Mar 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715315; cv=none; b=q+8iKv3g8bYh7dDRfoskptTn5QSyVDxltO4VYPj6PchkP9l0M+9PqGPbd2fnoabkfu1ctHu+LrXpXAJ6FGfhlZ5p3uEeEfjGMS2WZiSvx5x9uHdFFEI/B8h2ixe9j0jLpLn7YfzDisnPKcbEzDxFtJI5KQqSo6Mb3ZdoNq2/aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715315; c=relaxed/simple;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRgv8Ij6kW5ZUwUCTNeiuis2pLDRM4gSXiglOvTfQeId3L+sx6HrrCFzGbe15GS2GOVzKxYlyneG2SgNaRQVO8BEkf1sdgsL0Ixymn2DzJiWOkq4cgvd+f2LRJlNoG95rSAYRJT1SypyXJZRH9pWyIA+7Nhy+5/jXkvHhN8z4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgOI7KLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B9FC433C7;
	Fri, 29 Mar 2024 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715314;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgOI7KLIVkXt8dbAlB0uqts+BpuMsuHqsizBUSDkbkwZgpPX865wRORl3e6tA7z4y
	 OaY/FLimTHRGt4DsgEOgPxIRT+MIfcTOTSn0piE6/c0rSXadlbOs/vW6irgi3o34A+
	 5ucI4djVFuiXnZxwQduZArMGunmnsl7eJ8H80jYWmXhWSoBNxfrQOiFcqsx0t+NqQt
	 aj++R+26T4QqeBg63PulghtckPg6NuedwZEM4wAeGjbl2xUwcHHS/RrlUEkI/33gLt
	 z+/N26asacWjem0A1I38HdtHdy57a0dFX0sV+YTUVXVvXfOmCPG59i1UopVKglR5qf
	 hZD5xt6Rn5Hug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 48/68] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:25:44 -0400
Message-ID: <20240329122652.3082296-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit f85450f134f0b4ca7e042dc3dc89155656a2299d ]

In function get_pkg_num() if fopen_or_die() succeeds it returns a file
pointer to be used. But fclose() is never called before returning from
the function.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079cf..ebda9c366b2ba 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


