Return-Path: <linux-kernel+bounces-124687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193B9891B67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD131C2653A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BE173320;
	Fri, 29 Mar 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwrXKkvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B9172BCC;
	Fri, 29 Mar 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715704; cv=none; b=ufTJgmQLLXekDvJeTCSaNcU8bGHxHgyoXAtI/Zt3oJ/2QYRE9dGQ292eBYAoqgzl1ra/2GszKSJ6Wmefr5isRlve4ob6d2oICffdkJEZBEGFu8jOoPPZ3OwtodbraxjBg4fk+rBmiHB0+sZcNgSrl9RowljTYz4mQ4DikBROH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715704; c=relaxed/simple;
	bh=M9GujlUegVE05j0NOorQPyeqLctEmeISmm7vzvi1KZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB9xiEiBf7oZqZim2CU5sFuspcz4DFO9SotaGIkxsIUZnmw88xFrVrX+oJsQhwsHATHnO/7r+uVR0ZWJRJv4UcmsJl7HjJ0+RCTdAsw5I/I2cnn9jIOeEBkKnsdcv1MytF0whN8KV9QnjJwl30THG4lDDSstwmJkBLV16nc5/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwrXKkvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA3C433F1;
	Fri, 29 Mar 2024 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715704;
	bh=M9GujlUegVE05j0NOorQPyeqLctEmeISmm7vzvi1KZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwrXKkvo6o3D6aCHXLwqYX2bFB5gAge6bCoUKmHmtQWJjpkMiB9KdRGL/UAgE2uZj
	 LFb5bpMvJ5cHuPjzffctT7CLlM5w3f4ivY/5XP9/anh3Gukoa80NENw4EeJKklizAj
	 g0+c2ReFfZUN/X3oDmnrB05hARKBbuL+1vWuJ8RC6mtUwuKU7xGAr6AzxU2sirAfFK
	 7blsdi1d8r9WaK7fMLLji9JG5taO7hGf5MyV6g9FQPoRAzcKA/RvCi9BRRRwxeJvSC
	 l/4SSWTt29I7lYh1l57lDNCRQr0ncoXyKFXUhq/JyfH6sldMpEWXiS91M/iKk+nW/C
	 1t4yX+OGkTZyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 09/15] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:34:32 -0400
Message-ID: <20240329123445.3086536-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
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


