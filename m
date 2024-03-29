Return-Path: <linux-kernel+bounces-124849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC975891D18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3C61C241E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766031BF1ED;
	Fri, 29 Mar 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsv/VDzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0B1BDBBE;
	Fri, 29 Mar 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716286; cv=none; b=EAfzpAUq8gIaYgM7yJhJw7FHS/R4kQAE9GP4RW8ZcLR4WKnbGFkK9GgI2pLnFnIGx0DdJHBFyHR1iA1wYbMpcSW3oZI6e9wMUp7H/wpt0Q8VYiUJ4Ek/Q25Nne6vZ0BxNnJYlL0TxrJqWORQsn4I6DSdmaIfgwbU3qnyp5SEZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716286; c=relaxed/simple;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWhWbA9yYk7rkJR02OjerjU1JV633kCBRsOvYyIEHzzQ+ICyKPGGzcHmOaf5+p/LaJNG5jxMaxrTo6xN4dZEW9J9b2r/lhFXaT3BYIb09HPPdvBQxeSsX3jf7WukVts3SR8ENgLPUDql3iocqr9N8fZgF8T+2gjUMFSQ/HWUyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsv/VDzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5849C43390;
	Fri, 29 Mar 2024 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716286;
	bh=Kdyszlwq5JIK92eTlec4mtX/vVJlwIS0I5GaYJWP4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsv/VDzHn2FnpLWFW5mbb2nryF6vl8Xgkfrno0ZhyOeL7j57HCq32BGXku3XEVmC5
	 gD+OUftR9HW/lnxNDkBbj5vhJFTbfHA1P36HUIwUUFwv6Sye+jU2Q3ea25jXl1N2Hb
	 UG/opEZdUn6JzwfSW2T+XoszElaH6VqoIOoNQIKU6Rr1dtR5BYxIgZvUfQoQJc6Wrr
	 JMUS76AAh/GQwX4fPd1lZ/Tv4jYJDvRZ/qChWOCzoG7rr6jvaY3EN+fFGgpahHCoec
	 4KHAedQOcfvky6m0is+SZTCuYpk0EcQdw7w5N4iUJSM4xrXS/ZT5amXYJGeQk1Py0X
	 P5V2SVElrCkvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 40/75] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Fri, 29 Mar 2024 08:42:21 -0400
Message-ID: <20240329124330.3089520-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


