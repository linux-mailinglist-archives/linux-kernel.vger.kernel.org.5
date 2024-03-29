Return-Path: <linux-kernel+bounces-124620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908EB891AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DC2287720
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8815CD69;
	Fri, 29 Mar 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8gwBg/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42815CD5D;
	Fri, 29 Mar 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715564; cv=none; b=dH2tEvmqWYpGqrJPOt3XVtPPiIqynKPpfvM1fA+wl7dJsGdbZixbpNyKnf5vWXm5phixSE0HkH+6UCh5eIuHvZJBKBv5vANiEWGPIr/GTIs+9cjXZd5tAUpEyWx/Oektz+efrPMY36iRcW8MflTscPrqmjNF83yxukibYE2xQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715564; c=relaxed/simple;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXp3iT3MEiana/SyklE4Y/sGxY7xlB1OoIeHH3FKodQtbzs3rW8kmam4rHTubdCJETgUCxsfiWsHOvO3y1j9BpSpjoNDHz3mkKlUOlsIBHpK8isma19YdajzyJwEUOE4g8HCGb+yDR7nFV02+5u0Yi8IN84W0tupLqOsFnJJ3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8gwBg/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5931C433F1;
	Fri, 29 Mar 2024 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715563;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8gwBg/F9v2Iv3gC7F0TuckPdNV5uW4gI/ZoJXUc1mfXlG/picbCJrUvIEqT3y5L+
	 qRe0kDVx1B6GmxIc/n+vbg1fA1BECwuv6vqnGMuGOVe1nuXsTcQRoKQaQZA0GsOWZa
	 qxVKGERlieX0mcbZCyrkucKfqCO6jM5uRVK7gKLi0r8FwyEUe3VxHYcIgzY27ZrISg
	 DWnbwdqAcRXQvMJxbjNqx1dSbpvtB5nruqs1+fgRkpVIWYJSX08rpapi/rF/3DDomx
	 NsmL7c09SGHwDI1gxiKdn7Z5h2GMw2+3C6R7+K2JT/r8BrJqHJVLew5npWqbP2jmE2
	 kYRhitowH7NwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 17/31] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:31:36 -0400
Message-ID: <20240329123207.3085013-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
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


