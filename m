Return-Path: <linux-kernel+bounces-125014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE8891EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8B1F253D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB01B7E5D;
	Fri, 29 Mar 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVFBffCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1E1B7E4F;
	Fri, 29 Mar 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716633; cv=none; b=A7eodWwV9f7iGVyVqoiQuaQ06lOHJL67EBs8GgrRQ4nJ1CM5urV3k1sFrLJymbMr4R+CuuR6oJ4Y7uKfEySZo7vzqxQhQkL6ggOOvAEhO07Rw9Bc5S7hIB8MfKrO67y+LwxA8c6eSVrM0mVfh9qGbURo/qnD8vkCU7se37xNFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716633; c=relaxed/simple;
	bh=M9GujlUegVE05j0NOorQPyeqLctEmeISmm7vzvi1KZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENzs0xKcfOdSDGY/MMX9k5sWlXqX8Ldzjmg9c6xXg9pQ2BnOMwKLzq9GEGp4Qo8pNAxinHA1+G+k2+c1blM9/NYYs5Y0SUzzkGlPXZH4Bt8NEA/n4q6XODJZlRA06OFJ1vRI6SfiVyfuGUFAxSuhOKdJMNCQ4U/gJWOJAzvmDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVFBffCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2BC43394;
	Fri, 29 Mar 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716633;
	bh=M9GujlUegVE05j0NOorQPyeqLctEmeISmm7vzvi1KZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVFBffCGPcKsgvztriQ1vhv6yvB5qEwHn+83jHf941oEEys18WtvyPrRi8yRkw1vu
	 xo6sQTM3Tgi29PglBLPBuVOKLaKC/Bb6Odd/L2Db0PgrxqJ1PJaJNW2ipPQe04fm2v
	 u9pqJvrDxASvMK6v68H6E0szNtEAHKF9SJR3XZgb9l8SvjH9ftXNzLkF4Le32152po
	 VQOzXBd0mwgafC1xp9GbvGvSO7lRT1Ap9MsgvzLZ6gm9/I1Bf6oFnClfzoosJX8Box
	 BVeFnEaz9o7Y+ZUFDiLUGEUQdTmRgo2XZfC5t8VW37DvCM2UPok9CxxRtapUogMqF7
	 izIuXgQd3OwQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 12/23] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:49:45 -0400
Message-ID: <20240329125009.3093845-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 3fe1eed900d41..165eb4da8a644 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1111,6 +1111,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.43.0


